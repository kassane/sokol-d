/*
zlib/libpng license

Copyright (c) 2023-2025 Matheus Catarino França <matheus-catarino@hotmail.com>

This software is provided 'as-is', without any express or implied warranty.
In no event will the authors be held liable for any damages arising from the
use of this software.
*/
module build;

import std;

// Dependency versions
enum emsdk_version = "4.0.9";
enum imgui_version = "1.91.9";

void main(string[] args) @safe
{
    // Command-line options
    struct Options
    {
        bool help, verbose, downloadEmsdk, downloadImgui, downloadShdc;
        string compiler, target = defaultTarget, optimize = "debug", linkExample, runExample, linkage = "static";
        SokolBackend backend;
        bool useX11 = true, useWayland, useEgl, withSokolImgui;
    }

    Options opts;
    immutable sokolRoot = environment.get("SOKOL_ROOTPATH", getcwd);
    immutable vendorPath = absolutePath(buildPath(sokolRoot, "vendor"));
    immutable sokolSrcPath = absolutePath(buildPath(sokolRoot, "src", "sokol", "c"));

    // Parse arguments
    foreach (arg; args[1 .. $])
        with (opts) switch (arg)
    {
    case "--help":
        help = true;
        break;
    case "--verbose":
        verbose = true;
        break;
    case "--download-emsdk":
        downloadEmsdk = true;
        break;
    case "--download-imgui":
        downloadImgui = true;
        break;
    case "--download-sokol-tools":
        downloadShdc = true;
        break;
    case "--with-sokol-imgui":
        withSokolImgui = true;
        break;
    default:
        if (arg.startsWith("--backend="))
            backend = arg[10 .. $].to!SokolBackend;
        else if (arg.startsWith("--toolchain="))
            compiler = findProgram(arg[12 .. $]);
        else if (arg.startsWith("--optimize="))
            optimize = arg[11 .. $];
        else if (arg.startsWith("--target="))
            target = arg[9 .. $];
        else if (arg.startsWith("--link="))
            linkExample = arg[7 .. $];
        else if (arg.startsWith("--run="))
            runExample = arg[6 .. $];
        else if (arg.startsWith("--linkage="))
        {
            linkage = arg[10 .. $];
            if (!["static", "dynamic"].canFind(linkage))
                throw new Exception("Invalid linkage: use static or dynamic");
        }
        else
            throw new Exception("Unknown argument: " ~ arg);
        break;
    }

    if (args.length < 2 || opts.help)
    {
        writeln("Usage: build [options]\nOptions:");
        writeln("  --help                Show this help message");
        writeln("  --verbose             Enable verbose output");
        writeln("  --backend=<backend>   Select backend (d3d11, metal, glcore, gles3, wgpu)");
        writeln("  --toolchain=<compiler> Select C toolchain (e.g., gcc, clang, emcc)");
        writeln("  --optimize=<level>    Select optimization level (debug, release, small)");
        writeln("  --target=<target>     Select target (native, wasm, android)");
        writeln(
            "  --linkage=<type>      Specify library linkage (static or dynamic, default: static)");
        writeln("  --download-emsdk      Download Emscripten SDK");
        writeln("  --download-imgui      Download ImGui");
        writeln("  --download-sokol-tools Download sokol-tools");
        writeln("  --link=<example>      Link WASM example (e.g., triangle)");
        writeln("  --run=<example>       Run WASM example (e.g., triangle)");
        writeln("  --with-sokol-imgui    Enable sokol_imgui integration");
        return;
    }

    if (opts.backend == SokolBackend._auto)
        opts.backend = resolveSokolBackend(opts.backend, opts.target);

    if (!opts.linkExample && !opts.runExample)
    {
        writeln("Configuration:");
        writeln("  Target: ", opts.target, ", Optimize: ", opts.optimize, ", Backend: ", opts
                .backend);
        writeln("  Linkage: ", opts.linkage);
        writeln("  Download: Emscripten=", opts.downloadEmsdk, ", ImGui=", opts.downloadImgui, ", Sokol-tools=", opts
                .downloadShdc);
        writeln("  Verbose: ", opts.verbose);
    }

    // Setup dependencies
    if (opts.downloadEmsdk || opts.target.canFind("wasm"))
        getEmSDK(vendorPath);
    if (opts.downloadImgui || opts.withSokolImgui)
        getIMGUI(vendorPath);

    // Execute build steps
    if (opts.downloadShdc)
        buildShaders(vendorPath);
    else if (opts.linkExample)
    {
        EmLinkOptions linkOpts = {
            target: "wasm",
            optimize: opts.optimize,
            lib_main: buildPath("build", "lib" ~ opts.linkExample ~ ".a"),
            vendor: vendorPath,
            backend: opts.backend,
            use_emmalloc: true,
            use_imgui: opts.withSokolImgui,
            use_filesystem: false,
            shell_file_path: absolutePath(buildPath(sokolRoot, "src", "sokol", "web", "shell.html")),
            extra_args: [
                "-L" ~ absolutePath(buildPath(sokolRoot, "build")), "-lsokol"
            ],
            verbose: opts.verbose
        };
        emLinkStep(linkOpts);
    }
    else if (opts.runExample)
    {
        emRunStep(EmRunOptions(opts.runExample, vendorPath, opts.verbose));
    }
    else
    {
        LibSokolOptions libOpts = {
            target: opts.target,
            optimize: opts.optimize,
            toolchain: opts.compiler,
            vendor: vendorPath,
            sokolSrcPath: sokolSrcPath,
            backend: opts.backend,
            use_x11: opts.useX11,
            use_wayland: opts.useWayland,
            use_egl: opts.useEgl,
            with_sokol_imgui: opts.withSokolImgui,
            linkageStatic: opts.target.canFind("wasm") ? true : opts.linkage == "static",
            verbose: opts.verbose
        };
        //FIXME: enable in all targets
        if (opts.target.canFind("wasm"))
            buildLibSokol(libOpts);
    }
}

