/*
zlib/libpng license

Copyright (c) 2023-2024 Matheus Catarino França <matheus-catarino@hotmail.com>

This software is provided 'as-is', without any express or implied warranty.
In no event will the authors be held liable for any damages arising from the
use of this software.
*/
module build;

import std;

// Versions for dependencies
enum emsdk_version = "4.0.9";
enum imgui_version = "1.91.9";
enum zig_version = "0.14.0";

void main(string[] args) @safe
{
    // Parse command line arguments
    bool help = false;
    bool verbose = false;
    string compiler;
    string target;
    string optimize = "debug";
    SokolBackend sokol_backend;
    bool downloadEmsdk = false, downloadZig = false, downloadIMGUI = false, downloadSHDC = false;
    string sokolEnv = environment.get("SOKOL_ROOTPATH", getcwd);
    string vendorPath = absolutePath(buildPath(sokolEnv, "vendor"));
    bool link = false;
    string linkExample;
    bool run = false;
    string runExample;
    // backend options
    bool opt_use_glcore = false;
    bool opt_use_gles3 = false;
    bool opt_use_wgpu = false;
    bool opt_use_x11 = true;
    bool opt_use_wayland = false;
    bool opt_use_egl = false;
    bool opt_with_sokol_imgui = false;

    foreach (arg; args[1 .. $])
    {
        if (arg == "--help")
            help = true;
        else if (arg == "--verbose")
            verbose = true;
        else if (arg.startsWith("--backend="))
            sokol_backend = resolveSokolBackend(
                arg["--backend=".length .. $].to!SokolBackend, target);
        else if (arg.startsWith("--toolchain="))
            compiler = findProgram(arg["--toolchain=".length .. $]);
        else if (arg.startsWith("--optimize="))
            optimize = arg["--optimize=".length .. $];
        else if (arg.startsWith("--target="))
            target = arg["--target=".length .. $];
        else if (arg == "--download-emsdk")
            downloadEmsdk = true;
        else if (arg == "--download-zig")
            downloadZig = true;
        else if (arg == "--download-imgui")
            downloadIMGUI = true;
        else if (arg == "--download-sokol-tools")
            downloadSHDC = true;
        else if (arg.startsWith("--link="))
        {
            link = true;
            linkExample = arg["--link=".length .. $];
        }
        else if (arg.startsWith("--run="))
        {
            run = true;
            runExample = arg["--run=".length .. $];
        }
        else if (arg == "--use-glcore")
            opt_use_glcore = true;
        else if (arg == "--use-gles3")
            opt_use_gles3 = true;
        else if (arg == "--use-wgpu")
            opt_use_wgpu = true;
        else if (arg == "--with-sokol-imgui")
            opt_with_sokol_imgui = true;
    }

    if (args.length < 2 || help)
    {
        writeln("Usage: dub run -- [options]");
        writeln("Options:");
        writeln("  --help                   Show this help message");
        writeln("  --verbose                Enable verbose output for compiler commands");
        writeln("  --backend=<backend>      Select backend (d3d11, metal, glcore, gles3, wgpu)");
        writeln("  --toolchain=<compiler>   Select C toolchain (gcc, clang, emcc)");
        writeln("  --optimize=<level>       Select optimization level (debug, release)");
        writeln("  --target=<target>        Select target (native, wasm, android)");
        writeln("  --download-emsdk         Download and setup Emscripten SDK");
        writeln("  --download-zig           Download and setup Zig toolchain");
        writeln("  --download-imgui         Download and build imgui");
        writeln("  --download-sokol-tools   Download and setup sokol-tools");
        writeln("  --link=<example>         Link WASM example (e.g., triangle, cube)");
        writeln("  --run=<example>          Run WASM example HTML (e.g., triangle, cube)");
        writeln("  --use-glcore             Enable GL Core backend");
        writeln("  --use-gles3              Enable GLES3 backend");
        writeln("  --use-wgpu               Enable WebGPU backend");
        writeln("  --with-sokol-imgui       Enable sokol_imgui integration");
        return;
    }

    if (!link && !run)
    {
        writeln("Current configuration:");
        writeln("Using target: ", target);
        writeln("Using optimize: ", optimize);
        writeln("Using backend: ", sokol_backend);
        writeln("Get imgui-libs: ", downloadIMGUI);
        writeln("Get sokol-tools: ", downloadSHDC);
        writeln("Get Emscripten: ", downloadEmsdk);
        writeln("Download Zig: ", downloadZig);
        writeln("Verbose mode: ", verbose);
    }

    // Download and setup dependencies
    if (downloadEmsdk || target.canFind("wasm"))
        getEmSDK(vendorPath);
    if (downloadIMGUI || opt_with_sokol_imgui)
        getIMGUI(vendorPath);
    if (downloadZig)
        getZigToolchain(vendorPath);
    if (downloadSHDC)
        buildShaders(vendorPath);

    if (link)
    {
        // Link WASM example
        EmLinkOptions linkOptions = {
            target: "wasm",
            optimize: optimize,
            lib_main: buildPath("build", "lib" ~ linkExample ~ ".a"),
            vendor: vendorPath,
            use_webgl2: opt_use_gles3,
            use_webgpu: opt_use_wgpu,
            use_emmalloc: true,
            use_imgui: opt_with_sokol_imgui,
            use_filesystem: false,
            shell_file_path: absolutePath(buildPath(sokolEnv, "src", "sokol", "web", "shell.html")),
            extra_args: [
                "-L" ~ absolutePath(buildPath(sokolEnv, "build")),
                "-lsokol", "-lsokold"
            ],
            verbose: verbose
        };
        emLinkStep(linkOptions);
    }
    else if (run)
    {
        // Run WASM example
        EmRunOptions runOptions = {name: runExample,
        vendor: vendorPath};
        emRunStep(runOptions);
    }
    else
    {
        // Build libsokol
        LibSokolOptions options = {
            target: target,
            optimize: optimize,
            toolchain: compiler,
            backend: sokol_backend,
            use_wayland: opt_use_wayland,
            use_x11: opt_use_x11,
            use_egl: opt_use_egl,
            use_glcore: opt_use_glcore,
            use_gles3: opt_use_gles3,
            use_wgpu: opt_use_wgpu,
            with_sokol_imgui: opt_with_sokol_imgui,
            verbose: verbose,
            vendor: vendorPath,
        };
        buildLibSokol(options);
    }
}

