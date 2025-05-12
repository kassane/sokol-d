# Sokol-d examples

#### Available examples:

> [!TIP]
> Dub for [wasm|wgpu] (need ldc2) target add flag: `--arch wasm32-unknown-emscripten`

```console
dub :blend -c [native|wasm|wgpu] -b [debug|release|release-nobounds|release-betterc]
```
```console
dub :bufferoffsets -c [native|wasm|wgpu] -b [debug|release|release-nobounds|release-betterc]
```
```console
dub :clear -c [native|wasm|wgpu] -b [debug|release|release-nobounds|release-betterc]
```
```console
dub :cube -c [native|wasm|wgpu] -b [debug|release|release-nobounds|release-betterc]
```
```console
dub :debugtext -c [native|wasm|wgpu] -b [debug|release|release-nobounds|release-betterc]
```
```console
dub :droptest -c [native|wasm|wgpu] -b [debug|release|release-nobounds|release-betterc]
```
```console
dub :imgui -c [native|wasm|wgpu] -b [debug|release|release-nobounds|release-betterc]
```
```console
dub :instancing -c [native|wasm|wgpu] -b [debug|release|release-nobounds|release-betterc]
```
```console
dub :instancingcompute -c [native|wasm|wgpu] -b [debug|release|release-nobounds|release-betterc]
```
```console
dub :saudio -c [native|wasm|wgpu] -b [debug|release|release-nobounds|release-betterc]
```
```console
dub :sglcontext -c [native|wasm|wgpu] -b [debug|release|release-nobounds|release-betterc]
```
```console
dub :sglpoints -c [native|wasm|wgpu] -b [debug|release|release-nobounds|release-betterc]
```
```console
dub :triangle -c [native|wasm|wgpu] -b [debug|release|release-nobounds|release-betterc]
```

>[!NOTE]
> For non-D programmers: `dub` by default build & run the application.
> For build-only mode, use `dub build [...]` instead of `dub [...]` or `dub run [...]`.