// Dependency management
void getEmSDK(string vendor) @safe
{
    downloadAndExtract("Emscripten SDK", vendor, "emsdk",
        format("https://github.com/emscripten-core/emsdk/archive/refs/tags/%s.zip", emsdk_version),
        (path) => emSdkSetupStep(path));
}

void getIMGUI(string vendor) @safe
{
    downloadAndExtract("ImGui", vendor, "imgui",
        format("https://github.com/floooh/dcimgui/archive/refs/tags/v%s.zip", imgui_version));
}

void buildShaders(string vendor) @safe
{
    immutable shdcPath = getSHDC(vendor);
    immutable shadersDir = "examples/shaders";
    immutable shaders = [
        "triangle", "bufferoffsets", "cube", "instancing", "mrt",
        "noninterleaved", "offscreen", "quad", "shapes", "texcube", "blend"
    ];

    version (OSX)
        enum glsl = "glsl410";
    else
        enum glsl = "glsl430";
    immutable slang = glsl ~ ":metal_macos:hlsl5:glsl300es:wgsl";

    version (Posix)
        executeOrFail(["chmod", "+x", shdcPath], "Failed to set shader permissions", true);

    foreach (shader; shaders)
        executeOrFail([
        shdcPath, "-i", buildPath(shadersDir, shader ~ ".glsl"),
        "-o", buildPath(shadersDir, shader ~ ".d"), "-l", slang, "-f", "sokol_d"
    ], "Shader compilation failed for " ~ shader, true);
}

// Download and extract utility
void downloadAndExtract(string name, string vendor, string dir, string url, void delegate(string) @safe postExtract = null) @safe
{
    writeln("Setting up ", name);
    string path = absolutePath(buildPath(vendor, dir));
    string file = dir ~ ".zip";
    scope (exit)
        if (exists(file))
            remove(file);

    if (!exists(path))
    {
        download(url, file);
        extractZip(file, path);
    }
    if (postExtract)
        postExtract(path);
}

// Core build structures
enum SokolBackend
{
    _auto,
    d3d11,
    metal,
    glcore,
    gles3,
    wgpu
}

struct LibSokolOptions
{
    string target, optimize, toolchain, vendor, sokolSrcPath;
    SokolBackend backend;
    bool use_egl, use_x11 = true, use_wayland, with_sokol_imgui, linkageStatic, verbose;
}

