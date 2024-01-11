//! based on sokol-zig

const std = @import("std");
const builtin = @import("builtin");
const Builder = std.Build;
const CompileStep = Builder.Step.Compile;
const RunStep = Builder.Step.Run;
const CrossTarget = Builder.ResolvedTarget;
const OptimizeMode = std.builtin.OptimizeMode;
const fmt = std.fmt;

pub const Backend = enum {
    auto, // Windows: D3D11, macOS/iOS: Metal, otherwise: GL
    d3d11,
    metal,
    gl,
    gles2,
    gles3,
    wgpu,
};

pub const Config = struct {
    backend: Backend = .auto,
    force_egl: bool = false,
    enable_x11: bool = true,
    enable_wayland: bool = false,
};

fn rootPath() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}

// build sokol into a static library
pub fn buildSokol(b: *Builder, target: CrossTarget, optimize: OptimizeMode, config: Config, comptime prefix_path: []const u8) *CompileStep {
    const sharedlib = b.option(bool, "Shared", "Build sokol dynamic library [default: static]") orelse false;
    const lib = if (sharedlib) b.addSharedLibrary(.{
        .name = "sokol",
        .target = target,
        .optimize = optimize,
    }) else b.addStaticLibrary(.{
        .name = "sokol",
        .target = target,
        .optimize = optimize,
    });
    lib.root_module.sanitize_c = false;
    lib.linkLibC();
    const sokol_path = prefix_path ++ "src/sokol/c/";
    const csources = [_][]const u8{
        "sokol_log.c",
        "sokol_app.c",
        "sokol_gfx.c",
        "sokol_glue.c",
        "sokol_time.c",
        "sokol_audio.c",
        "sokol_gl.c",
        "sokol_debugtext.c",
        "sokol_shape.c",
    };
    var _backend = config.backend;
    if (_backend == .auto) {
        if (lib.rootModuleTarget().isDarwin()) {
            _backend = .metal;
        } else if (lib.rootModuleTarget().os.tag == .windows) {
            _backend = .d3d11;
        } else if (lib.rootModuleTarget().abi == .android) {
            _backend = .gles3;
        } else {
            _backend = .gl;
        }
    }
    const backend_option = switch (_backend) {
        .d3d11 => "-DSOKOL_D3D11",
        .metal => "-DSOKOL_METAL",
        .gl => "-DSOKOL_GLCORE33",
        .gles2 => "-DSOKOL_GLES2",
        .gles3 => "-DSOKOL_GLES3",
        .wgpu => "-DSOKOL_WGPU",
        else => unreachable,
    };

    if (lib.rootModuleTarget().isDarwin()) {
        inline for (csources) |csrc| {
            lib.addCSourceFile(.{
                .file = .{ .path = sokol_path ++ csrc },
                .flags = switch (target.result.os.tag) {
                    .macos => &.{ "-ObjC", "-DIMPL", "-mmacos-version-min=12", backend_option },
                    else => &.{ "-ObjC", "-DIMPL", backend_option },
                },
            });
        }
        lib.linkFramework("Foundation");
        lib.linkFramework("AudioToolbox");
        if (.metal == _backend) {
            lib.linkFramework("MetalKit");
            lib.linkFramework("Metal");
        }
        if (lib.rootModuleTarget().os.tag == .ios) {
            lib.linkFramework("UIKit");
            lib.linkFramework("AVFoundation");
            if (.gl == _backend) {
                lib.linkFramework("OpenGLES");
                lib.linkFramework("GLKit");
            }
        } else if (lib.rootModuleTarget().os.tag == .macos) {
            lib.linkFramework("Cocoa");
            lib.linkFramework("QuartzCore");
            if (.gl == _backend) {
                lib.linkFramework("OpenGL");
            }
        }
    } else {
        const egl_flag = if (config.force_egl) "-DSOKOL_FORCE_EGL " else "";
        const x11_flag = if (!config.enable_x11) "-DSOKOL_DISABLE_X11 " else "";
        const wayland_flag = if (!config.enable_wayland) "-DSOKOL_DISABLE_WAYLAND" else "";

        inline for (csources) |csrc| {
            lib.addCSourceFile(.{
                .file = .{ .path = sokol_path ++ csrc },
                .flags = &[_][]const u8{ "-DIMPL", backend_option, egl_flag, x11_flag, wayland_flag },
            });
        }

        if (lib.rootModuleTarget().abi == .android) {
            if (.gles3 != _backend) {
                @panic("For android targets, you must have backend set to GLES3");
            }
            lib.linkSystemLibrary("GLESv3");
            lib.linkSystemLibrary("EGL");
            lib.linkSystemLibrary("android");
            lib.linkSystemLibrary("log");
        } else if (lib.rootModuleTarget().os.tag == .linux) {
            const link_egl = config.force_egl or config.enable_wayland;
            const egl_ensured = (config.force_egl and config.enable_x11) or config.enable_wayland;

            lib.linkSystemLibrary("asound");

            if (.gles2 == _backend) {
                lib.linkSystemLibrary("glesv2");
                if (!egl_ensured) {
                    @panic("GLES2 in Linux only available with Config.force_egl and/or Wayland");
                }
            } else {
                lib.linkSystemLibrary("GL");
            }
            if (config.enable_x11) {
                lib.linkSystemLibrary("X11");
                lib.linkSystemLibrary("Xi");
                lib.linkSystemLibrary("Xcursor");
            }
            if (config.enable_wayland) {
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
            if (.d3d11 == _backend) {
                lib.linkSystemLibrary("d3d11");
                lib.linkSystemLibrary("dxgi");
            }
        }
    }
    return lib;
}

pub fn build(b: *Builder) !void {
    var config: Config = .{};

    const force_gl = b.option(bool, "gl", "Force GL backend") orelse false;
    config.backend = if (force_gl) .gl else .auto;

    // NOTE: Wayland support is *not* currently supported in the standard sokol-zig bindings,
    // you need to generate your own bindings using this PR: https://github.com/floooh/sokol/pull/425
    config.enable_wayland = b.option(bool, "wayland", "Compile with wayland-support (default: false)") orelse false;
    config.enable_x11 = b.option(bool, "x11", "Compile with x11-support (default: true)") orelse true;
    config.force_egl = b.option(bool, "egl", "Use EGL instead of GLX if possible (default: false)") orelse false;

    var target = b.standardTargetOptions(.{});

    // ldc2 w/ druntime + phobos2 works on MSVC
    if (target.result.os.tag == .windows and target.query.isNative()) {
        target.result.abi = .msvc; // for ldc2
        target.query.abi = .msvc; // for libsokol
    }

    const optimize = b.standardOptimizeOption(.{});
    const sokol = buildSokol(b, target, optimize, config, "");

    // LDC-config options
    const enable_betterC = b.option(bool, "BetterC", "Omit generating some runtime information and helper functions. [default: false]") orelse false;
    const enable_zigcc = b.option(bool, "ZigCC", "Use zig cc as compiler and linker. [default: false]") orelse false;

    if (enable_zigcc)
        buildZigCC(b);

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
        // "saudio",
        // "sgl",
        "sgl-context",
        // "sgl-points",
        // "debugtext",
        "debugtext-print",
        // "debugtext-userfont",
        // "shapes",
    };
    b.getInstallStep().name = "sokol library";
    inline for (examples) |example| {
        const ldc = try buildLDC(b, sokol, .{
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
        });
        ldc.setName(example);
        b.getInstallStep().dependOn(&ldc.step);

        const example_run = b.addSystemCommand(&.{b.pathJoin(&.{ b.install_path, "bin", example })});
        const run = b.step(b.fmt("run-{s}", .{example}), b.fmt("Run example {s}", .{example}));
        run.dependOn(&example_run.step);
    }
    buildShaders(b);
}