void getZigToolchain(ref string rootpath) @safe
{
    writeln("Downloading and setting up Zig toolchain...");

    version (Windows)
        immutable string ext = ".zip", exe = ".exe";
    else
        immutable string ext = ".tar.xz", exe = "";

    version (Windows)
        immutable string os = "windows";
    else version (linux)
        immutable string os = "linux";
    else version (OSX)
        immutable string os = "macos";
    else version (FreeBSD)
        immutable string os = "freebsd";
    else
        static assert(0, "Unsupported OS");

    version (X86_64)
        immutable string arch = "x86_64";
    else version (X86)
        immutable string arch = "x86";
    else version (AArch64)
        immutable string arch = "aarch64";
    else
        static assert(0, "Unsupported architecture");

    immutable string filename = fmt("zig-%s-%s-%s", os, arch, zig_version);
    writeln("file: ", filename ~ ext);
    writeln("rootpath: ", rootpath);

    scope (exit)
    {
        if (exists(filename ~ ext))
            remove(filename ~ ext);
    }

    if (!exists(rootpath))
    {
        download(fmt("https://ziglang.org/download/%s/%s", zig_version, filename ~ ext), filename ~ ext);
        if (ext.endsWith("zip"))
            extractZip(filename ~ ext, rootpath);
        else
            extractTarXZ(filename ~ ext, rootpath);
    }

    immutable string extractedPath = buildPath(rootpath, filename);
    immutable string newPath = buildPath(rootpath, "zig");
    if (exists(extractedPath) && !exists(newPath))
        rename(extractedPath, newPath);

    rootpath = newPath;

    auto res = execute([
        absolutePath(buildPath(rootpath, "zig")) ~ exe, "version"
    ]);
    enforce(res.status == 0, "Failed to run Zig toolchain");
    writefln("zig version: %s", res.output);
}