struct EmLinkOptions
{
    string target, optimize, lib_main, vendor, shell_file_path;
    SokolBackend backend;
    bool release_use_closure = true, release_use_lto, use_emmalloc, use_filesystem, use_imgui, verbose;
    string[] extra_args;
}

struct EmRunOptions
{
    string name, vendor;
    bool verbose;
}

// Build Sokol and ImGui libraries
void buildLibSokol(LibSokolOptions opts) @safe
{
    immutable buildDir = absolutePath("build");
    mkdirRecurse(buildDir);

    // Compiler setup
    string compiler = opts.toolchain ? opts.toolchain : defaultCompiler(opts.target);
    string[] cflags = [
        "-DNDEBUG", "-DIMPL",
        format("-DSOKOL_%s", resolveSokolBackend(opts.backend, opts.target).to!string.toUpper)
    ];
    string[] lflags;

    // Platform-specific flags
    switch (opts.target)
    {
    case "darwin":
        cflags ~= [
            "-ObjC", "-Wall", "-Wextra", "-Wno-unused-function",
            "-Wno-return-type-c-linkage"
        ];
        lflags ~= [
            "-framework", "Cocoa", "-framework", "QuartzCore", "-framework",
            "Foundation",
            "-framework", "MetalKit", "-framework", "Metal", "-framework",
            "AudioToolbox"
        ];
        break;
    case "linux":
        cflags ~= ["-Wall", "-Wextra", "-Wno-unused-function"];
        if (opts.use_egl)
            cflags ~= "-DSOKOL_FORCE_EGL";
        if (!opts.use_x11)
            cflags ~= "-DSOKOL_DISABLE_X11";
        if (!opts.use_wayland)
            cflags ~= "-DSOKOL_DISABLE_WAYLAND";
        lflags ~= opts.use_wayland ? [
            "-lwayland-client", "-lwayland-egl", "-lwayland-cursor", "-lxkbcommon"
        ] : [];
        lflags ~= ["-lX11", "-lGL", "-lXi", "-lXcursor", "-lasound"];
        break;
    case "windows":
        cflags ~= ["/DNDEBUG", "/DIMPL", "/wd4190", "/O2"];
        lflags ~= ["dxgi.lib", "d3d11.lib"];
        break;
    case "wasm":
        cflags ~= ["-fPIE"];
        compiler = buildPath(opts.vendor, "emsdk", "upstream", "emscripten", "emcc") ~ (isWindows ? ".bat"
                : "");
        break;
    default:
        break;
    }

    // Optimization and dynamic library flags
    cflags ~= opts.optimize == "debug" && !opts.target.canFind("windows") ? "-O0" : "-O2";
    if (!opts.linkageStatic && !opts.target.canFind("wasm"))
        cflags ~= "-fPIC";

    // Compile Sokol sources
    immutable sokolSources = [
        "sokol_log.c", "sokol_app.c", "sokol_gfx.c", "sokol_time.c",
        "sokol_audio.c",
        "sokol_gl.c", "sokol_debugtext.c", "sokol_shape.c", "sokol_glue.c",
        "sokol_fetch.c", "sokol_memtrack.c"
    ];
    auto sokolObjs = compileSources(sokolSources, buildDir, opts.sokolSrcPath, compiler, cflags, "sokol_", opts
            .verbose);

    // Create Sokol library
    immutable sokolLib = buildPath(buildDir, opts.linkageStatic ? "libsokol.a" : (opts.target.canFind("darwin") ? "libsokol.dylib" : opts
            .target.canFind("windows") ? "sokol.dll" : "libsokol.so"));
    linkLibrary(sokolLib, sokolObjs, opts.target, opts.linkageStatic, opts.vendor, lflags, opts
            .verbose);
    sokolObjs.each!(obj => exists(obj) && remove(obj));

    // Handle ImGui
    if (opts.with_sokol_imgui)
    {
        immutable imguiRoot = absolutePath(buildPath(opts.vendor, "imgui", "src"));
        enforce(exists(imguiRoot), "ImGui source not found. Use --download-imgui.");

        immutable imguiSources = [
            "cimgui.cpp", "imgui.cpp", "imgui_demo.cpp", "imgui_draw.cpp",
            "imgui_tables.cpp", "imgui_widgets.cpp"
        ];
        cflags ~= format("-I%s", imguiRoot);

        string imguiCompiler = opts.target.canFind("wasm") ? buildPath(opts.vendor, "emsdk", "upstream", "emscripten", "em++") ~ (
            isWindows ? ".bat" : "") : compiler.canFind("clang") ? findProgram(compiler ~ "++") : compiler.canFind(
            "gcc") ? findProgram("g++") : compiler;

        // Compile ImGui sources
        auto imguiObjs = compileSources(imguiSources, buildDir, imguiRoot, imguiCompiler, cflags ~ "-DNDEBUG", "imgui_", opts
                .verbose);

        // Compile sokol_imgui.c
        immutable sokolImguiPath = buildPath(opts.sokolSrcPath, "sokol_imgui.c");
        enforce(exists(sokolImguiPath), "sokol_imgui.c not found");
        immutable sokolImguiObj = buildPath(buildDir, "sokol_imgui.o");
        compileSource(sokolImguiPath, sokolImguiObj, compiler, cflags, opts.verbose);
        imguiObjs ~= sokolImguiObj;

        // Create ImGui library
        immutable imguiLib = buildPath(buildDir, opts.linkageStatic ? "libcimgui.a" : (opts.target.canFind("darwin") ? "libcimgui.dylib" : opts
                .target.canFind("windows") ? "cimgui.dll" : "libcimgui.so"));
        linkLibrary(imguiLib, imguiObjs, opts.target, opts.linkageStatic, opts.vendor, lflags, opts
                .verbose);
        imguiObjs.each!(obj => exists(obj) && remove(obj));
    }
}

