//! based on sokol-zig

const std = @import("std");
const builtin = @import("builtin");
const Build = std.Build;
const CompileStep = Build.Step.Compile;
const RunStep = Build.Step.Run;

pub const SokolBackend = enum {
    auto, // Windows: D3D11, macOS/iOS: Metal, otherwise: GL
    d3d11,
    metal,
    gl,
    gles3,
    wgpu,
};

pub const LibSokolOptions = struct {
    target: Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
    backend: SokolBackend = .auto,
    use_egl: bool = false,
    use_x11: bool = true,
    use_wayland: bool = false,
    emsdk: ?*Build.Dependency = null,
    with_sokol_imgui: bool = false,
};

// helper function to resolve .auto backend based on target platform
fn resolveSokolBackend(backend: SokolBackend, target: std.Target) SokolBackend {
    if (backend != .auto) {
        return backend;
    } else if (target.isDarwin()) {
        return .metal;
    } else if (target.os.tag == .windows) {
        return .d3d11;
    } else if (target.isWasm()) {
        return .gles3;
    } else if (target.isAndroid()) {
        return .gles3;
    } else {
        return .gl;
    }
}

fn rootPath() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}

// build sokol into a static library
pub fn buildLibSokol(b: *Build, options: LibSokolOptions) !*CompileStep {
    const sharedlib = b.option(bool, "shared", "Build sokol dynamic library (default: static)") orelse false;
    const lib = if (sharedlib) b.addSharedLibrary(.{
        .name = "sokol",
        .target = options.target,
        .optimize = options.optimize,
        .link_libc = true,
    }) else b.addStaticLibrary(.{
        .name = "sokol",
        .target = options.target,
        .optimize = options.optimize,
        .link_libc = true,
    });
    lib.root_module.sanitize_c = false;

    switch (options.optimize) {
        .Debug, .ReleaseSafe => lib.bundle_compiler_rt = true,
        else => lib.root_module.strip = true,
    }
    if (options.target.result.isWasm()) {
        lib.root_module.root_source_file = b.path("src/handmade/math.zig");
        if (options.optimize != .Debug)
            lib.want_lto = true;
        // make sure we're building for the wasm32-emscripten target, not wasm32-freestanding
        if (lib.rootModuleTarget().os.tag != .emscripten) {
            std.log.err("Please build with 'zig build -Dtarget=wasm32-emscripten", .{});
            return error.Wasm32EmscriptenExpected;
        }
        // one-time setup of Emscripten SDK
        if (!options.with_sokol_imgui) {
            if (try emSdkSetupStep(b, options.emsdk.?)) |emsdk_setup| {
                lib.step.dependOn(&emsdk_setup.step);
            }
            // add the Emscripten system include seach path
            lib.addIncludePath(emSdkLazyPath(b, options.emsdk.?, &.{ "upstream", "emscripten", "cache", "sysroot", "include" }));
        }
    }

    // resolve .auto backend into specific backend by platform
    const backend = resolveSokolBackend(options.backend, lib.rootModuleTarget());
    const backend_cflags = switch (backend) {
        .d3d11 => "-DSOKOL_D3D11",
        .metal => "-DSOKOL_METAL",
        .gl => "-DSOKOL_GLCORE",
        .gles3 => "-DSOKOL_GLES3",
        .wgpu => "-DSOKOL_WGPU",
        else => @panic("unknown sokol backend"),
    };

    // platform specific compile and link options
    var cflags: []const []const u8 = &.{ "-DIMPL", backend_cflags };
    if (lib.rootModuleTarget().isDarwin()) {
        cflags = &.{ "-ObjC", "-DIMPL", backend_cflags };
        lib.linkFramework("Foundation");
        lib.linkFramework("AudioToolbox");
        if (.metal == backend) {
            lib.linkFramework("MetalKit");
            lib.linkFramework("Metal");
        }
        if (lib.rootModuleTarget().os.tag == .ios) {
            lib.linkFramework("UIKit");
            lib.linkFramework("AVFoundation");
            if (.gl == backend) {
                lib.linkFramework("OpenGLES");
                lib.linkFramework("GLKit");
            }
        } else if (lib.rootModuleTarget().os.tag == .macos) {
            lib.linkFramework("Cocoa");
            lib.linkFramework("QuartzCore");
            if (.gl == backend) {
                lib.linkFramework("OpenGL");
            }
        }
    } else if (lib.rootModuleTarget().isAndroid()) {
        if (.gles3 != backend) {
            @panic("For android targets, you must have backend set to GLES3");
        }
        lib.linkSystemLibrary("GLESv3");
        lib.linkSystemLibrary("EGL");
        lib.linkSystemLibrary("android");
        lib.linkSystemLibrary("log");
    } else if (lib.rootModuleTarget().os.tag == .linux) {
        const egl_cflags = if (options.use_egl) "-DSOKOL_FORCE_EGL " else "";
        const x11_cflags = if (!options.use_x11) "-DSOKOL_DISABLE_X11 " else "";
        const wayland_cflags = if (!options.use_wayland) "-DSOKOL_DISABLE_WAYLAND" else "";
        const link_egl = options.use_egl or options.use_wayland;
        cflags = &.{ "-DIMPL", backend_cflags, egl_cflags, x11_cflags, wayland_cflags };
        lib.linkSystemLibrary("asound");
        lib.linkSystemLibrary("GL");
        if (options.use_x11) {
            lib.linkSystemLibrary("X11");
            lib.linkSystemLibrary("Xi");
            lib.linkSystemLibrary("Xcursor");
        }
        if (options.use_wayland) {
            lib.linkSystemLibrary("wayland-client");
            lib.linkSystemLibrary("wayland-cursor");
            lib.linkSystemLibrary("wayland-egl");
            lib.linkSystemLibrary("xkbcommon");
        }
        if (link_egl) {
            lib.linkSystemLibrary("egl");
        }
    } else if (lib.rootModuleTarget().os.tag == .windows) {
        lib.linkSystemLibrary("kernel32");
        lib.linkSystemLibrary("user32");
        lib.linkSystemLibrary("gdi32");
        lib.linkSystemLibrary("ole32");
        if (.d3d11 == backend) {
            lib.linkSystemLibrary("d3d11");
            lib.linkSystemLibrary("dxgi");
        }
    }

    // finally add the C source files
    const csrc_root = "src/sokol/c/";
    const csources = [_][]const u8{
        csrc_root ++ "sokol_log.c",
        csrc_root ++ "sokol_app.c",
        csrc_root ++ "sokol_gfx.c",
        csrc_root ++ "sokol_time.c",
        csrc_root ++ "sokol_audio.c",
        csrc_root ++ "sokol_gl.c",
        csrc_root ++ "sokol_debugtext.c",
        csrc_root ++ "sokol_shape.c",
        csrc_root ++ "sokol_fetch.c",
        csrc_root ++ "sokol_glue.c",
    };
    for (csources) |csrc| {
        lib.addCSourceFile(.{
            .file = b.path(csrc),
            .flags = cflags,
        });
    }

    if (options.with_sokol_imgui) {
        lib.addCSourceFile(.{
            .file = b.path(csrc_root ++ "sokol_imgui.c"),
            .flags = cflags,
        });
        const cimgui = try buildImgui(b, .{
            .target = options.target,
            .optimize = options.optimize,
            .emsdk = options.emsdk,
        });
        for (cimgui.root_module.include_dirs.items) |dir| {
            try lib.root_module.include_dirs.append(b.allocator, dir);
        }
        lib.linkLibrary(cimgui);
    }
    return lib;
}