void getEmSDK(ref string vendor) @safe
{
    writeln("Downloading and setting up Emscripten SDK");
    string rootpath = absolutePath(buildPath(vendor, "emsdk"));
    string filename = "emsdk.zip";

    scope (exit)
    {
        if (exists(filename))
            remove(filename);
    }

    if (!exists(rootpath))
    {
        if (!exists(filename))
            download(fmt("https://github.com/emscripten-core/emsdk/archive/refs/tags/%s.zip", emsdk_version), filename);
        extractZip(filename, rootpath);
    }

    writeln("Emscripten SDK path: ", rootpath);
    emSdkSetupStep(rootpath);
}

void getIMGUI(ref string vendor) @safe
{
    writeln("Downloading IMGUI");
    string rootpath = absolutePath(buildPath(vendor, "imgui"));
    string filename = "imgui.zip";

    scope (exit)
    {
        if (exists(filename))
            remove(filename);
    }

    if (!exists(rootpath))
    {
        download(fmt("https://github.com/floooh/dcimgui/archive/refs/tags/v%s.zip", imgui_version), filename);
        extractZip(filename, rootpath);
    }
    writeln("rootpath: ", rootpath);
}

string getSHDC(ref string vendor) @safe
{
    writeln("Downloading and setting up sokol-tools");
    immutable string rootpath = absolutePath(buildPath(vendor, "shdc"));
    immutable string filename = "shdc.zip";

    if (!exists(rootpath))
        download("https://github.com/floooh/sokol-tools-bin/archive/refs/heads/master.zip", filename);
    else if (exists(filename))
        scope (exit)
            remove(filename);

    if (!exists(rootpath))
        extractZip(filename, rootpath);

    version (Windows)
        immutable string ext = ".bat";
    else
        immutable string ext = "";

    writeln("rootpath: ", rootpath);
    return rootpath;
}

void extractTarXZ(string tarFile, string destination) @safe
{
    if (exists(destination))
        rmdirRecurse(destination);

    mkdirRecurse(destination);
    auto pid = spawnProcess([
        "tar", "xf", tarFile, fmt("--directory=%s", destination)
    ]);
    enforce(pid.wait() == 0, "Extraction failed");
}

void extractZip(string zipFile, string destination) @trusted
{
    ZipArchive archive = new ZipArchive(read(zipFile));
    writeln("unpacking: ", zipFile);
    string prefix;

    if (exists(zipFile))
        std.file.remove(zipFile);

    if (exists(destination))
        rmdirRecurse(destination);

    mkdirRecurse(destination);

    foreach (name, _; archive.directory)
    {
        prefix = name[0 .. $ - name.find("/").length + 1];
        break;
    }
    foreach (name, am; archive.directory)
    {
        if (!am.expandedSize)
            continue;

        string path = buildPath(destination, chompPrefix(name, prefix));
        auto dir = dirName(path);
        if (!dir.empty && !dir.exists)
            mkdirRecurse(dir);
        archive.expand(am);
        std.file.write(path, am.expandedData);
    }
}

