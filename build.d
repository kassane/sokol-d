/*
zlib/libpng license

Copyright (c) 2023-2024 Matheus Catarino França <matheus-catarino@hotmail.com>

This software is provided 'as-is', without any express or implied warranty.
In no event will the authors be held liable for any damages arising from the
use of this software.
*/

import std;

void main(string[] args)
{
    // Parse command line arguments
    bool help = false;
    string compiler = findProgram("gcc");
    string target = "native";
    string optimize = "debug";
    bool downloadEmsdk = false, downloadZig = false;
    SokolBackend sokol_backend = SokolBackend.auto_;

    bool opt_use_gl = false;
    bool opt_use_gles3 = false;
    bool opt_use_wgpu = false;
    bool opt_use_x11 = true;
    bool opt_use_wayland = false;
    bool opt_use_egl = false;
    bool opt_with_sokol_imgui = false;

    foreach (arg; args[1 .. $])
    {
        if (arg == "--help")
        {
            help = true;
        }
        else if (arg.startsWith("--backend="))
        {
            sokol_backend = resolveSokolBackend(arg["--backend=".length .. $].to!SokolBackend, target);
        }
        else if (arg.startsWith("--toolchain="))
        {
            compiler = findProgram(arg["--toolchain=".length .. $]);
        }
        else if (arg.startsWith("--optimize="))
        {
            optimize = arg["--optimize=".length .. $];
        }
        else if (arg.startsWith("--target="))
        {
            target = arg["--target=".length .. $];
        }
        else if (arg == "--download-emsdk")
        {
            downloadEmsdk = true;
        }
        else if (arg == "--download-zig")
        {
            downloadZig = true;
        }
    }

    if (args.length < 2 || help)
    {
        writeln("Usage: dub run -- [options]");
        writeln("Options:");
        writeln("  --help                 Show this help message");
        writeln(
            "  --backend=<backend>     Select backend (auto, d3d11, metal, gl, gles3, wgpu)");
        writeln("  --toolchain=<compiler>  Select C toolchain (gcc, clang, emcc)");
        writeln("  --optimize=<level>      Select optimization level (debug, release)");
        writeln("  --target=<target>      Select target (native, wasm, android)");
        writeln("  --download-emsdk       Download and setup Emscripten SDK");
        writeln("  --download-zig       Download and setup Zig toolchain");
        return;
    }
    else
    {
        writeln("Currently configuration:");
        writeln("Using compiler: ", compiler);
        writeln("Using target: ", target);
        writeln("Using optimize: ", optimize);
        writeln("Using backend: ", sokol_backend);
        writeln("Get EmSDK: ", downloadEmsdk);
        writeln("Get Zig: ", downloadZig);
    }

    LibSokolOptions options = {
        target: target,
        optimize: optimize,
        toolchain: compiler,
        backend: sokol_backend,
        use_wayland: opt_use_wayland,
        use_x11: opt_use_x11,
        use_egl: opt_use_egl,
        with_sokol_imgui: opt_with_sokol_imgui,
    };

    buildLibSokol(options);

    // Download and setup Emscripten SDK if requested
    if (downloadEmsdk)
    {
        getEmSDK();
    }
    if (downloadZig)
    {
        getZigToolchain();
    }
}

void getZigToolchain()
{
    writeln("Downloading and setting up Zig toolchain...");

    version (Windows)
        string ext = ".zip", exe = ".exe";
    else
        string ext = ".tar.xz", exe = "";

    version (Windows)
        string os = "windows";
    else version (Linux)
        string os = "linux";
    else version (OSX)
        string os = "macos";
    else version (FreeBSD)
        string os = "freebsd";

    version (X86_64)
        string arch = "x86_64";
    else version (X86)
        string arch = "x86";
    else version (AArch64)
        string arch = "aarch64";

    string zig_version = "0.13.0";

    string filename = fmt("zig-%s-%s-%s", os, arch, zig_version);
    writeln("file: ", filename ~ ext);

    // Check if the file already exists
    if (!exists(filename ~ ext))
        download(fmt("https://ziglang.org/download/%s/%s", zig_version, filename ~ ext), filename ~ ext);

    // Extract Zig toolchain
    if (ext.endsWith("zip"))
        extractZip(filename ~ ext, "vendor/zig");
    else
        extractTarXZ(filename ~ ext, "vendor/zig");

    version (Windows)
        auto res = execute([rootPath() ~ "/vendor/zig/zig" ~ exe, "version"]);
    else
        auto res = execute([
        rootPath() ~ fmt("/vendor/zig/%s/zig", filename) ~ exe, "version"
    ]);
    enforce(res.status == 0, "Failed to run Zig toolchain");
    writefln("zig version: %s", res.output);
}

void getEmSDK()
{
    writeln("Downloading and setting up Emscripten SDK");

    // Download EMSDK
    if (!exists("emsdk.zip"))
        download("https://github.com/emscripten-core/emsdk/archive/refs/tags/3.1.68.zip", "emsdk.zip");

    // Extract EMSDK
    extractZip("emsdk.zip", "vendor/emsdk");

    version (Windows)
        string ext = ".bat";
    else
        string ext = "";

    // Setup EMSDK
    version (Posix)
    {
        auto result = execute([
            "chmod", "+x", rootPath() ~ "/vendor/emsdk/emsdk" ~ ext
        ]);
        enforce(result.status == 0, "Failed to run chmod in emsdk");
    }

    auto pid = spawnProcess([
        rootPath() ~ "/vendor/emsdk/emsdk" ~ ext, "install", "latest"
    ]);
    wait(pid);

    pid = spawnProcess([
        rootPath() ~ "/vendor/emsdk/emsdk" ~ ext, "activate", "latest"
    ]);
    wait(pid);
}