pub fn build(b: *Build) !void {
    const opt_use_gl = b.option(bool, "gl", "Force OpenGL (default: false)") orelse false;
    const opt_use_wgpu = b.option(bool, "wgpu", "Force WebGPU (default: false, web only)") orelse false;
    const opt_use_x11 = b.option(bool, "x11", "Force X11 (default: true, Linux only)") orelse true;
    const opt_use_wayland = b.option(bool, "wayland", "Force Wayland (default: false, Linux only, not supported in main-line headers)") orelse false;
    const opt_use_egl = b.option(bool, "egl", "Force EGL (default: false, Linux only)") orelse false;
    const opt_with_sokol_imgui = b.option(bool, "imgui", "Add support for sokol_imgui.h bindings") orelse false;
    const sokol_backend: SokolBackend = if (opt_use_gl) .gl else if (opt_use_wgpu) .wgpu else .auto;

    // LDC-options options
    const dub_artifact = b.option(bool, "artifact", "Build artifacts (default: false)") orelse false;
    const enable_betterC = b.option(bool, "betterC", "Omit generating some runtime information and helper functions (default: false)") orelse false;
    const enable_zigcc = b.option(bool, "zigCC", "Use zig cc as compiler and linker (default: false)") orelse false;
    // ldc2 w/ druntime + phobos2 works on MSVC
    const target = b.standardTargetOptions(.{ .default_target = if (builtin.os.tag == .windows) try std.Target.Query.parse(.{ .arch_os_abi = "native-windows-msvc" }) else .{} });
    const optimize = b.standardOptimizeOption(.{});

    const emsdk = b.dependency("emsdk", .{});
    const lib_sokol = try buildLibSokol(b, .{
        .target = target,
        .optimize = optimize,
        .backend = sokol_backend,
        .use_wayland = opt_use_wayland,
        .use_x11 = opt_use_x11,
        .use_egl = opt_use_egl,
        .with_sokol_imgui = opt_with_sokol_imgui,
        .emsdk = emsdk,
    });
    if (dub_artifact) {
        b.installArtifact(lib_sokol);
    } else {
        // build examples
        const examples = .{
            "clear",
            "triangle",
            "cube",
            "blend",
            "mrt",
            "saudio",
            "sgl_context",
            "sgl_points",
            "debugtext",
            "user_data", // Need GC for user data [associative array]
            "imgui",
            "droptest",
        };

        inline for (examples) |example| {
            if (std.mem.eql(u8, example, "imgui") or std.mem.eql(u8, example, "droptest"))
                if (!opt_with_sokol_imgui)
                    break;
            const ldc = try ldcBuildStep(b, .{
                .name = example,
                .artifact = lib_sokol,
                .sources = &[_][]const u8{
                    b.fmt("{s}/src/examples/{s}.d", .{ rootPath(), example }),
                },
                .betterC = if (std.mem.eql(u8, example, "user-data")) false else enable_betterC,
                .dflags = &.{
                    "-w",
                    "-preview=all",
                },
                // fixme: https://github.com/kassane/sokol-d/issues/1 - betterC works on darwin
                .zig_cc = if (target.result.isDarwin() and !enable_betterC) false else enable_zigcc,
                .target = target,
                .optimize = optimize,
                // send ldc2-obj (wasm artifact) to emcc
                .kind = if (target.result.isWasm()) .obj else .exe,
                .emsdk = emsdk,
                .backend = sokol_backend,
            });
            b.getInstallStep().dependOn(&ldc.step);
        }
    }
    buildShaders(b);

    // build tests
    // fixme: not building on Windows libsokol w/ kind test (missing cc [??])
    _ = try ldcBuildStep(b, .{
        .name = "test-math",
        .kind = .@"test",
        .target = b.host,
        .sources = &.{b.fmt("{s}/src/handmade/math.d", .{rootPath()})},
        .dflags = &.{},
    });
}