void download(string url, string fileName) @trusted
{
    auto buf = appender!(ubyte[])();
    size_t contentLength;

    auto http = HTTP(url);
    http.method = HTTP.Method.get;
    http.onReceiveHeader((in k, in v) {
        if (k == "content-length")
            contentLength = to!size_t(v);
    });

    int barWidth = 50;
    http.onReceive((data) {
        buf.put(data);
        if (contentLength > 0)
        {
            float progress = cast(float) buf.data.length / contentLength;
            int pos = cast(int)(barWidth * progress);

            write("\r[");
            for (int i = 0; i < barWidth; ++i)
            {
                if (i < pos)
                    write("=");
                else if (i == pos)
                    write(">");
                else
                    write(" ");
            }
            writef("] %d%%", cast(int)(progress * 100));
            stdout.flush();
        }
        return data.length;
    });

    http.dataTimeout = dur!"msecs"(0);
    http.perform();
    immutable sc = http.statusLine().code;
    enforce(sc / 100 == 2 || sc == 302, fmt("HTTP request returned status code %s", sc));

    auto file = File(fileName, "wb");
    scope (success)
        file.close();
    file.rawWrite(buf.data);
    writeln();
}

enum SokolBackend : ushort
{
    d3d11,
    metal,
    glcore,
    gles3,
    wgpu
}

struct LibSokolOptions
{
    string target;
    string optimize;
    string toolchain;
    SokolBackend backend;
    bool use_glcore = false;
    bool use_gles3 = false;
    bool use_egl = false;
    bool use_x11 = true;
    bool use_wayland = false;
    bool use_wgpu = false;
    string vendor = null;
    bool with_sokol_imgui = false;
    bool sharedlib = false;
    bool verbose = false; // Add verbose flag
}

SokolBackend resolveSokolBackend(SokolBackend backend, string target) @safe
{
    if (target.canFind("linux"))
        return backend.glcore;
    else if (target.canFind("darwin"))
        return backend.metal;
    else if (target.canFind("windows"))
        return backend.d3d11;
    else if (target.canFind("wasm"))
        return backend != SokolBackend.wgpu ? backend.gles3 : backend;
    else if (target.canFind("android"))
        return backend.gles3;
    else
    {
        // Default to auto-detect (host)
        version (linux)
            return backend.glcore;
        else version (Windows)
            return backend.d3d11;
        else version (OSX)
            return backend.metal;
        else
            return backend;
    }
}