// Compile a single source file
void compileSource(string srcPath, string objPath, string compiler, string[] cflags, bool verbose) @safe
{
    enforce(exists(srcPath), format("Source file %s does not exist", srcPath));
    string[] cmd = [compiler] ~ cflags ~ ["-c", "-o", objPath, srcPath];
    if (verbose)
        writeln("Executing: ", cmd.join(" "));
    auto result = executeShell(cmd.join(" "));
    if (verbose && result.output.length)
        writeln("Output:\n", result.output);
    enforce(result.status == 0, format("Failed to compile %s: %s", srcPath, result.output));
}

// Compile multiple sources
string[] compileSources(const(string[]) sources, string buildDir, string srcRoot, string compiler, string[] cflags, string prefix, bool verbose) @safe
{
    string[] objFiles;
    foreach (src; sources)
    {
        immutable srcPath = buildPath(srcRoot, src);
        immutable objPath = buildPath(buildDir, prefix ~ src.baseName ~ ".o");
        compileSource(srcPath, objPath, compiler, cflags, verbose);
        objFiles ~= objPath;
    }
    return objFiles;
}

// Link objects into a static or dynamic library
void linkLibrary(string libPath, string[] objFiles, string target, bool linkageStatic, string vendor, string[] lflags, bool verbose) @safe
{
    string arCmd = target.canFind("wasm") ? buildPath(vendor, "emsdk", "upstream", "emscripten", "emar") ~ (
        isWindows ? ".bat" : "") : isWindows ? "lib.exe" : "ar";
    string[] cmd;

    if (!linkageStatic && !target.canFind("wasm"))
    {
        if (target.canFind("darwin"))
        {
            string linker = findProgram("clang");
            cmd = [linker, "-dynamiclib", "-o", libPath] ~ objFiles ~ lflags;
        }
        else if (target.canFind("windows"))
        {
            string linker = findProgram("cl");
            cmd = [linker, "/LD", format("/Fe:%s", libPath)] ~ objFiles ~ lflags;
        }
        else // Linux
        {
            string linker = findProgram("gcc");
            cmd = [linker, "-shared", "-o", libPath] ~ objFiles ~ lflags;
        }
    }
    else if (isWindows && !target.canFind("wasm"))
    {
        cmd = [arCmd, "/nologo", format("/OUT:%s", libPath)] ~ objFiles;
    }
    else
    {
        cmd = [arCmd, "rcs", libPath] ~ objFiles;
    }

    if (verbose)
        writeln("Executing: ", cmd.join(" "));
    auto result = executeShell(cmd.join(" "));
    if (verbose && result.output.length)
        writeln("Output:\n", result.output);
    enforce(result.status == 0, format("Failed to create %s: %s", libPath, result.output));
}