// Use LDC2 (https://github.com/ldc-developers/ldc) to compile the D examples
pub fn ldcBuildStep(b: *Build, options: DCompileStep) !*std.Build.Step.InstallDir {
    // ldmd2: ldc2 wrapped w/ dmd flags
    const ldc = try b.findProgram(&.{"ldmd2"}, &.{});

    // D compiler
    var ldc_exec = b.addSystemCommand(&.{ldc});
    ldc_exec.setName(options.name);

    // set kind of build
    switch (options.kind) {
        .@"test" => {
            ldc_exec.addArgs(&.{ "-unittest", "-main" });
        },
        .obj => ldc_exec.addArg("-c"),
        else => {},
    }

    if (options.kind == .lib) {
        if (options.linkage == .dynamic) {
            ldc_exec.addArg("-shared");
            if (options.target.result.os.tag == .windows) {
                ldc_exec.addArg("-fvisibility=public");
                ldc_exec.addArg("--dllimport=all");
            }
        } else {
            ldc_exec.addArg("-lib");
            if (options.target.result.os.tag == .windows)
                ldc_exec.addArg("--dllimport=defaultLibsOnly");
            ldc_exec.addArg("-fvisibility=hidden");
        }
    }

    for (options.dflags) |dflag| {
        ldc_exec.addArg(dflag);
    }

    if (options.includePaths) |includePath| {
        for (includePath) |dir| {
            if (dir[0] == '-') {
                @panic("add includepath only!");
            }
            ldc_exec.addArg(b.fmt("-I{s}", .{dir}));
        }
    }

    if (options.ldflags) |ldflags| {
        for (ldflags) |ldflag| {
            if (ldflag[0] == '-') {
                @panic("ldflags: add library name only!");
            }
            ldc_exec.addArg(b.fmt("-L-l{s}", .{ldflag}));
        }
    }

    // betterC disable druntime and phobos
    if (options.betterC)
        ldc_exec.addArg("-betterC");

    switch (options.optimize) {
        .Debug => {
            ldc_exec.addArg("-debug");
            ldc_exec.addArg("-d-debug");
            ldc_exec.addArg("-gc"); // debuginfo for non D dbg
            ldc_exec.addArg("-g"); // debuginfo for D dbg
            ldc_exec.addArg("-gf");
            ldc_exec.addArg("-gs");
            ldc_exec.addArg("-vgc");
            ldc_exec.addArg("-vtls");
            ldc_exec.addArg("-verrors=context");
            ldc_exec.addArg("-boundscheck=on");
        },
        .ReleaseSafe => {
            ldc_exec.addArgs(&.{ "-O2", "-boundscheck=safeonly" });
        },
        .ReleaseFast => {
            ldc_exec.addArgs(&.{ "-O3", "-boundscheck=off" });
        },
        .ReleaseSmall => {
            ldc_exec.addArgs(&.{ "-Oz", "-boundscheck=off" });
        },
    }

    // Print character (column) numbers in diagnostics
    ldc_exec.addArg("-vcolumns");

    const extFile = switch (options.kind) {
        .exe, .@"test" => std.Target.exeFileExt(options.target.result),
        .lib => if (options.linkage == .static) std.Target.staticLibSuffix(options.target.result) else std.Target.dynamicLibSuffix(options.target.result),
        .obj => if (options.target.result.os.tag == .windows) ".obj" else ".o",
    };
    // object file output (zig-cache/o/{hash_id}/*.o)
    const objpath = ldc_exec.addPrefixedOutputFileArg("-of=", try std.mem.concat(b.allocator, u8, &.{ options.name, extFile }));
    if (b.cache_root.path) |dir| {
        // mutable state hash (ldc2 cache - llvm-ir2obj)
        ldc_exec.addArg(b.fmt("-cache={s}", .{b.pathJoin(&.{
            dir,
            "o",
            &b.graph.cache.hash.final(),
        })}));
    }

    // disable LLVM-IR verifier
    // https://llvm.org/docs/Passes.html#verify-module-verifier
    ldc_exec.addArg("-disable-verify");

    // keep all function bodies in .di files
    ldc_exec.addArg("-Hkeep-all-bodies");

    // automatically finds needed library files and builds
    ldc_exec.addArg("-i");

    // sokol include path
    ldc_exec.addArg(b.fmt("-I{s}", .{b.pathJoin(&.{ rootPath(), "src" })}));

    // D-packages include path
    if (options.d_packages) |d_packages| {
        for (d_packages) |pkg| {
            ldc_exec.addArg(b.fmt("-I{s}", .{pkg}));
        }
    }

    // D Source files
    for (options.sources) |src| {
        ldc_exec.addFileArg(path(b, src));
    }

    // linker flags
    // GNU LD
    if (options.target.result.os.tag == .linux and !options.zig_cc) {
        ldc_exec.addArg("-L--no-as-needed");
    }
    // LLD (not working in zld)
    if (options.target.result.isDarwin() and !options.zig_cc) {
        // https://github.com/ldc-developers/ldc/issues/4501
        ldc_exec.addArg("-L-w"); // hide linker warnings
    }

    if (options.target.result.isWasm()) {
        ldc_exec.addArg("--d-version=CarelessAlocation");
        ldc_exec.addArg("-L-allow-undefined");
    }

    if (b.verbose) {
        ldc_exec.addArg("-vdmd");
        ldc_exec.addArg("-Xcc=-v");
    }

    if (options.artifact) |lib_sokol| {
        if (lib_sokol.linkage == .dynamic or options.linkage == .dynamic) {
            // linking the druntime/Phobos as dynamic libraries
            ldc_exec.addArg("-link-defaultlib-shared");
        }

        // C include path
        for (lib_sokol.root_module.include_dirs.items) |include_dir| {
            if (include_dir == .other_step) continue;
            const dir = if (include_dir == .path)
                include_dir.path.getPath(b)
            else if (include_dir == .path_system)
                include_dir.path_system.getPath(b)
            else
                include_dir.path_after.getPath(b);
            ldc_exec.addArg(b.fmt("-P-I{s}", .{dir}));
        }

        // library paths
        for (lib_sokol.root_module.lib_paths.items) |libpath| {
            if (libpath.getPath(b).len > 0) // skip empty paths
                ldc_exec.addArg(b.fmt("-L-L{s}", .{libpath.getPath(b)}));
        }

        // link system libs
        for (lib_sokol.root_module.link_objects.items) |link_object| {
            if (link_object != .system_lib) continue;
            const system_lib = link_object.system_lib;
            ldc_exec.addArg(b.fmt("-L-l{s}", .{system_lib.name}));
        }
        // C flags
        for (lib_sokol.root_module.link_objects.items) |link_object| {
            if (link_object != .c_source_file) continue;
            const c_source_file = link_object.c_source_file;
            for (c_source_file.flags) |flag|
                if (flag.len > 0) // skip empty flags
                    ldc_exec.addArg(b.fmt("-Xcc={s}", .{flag}));
            break;
        }
        // C defines
        for (lib_sokol.root_module.c_macros.items) |cdefine| {
            if (cdefine.len > 0) // skip empty cdefines
                ldc_exec.addArg(b.fmt("-P-D{s}", .{cdefine}));
            break;
        }

        if (lib_sokol.dead_strip_dylibs) {
            ldc_exec.addArg("-L=-dead_strip");
        }
        // Darwin frameworks
        if (options.target.result.isDarwin()) {
            var it = lib_sokol.root_module.frameworks.iterator();
            while (it.next()) |framework| {
                ldc_exec.addArg(b.fmt("-L-framework", .{}));
                ldc_exec.addArg(b.fmt("-L{s}", .{framework.key_ptr.*}));
            }
        }

        if (lib_sokol.root_module.sanitize_thread) |tsan| {
            if (tsan)
                ldc_exec.addArg("--fsanitize=thread");
        }

        // zig enable sanitize=undefined by default
        if (lib_sokol.root_module.sanitize_c) |ubsan| {
            if (ubsan)
                ldc_exec.addArg("--fsanitize=address");
        }

        if (lib_sokol.root_module.omit_frame_pointer) |enabled| {
            if (enabled)
                ldc_exec.addArg("--frame-pointer=none")
            else
                ldc_exec.addArg("--frame-pointer=all");
        }

        // link-time optimization
        if (lib_sokol.want_lto) |enabled|
            if (enabled) ldc_exec.addArg("--flto=full");
    }

    // ldc2 doesn't support zig native (a.k.a: native-native or native)
    const mtriple = if (options.target.result.isDarwin())
        b.fmt("{s}-apple-{s}", .{ if (options.target.result.cpu.arch.isAARCH64()) "arm64" else @tagName(options.target.result.cpu.arch), @tagName(options.target.result.os.tag) })
    else if (options.target.result.isWasm() and options.target.result.os.tag == .freestanding)
        b.fmt("{s}-unknown-unknown-wasm", .{@tagName(options.target.result.cpu.arch)})
    else if (options.target.result.isWasm())
        b.fmt("{s}-unknown-{s}", .{ @tagName(options.target.result.cpu.arch), @tagName(options.target.result.os.tag) })
    else
        b.fmt("{s}-{s}-{s}", .{ @tagName(options.target.result.cpu.arch), @tagName(options.target.result.os.tag), @tagName(options.target.result.abi) });

    ldc_exec.addArg(b.fmt("-mtriple={s}", .{mtriple}));

    const cpu_model = options.target.result.cpu.model.llvm_name orelse "generic";
    ldc_exec.addArg(b.fmt("-mcpu={s}", .{cpu_model}));

    const outputDir = switch (options.kind) {
        .lib => "lib",
        .exe => "bin",
        .@"test" => "test",
        .obj => "obj",
    };

    // output file
    const installdir = b.addInstallDirectory(.{
        .install_dir = .prefix,
        .source_dir = objpath.dirname(),
        .install_subdir = outputDir,
        .exclude_extensions = &.{
            "o",
            "obj",
        },
    });
    installdir.step.dependOn(&ldc_exec.step);

    if (options.zig_cc) {
        const zcc = buildZigCC(b);
        const install = b.addInstallArtifact(zcc, .{ .dest_dir = .{ .override = .{ .custom = "tools" } } });
        const zcc_path = b.pathJoin(&.{ b.install_prefix, "tools", if (options.target.result.os.tag == .windows) "zcc.exe" else "zcc" });
        const zcc_exists = !std.meta.isError(std.fs.accessAbsolute(zcc_path, .{}));
        if (!zcc_exists)
            ldc_exec.step.dependOn(&install.step);
        ldc_exec.addArg(b.fmt("--gcc={s}", .{zcc_path}));
        ldc_exec.addArg(b.fmt("--linker={s}", .{zcc_path}));
    }

    const example_run = b.addSystemCommand(&.{b.pathJoin(&.{ b.install_path, outputDir, options.name })});
    example_run.step.dependOn(&installdir.step);

    const run = if (options.kind != .@"test")
        b.step(b.fmt("run-{s}", .{options.name}), b.fmt("Run {s} example", .{options.name}))
    else
        b.step("test", "Run all tests");

    if (options.target.result.isWasm()) {
        // get D object file and put it in the wasm artifact
        const artifact = addArtifact(b, options);
        artifact.addObjectFile(objpath);
        artifact.linkLibrary(options.artifact.?);
        artifact.step.dependOn(&ldc_exec.step);
        const backend = resolveSokolBackend(options.backend, options.target.result);
        const link_step = try emLinkStep(b, .{
            .lib_main = artifact,
            .target = options.target,
            .optimize = options.optimize,
            .emsdk = options.emsdk.?,
            .use_webgpu = backend == .wgpu,
            .use_webgl2 = backend != .wgpu,
            .use_emmalloc = true,
            .use_filesystem = false,
            .release_use_lto = options.artifact.?.want_lto orelse false,
            .shell_file_path = b.path("src/sokol/web/shell.html"),
            // NOTE: This is required to make the Zig @returnAddress() builtin work,
            // which is used heavily in the stdlib allocator code (not just
            // the GeneralPurposeAllocator).
            // The Emscripten runtime error message when the option is missing is:
            // Cannot use convertFrameToPC (needed by __builtin_return_address) without -sUSE_OFFSET_CONVERTER
            .extra_args = &.{"-sUSE_OFFSET_CONVERTER=1"},
        });
        link_step.step.dependOn(&ldc_exec.step);
        const emrun = emRunStep(b, .{ .name = options.name, .emsdk = options.emsdk.? });
        emrun.step.dependOn(&link_step.step);
        run.dependOn(&emrun.step);
    } else {
        if (options.artifact) |lib_sokol| {
            if (lib_sokol.rootModuleTarget().os.tag == .windows and lib_sokol.isDynamicLibrary()) {
                ldc_exec.addArg(b.pathJoin(&.{
                    b.install_path,
                    "lib",
                    b.fmt("{s}.lib", .{lib_sokol.name}),
                }));
            } else {
                ldc_exec.addArtifactArg(lib_sokol);
                var it = lib_sokol.root_module.iterateDependencies(lib_sokol, false);
                while (it.next()) |item| {
                    for (item.module.link_objects.items) |link_object| {
                        switch (link_object) {
                            .other_step => |compile_step| {
                                switch (compile_step.kind) {
                                    .lib => {
                                        ldc_exec.addArtifactArg(compile_step);
                                    },
                                    else => {},
                                }
                            },
                            else => {},
                        }
                    }
                }
            }
        }
        run.dependOn(&example_run.step);
    }
    return installdir;
}