void buildLibSokol(LibSokolOptions options) @safe
{
    string buildDir = absolutePath("build");
    mkdirRecurse(buildDir);

    // Common compiler flags
    string[] cflags = ["-DNDEBUG", "-DIMPL"];
    string[] csources = [
        "sokol_log.c", "sokol_app.c", "sokol_gfx.c", "sokol_time.c",
        "sokol_audio.c", "sokol_gl.c", "sokol_debugtext.c", "sokol_shape.c",
        "sokol_glue.c", "sokol_fetch.c", "sokol_memtrack.c"
    ];

    // Resolve backend
    SokolBackend backend = resolveSokolBackend(options.backend, options.target);
    string backendCflag = "-DSOKOL_" ~ backend.to!string.toUpper;
    cflags ~= backendCflag;

    // Platform-specific configurations
    string compiler = options.toolchain;
    if (compiler.empty)
    {
        version (linux)
            compiler = findProgram("gcc");
        else version (Windows)
            compiler = findProgram("cl");
        else version (OSX)
            compiler = findProgram("clang");
        else version (Android)
            compiler = findProgram("clang");
        else
            static assert(false, "Unsupported platform");
    }
    string[] linkFlags;
    string[] libs;

    if (options.target.canFind("darwin"))
    {
        cflags ~= [
            "-ObjC", "-Wall", "-Wextra", "-Wno-unused-function",
            "-Wno-return-type-c-linkage"
        ];
        linkFlags ~= [
            "-framework", "Cocoa", "-framework", "QuartzCore", "-framework",
            "Foundation",
            "-framework", "MetalKit", "-framework", "Metal", "-framework",
            "AudioToolbox"
        ];
        libs ~= "objC";
        if (compiler.empty)
            compiler = findProgram("clang");
    }
    else if (options.target.canFind("linux"))
    {
        cflags ~= ["-Wall", "-Wextra", "-Wno-unused-function"];
        if (options.use_egl)
            cflags ~= "-DSOKOL_FORCE_EGL";
        if (!options.use_x11)
            cflags ~= "-DSOKOL_DISABLE_X11";
        if (!options.use_wayland)
            cflags ~= "-DSOKOL_DISABLE_WAYLAND";
        else
            libs ~= [
            "wayland-client", "wayland-egl", "wayland-cursor", "xkbcommon"
        ];
        libs ~= ["X11", "GL", "Xi", "Xcursor", "asound"];
        if (compiler.empty)
            compiler = findProgram("gcc");
    }
    else if (options.target.canFind("windows"))
    {
        cflags ~= ["/DNDEBUG", "/DIMPL", "/wd4190", "/O2"];
        libs ~= ["dxgi", "d3d11"];
        if (compiler.empty)
            compiler = findProgram("cl");
    }
    else if (options.target.canFind("wasm"))
    {
        if (options.use_gles3)
            cflags ~= "-DSOKOL_GLES3";
        else if (options.use_wgpu)
            cflags ~= "-DSOKOL_WGPU";
        else
            cflags ~= "-DSOKOL_GLES3"; // Default for WASM

        cflags ~= ["-fPIE"];
        compiler = buildPath(options.vendor, "emsdk", "upstream", "emscripten", "emcc");
        version (Windows)
            compiler ~= ".bat";
    }

    // Add optimization flags
    if (options.optimize == "debug" && !options.target.canFind("windows"))
        cflags ~= "-O0";
    else
        cflags ~= "-O2";

    // Handle shared library
    if (options.sharedlib && !options.target.canFind("windows"))
        cflags ~= "-fPIC";

    // Compile Sokol C sources
    string csrcRoot = absolutePath("src/sokol/c");
    string[] sokolObjFiles;

    foreach (csrc; csources)
    {
        string srcPath = buildPath(csrcRoot, csrc);
        if (!exists(srcPath))
            throw new Exception(fmt("Source file %s does not exist", srcPath));

        string objPath = buildPath(buildDir, "sokol_" ~ csrc.baseName ~ ".o");
        sokolObjFiles ~= objPath;

        string[] sokolCompileCmd = [compiler];
        sokolCompileCmd ~= cflags;
        sokolCompileCmd ~= ["-c", "-o", objPath, srcPath];
        if (options.verbose)
            writeln("Executing: ", sokolCompileCmd.join(" "));
        auto sokolCompileResult = execute(sokolCompileCmd);
        enforce(sokolCompileResult.status == 0, fmt("Failed to compile %s: %s", csrc, sokolCompileResult
                .output));
    }

    // Create libsokol.a
    string sokolLibPath = buildPath(buildDir, "libsokol.a");
    string arCmd = options.target.canFind("wasm") ? buildPath(options.vendor, "emsdk", "upstream", "emscripten", "emar") : "ar";
    version (Windows)
        if (options.target.canFind("wasm"))
            arCmd ~= ".bat";
        else
            arCmd = "lib.exe";

    version (Windows)
    {
        if (!options.target.canFind("wasm"))
        {
            string[] sokolArchiveCmd = [
                arCmd, "/nologo", fmt("/OUT:%s", sokolLibPath)
            ];
            sokolArchiveCmd ~= sokolObjFiles;
            if (options.verbose)
                writeln("Executing: ", sokolArchiveCmd.join(" "));
            auto sokolArchiveResult = execute(sokolArchiveCmd);
            enforce(sokolArchiveResult.status == 0, fmt("Failed to create archive %s: %s", sokolLibPath, sokolArchiveResult
                    .output));
        }
        else
        {
            string[] sokolArchiveCmd = [arCmd, "rcs", sokolLibPath];
            sokolArchiveCmd ~= sokolObjFiles;
            if (options.verbose)
                writeln("Executing: ", sokolArchiveCmd.join(" "));
            auto sokolArchiveResult = execute(sokolArchiveCmd);
            enforce(sokolArchiveResult.status == 0, fmt("Failed to create archive %s: %s", sokolLibPath, sokolArchiveResult
                    .output));
        }
    }
    else
    {
        string[] sokolArchiveCmd = [arCmd, "rcs", sokolLibPath];
        sokolArchiveCmd ~= sokolObjFiles;
        if (options.verbose)
            writeln("Executing: ", sokolArchiveCmd.join(" "));
        auto sokolArchiveResult = execute(sokolArchiveCmd);
        enforce(sokolArchiveResult.status == 0, fmt("Failed to create archive %s: %s", sokolLibPath, sokolArchiveResult
                .output));
    }

    // Clean up Sokol object files
    foreach (obj; sokolObjFiles)
        if (exists(obj))
            remove(obj);

    // Handle ImGui if enabled
    if (options.with_sokol_imgui)
    {
        string imguiRoot = absolutePath(buildPath(options.vendor, "imgui", "src"));
        if (!exists(imguiRoot))
            throw new Exception("ImGui source directory not found. Run with --download-imgui.");

        string[] imguiSources = [
            "imgui.cpp", "imgui_demo.cpp", "imgui_draw.cpp",
            "imgui_tables.cpp", "imgui_widgets.cpp", "cimgui.cpp"
        ];
        cflags ~= fmt("-I%s", imguiRoot);

        string imguiCompiler;
        if (options.target.canFind("wasm"))
            imguiCompiler = buildPath(options.vendor, "emsdk", "upstream", "emscripten", "em++");
        else if (compiler.canFind("clang"))
            imguiCompiler = findProgram(compiler ~ "++");
        else if (compiler.canFind("gcc"))
            imguiCompiler = findProgram("g++");
        else
            imguiCompiler = compiler;

        version (Windows)
            if (options.target.canFind("wasm"))
                imguiCompiler ~= ".bat";

        string[] imguiObjFiles;

        // Compile ImGui sources
        foreach (src; imguiSources)
        {
            string srcPath = buildPath(imguiRoot, src);
            if (!exists(srcPath))
                throw new Exception(fmt("ImGui source file %s does not exist", srcPath));

            string objPath = buildPath(buildDir, "imgui_" ~ src.baseName ~ ".o");
            imguiObjFiles ~= objPath;

            string[] imguiCompileCmd = [imguiCompiler, "-DNDEBUG"];
            if (options.target.canFind("wasm"))
                imguiCompileCmd ~= "-fPIE";
            imguiCompileCmd ~= cflags; // Include Sokol cflags for consistency
            imguiCompileCmd ~= ["-c", "-o", objPath, srcPath];
            if (options.verbose)
                writeln("Executing: ", imguiCompileCmd.join(" "));
            auto imguiCompileResult = execute(imguiCompileCmd);
            enforce(imguiCompileResult.status == 0, fmt("Failed to compile %s: %s", src, imguiCompileResult
                    .output));
        }

        // Compile sokol_imgui.c
        string srcPath = buildPath(csrcRoot, "sokol_imgui.c");
        if (!exists(srcPath))
            throw new Exception(fmt("Source file %s does not exist", srcPath));

        string objPath = buildPath(buildDir, "sokol_imgui.o");
        imguiObjFiles ~= objPath;

        string[] sokolImguiCompileCmd = [compiler];
        sokolImguiCompileCmd ~= cflags;
        sokolImguiCompileCmd ~= ["-c", "-o", objPath, srcPath];
        if (options.verbose)
            writeln("Executing: ", sokolImguiCompileCmd.join(" "));
        auto sokolImguiCompileResult = execute(sokolImguiCompileCmd);
        enforce(sokolImguiCompileResult.status == 0, fmt("Failed to compile sokol_imgui.c: %s", sokolImguiCompileResult
                .output));

        // Create libcimgui.a
        string imguiLibPath = buildPath(buildDir, "libcimgui.a");

        version (Windows)
        {
            if (!options.target.canFind("wasm"))
            {
                string[] imguiArchiveCmd = [
                    arCmd, "/nologo", fmt("/OUT:%s", imguiLibPath)
                ];
                imguiArchiveCmd ~= imguiObjFiles;
                if (options.verbose)
                    writeln("Executing: ", imguiArchiveCmd.join(" "));
                auto imguiArchiveResult = execute(imguiArchiveCmd);
                enforce(imguiArchiveResult.status == 0, fmt("Failed to create archive %s: %s", imguiLibPath, imguiArchiveResult
                        .output));
            }
            else
            {
                string[] imguiArchiveCmd = [arCmd, "rcs", imguiLibPath];
                imguiArchiveCmd ~= imguiObjFiles;
                if (options.verbose)
                    writeln("Executing: ", imguiArchiveCmd.join(" "));
                auto imguiArchiveResult = execute(imguiArchiveCmd);
                enforce(imguiArchiveResult.status == 0, fmt("Failed to create archive %s: %s", imguiLibPath, imguiArchiveResult
                        .output));
            }
        }
        else
        {
            string[] imguiArchiveCmd = [arCmd, "rcs", imguiLibPath];
            imguiArchiveCmd ~= imguiObjFiles;
            if (options.verbose)
                writeln("Executing: ", imguiArchiveCmd.join(" "));
            auto imguiArchiveResult = execute(imguiArchiveCmd);
            enforce(imguiArchiveResult.status == 0, fmt("Failed to create archive %s: %s", imguiLibPath, imguiArchiveResult
                    .output));
        }

        // Clean up ImGui object files
        foreach (obj; imguiObjFiles)
            if (exists(obj))
                remove(obj);
    }
}

