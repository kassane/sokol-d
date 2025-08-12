#!/usr/bin/env bash

# NOTE: this is a simple helper script to allow compiling the shaders with a locally modified sokol-shdc executable
set -e

if [ -z "$1" ]
then
    echo "usage: ./local-compile-shaders [path to sokol-shdc]"
    exit 1
fi

sokol_shdc="$1"

cd examples/shaders
$sokol_shdc -i blend.glsl -o blend.d --format sokol_d --slang glsl410:glsl300es:hlsl5:metal_macos:wgsl
$sokol_shdc -i bufferoffsets.glsl -o bufferoffsets.d --format sokol_d --slang glsl410:glsl300es:hlsl5:metal_macos:wgsl
$sokol_shdc -i cube.glsl -o cube.d --format sokol_d --slang glsl410:glsl300es:hlsl5:metal_macos:wgsl
$sokol_shdc -i instancing.glsl -o instancing.d --format sokol_d --slang glsl410:glsl300es:hlsl5:metal_macos:wgsl
$sokol_shdc -i mrt.glsl -o mrt.d --format sokol_d --slang glsl410:glsl300es:hlsl5:metal_macos:wgsl
$sokol_shdc -i noninterleaved.glsl -o noninterleaved.d --format sokol_d --slang glsl410:glsl300es:hlsl5:metal_macos:wgsl
$sokol_shdc -i offscreen.glsl -o offscreen.d --format sokol_d --slang glsl410:glsl300es:hlsl5:metal_macos:wgsl
$sokol_shdc -i quad.glsl -o quad.d --format sokol_d --slang glsl410:glsl300es:hlsl5:metal_macos:wgsl
$sokol_shdc -i shapes.glsl -o shapes.d --format sokol_d --slang glsl410:glsl300es:hlsl5:metal_macos:wgsl
$sokol_shdc -i texcube.glsl -o texcube.d --format sokol_d --slang glsl410:glsl300es:hlsl5:metal_macos:wgsl
$sokol_shdc -i triangle.glsl -o triangle.d --format sokol_d --slang glsl410:glsl300es:hlsl5:metal_macos:wgsl

$sokol_shdc -i instancingcompute.glsl -o instancingcompute.d --format sokol_d --slang glsl430:glsl310es:hlsl5:metal_macos:wgsl
$sokol_shdc -i vertexpull.glsl -o vertexpull.d --format sokol_d --slang glsl430:glsl310es:hlsl5:metal_macos:wgsl

cd ../..