pub const DCompileStep = struct {
    target: Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode = .Debug,
    kind: CompileStep.Kind = .exe,
    linkage: std.builtin.LinkMode = .static,
    betterC: bool = false,
    sources: []const []const u8,
    dflags: []const []const u8,
    includePaths: ?[]const []const u8 = null,
    ldflags: ?[]const []const u8 = null,
    name: []const u8,
    zig_cc: bool = false,
    d_packages: ?[]const []const u8 = null,
    artifact: ?*Build.Step.Compile = null,
    emsdk: ?*Build.Dependency = null,
    backend: SokolBackend = .auto,
};
pub fn addArtifact(b: *Build, options: DCompileStep) *Build.Step.Compile {
    return Build.Step.Compile.create(b, .{
        .name = options.name,
        .root_module = .{
            .target = options.target,
            .optimize = options.optimize,
        },
        .linkage = options.linkage,
        .kind = options.kind,
    });
}

pub fn path(b: *std.Build, sub_path: []const u8) std.Build.LazyPath {
    if (std.fs.path.isAbsolute(sub_path)) {
        return .{
            .cwd_relative = sub_path,
        };
    } else return .{
        .src_path = .{
            .owner = b,
            .sub_path = sub_path,
        },
    };
}

// -------------------------- Others Configuration --------------------------

