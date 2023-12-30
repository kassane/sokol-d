
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
zig build clear -Doptimize=ReleaseFast # works (optional: add -DBetterC)
zig build debugtext_print -Doptimize=ReleaseFast # run, but no anims (fixme)
zig build sgl_context -Doptimize=ReleaseFast # run, but no anims (fixme)
zig build cube -Doptimize=ReleaseFast # (fixme)

# custom options:
# -DZigCC (use zig cc as compiler and linker),
# -DBetterC (disable D runtime on ldc2)
```

## Shaders
Checkout [sokol-tools](https://github.com/floooh/sokol-tools) for a sokol shader pipeline! It supports these D bindings and all shaders in the examples folder
here have been compiled using it with `-f sokol_d`!

```bash
zig build shaders # (re-)generate D bindings from shaders.
```

## License and attributinos
This code is released under the zlib license (see `LICENSE` for info). Parts of `gen_d.py` have been copied and modified from
the zig-bindings (https://github.com/floooh/sokol-zig/) and rust-bindings (https://github.com/floooh/sokol-rust/) for sokol.

The sokol headers are created by Andre Weissflog (floooh) and sokol is released under its own license here: https://github.com/floooh/sokol/blob/master/LICENSE
