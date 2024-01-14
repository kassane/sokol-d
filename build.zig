//! based on sokol-zig

const std = @import("std");
const builtin = @import("builtin");
const Build = std.Build;
const CompileStep = Build.Step.Compile;
const RunStep = Build.Step.Run;
const CrossTarget = Build.ResolvedTarget;
const OptimizeMode = std.builtin.OptimizeMode;
const fmt = std.fmt;

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
    optimize: OptimizeMode,
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

    // ldc2 w/ druntime + phobos2 works on MSVC
    if (target.result.os.tag == .windows and target.query.isNative()) {
        target.result.abi = .msvc; // for ldc2
        target.query.abi = .msvc; // for libsokol
    }

    const optimize = b.standardOptimizeOption(.{});
    const sokol = try buildLibSokol(b, .{
        .target = target,
        .optimize = optimize,
        // .emsdk = emsdk,
        .backend = sokol_backend,
        .use_wayland = opt_use_wayland,
        .use_x11 = opt_use_x11,
        .use_egl = opt_use_egl,
    });

    // LDC-options options
    const enable_betterC = b.option(bool, "betterC", "Omit generating some runtime information and helper functions. (default: false)") orelse false;
    const enable_zigcc = b.option(bool, "zigCC", "Use zig cc as compiler and linker. (default: false)") orelse false;

    if (enable_zigcc) {
        buildZigCC(b);
    }

    // WiP: build examples
    const examples = .{
        "clear",
        "triangle",
        // "quad",
        // "bufferoffsets",
        "cube",
        // "noninterleaved",
        // "texcube",
        "blend",
        // "offscreen",
        // "instancing",
        "mrt",
        "saudio",
        // "sgl",
        "sgl-context",
        // "sgl-points",
        // "debugtext",
        "debugtext-print",
        // "debugtext-userfont",
        // "shapes",
        "user-data",
    };
    b.getInstallStep().name = "sokol library";
    inline for (examples) |example| {
        const ldc = try DCompileStep(b, sokol, .{
            .name = example,
            .sources = &.{b.fmt("{s}/src/examples/{s}.d", .{ rootPath(), example })},
            .betterC = enable_betterC,
            .dflags = &.{
                "-w", // warnings as error
                // more info: ldc2 -preview=help (list all specs)
                "-preview=all",
            },
            // fixme: https://github.com/kassane/sokol-d/issues/1 - betterC works on darwin
            .zig_cc = if (target.result.isDarwin() and !enable_betterC) false else enable_zigcc,
            .target = target,
            .optimize = optimize,
        });
        b.getInstallStep().dependOn(&ldc.step);
    }
    buildShaders(b);
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

