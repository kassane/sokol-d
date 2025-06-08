[![CI Build](https://github.com/kassane/sokol-d/actions/workflows/build.yml/badge.svg)](https://github.com/kassane/sokol-d/actions/workflows/build.yml)
![Latest release](https://img.shields.io/github/v/release/kassane/sokol-d?include_prereleases&label=latest)
[![Static Badge](https://img.shields.io/badge/v2.111.0%20(stable)-f8240e?logo=d&logoColor=f8240e&label=frontend)](https://dlang.org/download.html)

Auto-generated [D](https://dlang.org) bindings for the [sokol headers](https://github.com/floooh/sokol).

#### Targets

By default, the backend 3D API will be selected based on the target platform:

- macOS: Metal
- Windows: D3D11
- Linux: GL/Wayland
- Wasm (LDC2 required) - WebGL3/WebGPU support

#### Usage - template project

```console
dub init -t sokol-d <project-name>
```

## Build Requirements

- [D Compiler](https://dlang.org/download.html) (DMD/LDC2/GDC) v2.111.0 or higher
- C/C++ compiler (GCC/Clang/MSVC)
- Linux dependencies: libglu1-mesa-dev, mesa-common-dev, xorg-dev, libasound-dev (for X11/Wayland, GL and ALSA development)

## Building Native Examples

1. build and run any example:
```bash
cd examples
dub :triangle
dub :cube
dub :imgui
```

## Building WebAssembly Examples

1. build any example for WASM:
```bash
cd examples
dub :triangle -c wasm     # for WebGL2
# or
dub :triangle -c wgpu     # for WebGPU
```

### All Configurations

```bash
dub build --print-configs    
Available configurations:
    sokol-static [default]   # Static library build
    sokol-shared             # Shared/dynamic library build
    sokol-wayland-static     # Wayland static build for Linux
    sokol-wayland-shared     # Wayland shared build for Linux
    imgui-static             # Sokol + Dear ImGui static build
    imgui-shared             # Sokol + Dear ImGui shared build  
    imgui-wgles3             # Sokol + Dear ImGui WebGL ES3 build
    imgui-wgpu               # Sokol + Dear ImGui WebGPU build
    sokol-wgles3             # WebGL ES3 build
    sokol-wgpu               # WebGPU build
    genshaders               # [re]Generate shader code
```

## Additional Build Options

### Library Types
- Static library: `dub build -c sokol-static`
- Shared library: `dub build -c sokol-shared`

### Linux Display Server
- X11 (default with static): `dub build -c sokol-static`
- Wayland static: `dub build -c sokol-wayland-static`
- Wayland shared: `dub build -c sokol-wayland-shared`

### Build Modes
Available for all configurations:
- Debug: `-b debug`
- Release: `-b release`
- Release (no bounds checking): `-b release-nobounds`
- Release (better C): `-b release-betterc`

## Available Examples
- blend
- bufferoffsets
- clear
- cube
- debugtext
- droptest
- imgui
- instancing
- instancingcompute
- saudio
- sglcontext
- sglpoints
- triangle

See [examples](examples)

## Shaders

Checkout [sokol-tools](https://github.com/floooh/sokol-tools) for a sokol shader pipeline! It supports these D bindings and all shaders in the examples folder
here have been compiled using it with `-f sokol_d`!

```bash
dub build -c genshaders
```

<br>

## License and attributions

This code is released under the zlib license (see [LICENSE](LICENSE) for info). Parts of `gen_d.py` have been copied and modified from
the zig-bindings[^1] and rust-bindings[^2] for sokol.

The sokol headers are created by Andre Weissflog (floooh) and sokol is released under its own license[^3].

[^1]: https://github.com/floooh/sokol-zig/
[^2]: https://github.com/floooh/sokol-rust/
[^3]: https://github.com/floooh/sokol/blob/master/LICENSE
