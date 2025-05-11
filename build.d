/*
zlib/libpng license

Copyright (c) 2023-2024 Matheus Catarino França <matheus-catarino@hotmail.com>

This software is provided 'as-is', without any express or implied warranty.
In no event will the authors be held liable for any damages arising from the
use of this software.
*/
module build;
import std;

enum emsdk_version = "4.0.4";
enum imgui_version = "1.91.9";
enum zig_version = "0.14.0";

void main(string[] args) @safe
{
    // Parse command line arguments
    bool help = false;
    string compiler = findProgram("gcc");
    string target = "native";
    string optimize = "debug";
    bool downloadEmsdk = false, downloadZig = false, downloadIMGUI = false, downloadSHDC = false;
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
        else if (arg == "--download-imgui")
        {
            downloadIMGUI = true;
        }
        else if (arg == "--download-sokol-tools")
        {
            downloadSHDC = true;
        }
    }

    if (args.length < 2 || help)
    {
        writeln("Usage: dub run -- [options]");
        writeln("Options:");
        writeln("  --help                   Show this help message");
        writeln(
            "  --backend=<backend>          Select backend (auto, d3d11, metal, gl, gles3, wgpu)");
        writeln("  --toolchain=<compiler>   Select C toolchain (gcc, clang, emcc)");
        writeln("  --optimize=<level>       Select optimization level (debug, release)");
        writeln("  --target=<target>        Select target (native, wasm, android)");
        writeln("  --download-emsdk         Download and setup Emscripten SDK");
        writeln("  --download-zig           Download and setup Zig toolchain");
        writeln("  --download-imgui         Download and build imgui");
        writeln("  --download-sokol-tools   Download and setup sokol-tools");
        return;
    }
    else
    {
        writeln("Currently configuration:");
        writeln("Using compiler: ", compiler);
        writeln("Using target: ", target);
        writeln("Using optimize: ", optimize);
        writeln("Using backend: ", sokol_backend);
        writeln("Get imgui-libs: ", downloadIMGUI);
        writeln("Get sokol-tools: ", downloadSHDC);
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

    // Download and setup Emscripten SDK if requested
    if (downloadEmsdk)
    {
        version (LDC)
            getEmSDK;
        else
            static assert(0, "Emscripten SDK is only supported on LDC");
    }
    if (downloadIMGUI)
        getIMGUI;
    if (downloadZig)
        getZigToolchain;
    if (downloadSHDC)
        buildShaders;

    // build libsokol
    buildLibSokol(options);
}

void getZigToolchain() @safe
{
    writeln("Downloading and setting up Zig toolchain...");
    string rootpath = absolutePath(buildPath("vendor"));

    version (Windows)
        immutable string ext = ".zip", exe = ".exe";
    else
        immutable string ext = ".tar.xz", exe = "";

    version (Windows)
        immutable string os = "windows";
    else version (Linux)
        immutable string os = "linux";
    else version (OSX)
        immutable string os = "macos";
    else version (FreeBSD)
        immutable string os = "freebsd";

    version (X86_64)
        immutable string arch = "x86_64";
    else version (X86)
        immutable string arch = "x86";
    else version (AArch64)
        immutable string arch = "aarch64";

    immutable string filename = fmt("zig-%s-%s-%s", os, arch, zig_version);
    writeln("file: ", filename ~ ext);
    writeln("rootpath: ", rootpath);

    scope (exit)
    {
        if (exists(filename ~ ext))
            remove(filename ~ ext);
    }

    // Check if the file already exists
    if (!exists(rootpath))
    {
        download(fmt("https://ziglang.org/download/%s/%s", zig_version, filename ~ ext), filename ~ ext);

        // Extract Zig toolchain
        if (ext.endsWith("zip"))
            extractZip(filename ~ ext, rootpath);
        else
            extractTarXZ(filename ~ ext, rootpath);
    }

    // move from vendor/zig-{os}-{arch}-{version} to vendor/zig
    immutable string extractedPath = buildPath(rootpath, filename);
    immutable string newPath = buildPath(rootpath, "zig");
    if (exists(extractedPath) && !exists(newPath))
        rename(extractedPath, newPath);

    rootpath = newPath;

    // Check if Zig toolchain is installed
    auto res = execute([
        absolutePath(buildPath(rootpath, "zig")) ~ exe, "version"
    ]);
    enforce(res.status == 0, "Failed to run Zig toolchain");
    writefln("zig version: %s", res.output);
}