string findProgram(string programName) @safe
{
    string[] paths = environment.get("PATH").split(pathSeparator);
    foreach (path; paths)
    {
        string fullPath = buildPath(path, programName);
        version (Windows)
            fullPath ~= ".exe";
        if (exists(fullPath) && isFile(fullPath))
            return fullPath;
    }
    return programName; // Return the program name as-is if not found
}

string fmt(Args...)(string fmt, auto ref Args args) @safe
{
    auto app = appender!string();
    formattedWrite(app, fmt, args);
    return app.data;
}

struct EmLinkOptions
{
    string target;
    string optimize;
    string lib_main;
    string vendor;
    bool release_use_closure = true;
    bool release_use_lto = false;
    bool use_webgpu = false;
    bool use_webgl2 = false;
    bool use_emmalloc = false;
    bool use_filesystem = true;
    bool use_imgui = false;
    string shell_file_path;
    string[] extra_args;
    bool verbose = false;
}

void emLinkStep(EmLinkOptions options) @safe
{
    string emcc_path = buildPath(options.vendor, "emsdk", "upstream", "emscripten", options.use_imgui ? "em++"
            : "emcc");
    version (Windows)
        emcc_path ~= ".bat";
    string[] emcc_cmd = [emcc_path];

    if (options.use_imgui)
        emcc_cmd ~= ["-lcimgui", "-lcimguid"];

    if (options.optimize == "debug")
        emcc_cmd ~= ["-Og", "-sSAFE_HEAP=1", "-sSTACK_OVERFLOW_CHECK=1"];
    else
    {
        emcc_cmd ~= "-sASSERTIONS=0";
        emcc_cmd ~= (options.optimize == "small") ? "-Oz" : "-O3";
        if (options.release_use_lto)
            emcc_cmd ~= "-flto";
        if (options.release_use_closure)
            emcc_cmd ~= ["--closure", "1"];
    }

    if (options.use_webgpu)
        emcc_cmd ~= "-sUSE_WEBGPU=1";
    if (options.use_webgl2)
        emcc_cmd ~= "-sUSE_WEBGL2=1";
    if (!options.use_filesystem)
        emcc_cmd ~= "-sNO_FILESYSTEM=1";
    if (options.use_emmalloc)
        emcc_cmd ~= "-sMALLOC='emmalloc'";
    if (options.shell_file_path)
        emcc_cmd ~= "--shell-file=" ~ options.shell_file_path;

    emcc_cmd ~= ["-sSTACK_SIZE=512KB"];
    emcc_cmd ~= options.extra_args;
    emcc_cmd ~= options.lib_main;
    immutable baseName = options.lib_main.baseName[3 .. $ - 2]; // drop  "lib" and ".a"
    string out_file = buildPath("build", baseName ~ ".html");
    emcc_cmd ~= ["-o", out_file];

    if (options.verbose)
        writeln("Executing: ", emcc_cmd.join(" "));
    auto result = execute(emcc_cmd);
    enforce(result.status == 0, fmt("Error: emcc command failed\n%s", result.output));

    string install_dir = "web";
    mkdirRecurse(install_dir);
    copy(out_file, buildPath(install_dir, out_file.baseName));
    copy(buildPath("build", baseName ~ ".wasm"), buildPath(install_dir, baseName ~ ".wasm"));
    copy(buildPath("build", baseName ~ ".js"), buildPath(install_dir, baseName ~ ".js"));
}