// zig-cc wrapper for ldc2
pub fn buildZigCC(b: *Build) *CompileStep {
    const exe = b.addExecutable(.{
        .name = "zcc",
        .target = b.host,
        .optimize = .ReleaseSafe,
        .root_source_file = b.path("tools/zigcc.zig"),
    });
    return exe;
}

// a separate step to compile shaders, expects the shader compiler in ../sokol-tools-bin/
fn buildShaders(b: *Build) void {
    const shdc_dep = b.dependency("shdc", .{}).path("").getPath(b);

    const sokol_tools_bin_dir = b.pathJoin(&.{ shdc_dep, "bin" });
    const shaders_dir = "src/examples/shaders/";
    const shaders = .{
        "triangle.glsl",
        "bufferoffsets.glsl",
        "cube.glsl",
        "instancing.glsl",
        "mrt.glsl",
        "noninterleaved.glsl",
        "offscreen.glsl",
        "quad.glsl",
        "shapes.glsl",
        "texcube.glsl",
        "blend.glsl",
    };
    const optional_shdc: ?[:0]const u8 = comptime switch (builtin.os.tag) {
        .windows => "win32/sokol-shdc.exe",
        .linux => "linux/sokol-shdc",
        .macos => if (builtin.cpu.arch.isX86()) "osx/sokol-shdc" else "osx_arm64/sokol-shdc",
        else => null,
    };
    if (optional_shdc == null) {
        std.log.warn("unsupported host platform, skipping shader compiler step", .{});
        return;
    }
    const shdc_path = b.findProgram(&.{"sokol-shdc"}, &.{}) catch b.pathJoin(&.{ sokol_tools_bin_dir, optional_shdc.? });
    const shdc_step = b.step("shaders", "Compile shaders (needs ../sokol-tools-bin)");
    inline for (shaders) |shader| {
        const cmd = b.addSystemCommand(&.{
            shdc_path,
            "-i",
            shaders_dir ++ shader,
            "-o",
            shaders_dir ++ shader[0 .. shader.len - 5] ++ ".d",
            "-l",
            "glsl430:metal_macos:hlsl4:glsl300es:wgsl",
            "-f",
            "sokol_d",
        });
        shdc_step.dependOn(&cmd.step);
    }
}

