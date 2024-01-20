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
    }) else b.addStaticLibrary(.{
        .name = "sokol",
        .target = options.target,
        .optimize = options.optimize,
    });
    lib.root_module.sanitize_c = false;
    lib.linkLibC();
    lib.root_module.root_source_file = .{ .path = "src/handmade/math.zig" };

    if (options.target.result.isWasm()) {
        // make sure we're building for the wasm32-emscripten target, not wasm32-freestanding
        if (lib.rootModuleTarget().os.tag != .emscripten) {
            std.log.err("Please build with 'zig build -Dtarget=wasm32-emscripten", .{});
            return error.Wasm32EmscriptenExpected;
        }
        // one-time setup of Emscripten SDK
        if (try emSdkSetupStep(b, options.emsdk.?)) |emsdk_setup| {
            lib.step.dependOn(&emsdk_setup.step);
        }
        // add the Emscripten system include seach path
        const emsdk_sysroot = b.pathJoin(&.{ emSdkPath(b, options.emsdk.?), "upstream", "emscripten", "cache", "sysroot" });
        const include_path = b.pathJoin(&.{ emsdk_sysroot, "include" });
        lib.addSystemIncludePath(.{ .path = include_path });
    }

    // resolve .auto backend into specific backend by platform
    const backend = resolveSokolBackend(options.backend, lib.rootModuleTarget());
    const backend_cflags = switch (backend) {
        .d3d11 => "-DSOKOL_D3D11",
        .metal => "-DSOKOL_METAL",
        .gl => "-DSOKOL_GLCORE33",
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
        csrc_root ++ "sokol_glue.c",
        csrc_root ++ "sokol_debugtext.c",
        csrc_root ++ "sokol_shape.c",
    };
    for (csources) |csrc| {
        lib.addCSourceFile(.{
            .file = .{ .path = csrc },
            .flags = cflags,
        });
    }
    if (sharedlib)
        b.installArtifact(lib);
    return lib;
}