struct EmRunOptions
{
    string name;
    string vendor;
}

void emRunStep(EmRunOptions options) @safe
{
    string emrun_path = buildPath(options.vendor, "emsdk", "upstream", "emscripten", "emrun");
    version (Windows)
        emrun_path ~= ".bat";
    string[] emrun_cmd = [emrun_path, buildPath("web", options.name ~ ".html")];

    auto result = execute(emrun_cmd);
    if (result.status != 0)
    {
        writeln("Error: emrun command failed");
        writeln(result.output);
    }
}

void emSdkSetupStep(string emsdk) @safe
{
    string dot_emsc_path = buildPath(emsdk, ".emscripten");
    if (!exists(dot_emsc_path))
    {
        string[] emsdk_cmd;
        version (Windows)
            emsdk_cmd = [buildPath(emsdk, "emsdk.bat")];
        else
            emsdk_cmd = ["bash", buildPath(emsdk, "emsdk")];

        auto status = wait(spawnProcess(emsdk_cmd ~ ["install", "latest"]));
        if (status != 0)
            throw new Exception("Error: emsdk install failed");

        status = wait(spawnProcess(emsdk_cmd ~ ["activate", "latest"]));
        if (status != 0)
            throw new Exception("Error: emsdk activate failed");
    }
}