// ------------------------ Wasm Configuration ------------------------

// for wasm32-emscripten, need to run the Emscripten linker from the Emscripten SDK
// NOTE: ideally this would go into a separate emsdk-zig package
pub const EmLinkOptions = struct {
    target: Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
    // name: []const u8,
    lib_main: *Build.Step.Compile,
    // lib_sokol: *Build.Step.Compile,
    emsdk: *Build.Dependency,
    release_use_closure: bool = true,
    release_use_lto: bool = false,
    use_webgpu: bool = false,
    use_webgl2: bool = false,
    use_emmalloc: bool = false,
    use_filesystem: bool = true,
    shell_file_path: ?Build.LazyPath,
    extra_args: []const []const u8 = &.{},
};

pub fn emLinkStep(b: *Build, options: EmLinkOptions) !*Build.Step.InstallDir {
    const emcc_path = emSdkLazyPath(b, options.emsdk, &.{ "upstream", "emscripten", "emcc" }).getPath(b);
    const emcc = b.addSystemCommand(&.{emcc_path});
    emcc.setName("emcc"); // hide emcc path
    if (options.optimize == .Debug) {
        emcc.addArgs(&.{ "-Og", "-sSAFE_HEAP=1", "-sSTACK_OVERFLOW_CHECK=1" });
    } else {
        emcc.addArg("-sASSERTIONS=0");
        if (options.optimize == .ReleaseSmall) {
            emcc.addArg("-Oz");
        } else {
            emcc.addArg("-O3");
        }
        if (options.release_use_lto) {
            emcc.addArg("-flto");
        }
        if (options.release_use_closure) {
            emcc.addArgs(&.{ "--closure", "1" });
        }
    }
    if (options.use_webgpu) {
        emcc.addArg("-sUSE_WEBGPU=1");
    }
    if (options.use_webgl2) {
        emcc.addArg("-sUSE_WEBGL2=1");
    }
    if (!options.use_filesystem) {
        emcc.addArg("-sNO_FILESYSTEM=1");
    }
    if (options.use_emmalloc) {
        emcc.addArg("-sMALLOC='emmalloc'");
    }
    if (options.shell_file_path) |shell_file_path| {
        emcc.addPrefixedFileArg("--shell-file=", shell_file_path);
    }
    for (options.extra_args) |arg| {
        emcc.addArg(arg);
    }

    // add the main lib, and then scan for library dependencies and add those too
    emcc.addArtifactArg(options.lib_main);
    var it = options.lib_main.root_module.iterateDependencies(options.lib_main, false);
    while (it.next()) |item| {
        for (item.module.link_objects.items) |link_object| {
            switch (link_object) {
                .other_step => |compile_step| {
                    switch (compile_step.kind) {
                        .lib => {
                            emcc.addArtifactArg(compile_step);
                        },
                        else => {},
                    }
                },
                else => {},
            }
        }
    }
    emcc.addArg("-o");
    const out_file = emcc.addOutputFileArg(b.fmt("{s}.html", .{options.lib_main.name}));

    // the emcc linker creates 3 output files (.html, .wasm and .js)
    const install = b.addInstallDirectory(.{
        .source_dir = out_file.dirname(),
        .install_dir = .prefix,
        .install_subdir = "web",
    });
    install.step.dependOn(&emcc.step);

    // get the emcc step to run on 'zig build'
    b.getInstallStep().dependOn(&install.step);
    return install;
}