pub fn build(b: *Build) !void {
    const opt_use_gl = b.option(bool, "gl", "Force OpenGL (default: false)") orelse false;
    const opt_use_wgpu = b.option(bool, "wgpu", "Force WebGPU (default: false, web only)") orelse false;
    const opt_use_x11 = b.option(bool, "x11", "Force X11 (default: true, Linux only)") orelse true;
    const opt_use_wayland = b.option(bool, "wayland", "Force Wayland (default: false, Linux only, not supported in main-line headers)") orelse false;
    const opt_use_egl = b.option(bool, "egl", "Force EGL (default: false, Linux only)") orelse false;
    const sokol_backend: SokolBackend = if (opt_use_gl) .gl else if (opt_use_wgpu) .wgpu else .auto;

    var target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // ldc2 w/ druntime + phobos2 works on MSVC
    if (target.result.os.tag == .windows and target.query.isNative()) {
        target.result.abi = .msvc; // for ldc2
        target.query.abi = .msvc; // for libsokol
    }
    const emsdk = b.dependency("emsdk", .{});
    const lib_sokol = try buildLibSokol(b, .{
        .target = target,
        .optimize = optimize,
        .backend = sokol_backend,
        .use_wayland = opt_use_wayland,
        .use_x11 = opt_use_x11,
        .use_egl = opt_use_egl,
        .emsdk = emsdk,
    });

    // LDC-options options
    const enable_betterC = b.option(bool, "betterC", "Omit generating some runtime information and helper functions (default: false)") orelse false;
    const enable_zigcc = b.option(bool, "zigCC", "Use zig cc as compiler and linker (default: false)") orelse false;

    if (enable_zigcc) {
        const zcc = buildZigCC(b);
        const install = b.addInstallArtifact(zcc, .{ .dest_dir = .{ .override = .{ .custom = "tools" } } });
        b.default_step.dependOn(&install.step);
    }

    // build examples
    const examples = .{
        "clear",
        "triangle",
        "cube",
        "blend",
        "mrt",
        "saudio",
        "sgl_context",
        "debugtext_print",
        // "user_data", // Need GC for user data [associative array]
    };

    inline for (examples) |example| {
        const ldc = try ldcBuildStep(b, .{
            .name = example,
            .artifact = lib_sokol,
            .sources = &[_][]const u8{b.fmt("{s}/src/examples/{s}.d", .{ rootPath(), example })},
            .betterC = if (std.mem.eql(u8, example, "user-data")) false else enable_betterC,
            .dflags = &[_][]const u8{
                "-w", // warnings as error
                // more info: ldc2 -preview=help (list all specs)
                "-preview=all",
                "-lowmem",
            },
            // fixme: https://github.com/kassane/sokol-d/issues/1 - betterC works on darwin
            .zig_cc = if (target.result.isDarwin() and !enable_betterC) false else enable_zigcc,
            .target = target,
            .optimize = if (target.result.isWasm()) .ReleaseSmall else optimize,
            .kind = if (target.result.isWasm()) .obj else .exe,
            .emsdk = emsdk,
        });
        b.getInstallStep().dependOn(&ldc.step);
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
pub fn ldcBuildStep(b: *Build, options: DCompileStep) !*RunStep {
    // ldmd2: ldc2 wrapped w/ dmd flags
    const ldc = try b.findProgram(&.{"ldmd2"}, &.{});

    var cmds = std.ArrayList([]const u8).init(b.allocator);
    defer cmds.deinit();

    // D compiler
    try cmds.append(ldc);

    if (options.zig_cc) {
        try cmds.append(b.fmt("--gcc={s}", .{b.pathJoin(&.{ b.install_prefix, "tools", if (options.target.result.os.tag == .windows) "zcc.exe" else "zcc" })}));
        try cmds.append(b.fmt("--linker={s}", .{b.pathJoin(&.{ b.install_prefix, "tools", if (options.target.result.os.tag == .windows) "zcc.exe" else "zcc" })}));
    }

    // set kind of build
    switch (options.kind) {
        .@"test" => {
            try cmds.append("-unittest");
            try cmds.append("-main");
        },
        .obj => try cmds.append("-c"),
        else => {},
    }

    if (options.kind == .lib) {
        if (options.linkage == .dynamic) {
            try cmds.append("-shared");
            if (options.target.result.os.tag == .windows) {
                try cmds.append("-fvisibility=public");
                try cmds.append("--dllimport=all");
            }
        } else {
            try cmds.append("-lib");
            if (options.target.result.os.tag == .windows)
                try cmds.append("--dllimport=defaultLibsOnly");
            try cmds.append("-fvisibility=hidden");
        }
    }

    for (options.dflags) |dflag| {
        try cmds.append(dflag);
    }

    if (options.ldflags) |ldflags| {
        for (ldflags) |ldflag| {
            if (ldflag[0] == '-') {
                @panic("ldflags: add library name only!");
            }
            try cmds.append(b.fmt("-L-l{s}", .{ldflag}));
        }
    }

    // betterC disable druntime and phobos
    if (options.betterC)
        try cmds.append("-betterC");

    switch (options.optimize) {
        .Debug => {
            try cmds.append("-debug");
            try cmds.append("-d-debug");
            try cmds.append("-gc"); // debuginfo for non D dbg
            try cmds.append("-g"); // debuginfo for D dbg
            try cmds.append("-gf");
            try cmds.append("-gs");
            try cmds.append("-vgc");
            try cmds.append("-vtls");
            try cmds.append("-verrors=context");
            try cmds.append("-boundscheck=on");
        },
        .ReleaseSafe => {
            try cmds.append("-O3");
            try cmds.append("-release");
            try cmds.append("-enable-inlining");
            try cmds.append("-boundscheck=safeonly");
        },
        .ReleaseFast => {
            try cmds.append("-O3");
            try cmds.append("-release");
            try cmds.append("-enable-inlining");
            try cmds.append("-boundscheck=off");
        },
        .ReleaseSmall => {
            try cmds.append("-Oz");
            try cmds.append("-release");
            try cmds.append("-enable-inlining");
            try cmds.append("-boundscheck=off");
        },
    }

    // Print character (column) numbers in diagnostics
    try cmds.append("-vcolumns");

    // object file output (zig-cache/o/{hash_id}/*.o)
    if (b.cache_root.path) |path| {
        // immutable state hash
        if (options.kind != .obj)
            try cmds.append(b.fmt("-od={s}", .{b.pathJoin(&.{ path, "o", &b.cache.hash.peek() })}));
        // mutable state hash
        try cmds.append(b.fmt("-cache={s}", .{b.pathJoin(&.{ path, "o", &b.cache.hash.final() })}));
    }
    // name object files uniquely (so the files don't collide)
    try cmds.append("-oq");

    // remove object files after success build, and put them in a unique temp directory
    // try cmds.append("-cleanup-obj");

    // disable LLVM-IR verifier
    // https://llvm.org/docs/Passes.html#verify-module-verifier
    try cmds.append("-disable-verify");

    // keep all function bodies in .di files
    try cmds.append("-Hkeep-all-bodies");

    // automatically finds needed library files and builds
    try cmds.append("-i");

    // sokol include path
    try cmds.append(b.fmt("-I{s}", .{b.pathJoin(&.{ rootPath(), "src" })}));

    // D-packages include path
    if (options.d_packages) |d_packages| {
        for (d_packages) |pkg| {
            try cmds.append(b.fmt("-I{s}", .{pkg}));
        }
    }

    // D Source files
    for (options.sources) |src| {
        try cmds.append(src);
    }

    // linker flags
    // GNU LD
    if (options.target.result.os.tag == .linux and !options.zig_cc) {
        try cmds.append("-L--no-as-needed");
    }
    // LLD (not working in zld)
    if (options.target.result.isDarwin() and !options.zig_cc) {
        // https://github.com/ldc-developers/ldc/issues/4501
        try cmds.append("-L-w"); // hide linker warnings
    }

    if (b.verbose) {
        try cmds.append("-vdmd");
        try cmds.append("-Xcc=-v");
    }

    if (options.artifact) |lib_sokol| {
        if (lib_sokol.linkage == .dynamic or options.linkage == .dynamic) {
            // linking the druntime/Phobos as dynamic libraries
            try cmds.append("-link-defaultlib-shared");
        }

        // C include path
        for (lib_sokol.root_module.include_dirs.items) |include_dir| {
            const path = include_dir.path_system.getPath(b);
            try cmds.append(b.fmt("-P-I{s}", .{path}));
        }

        // library paths
        for (lib_sokol.root_module.lib_paths.items) |libpath| {
            if (libpath.path.len > 0) // skip empty paths
                try cmds.append(b.fmt("-L-L{s}", .{libpath.path}));
        }

        // link system libs
        for (lib_sokol.root_module.link_objects.items) |link_object| {
            if (link_object != .system_lib) continue;
            const system_lib = link_object.system_lib;
            try cmds.append(b.fmt("-L-l{s}", .{system_lib.name}));
        }
        // C flags
        for (lib_sokol.root_module.link_objects.items) |link_object| {
            if (link_object != .c_source_file) continue;
            const c_source_file = link_object.c_source_file;
            for (c_source_file.flags) |flag|
                if (flag.len > 0) // skip empty flags
                    try cmds.append(b.fmt("-Xcc={s}", .{flag}));
            break;
        }
        // C defines
        for (lib_sokol.root_module.c_macros.items) |cdefine| {
            if (cdefine.len > 0) // skip empty cdefines
                try cmds.append(b.fmt("-Xcc=-D{s}", .{cdefine}));
            break;
        }

        if (lib_sokol.dead_strip_dylibs) {
            try cmds.append("-L=-dead_strip");
        }
        // Darwin frameworks
        if (options.target.result.isDarwin()) {
            var it = lib_sokol.root_module.frameworks.iterator();
            while (it.next()) |framework| {
                try cmds.append(b.fmt("-L-framework", .{}));
                try cmds.append(b.fmt("-L{s}", .{framework.key_ptr.*}));
            }
        }

        if (lib_sokol.root_module.sanitize_thread) |tsan| {
            if (tsan)
                try cmds.append("--fsanitize=thread");
        }

        // zig enable sanitize=undefined by default
        if (lib_sokol.root_module.sanitize_c) |ubsan| {
            if (ubsan)
                try cmds.append("--fsanitize=address");
        }

        if (lib_sokol.root_module.omit_frame_pointer) |enabled| {
            if (enabled)
                try cmds.append("--frame-pointer=none")
            else
                try cmds.append("--frame-pointer=all");
        }

        // link-time optimization
        if (lib_sokol.want_lto) |enabled|
            if (enabled) try cmds.append("--flto=full");
    }

    // ldc2 doesn't support zig native (a.k.a: native-native or native)
    if (options.target.result.isDarwin())
        try cmds.append(b.fmt("--mtriple={s}-apple-{s}", .{ if (options.target.result.cpu.arch.isAARCH64()) "arm64" else @tagName(options.target.result.cpu.arch), @tagName(options.target.result.os.tag) }))
    else if (options.target.result.isWasm()) {
        try cmds.append("-L-allow-undefined");
        try cmds.append(b.fmt("--mtriple={s}-unknown-unknown-wasm", .{@tagName(options.target.result.cpu.arch)}));
    } else try cmds.append(b.fmt("--mtriple={s}-{s}-{s}", .{ @tagName(options.target.result.cpu.arch), @tagName(options.target.result.os.tag), @tagName(options.target.result.abi) }));

    // cpu model (e.g. "baseline")
    if (options.target.query.isNative())
        try cmds.append(b.fmt("--mcpu={s}", .{builtin.cpu.model.name}));

    const outputDir = switch (options.kind) {
        .lib => "lib",
        .exe => "bin",
        .@"test" => "test",
        .obj => "obj",
    };

    // output file
    if (options.kind != .obj)
        try cmds.append(b.fmt("-of={s}", .{b.pathJoin(&.{ b.install_prefix, outputDir, options.name })}))
    else
        try cmds.append(b.fmt("-od={s}", .{b.pathJoin(&.{ b.install_prefix, outputDir })}));

    // run the command
    var ldc_exec = b.addSystemCommand(cmds.items);
    ldc_exec.setName(options.name);

    if (options.artifact) |lib_sokol| {
        ldc_exec.addArtifactArg(lib_sokol);
    }

    const example_run = b.addSystemCommand(&.{b.pathJoin(&.{ b.install_path, outputDir, options.name })});
    example_run.step.dependOn(&ldc_exec.step);

    if (options.kind != .@"test") {
        const run = b.step(b.fmt("run-{s}", .{options.name}), b.fmt("Run {s} example", .{options.name}));
        run.dependOn(&example_run.step);
    } else {
        const tests = b.step("test", "Run all tests");
        tests.dependOn(&example_run.step);
    }

    if (options.target.result.isWasm()) {
        try wasmBuild(b, options.emsdk.?, .{
            .name = options.name,
            .lib_main = b.fmt("{s}/examples.{s}.o", .{ b.pathJoin(&.{ b.install_prefix, outputDir }), options.name }),
            .lib_sokol = options.artifact.?,
            .target = options.target,
            .optimize = options.optimize,
            .step = &ldc_exec.step,
        });
    }

    return ldc_exec;
}

pub const DCompileStep = struct {
    target: Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode = .Debug,
    kind: CompileStep.Kind = .exe,
    linkage: CompileStep.Linkage = .static,
    betterC: bool = false,
    sources: []const []const u8,
    dflags: []const []const u8,
    ldflags: ?[]const []const u8 = null,
    name: []const u8,
    zig_cc: bool = false,
    d_packages: ?[]const []const u8 = null,
    artifact: ?*Build.Step.Compile = null,
    emsdk: ?*Build.Dependency = null,
};

// -------------------------- Others Configuration --------------------------

// zig-cc wrapper for ldc2
pub fn buildZigCC(b: *Build) *CompileStep {
    const exe = b.addExecutable(.{
        .name = "zcc",
        .target = b.host,
        .optimize = .ReleaseSafe,
        .root_source_file = .{
            .path = "tools/zigcc.zig",
        },
    });
    return exe;
}

// a separate step to compile shaders, expects the shader compiler in ../sokol-tools-bin/
fn buildShaders(b: *Build) void {
    const sokol_tools_bin_dir = "../sokol-tools-bin/bin/";
    const shaders_dir = "src/shaders/";
    const shaders = .{
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
    const shdc_path = b.findProgram(&.{"sokol-shdc"}, &.{}) catch sokol_tools_bin_dir ++ optional_shdc.?;
    const shdc_step = b.step("shaders", "Compile shaders (needs ../sokol-tools-bin)");
    inline for (shaders) |shader| {
        const cmd = b.addSystemCommand(&.{
            shdc_path,
            "-i",
            shaders_dir ++ shader,
            "-o",
            shaders_dir ++ shader[0 .. shader.len - 5] ++ ".d",
            "-l",
            "glsl330:metal_macos:hlsl4:glsl300es:wgsl",
            "-f",
            "sokol_d",
        });
        shdc_step.dependOn(&cmd.step);
    }
}

// ------------------------ Wasm Configuration ------------------------

fn wasmBuild(b: *Build, emsdk: *Build.Dependency, options: struct {
    name: []const u8,
    lib_main: []const u8,
    lib_sokol: *Build.Step.Compile,
    target: Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
    step: *Build.Step,
}) !void {
    const link_step = try emLinkStep(b, .{
        .name = options.name,
        .lib_main = options.lib_main,
        .lib_sokol = options.lib_sokol,
        .target = options.target,
        .optimize = options.optimize,
        .emsdk = emsdk,
        .use_webgl2 = true,
        .use_emmalloc = true,
        .use_filesystem = false,
        .shell_file_path = "src/sokol/web/shell.html",
        // NOTE: This is required to make the Zig @returnAddress() builtin work,
        // which is used heavily in the stdlib allocator code (not just
        // the GeneralPurposeAllocator).
        // The Emscripten runtime error message when the option is missing is:
        // Cannot use convertFrameToPC (needed by __builtin_return_address) without -sUSE_OFFSET_CONVERTER
        .extra_args = &.{"-sUSE_OFFSET_CONVERTER=1"},
    });
    link_step.step.dependOn(options.step);
    const run = emRunStep(b, .{ .name = options.name, .emsdk = emsdk });
    run.step.dependOn(&link_step.step);
    b.step(b.fmt("run-web-{s}", .{options.name}), b.fmt("Run {s} example", .{options.name})).dependOn(&run.step);
}

// for wasm32-emscripten, need to run the Emscripten linker from the Emscripten SDK
// NOTE: ideally this would go into a separate emsdk-zig package
pub const EmLinkOptions = struct {
    target: Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode,
    name: []const u8,
    lib_main: []const u8,
    lib_sokol: *Build.Step.Compile,
    emsdk: *Build.Dependency,
    release_use_closure: bool = true,
    release_use_lto: bool = true,
    use_webgpu: bool = false,
    use_webgl2: bool = false,
    use_emmalloc: bool = false,
    use_filesystem: bool = true,
    shell_file_path: ?[]const u8 = null,
    extra_args: []const []const u8 = &.{},
};

pub fn emLinkStep(b: *Build, options: EmLinkOptions) !*Build.Step.Run {
    const emcc_path = b.findProgram(&.{"emcc"}, &.{}) catch b.pathJoin(&.{ emSdkPath(b, options.emsdk), "upstream", "emscripten", "emcc" });

    // create a separate output directory zig-out/web
    try std.fs.cwd().makePath(b.fmt("{s}/web", .{b.install_path}));

    var emcc_cmd = std.ArrayList([]const u8).init(b.allocator);
    defer emcc_cmd.deinit();

    try emcc_cmd.append(emcc_path);
    if (options.optimize == .Debug) {
        try emcc_cmd.append("-Og");
    } else {
        try emcc_cmd.append("-sASSERTIONS=0");
        if (options.optimize == .ReleaseSmall) {
            try emcc_cmd.append("-Oz");
        } else {
            try emcc_cmd.append("-O3");
        }
        if (options.release_use_lto) {
            try emcc_cmd.append("-flto");
        }
        if (options.release_use_closure) {
            try emcc_cmd.append("--closure");
            try emcc_cmd.append("1");
        }
    }
    if (options.use_webgpu) {
        try emcc_cmd.append("-sUSE_WEBGPU=1");
    }
    if (options.use_webgl2) {
        try emcc_cmd.append("-sUSE_WEBGL2=1");
    }
    if (!options.use_filesystem) {
        try emcc_cmd.append("-sNO_FILESYSTEM=1");
    }
    if (options.use_emmalloc) {
        try emcc_cmd.append("-sMALLOC='emmalloc'");
    }
    if (options.shell_file_path) |shell_file_path| {
        try emcc_cmd.append(b.fmt("--shell-file={s}", .{shell_file_path}));
    }
    try emcc_cmd.append(b.fmt("-o{s}/web/{s}.html", .{ b.install_path, options.name }));
    for (options.extra_args) |arg| {
        try emcc_cmd.append(arg);
    }

    const emcc = b.addSystemCommand(emcc_cmd.items);
    emcc.setName("emcc"); // hide emcc path

    // add the main lib, and then scan for library dependencies and add those too
    emcc.addArgs(&.{options.lib_main});
    emcc.addArtifactArg(options.lib_sokol);

    // get the emcc step to run on 'zig build'
    b.getInstallStep().dependOn(&emcc.step);
    return emcc;
}

// build a run step which uses the emsdk emrun command to run a build target in the browser
// NOTE: ideally this would go into a separate emsdk-zig package
pub const EmRunOptions = struct {
    name: []const u8,
    emsdk: *Build.Dependency,
};
pub fn emRunStep(b: *Build, options: EmRunOptions) *Build.Step.Run {
    const emrun_path = b.findProgram(&.{"emrun"}, &.{}) catch b.pathJoin(&.{ emSdkPath(b, options.emsdk), "upstream", "emscripten", "emrun" });
    const emrun = b.addSystemCommand(&.{ emrun_path, b.fmt("{s}/web/{s}.html", .{ b.install_path, options.name }) });
    return emrun;
}

// helper function to extract emsdk path from the emsdk package dependency
fn emSdkPath(b: *Build, emsdk: *Build.Dependency) []const u8 {
    return emsdk.path("").getPath(b);
}

// One-time setup of the Emscripten SDK (runs 'emsdk install + activate'). If the
// SDK had to be setup, a run step will be returned which should be added
// as dependency to the sokol library (since this needs the emsdk in place),
// if the emsdk was already setup, null will be returned.
// NOTE: ideally this would go into a separate emsdk-zig package
fn emSdkSetupStep(b: *Build, emsdk: *Build.Dependency) !?*Build.Step.Run {
    const emsdk_path = emSdkPath(b, emsdk);
    const dot_emsc_path = b.pathJoin(&.{ emsdk_path, ".emscripten" });
    const dot_emsc_exists = !std.meta.isError(std.fs.accessAbsolute(dot_emsc_path, .{}));
    if (!dot_emsc_exists) {
        var cmd = std.ArrayList([]const u8).init(b.allocator);
        defer cmd.deinit();
        if (builtin.os.tag == .windows)
            try cmd.append(b.pathJoin(&.{ emsdk_path, "emsdk.bat" }))
        else {
            try cmd.append("bash"); // or try chmod
            try cmd.append(b.pathJoin(&.{ emsdk_path, "emsdk" }));
        }
        const emsdk_install = b.addSystemCommand(cmd.items);
        emsdk_install.addArgs(&.{ "install", "latest" });
        const emsdk_activate = b.addSystemCommand(cmd.items);
        emsdk_activate.addArgs(&.{ "activate", "latest" });
        emsdk_activate.step.dependOn(&emsdk_install.step);
        return emsdk_activate;
    } else {
        return null;
    }
}
