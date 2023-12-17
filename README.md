
Auto-generated [D](https://dlang.org) bindings for the [sokol headers](https://github.com/floooh/sokol).

## BUILD

**Required**

- [zig](https://ziglang.org/download) v0.11.0 or master
- [ldc](https://ldc-developers.github.io) v1.35.0 or latest-CI (nightly)

Supported platforms are: Windows, macOS, Linux (with X11)

On Linux install the following packages: libglu1-mesa-dev, mesa-common-dev, xorg-dev, libasound-dev (or generally: the dev packages required for X11, GL and ALSA development)

```sh
# build sokol library only
zig build -Doptimize=ReleaseFast
# build samples [WiP]
zig build debugtext_print -Doptimize=ReleaseFast # run, but show black screen
zig build cube -Doptimize=ReleaseFast # not building
```