// build a run step which uses the emsdk emrun command to run a build target in the browser
// NOTE: ideally this would go into a separate emsdk-zig package
pub const EmRunOptions = struct {
    name: []const u8,
    emsdk: *Build.Dependency,
};
pub fn emRunStep(b: *Build, options: EmRunOptions) *Build.Step.Run {
    const emrun_path = b.findProgram(&.{"emrun"}, &.{}) catch emSdkLazyPath(b, options.emsdk, &.{ "upstream", "emscripten", "emrun" }).getPath(b);
    const emrun = b.addSystemCommand(&.{ emrun_path, b.fmt("{s}/web/{s}.html", .{ b.install_path, options.name }) });
    return emrun;
}

// helper function to build a LazyPath from the emsdk root and provided path components
fn emSdkLazyPath(b: *Build, emsdk: *Build.Dependency, subPaths: []const []const u8) Build.LazyPath {
    return emsdk.path(b.pathJoin(subPaths));
}

fn createEmsdkStep(b: *Build, emsdk: *Build.Dependency) *Build.Step.Run {
    if (builtin.os.tag == .windows) {
        return b.addSystemCommand(&.{emSdkLazyPath(b, emsdk, &.{"emsdk.bat"}).getPath(b)});
    } else {
        const step = b.addSystemCommand(&.{"bash"});
        step.addArg(emSdkLazyPath(b, emsdk, &.{"emsdk"}).getPath(b));
        return step;
    }
}

