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

## BUILD

**Required**

- [D Compiler](https://dlang.org/download.html) (DMD/LDC2/GDC)
- C/C++ compiler (GCC/Clang/MSVC)

Supported platforms are: Windows, macOS, Linux (with X11/Wayland)

On Linux install the following packages: libglu1-mesa-dev, mesa-common-dev, xorg-dev, libasound-dev (or generally: the dev packages required for X11/Wayland, GL and ALSA development)

```bash
# build sokol static library + all examples
dub build -c sokol-static

# build sokol shared library + all examples
dub build -c sokol-shared

# build sokol wayland static library + all examples
dub build -c sokol-wayland-static

# build sokol wayland shared library + all examples
dub build -c sokol-wayland-shared

cd examples
# Run Examples (native/wasm/wgpu)
dub :blend -c [native|wasm|wgpu]
dub :bufferoffsets -c [native|wasm|wgpu]
dub :clear -c [native|wasm|wgpu]
dub :cube -c [native|wasm|wgpu]
dub :debugtext -c [native|wasm|wgpu]
dub :droptest -c [native|wasm|wgpu]
dub :imgui -c [native|wasm|wgpu]
dub :instancing -c [native|wasm|wgpu]
dub :instancingcompute -c [native|wasm|wgpu]
dub :saudio -c [native|wasm|wgpu]
dub :sglcontext -c [native|wasm|wgpu]
dub :sglpoints -c [native|wasm|wgpu]
dub :triangle -c [native|wasm|wgpu]

# Build modes available:
# -b debug
# -b release  
# -b release-nobounds
# -b release-betterc
```

## Shaders

Checkout [sokol-tools](https://github.com/floooh/sokol-tools) for a sokol shader pipeline! It supports these D bindings and all shaders in the examples folder
here have been compiled using it with `-f sokol_d`!

```bash
dub :genshaders
```

<br>

## License and attributions

This code is released under the zlib license (see [LICENSE](LICENSE) for info). Parts of `gen_d.py` have been copied and modified from
the zig-bindings[^1] and rust-bindings[^2] for sokol.

The sokol headers are created by Andre Weissflog (floooh) and sokol is released under its own license[^3].

[^1]: https://github.com/floooh/sokol-zig/
[^2]: https://github.com/floooh/sokol-rust/
[^3]: https://github.com/floooh/sokol/blob/master/LICENSE