void buildShaders(ref string vendor) @safe
{
    immutable string sokolToolsBinDir = buildPath(getSHDC(vendor), "bin");
    immutable string shadersDir = buildPath("examples", "shaders");
    immutable string[] shaders = [
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
        "blend.glsl"
    ];

    string optionalShdc;
    version (Windows)
        optionalShdc = buildPath("win32", "sokol-shdc.exe");
    else version (linux)
    {
        version (AArch64)
            optionalShdc = buildPath("linux_arm64", "sokol-shdc");
        else
            optionalShdc = buildPath("linux", "sokol-shdc");
    }
    else version (OSX)
    {
        version (AArch64)
            optionalShdc = buildPath("osx_arm64", "sokol-shdc");
        else
            optionalShdc = buildPath("osx", "sokol-shdc");
    }

    if (optionalShdc is null)
    {
        writeln("Warning: unsupported host platform, skipping shader compiler step");
        return;
    }

    immutable string shdcPath = buildPath(sokolToolsBinDir, optionalShdc);

    version (OSX)
        immutable string glsl = "glsl410";
    else
        immutable string glsl = "glsl430";
    string slang = glsl ~ ":metal_macos:hlsl5:glsl300es:wgsl";

    int status;
    version (Posix)
    {
        status = wait(spawnProcess(["chmod", "+x", shdcPath]));
        if (status != 0)
            throw new Exception("Error: failed to set permissions on shader compiler");
    }

    foreach (shader; shaders)
    {
        status = wait(spawnProcess([
            shdcPath, "-i", buildPath(shadersDir, shader),
            "-o", buildPath(shadersDir, shader[0 .. $ - 5]) ~ ".d",
            "-l", slang, "-f", "sokol_d"
        ]));
        if (status != 0)
            throw new Exception("Error: shader compiler failed");
    }
}
