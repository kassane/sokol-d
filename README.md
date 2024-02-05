
[![CI Build](https://github.com/kassane/sokol-d/actions/workflows/build.yml/badge.svg)](https://github.com/kassane/sokol-d/actions/workflows/build.yml)

Auto-generated [D](https://dlang.org) bindings for the [sokol headers](https://github.com/floooh/sokol).

#### Status: Experimental

#### Targets

- Native
- Wasm (`-Dtarget=wasm32-emscripten`)

## BUILD

**Required**

- [zig](https://ziglang.org/download) v0.12.0 or master
- [ldc](https://ldc-developers.github.io) v1.36.0 or latest-CI (nightly)

Supported platforms are: Windows, macOS, Linux (with X11)

On Linux install the following packages: libglu1-mesa-dev, mesa-common-dev, xorg-dev, libasound-dev (or generally: the dev packages required for X11, GL and ALSA development)

```bash
# build sokol library + all examples [default: static library]
zig build -Doptimize=ReleaseFast

# build sokol shared library + all examples
zig build -Doptimize=ReleaseFast -Dshared

# Run Examples
zig build run-blend -Doptimize=ReleaseFast
zig build run-clear -Doptimize=ReleaseFast
zig build run-cube -Doptimize=ReleaseFast
zig build run-debugtext_print -Doptimize=ReleaseFast
zig build run-mrt -Doptimize=ReleaseFast
zig build run-saudio -Doptimize=ReleaseFast
zig build run-sgl_context -Doptimize=ReleaseFast
zig build run-sgl_points -Doptimize=ReleaseFast
zig build run-user_data -Doptimize=ReleaseFast
zig build run-triangle -Doptimize=ReleaseFast

zig build --help
# Project-Specific Options:
#   -Dgl=[bool]                  Force OpenGL (default: false)
#   -Dwgpu=[bool]                Force WebGPU (default: false, web only)
#   -Dx11=[bool]                 Force X11 (default: true, Linux only)
#   -Dwayland=[bool]             Force Wayland (default: false, Linux only, not supported in main-line headers)
#   -Degl=[bool]                 Force EGL (default: false, Linux only)
#   -Dtarget=[string]            The CPU architecture, OS, and ABI to build for
#   -Dcpu=[string]               Target CPU features to add or subtract
#   -Doptimize=[enum]            Prioritize performance, safety, or binary size (-O flag)
#                                  Supported Values:
#                                    Debug
#                                    ReleaseSafe
#                                    ReleaseFast
#                                    ReleaseSmall
#   -Dshared=[bool]              Build sokol dynamic library (default: static)
#   -DbetterC=[bool]             Omit generating some runtime information and helper functions (default: false)
#   -DzigCC=[bool]               Use zig cc as compiler and linker (default: false)
```

## Shaders

Checkout [sokol-tools](https://github.com/floooh/sokol-tools) for a sokol shader pipeline! It supports these D bindings and all shaders in the examples folder
here have been compiled using it with `-f sokol_d`!

```bash
zig build shaders # (re)generate D bindings from shaders.
```

<br>

## License and attributions

<sub>
This code is released under the zlib license (see `LICENSE` for info). Parts of `gen_d.py` have been copied and modified from
the zig-bindings (https://github.com/floooh/sokol-zig/) and rust-bindings (https://github.com/floooh/sokol-rust/) for sokol.
</sub>


<sub>
The sokol headers are created by Andre Weissflog (floooh) and sokol is released under its own license here: https://github.com/floooh/sokol/blob/master/LICENSE
</sub>
</br>