void getEmSDK() @safe
{
    writeln("Downloading and setting up Emscripten SDK");
    string rootpath = absolutePath(buildPath("vendor", "emsdk"));
    immutable string filename = "emsdk.zip";

    // Download EMSDK
    if (!exists(filename))
        download(fmt("https://github.com/emscripten-core/emsdk/archive/refs/tags/%s.zip", emsdk_version), filename);
    // Extract EMSDK
    if (!exists(rootpath))
        extractZip(filename, rootpath);
    else if (exists(filename))
        scope (exit)
            remove(filename);

    writeln("rootpath: ", rootpath);
    emSdkSetupStep(rootpath);
}

void getIMGUI() @safe
{
    writeln("Downloading IMGUI");
    string rootpath = absolutePath(buildPath("vendor", "cimgui"));
    string filename = "imgui.zip";

    scope (exit)
    {
        if (exists(filename))
            remove(filename);
        if (exists("c" ~ filename))
            remove("c" ~ filename);
    }

    if (!exists(rootpath))
    {
        download(fmt("https://github.com/cimgui/cimgui/archive/refs/tags/%s.zip", imgui_version), "c" ~ filename);
        download(fmt("https://github.com/ocornut/imgui/archive/refs/tags/v%s.zip", imgui_version), filename);
        extractZip("c" ~ filename, rootpath);
        extractZip(filename, buildPath(rootpath, "imgui"));
    }
    writeln("rootpath: ", rootpath);
}

string getSHDC() @safe
{
    writeln("Downloading and setting up sokol-tools");
    immutable string rootpath = absolutePath(buildPath("vendor", "shdc"));
    immutable string filename = "shdc.zip";

    // Download sokol-tools
    if (!exists(rootpath))
        download("https://github.com/floooh/sokol-tools-bin/archive/refs/heads/master.zip", filename);
    else if (exists(filename))
        scope (exit)
            remove(filename);

    // Extract sokol-tools
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
    ZipArchive archive = new ZipArchive(read(zipFile)); // unsafe/@system
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

    auto http = HTTP(url); // unsafe/@system (need libcurl)
    http.method = HTTP.Method.get;
    http.onReceiveHeader((in k, in v) {
        if (k == "content-length")
            contentLength = to!size_t(v);
    });

    // Progress bar
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
    enforce(sc / 100 == 2 || sc == 302,
        fmt("HTTP request returned status code %s", sc));

    auto file = File(fileName, "wb");
    scope (success)
        file.close();
    file.rawWrite(buf.data);
    writeln();
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
SokolBackend resolveSokolBackend(SokolBackend backend, string target) @safe
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

// Build sokol into a static library
void buildLibSokol(LibSokolOptions options) @safe
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
}

string fmt(Args...)(string fmt, auto ref Args args) @safe
{
    auto app = appender!string();
    formattedWrite(app, fmt, args);
    return app.data;
}

// Struct to hold options for Emscripten linking
struct EmLinkOptions
{
    string target;
    string optimize;
    string lib_main;
    string emsdk;
    bool release_use_closure = true;
    bool release_use_lto = false;
    bool use_webgpu = false;
    bool use_webgl2 = false;
    bool use_emmalloc = false;
    bool use_filesystem = true;
    string shell_file_path;
    string[] extra_args;
}