// a separate step to compile shaders, expects the shader compiler in ../sokol-tools-bin/
fn buildShaders(b: *Builder) void {
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
            "glsl330:metal_macos:hlsl4",
            "-f",
            "sokol_d",
        });
        shdc_step.dependOn(&cmd.step);
    }
}

// Use LDC2 (https://github.com/ldc-developers/ldc) to compile the D examples
fn buildLDC(b: *Builder, lib: *CompileStep, config: ldcConfig) !*RunStep {
    // ldmd2: ldc2 wrapped w/ dmd flags
    const ldc = try b.findProgram(&.{"ldmd2"}, &.{});

    var cmds = std.ArrayList([]const u8).init(b.allocator);
    defer cmds.deinit();

    // D compiler
    try cmds.append(ldc);

    if (config.zig_cc) {
        try cmds.append(b.fmt("--gcc={s}", .{b.pathJoin(&.{ b.install_prefix, "bin", if (lib.rootModuleTarget().os.tag == .windows) "zcc.exe" else "zcc" })}));
        try cmds.append(b.fmt("--linker={s}", .{b.pathJoin(&.{ b.install_prefix, "bin", if (lib.rootModuleTarget().os.tag == .windows) "zcc.exe" else "zcc" })}));
    }

    // set kind of build
    switch (config.kind) {
        .@"test" => {
            try cmds.append("-unittest");
            try cmds.append("-main");
        },
        .lib => try cmds.append("-lib"),
        .obj => try cmds.append("-c"),
        .exe => {},
    }

    if (config.kind == .lib) {
        if (config.linkage == .dynamic)
            try cmds.append("-shared");
    }

    for (config.dflags) |dflag| {
        try cmds.append(dflag);
    }

    // betterC disable druntime and phobos
    if (config.betterC)
        try cmds.append("--betterC");

    switch (lib.root_module.optimize.?) {
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

    // object files with fully qualified names
    try cmds.append("--oq");

    // disable LLVM-IR verifier
    // https://llvm.org/docs/Passes.html#verify-module-verifier
    try cmds.append("--disable-verify");

    // keep all function bodies in .di files
    try cmds.append("--Hkeep-all-bodies");

    // Include imported modules in the compilation
    // automatically finds needed library files and builds
    try cmds.append("-i");

    // sokol D files and include path
    try cmds.append(b.fmt("-I{s}", .{b.pathJoin(&.{
        rootPath(),
        "src",
    })}));

    // example D file
    for (config.sources) |src| {
        try cmds.append(src);
    }

    // library paths
    for (lib.root_module.lib_paths.items) |libpath| {
        if (libpath.path.len > 0) // skip empty paths
            try cmds.append(b.fmt("-L-L{s}", .{libpath.path}));
    }

    // link system libs
    for (lib.root_module.link_objects.items) |link_object| {
        if (link_object != .system_lib) continue;
        const system_lib = link_object.system_lib;
        try cmds.append(b.fmt("-L-l{s}", .{system_lib.name}));
    }
    // C flags
    for (lib.root_module.link_objects.items) |link_object| {
        if (link_object != .c_source_file) continue;
        const c_source_file = link_object.c_source_file;
        for (c_source_file.flags) |flag|
            if (flag.len > 0) // skip empty flags
                try cmds.append(b.fmt("--Xcc={s}", .{flag}));
        break;
    }
    for (lib.root_module.c_macros.items) |cdefine| {
        if (cdefine.len > 0) // skip empty cdefines
            try cmds.append(b.fmt("--Xcc=-D{s}", .{cdefine}));
        break;
    }

    // link flags
    // GNU LD
    if (lib.rootModuleTarget().os.tag == .linux and !config.zig_cc)
        try cmds.append("-L--no-as-needed");
    // LLD (not working in zld)
    if (lib.rootModuleTarget().isDarwin() and !config.zig_cc)
        // https://github.com/ldc-developers/ldc/issues/4501
        try cmds.append("-L-w"); // resolve linker warnings

    // Darwin frameworks
    if (lib.rootModuleTarget().isDarwin()) {
        var it = lib.root_module.frameworks.iterator();
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

    if (lib.root_module.sanitize_thread) |tsan|
        if (tsan)
            try cmds.append("--fsanitize=thread");

    // zig enable sanitize=undefined by default
    if (lib.root_module.sanitize_c) |ubsan|
        if (ubsan)
            try cmds.append("--fsanitize=address");

    if (lib.root_module.omit_frame_pointer) |enabled| {
        if (enabled)
            try cmds.append("--frame-pointer=none")
        else
            try cmds.append("--frame-pointer=all");
    }

    // link-time optimization
    if (lib.want_lto) |enabled|
        if (enabled) try cmds.append("--flto=full");

    // ldc2 doesn't support zig native (a.k.a: native-native or native)
    if (lib.rootModuleTarget().isDarwin())
        try cmds.append(b.fmt("--mtriple={s}-apple-{s}", .{ if (lib.rootModuleTarget().cpu.arch.isAARCH64()) "arm64" else @tagName(lib.rootModuleTarget().cpu.arch), @tagName(lib.rootModuleTarget().os.tag) }))
    else if (lib.rootModuleTarget().isWasm())
        try cmds.append(b.fmt("--mtriple={s}-unknown-unknown-{s}", .{ @tagName(lib.rootModuleTarget().cpu.arch), @tagName(lib.rootModuleTarget().os.tag) }))
    else
        try cmds.append(b.fmt("--mtriple={s}-{s}-{s}", .{ @tagName(lib.rootModuleTarget().cpu.arch), @tagName(lib.rootModuleTarget().os.tag), @tagName(lib.rootModuleTarget().abi) }));

    // cpu model (e.g. "baseline")
    // try cmds.append(b.fmt("--mcpu={s}", .{lib.rootModuleTarget().cpu.model.name}));

    // output file
    try cmds.append(b.fmt("--of={s}", .{b.pathJoin(&.{ b.install_prefix, "bin", config.name orelse "d_binary" })}));

    // run the command
    var ldc_exec = b.addSystemCommand(cmds.items);
    ldc_exec.addArtifactArg(lib);
    return ldc_exec;
}

fn buildZigCC(b: *Builder) void {
    const exe = b.addExecutable(.{
        .name = "zcc",
        .target = b.host, // native (host)
        .optimize = .ReleaseSafe,
        .root_source_file = .{
            .path = "tools/zigcc.zig",
        },
    });
    b.installArtifact(exe);
}

const ldcConfig = struct {
    kind: CompileStep.Kind = .exe,
    linkage: CompileStep.Linkage = .static,
    betterC: bool = false,
    sources: []const []const u8 = std.mem.zeroes([]const []const u8),
    dflags: []const []const u8 = std.mem.zeroes([]const []const u8),
    name: ?[]const u8 = null,
    zig_cc: bool = false,
};