// Link WASM executable
void emLinkStep(EmLinkOptions opts) @safe
{
    string emcc = buildPath(opts.vendor, "emsdk", "upstream", "emscripten", opts.use_imgui ? "em++"
            : "emcc") ~ (isWindows ? ".bat" : "");
    string[] cmd = [emcc];

    if (opts.use_imgui)
        cmd ~= "-lcimgui";
    if (opts.optimize == "debug")
        cmd ~= ["-Og", "-sSAFE_HEAP=1", "-sSTACK_OVERFLOW_CHECK=1"];
    else
    {
        cmd ~= "-sASSERTIONS=0";
        cmd ~= opts.optimize == "small" ? "-Oz" : "-O3";
        if (opts.release_use_lto)
            cmd ~= "-flto";
        if (opts.release_use_closure)
            cmd ~= ["--closure", "1"];
    }

    if (opts.backend == SokolBackend.wgpu)
        cmd ~= "-sUSE_WEBGPU=1";
    if (opts.backend == SokolBackend.gles3)
        cmd ~= "-sUSE_WEBGL2=1";
    if (!opts.use_filesystem)
        cmd ~= "-sNO_FILESYSTEM=1";
    if (opts.use_emmalloc)
        cmd ~= "-sMALLOC='emmalloc'";
    if (opts.shell_file_path)
        cmd ~= "--shell-file=" ~ opts.shell_file_path;

    cmd ~= ["-sSTACK_SIZE=512KB"] ~ opts.extra_args ~ opts.lib_main;
    immutable baseName = opts.lib_main.baseName[3 .. $ - 2]; // Strip "lib" and ".a"
    string outFile = buildPath("build", baseName ~ ".html");
    cmd ~= ["-o", outFile];

    if (opts.verbose)
        writeln("Executing: ", cmd.join(" "));
    auto result = executeShell(cmd.join(" "));
    if (opts.verbose && result.output.length)
        writeln("Output:\n", result.output);
    enforce(result.status == 0, format("emcc failed: %s: %s", outFile, result.output));

    string webDir = "web";
    mkdirRecurse(webDir);
    foreach (ext; [".html", ".wasm", ".js"])
        copy(buildPath("build", baseName ~ ext), buildPath(webDir, baseName ~ ext));
}

// Run WASM executable
void emRunStep(EmRunOptions opts) @safe
{
    string emrun = buildPath(opts.vendor, "emsdk", "upstream", "emscripten", "emrun") ~ (
        isWindows ? ".bat" : "");
    executeOrFail([emrun, buildPath("web", opts.name ~ ".html")], "emrun failed", opts.verbose);
}

// Setup Emscripten SDK
void emSdkSetupStep(string emsdk) @safe
{
    if (!exists(buildPath(emsdk, ".emscripten")))
    {
        immutable cmd = buildPath(emsdk, "emsdk") ~ (isWindows ? ".bat" : "");
        executeOrFail([!isWindows ? "bash " ~ cmd : cmd, "install", "latest"], "emsdk install failed", true);
        executeOrFail([!isWindows ? "bash " ~ cmd : cmd, "activate", "latest"], "emsdk activate failed", true);
    }
}

// Utility functions
string findProgram(string programName) @safe
{
    foreach (path; environment.get("PATH").split(pathSeparator))
    {
        string fullPath = buildPath(path, programName);
        version (Windows)
            fullPath ~= ".exe";
        if (exists(fullPath) && isFile(fullPath))
            return fullPath;
    }
    throw new Exception(format("Program '%s' not found in PATH", programName));
}