// Function to create an Emscripten link step
void emLinkStep(EmLinkOptions options) @safe
{
    string emcc_path = buildPath(options.emsdk, "upstream", "emscripten", "emcc");
    string[] emcc_cmd = [emcc_path];

    if (options.optimize == "Debug")
    {
        emcc_cmd ~= ["-Og", "-sSAFE_HEAP=1", "-sSTACK_OVERFLOW_CHECK=1"];
    }
    else
    {
        emcc_cmd ~= "-sASSERTIONS=0";
        if (options.optimize == "ReleaseSmall")
        {
            emcc_cmd ~= "-Oz";
        }
        else
        {
            emcc_cmd ~= "-O3";
        }
        if (options.release_use_lto)
        {
            emcc_cmd ~= "-flto";
        }
        if (options.release_use_closure)
        {
            emcc_cmd ~= ["--closure", "1"];
        }
    }

    if (options.use_webgpu)
    {
        emcc_cmd ~= "-sUSE_WEBGPU=1";
    }
    if (options.use_webgl2)
    {
        emcc_cmd ~= "-sUSE_WEBGL2=1";
    }
    if (!options.use_filesystem)
    {
        emcc_cmd ~= "-sNO_FILESYSTEM=1";
    }
    if (options.use_emmalloc)
    {
        emcc_cmd ~= "-sMALLOC='emmalloc'";
    }
    if (options.shell_file_path)
    {
        emcc_cmd ~= "--shell-file=" ~ options.shell_file_path;
    }

    emcc_cmd ~= options.extra_args;

    // Add the main lib and its dependencies
    emcc_cmd ~= options.lib_main;
    // Note: You'll need to implement dependency scanning logic here

    string out_file = options.lib_main ~ ".html";
    emcc_cmd ~= ["-o", out_file];

    // Execute the emcc command
    auto result = execute(emcc_cmd);
    if (result.status != 0)
    {
        writeln("Error: emcc command failed");
        writeln(result.output);
    }

    // Install the output files
    string install_dir = "web";
    mkdirRecurse(install_dir);
    copy(out_file, buildPath(install_dir, out_file.baseName));
    copy(options.lib_main ~ ".wasm", buildPath(install_dir, options.lib_main ~ ".wasm"));
    copy(options.lib_main ~ ".js", buildPath(install_dir, options.lib_main ~ ".js"));
}

// Struct to hold options for Emscripten run
struct EmRunOptions
{
    string name;
    string emsdk;
}

// Function to create an Emscripten run step
void emRunStep(EmRunOptions options) @safe
{
    string emrun_path = buildPath(options.emsdk, "upstream", "emscripten", "emrun");
    string[] emrun_cmd = [emrun_path, buildPath("web", options.name ~ ".html")];

    // Execute the emrun command
    auto result = execute(emrun_cmd);
    if (result.status != 0)
    {
        writeln("Error: emrun command failed");
        writeln(result.output);
    }
}

// Helper function to build a path from the emsdk root and provided path components
string emSdkPath(string emsdk, string[] subPaths) @safe
{
    return absolutePath(buildPath(emsdk ~ subPaths));
}

// Function to create an Emscripten SDK setup step
void emSdkSetupStep(string emsdk) @safe
{
    string dot_emsc_path = buildPath(emsdk, ".emscripten");
    if (!exists(dot_emsc_path))
    {
        string[] emsdk_cmd;
        version (Windows)
        {
            emsdk_cmd = [buildPath(emsdk, "emsdk.bat")];
        }
        else
        {
            emsdk_cmd = ["bash", buildPath(emsdk, "emsdk")];
        }

        auto status = wait(spawnProcess(emsdk_cmd ~ ["install", "latest"]));
        if (status != 0)
        {
            throw new Exception("Error: emsdk install failed");
        }

        status = wait(spawnProcess(emsdk_cmd ~ ["activate", "latest"]));
        if (status != 0)
        {
            throw new Exception("Error: emsdk activate failed");
        }
    }
}

// a separate step to compile shaders, expects the shader compiler in ../sokol-tools-bin/
void buildShaders() @safe
{
    immutable string sokolToolsBinDir = buildPath(getSHDC, "bin");
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
    {
        optionalShdc = buildPath("win32", "sokol-shdc.exe");
    }
    else version (linux)
    {
        version (AArch64)
        {
            optionalShdc = buildPath("linux_arm64", "sokol-shdc");
        }
        else
        {
            optionalShdc = buildPath("linux", "sokol-shdc");
        }
    }
    else version (OSX)
    {
        version (AArch64)
        {
            optionalShdc = buildPath("osx_arm64", "sokol-shdc");
        }
        else
        {
            optionalShdc = buildPath("osx", "sokol-shdc");
        }
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

    // need chmod permissions on Posix (Linux/MacOS)
    version (Posix)
    {
        int status = wait(spawnProcess([
            "chmod",
            "+x",
            shdcPath,
        ]));
        if (status != 0)
        {
            throw new Exception("Error: failed to set permissions on shader compiler");
        }
    }
    else
    {
        // fix shadowing for Windows
        int status = 0;
    }

    foreach (shader; shaders)
    {
        status = wait(spawnProcess([
            shdcPath,
            "-i",
            buildPath(shadersDir, shader),
            "-o",
            buildPath(shadersDir, shader[0 .. $ - 5]) ~ ".d",
            "-l",
            slang,
            "-f",
            "sokol_d",
            "--reflection",
        ]));
        if (status != 0)
        {
            throw new Exception("Error: shader compiler failed");
        }

    }
}