// One-time setup of the Emscripten SDK (runs 'emsdk install + activate'). If the
// SDK had to be setup, a run step will be returned which should be added
// as dependency to the sokol library (since this needs the emsdk in place),
// if the emsdk was already setup, null will be returned.
// NOTE: ideally this would go into a separate emsdk-zig package
// NOTE 2: the file exists check is a bit hacky, it would be cleaner
// to build an on-the-fly helper tool which takes care of the SDK
// setup and just does nothing if it already happened
fn emSdkSetupStep(b: *Build, emsdk: *Build.Dependency) !?*Build.Step.Run {
    const dot_emsc_path = emSdkLazyPath(b, emsdk, &.{".emscripten"}).getPath(b);
    const dot_emsc_exists = !std.meta.isError(std.fs.accessAbsolute(dot_emsc_path, .{}));
    if (!dot_emsc_exists) {
        const emsdk_install = createEmsdkStep(b, emsdk);
        emsdk_install.addArgs(&.{ "install", "latest" });
        const emsdk_activate = createEmsdkStep(b, emsdk);
        emsdk_activate.addArgs(&.{ "activate", "latest" });
        emsdk_activate.step.dependOn(&emsdk_install.step);
        return emsdk_activate;
    } else {
        return null;
    }
}
const libImGuiOptions = struct {
    target: Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
    emsdk: ?*Build.Dependency,
};
fn buildImgui(b: *Build, options: libImGuiOptions) !*CompileStep {
    const imgui_cpp = b.dependency("imgui", .{});
    const imgui_cpp_dir = imgui_cpp.path("");
    const cimgui = b.dependency("cimgui", .{});
    const cimgui_dir = cimgui.path("");

    const libimgui = b.addStaticLibrary(.{
        .name = "cimgui",
        .target = options.target,
        .optimize = options.optimize,
    });
    if (libimgui.linkage == .static)
        libimgui.pie = true
    else if (libimgui.linkage == .static)
        libimgui.root_module.pic = true;
    libimgui.addIncludePath(cimgui_dir);
    libimgui.addIncludePath(imgui_cpp_dir);
    if (libimgui.rootModuleTarget().isWasm()) {
        if (try emSdkSetupStep(b, options.emsdk.?)) |emsdk_setup| {
            libimgui.step.dependOn(&emsdk_setup.step);
        }
        // add the Emscripten system include seach path
        libimgui.addIncludePath(emSdkLazyPath(b, options.emsdk.?, &.{
            "upstream",
            "emscripten",
            "cache",
            "sysroot",
            "include",
        }));
    }
    libimgui.addCSourceFiles(.{
        .root = cimgui_dir,
        .files = &.{
            "cimgui.cpp",
        },
        .flags = &.{
            "-Wall",
            "-Wextra",
            "-fno-rtti",
            "-fno-exceptions",
            "-Wno-unused-parameter",
            "-Wno-missing-field-initializers",
            "-fno-threadsafe-statics",
        },
    });
    libimgui.addCSourceFiles(.{
        .root = imgui_cpp_dir,
        .files = &.{
            "imgui.cpp",
            "imgui_draw.cpp",
            "imgui_demo.cpp",
            "imgui_widgets.cpp",
            "imgui_tables.cpp",
        },
        .flags = &.{
            "-Wall",
            "-Wextra",
            "-fno-rtti",
            "-fno-exceptions",
            "-Wno-unused-parameter",
            "-Wno-missing-field-initializers",
            "-fno-threadsafe-statics",
        },
    });
    libimgui.root_module.sanitize_c = false;
    if (libimgui.rootModuleTarget().os.tag == .windows)
        libimgui.linkSystemLibrary("imm32");

    // https://github.com/ziglang/zig/issues/5312
    if (libimgui.rootModuleTarget().abi != .msvc) {
        // llvm-libcxx + llvm-libunwind + os-libc
        libimgui.linkLibCpp();
    } else {
        libimgui.linkLibC();
    }

    return libimgui;
}