string defaultCompiler(string target) @safe
{
    if (target.canFind("wasm"))
        return "";
    version (linux)
        return findProgram("gcc");
    version (Windows)
        return findProgram("cl");
    version (OSX)
        return findProgram("clang");
    version (Android)
        return findProgram("clang");
    throw new Exception("Unsupported platform");
}

SokolBackend resolveSokolBackend(SokolBackend backend, string target) @safe
{
    if (target.canFind("linux"))
        return SokolBackend.glcore;
    if (target.canFind("darwin"))
        return SokolBackend.metal;
    if (target.canFind("windows"))
        return SokolBackend.d3d11;
    if (target.canFind("wasm"))
        return backend == SokolBackend.wgpu ? backend : SokolBackend.gles3;
    if (target.canFind("android"))
        return SokolBackend.gles3;
    version (linux)
        return SokolBackend.glcore;
    version (Windows)
        return SokolBackend.d3d11;
    version (OSX)
        return SokolBackend.metal;
    return backend;
}

void executeOrFail(string[] cmd, string errorMsg, bool verbose) @safe
{
    if (verbose)
        writeln("Executing: ", cmd.join(" "));
    auto result = executeShell(cmd.join(" "));
    if (verbose && result.output.length)
        writeln("Output:\n", result.output);
    enforce(result.status == 0, format("%s: %s", errorMsg, result.output));
}

bool isWindows() @safe
{
    version (Windows)
        return true;
    return false;
}

// Download and extract functions
void download(string url, string fileName) @trusted
{
    auto buf = appender!(ubyte[])();
    size_t contentLength;
    auto http = HTTP(url);
    http.onReceiveHeader((in k, in v) {
        if (k == "content-length")
            contentLength = to!size_t(v);
    });

    int barWidth = 50;
    http.onReceive((data) {
        buf.put(data);
        if (contentLength)
        {
            float progress = cast(float) buf.data.length / contentLength;
            write("\r[", "=".replicate(cast(int)(barWidth * progress)), ">", " ".replicate(
                barWidth - cast(int)(barWidth * progress)), "] ",
                format("%d%%", cast(int)(progress * 100)));
            stdout.flush();
        }
        return data.length;
    });

    http.perform();
    enforce(http.statusLine.code / 100 == 2 || http.statusLine.code == 302, format(
            "HTTP request failed: %s", http.statusLine.code));
    std.file.write(fileName, buf.data);
    writeln();
}

void extractZip(string zipFile, string destination) @trusted
{
    ZipArchive archive = new ZipArchive(read(zipFile));
    string prefix = archive.directory.keys.front[0 .. $ - archive.directory.keys.front.find("/")
            .length + 1];

    if (exists(destination))
        rmdirRecurse(destination);
    mkdirRecurse(destination);

    foreach (name, am; archive.directory)
    {
        if (!am.expandedSize)
            continue;
        string path = buildPath(destination, chompPrefix(name, prefix));
        mkdirRecurse(dirName(path));
        std.file.write(path, archive.expand(am));
    }
}

string getSHDC(string vendor) @safe
{
    string path = absolutePath(buildPath(vendor, "shdc"));
    string file = "shdc.zip";
    scope (exit)
        if (exists(file))
            remove(file);

    if (!exists(path))
    {
        download("https://github.com/floooh/sokol-tools-bin/archive/refs/heads/master.zip", file);
        extractZip(file, path);
    }

    version (Windows)
        immutable shdc = buildPath("bin", "win32", "sokol-shdc.exe");
    else version (linux)
        immutable shdc = buildPath("bin", isAArch64 ? "linux_arm64" : "linux", "sokol-shdc");
    else version (OSX)
        immutable shdc = buildPath("bin", isAArch64 ? "osx_arm64" : "osx", "sokol-shdc");
    else
        throw new Exception("Unsupported platform for sokol-tools");

    return buildPath(path, shdc);
}

bool isAArch64() @safe
{
    version (AArch64)
        return true;
    return false;
}

string defaultTarget() @safe
{
    version (linux)
        return "linux";
    version (Windows)
        return "windows";
    version (OSX)
        return "darwin";
    version (Android)
        return "android";
    version (Emscripten)
        return "wasm";
    throw new Exception("Unsupported platform");
}