// Use LDC2 (https://github.com/ldc-developers/ldc) to compile the D examples
fn DCompileStep(b: *Build, lib_sokol: *CompileStep, options: LDCOptions) !*RunStep {
    // ldmd2: ldc2 wrapped w/ dmd flags
    const ldc = try b.findProgram(&.{"ldmd2"}, &.{});

    var cmds = std.ArrayList([]const u8).init(b.allocator);
    defer cmds.deinit();

    // D compiler
    try cmds.append(ldc);

    if (options.zig_cc) {
        try cmds.append(b.fmt("--gcc={s}", .{b.pathJoin(&.{ b.install_prefix, "bin", if (options.target.result.os.tag == .windows) "zcc.exe" else "zcc" })}));
        try cmds.append(b.fmt("--linker={s}", .{b.pathJoin(&.{ b.install_prefix, "bin", if (options.target.result.os.tag == .windows) "zcc.exe" else "zcc" })}));
    }

    // set kind of build
    switch (options.kind) {
        .@"test" => {
            try cmds.append("-unittest");
            try cmds.append("-main");
        },
        .lib => try cmds.append("-lib"),
        .obj => try cmds.append("-c"),
        .exe => {},
    }

    if (options.kind == .lib) {
        if (options.linkage == .dynamic) {
            try cmds.append("-shared");
            if (options.target.result.os.tag == .windows) {
                try cmds.append("-fvisibility=public");
                try cmds.append("--dllimport=all");
            }
        } else {
            if (options.target.result.os.tag == .windows)
                try cmds.append("--dllimport=defaultLibsOnly");
            try cmds.append("-fvisibility=hidden");
        }
    }

    for (options.dflags) |dflag| {
        try cmds.append(dflag);
    }

    // betterC disable druntime and phobos
    if (options.betterC)
        try cmds.append("--betterC")
    else if (lib_sokol.linkage == .dynamic or options.linkage == .dynamic)
        // linking the druntime/Phobos as dynamic libraries
        try cmds.append("-link-defaultlib-shared");

    switch (options.optimize) {
        .Debug => {
            try cmds.append("-d-debug");
            try cmds.append("--gc"); // debuginfo for non D dbg
            try cmds.append("-g"); // debuginfo
            try cmds.append("--O0");
            try cmds.append("-vgc");
            try cmds.append("-vtls");
            try cmds.append("-verrors=context");
        },
        .ReleaseSafe => {
            try cmds.append("--O2");
            try cmds.append("--release");
            try cmds.append("--enable-inlining");
            try cmds.append("--boundscheck=on");
        },
        .ReleaseFast => {
            try cmds.append("--O3");
            try cmds.append("--release");
            try cmds.append("--enable-inlining");
            try cmds.append("--boundscheck=off");
        },
        .ReleaseSmall => {
            try cmds.append("--Oz");
            try cmds.append("--release");
            try cmds.append("--enable-inlining");
            try cmds.append("--boundscheck=off");
        },
    }

    // Print character (column) numbers in diagnostics
    try cmds.append("--vcolumns");

    // object file output (zig-cache/o/{hash_id}/*.o)
    if (b.cache_root.path) |path|
        try cmds.append(b.fmt("-od={s}", .{b.pathJoin(&.{ path, "o", b.cache.hash.peek()[0..] })}));

    // name object files uniquely (so the files don't collide)
    try cmds.append("--oq");

    // remove object files after success build, and put them in a unique temp directory
    try cmds.append("--cleanup-obj");

    // disable LLVM-IR verifier
    // https://llvm.org/docs/Passes.html#verify-module-verifier
    try cmds.append("--disable-verify");

    // keep all function bodies in .di files
    try cmds.append("--Hkeep-all-bodies");

    // Include imported modules in the compilation
    // automatically finds needed library files and builds
    try cmds.append("-i");

    // sokol D files and include path
    try cmds.append(b.fmt("-I{s}", .{b.pathJoin(&.{ rootPath(), "src" })}));

    // example D file
    for (options.sources) |src| {
        try cmds.append(src);
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
                try cmds.append(b.fmt("--Xcc={s}", .{flag}));
        break;
    }
    for (lib_sokol.root_module.c_macros.items) |cdefine| {
        if (cdefine.len > 0) // skip empty cdefines
            try cmds.append(b.fmt("--Xcc=-D{s}", .{cdefine}));
        break;
    }

    // link flags
    // GNU LD
    if (options.target.result.os.tag == .linux and !options.zig_cc) {
        try cmds.append("-L--no-as-needed");
    }
    // LLD (not working in zld)
    if (options.target.result.isDarwin() and !options.zig_cc) {
        // https://github.com/ldc-developers/ldc/issues/4501
        try cmds.append("-L-w"); // hide linker warnings

        if (lib_sokol.dead_strip_dylibs) {
            try cmds.append("-L=-dead_strip");
        }
    }
    // Darwin frameworks
    if (options.target.result.isDarwin()) {
        var it = lib_sokol.root_module.frameworks.iterator();
        while (it.next()) |framework| {
            try cmds.append(b.fmt("-L-framework", .{}));
            try cmds.append(b.fmt("-L{s}", .{framework.key_ptr.*}));
        }
    }

    if (b.verbose) {
        try cmds.append("-vdmd");
        // try cmds.append("-v"); // very long
        try cmds.append("-Xcc=-v");
    }

    if (lib_sokol.root_module.sanitize_thread) |tsan|
        if (tsan)
            try cmds.append("--fsanitize=thread");

    // zig enable sanitize=undefined by default
    if (lib_sokol.root_module.sanitize_c) |ubsan|
        if (ubsan)
            try cmds.append("--fsanitize=address");

    if (lib_sokol.root_module.omit_frame_pointer) |enabled| {
        if (enabled)
            try cmds.append("--frame-pointer=none")
        else
            try cmds.append("--frame-pointer=all");
    }

    // link-time optimization
    if (lib_sokol.want_lto) |enabled|
        if (enabled) try cmds.append("--flto=full");

    // ldc2 doesn't support zig native (a.k.a: native-native or native)
    if (options.target.result.isDarwin())
        try cmds.append(b.fmt("--mtriple={s}-apple-{s}", .{ if (options.target.result.cpu.arch.isAARCH64()) "arm64" else @tagName(options.target.result.cpu.arch), @tagName(options.target.result.os.tag) }))
    else if (options.target.result.isWasm())
        try cmds.append(b.fmt("--mtriple={s}-unknown-unknown-{s}", .{ @tagName(options.target.result.cpu.arch), @tagName(options.target.result.os.tag) }))
    else
        try cmds.append(b.fmt("--mtriple={s}-{s}-{s}", .{ @tagName(options.target.result.cpu.arch), @tagName(options.target.result.os.tag), @tagName(options.target.result.abi) }));

    // cpu model (e.g. "baseline")
    // try cmds.append(b.fmt("--mcpu={s}", .{options.target.result.cpu.model.name}));

    // output file
    try cmds.append(b.fmt("--of={s}", .{b.pathJoin(&.{ b.install_prefix, "bin", options.name })}));

    // run the command
    var ldc_exec = b.addSystemCommand(cmds.items);
    ldc_exec.addArtifactArg(lib_sokol);
    ldc_exec.setName(options.name);

    const example_run = b.addSystemCommand(&.{b.pathJoin(&.{ b.install_path, "bin", options.name })});
    example_run.step.dependOn(&ldc_exec.step);

    const run = b.step(b.fmt("run-{s}", .{options.name}), b.fmt("Run {s} example", .{options.name}));
    run.dependOn(&example_run.step);

    return ldc_exec;
}

fn buildZigCC(b: *Build) void {
    const exe = b.addExecutable(.{
        .name = "zcc",
        .target = b.host,
        .optimize = .ReleaseSafe,
        .root_source_file = .{
            .path = "tools/zigcc.zig",
        },
    });
    b.installArtifact(exe);
}

const LDCOptions = struct {
    target: Build.ResolvedTarget,
    optimize: std.builtin.OptimizeMode = .Debug,
    kind: CompileStep.Kind = .exe,
    linkage: CompileStep.Linkage = .static,
    betterC: bool = false,
    sources: []const []const u8,
    dflags: []const []const u8,
    name: []const u8,
    zig_cc: bool = false,
    package: ?*Build.Dependency = null,

    fn packagePath(self: @This(), b: *Build) ?[]const u8 {
        if (self.package) |dep|
            return dep.path("").getPath(b);
        return null;
    }
};