void extractTarXZ(string tarFile, string destination)
{
    if (exists(destination))
        rmdirRecurse(destination);

    mkdirRecurse(destination);
    auto pid = spawnProcess([
        "tar", "xf", tarFile, fmt("--directory=%s", destination)
    ]);
    enforce(pid.wait() == 0, "Extraction failed");
}

void extractZip(string zipFile, string destination)
{
    scope archive = new ZipArchive(read(zipFile));
    std.stdio.writeln("unpacking:");
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
        std.stdio.writeln(path);
        auto dir = dirName(path);
        if (!dir.empty && !dir.exists)
            mkdirRecurse(dir);
        archive.expand(am);
        std.file.write(path, am.expandedData);
    }
}

void download(string url, string fileName)
{

    auto buf = appender!(ubyte[])();
    size_t contentLength;

    auto http = HTTP(url);
    http.method = HTTP.Method.get;
    http.onReceiveHeader((in k, in v) {
        if (k == "content-length")
            contentLength = to!size_t(v);
    });
    http.onReceive((data) {
        buf.put(data);
        std.stdio.writef("%sk/%sk\r", buf.data.length / 1024,
            contentLength ? to!string(contentLength / 1024) : "?");
        std.stdio.stdout.flush();
        return data.length;
    });
    http.dataTimeout = dur!"msecs"(0);
    http.perform();
    immutable sc = http.statusLine().code;
    enforce(sc / 100 == 2 || sc == 302,
        fmt("HTTP request returned status code %s", sc));
    std.stdio.writeln("done                    ");

    auto file = File(fileName, "wb");
    scope (success)
        file.close();
    file.rawWrite(buf.data);
}

enum SokolBackend : ushort
{
    auto_, // Windows: D3D11, macOS/iOS: Metal, otherwise: GL
    d3d11,
    metal,
    gl,
    gles3,
    wgpu
}

struct LibSokolOptions
{
    string target;
    string optimize;
    string toolchain;
    SokolBackend backend = SokolBackend.auto_;
    bool use_egl = false;
    bool use_x11 = true;
    bool use_wayland = false;
    string emsdk = null;
    bool with_sokol_imgui = false;
}

// Helper function to resolve .auto backend based on target platform
SokolBackend resolveSokolBackend(SokolBackend backend, string target)
{
    if (backend != SokolBackend.auto_)
    {
        return backend;
    }
    else if (target.canFind("darwin"))
    {
        return SokolBackend.metal;
    }
    else if (target.canFind("windows"))
    {
        return SokolBackend.d3d11;
    }
    else if (target.canFind("wasm"))
    {
        return SokolBackend.gles3;
    }
    else if (target.canFind("android"))
    {
        return SokolBackend.gles3;
    }
    else
    {
        return SokolBackend.gl;
    }
}

string rootPath()
{
    return __FILE__.dirName;
}

// Build sokol into a static library
void buildLibSokol(LibSokolOptions options)
{
    bool sharedlib = false;

    string libName = "sokol";
    string[] cflags = ["-DIMPL"];

    // Resolve .auto backend into specific backend by platform
    SokolBackend backend = resolveSokolBackend(options.backend, options.target);
    string backendCflag = "-DSOKOL_" ~ backend.to!string.toUpper;
    cflags ~= backendCflag;

    // Platform specific compile and link options
    if (options.target.canFind("darwin"))
    {
        cflags ~= "-ObjC";
        // Add framework linking for Darwin platforms
        // ...
    }
    else if (options.target.canFind("android"))
    {
        if (backend != SokolBackend.gles3)
        {
            throw new Exception("For android targets, you must have backend set to GLES3");
        }
        // Add Android-specific libraries
        // ...
    }
    else if (options.target.canFind("linux"))
    {
        if (options.use_egl)
            cflags ~= "-DSOKOL_FORCE_EGL";
        if (!options.use_x11)
            cflags ~= "-DSOKOL_DISABLE_X11";
        if (!options.use_wayland)
            cflags ~= "-DSOKOL_DISABLE_WAYLAND";
        // Add Linux-specific libraries
        // ...
    }
    else if (options.target.canFind("windows"))
    {
        // Add Windows-specific libraries
        // ...
    }

    // Add C source files
    string csrcRoot = "src/sokol/c/";
    string[] csources = [
        "sokol_log.c", "sokol_app.c", "sokol_gfx.c", "sokol_time.c",
        "sokol_audio.c", "sokol_gl.c", "sokol_debugtext.c", "sokol_shape.c",
        "sokol_fetch.c", "sokol_glue.c"
    ];

    foreach (csrc; csources)
    {
        string fullPath = buildPath(csrcRoot, csrc);
        // Add compilation command for each C source file
    }

    if (options.with_sokol_imgui)
    {
        string imgui_src = buildPath(csrcRoot, "sokol_imgui.c");
        // Add compilation command for sokol_imgui.c

        // Build and link cimgui
    }
}

string findProgram(string programName) @safe
{
    string[] paths = environment.get("PATH").split(pathSeparator);
    foreach (path; paths)
    {
        string fullPath = buildPath(path, programName);
        version (Windows)
        {
            fullPath ~= ".exe";
        }
        if (exists(fullPath) && isFile(fullPath))
        {
            return fullPath;
        }
    }
    throw new Exception("Could not find program: " ~ programName);
    // return null;
}

string fmt(Args...)(string fmt, auto ref Args args)
{
    import std.array, std.format;

    auto app = appender!string();
    formattedWrite(app, fmt, args);
    return app.data;
}
