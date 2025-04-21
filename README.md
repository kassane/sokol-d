[![CI Build](https://github.com/kassane/sokol-d/actions/workflows/build.yml/badge.svg)](https://github.com/kassane/sokol-d/actions/workflows/build.yml)
![Latest release](https://img.shields.io/github/v/release/kassane/ldcup?include_prereleases&label=latest)
[![Static Badge](https://img.shields.io/badge/v2.111.0%20(stable)-f8240e?logo=d&logoColor=f8240e&label=frontend)](https://dlang.org/download.html)

Auto-generated [D](https://dlang.org) bindings for the [sokol headers](https://github.com/floooh/sokol).

#### Targets

- Native
- Wasm (`-Dtarget=wasm32-emscripten-none`) - LTO enabled on release-mode.

By default, the backend 3D API will be selected based on the target platform:

- macOS: Metal
- Windows: D3D11
- Linux: GL

## BUILD

**Required**

- [zig](https://ziglang.org/download) v0.14.0 or master
- [ldc](https://ldc-developers.github.io) v1.40.0 or latest-CI (nightly)

Supported platforms are: Windows, macOS, Linux (with X11)

On Linux install the following packages: libglu1-mesa-dev, mesa-common-dev, xorg-dev, libasound-dev (or generally: the dev packages required for X11, GL and ALSA development)

```bash
# build sokol library + all examples [default: static library]
zig build

# build sokol shared library + all examples
zig build -Dshared

# build sokol library only
zig build -Dartifact

# Run Examples
zig build run-blend
zig build run-bufferoffsets
zig build run-clear
zig build run-cube
zig build run-debugtext
zig build run-mrt
zig build run-saudio
zig build run-instancing
zig build run-offscreen
zig build run-sgl_context
zig build run-sgl_points
zig build run-user_data
zig build run-noninterleaved
zig build run-texcube
zig build run-quad
zig build run-triangle
zig build run-shapes
zig build run-vertexpull
zig build run-imgui -Dimgui # optional: -Dimgui-version=docking
zig build run-droptest -Dimgui # optional: -Dimgui-version=docking

zig build --help
# Project-Specific Options:
#   -Dgl=[bool]                  Force OpenGL (default: false)
#   -Dgles3=[bool]               Force OpenGL ES3 (default: false)
#   -Dwgpu=[bool]                Force WebGPU (default: false, web only)
#   -Dx11=[bool]                 Force X11 (default: true, Linux only)
#   -Dwayland=[bool]             Force Wayland (default: false, Linux only, not supported in main-line headers)
#   -Degl=[bool]                 Force EGL (default: false, Linux only)
#   -Dimgui=[bool]               Add support for sokol_imgui.h bindings
#   -Dsokol_imgui_cprefix=[string] Override Dear ImGui C bindings prefix for sokol_imgui.h (see SOKOL_IMGUI_CPREFIX)
#   -Dcimgui_header_path=[string] Override the Dear ImGui C bindings header name (default: cimgui.h)
#   -Dimgui-version=[enum]       Select ImGui version to use
#                                  Supported Values:
#                                    default
#                                    docking
#   -Dubsan=[bool]               Enable undefined behavior sanitizer
#   -Dtsan=[bool]                Enable thread sanitizer
#   -Dartifact=[bool]            Build artifacts (default: false)
#   -DbetterC=[bool]             Omit generating some runtime information and helper functions (default: false)
#   -DzigCC=[bool]               Use zig cc as compiler and linker (default: false)
#   -Dshaders=[bool]             Build shaders (default: false)
#   -Dtarget=[string]            The CPU architecture, OS, and ABI to build for
#   -Dcpu=[string]               Target CPU features to add or subtract
#   -Dofmt=[string]              Target object format
#   -Ddynamic-linker=[string]    Path to interpreter on the target system
#   -Doptimize=[enum]            Prioritize performance, safety, or binary size
#                                  Supported Values:
#                                    Debug
#                                    ReleaseSafe
#                                    ReleaseFast
#                                    ReleaseSmall
#   -Dshared=[bool]              Build sokol dynamic library (default: static)
```
(also run `zig build -l` to get a list of build targets)

## Shaders

Checkout [sokol-tools](https://github.com/floooh/sokol-tools) for a sokol shader pipeline! It supports these D bindings and all shaders in the examples folder
here have been compiled using it with `-f sokol_d`!

```bash
zig build -Dshaders # (re)generate D bindings from shaders.
```

<br>

## License and attributions

This code is released under the zlib license (see [LICENSE](LICENSE) for info). Parts of `gen_d.py` have been copied and modified from
the zig-bindings[^1] and rust-bindings[^2] for sokol.

The sokol headers are created by Andre Weissflog (floooh) and sokol is released under its own license[^3].

[^1]: https://github.com/floooh/sokol-zig/
[^2]: https://github.com/floooh/sokol-rust/
[^3]: https://github.com/floooh/sokol/blob/master/LICENSE
