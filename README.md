
Auto-generated [D](https://dlang.org) bindings for the [sokol headers](https://github.com/floooh/sokol).

## BUILD

**Required**

- [zig](https://ziglang.org/download) v0.11.0 or master
- [ldc](https://ldc-developers.github.io) v1.35.0 or latest-CI (nightly)

Supported platforms are: Windows, macOS, Linux (with X11)

On Linux install the following packages: libglu1-mesa-dev, mesa-common-dev, xorg-dev, libasound-dev (or generally: the dev packages required for X11, GL and ALSA development)

```bash
# build sokol library only [default: static library]
zig build -Doptimize=ReleaseFast

# build sokol shared library
zig build -Doptimize=ReleaseFast -DShared

# build samples [WiP]
zig build clear -Doptimize=ReleaseFast # works
zig build debugtext_print -Doptimize=ReleaseFast # works
zig build sgl_context -Doptimize=ReleaseFast # run, but no anims (fixme)
zig build cube -Doptimize=ReleaseFast # run, but no anims (fixme)
zig build blend -Doptimize=ReleaseFast # run, but no anims (fixme)

zig build --help
# Project-Specific Options:
#   -Dgl=[bool]                  Force GL backend
#   -Dwayland=[bool]             Compile with wayland-support (default: false)
#   -Dx11=[bool]                 Compile with x11-support (default: true)
#   -Degl=[bool]                 Use EGL instead of GLX if possible (default: false)
#   -Dtarget=[string]            The CPU architecture, OS, and ABI to build for
#   -Dcpu=[string]               Target CPU features to add or subtract
#   -Doptimize=[enum]            Prioritize performance, safety, or binary size (-O flag)
#                                  Supported Values:
#                                    Debug
#                                    ReleaseSafe
#                                    ReleaseFast
#                                    ReleaseSmall
#   -DShared=[bool]              Build sokol dynamic library [default: static]
#   -DBetterC=[bool]             Omit generating some runtime information and helper functions. [default: false]
#   -DZigCC=[bool]               Use zig cc as compiler and linker. [default: false]
```

## Shaders
Checkout [sokol-tools](https://github.com/floooh/sokol-tools) for a sokol shader pipeline! It supports these D bindings and all shaders in the examples folder
here have been compiled using it with `-f sokol_d`!

```bash
zig build shaders # (re)generate D bindings from shaders.
```

## License and attributinos
This code is released under the zlib license (see `LICENSE` for info). Parts of `gen_d.py` have been copied and modified from
the zig-bindings (https://github.com/floooh/sokol-zig/) and rust-bindings (https://github.com/floooh/sokol-rust/) for sokol.

The sokol headers are created by Andre Weissflog (floooh) and sokol is released under its own license here: https://github.com/floooh/sokol/blob/master/LICENSE
