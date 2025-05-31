//------------------------------------------------------------------------------
//  noninterleaved.d
//
//  How to use non-interleaved vertex data (vertex components in
//  separate non-interleaved chunks in the same vertex buffers). Note
//  that only 4 separate chunks are currently possible because there
//  are 4 vertex buffer bind slots in sg_bindings, but you can keep
//  several related vertex components interleaved in the same chunk.
//------------------------------------------------------------------------------
module examples.noninterleaved;

private:

import sg = sokol.gfx;
import app = sokol.app;
import log = sokol.log;
import handmade.math : Mat4, Vec3;
import sglue = sokol.glue;
import shd = shaders.noninterleaved;

extern (C):
@safe:

struct State
{
    float rx = 0;
    float ry = 0;

    sg.Pipeline pip;
    sg.Bindings bind;
    sg.PassAction passAction = {};

    Mat4 view()
    {
        return Mat4.lookAt(Vec3(0.0, 1.5, 6.0), Vec3.zero(), Vec3.up());
    }
}

static State state;

void init()
{
    sg.Desc gfxd = {environment: sglue.environment,
    logger: {func: &log.func}};
    sg.setup(gfxd);

    float[168] vertices = [
        // positions
        -1.0, -1.0, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0, -1.0, -1.0, 1.0, -1.0,
        -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0, 1.0, 1.0, -1.0, 1.0, 1.0,
        -1.0, -1.0, -1.0, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0, -1.0, -1.0, 1.0,
        1.0, -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0, 1.0, 1.0, -1.0, 1.0,
        -1.0, -1.0, -1.0, -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0, -1.0, -1.0,
        -1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, -1.0,
        // colors
        1.0, 0.5, 0.0, 1.0, 1.0, 0.5, 0.0, 1.0, 1.0, 0.5, 0.0, 1.0,
        1.0, 0.5, 0.0, 1.0, 0.5, 1.0, 0.0, 1.0, 0.5, 1.0, 0.0, 1.0,
        0.5, 1.0, 0.0, 1.0, 0.5, 1.0, 0.0, 1.0, 0.5, 0.0, 1.0, 1.0,
        0.5, 0.0, 1.0, 1.0, 0.5, 0.0, 1.0, 1.0, 0.5, 0.0, 1.0, 1.0,
        1.0, 0.5, 1.0, 1.0, 1.0, 0.5, 1.0, 1.0, 1.0, 0.5, 1.0, 1.0,
        1.0, 0.5, 1.0, 1.0, 0.5, 1.0, 1.0, 1.0, 0.5, 1.0, 1.0, 1.0,
        0.5, 1.0, 1.0, 1.0, 0.5, 1.0, 1.0, 1.0, 1.0, 1.0, 0.5, 1.0,
        1.0, 1.0, 0.5, 1.0, 1.0, 1.0, 0.5, 1.0, 1.0, 1.0, 0.5, 1.0,
    ];

    // dfmt off
    sg.BufferDesc vbufd = {
        data:
        {
            ptr: vertices.ptr,
            size: vertices.sizeof
        },
        label: "vertices",
    };
    // dfmt on

    ushort[36] indices = [
        0, 1, 2, 0, 2, 3,
        6, 5, 4, 7, 6, 4,
        8, 9, 10, 8, 10, 11,
        14, 13, 12, 15, 14, 12,
        16, 17, 18, 16, 18, 19,
        22, 21, 20, 23, 22, 20,
    ];

    // dfmt off
    sg.BufferDesc ibufd = {
        usage: { index_buffer: true },
        data: {ptr: indices.ptr, size: indices.sizeof},
    };

    sg.PipelineDesc pld = {
        layout: {
            attrs: [
                shd.ATTR_NONINTERLEAVED_POSITION: {
                    format: sg.VertexFormat.Float3,
                    buffer_index: 0
                },
                shd.ATTR_NONINTERLEAVED_COLOR0: {
                    format: sg.VertexFormat.Float4,
                    buffer_index: 1
                },
            ],
        },
        shader: sg.makeShader(shd.noninterleavedShaderDesc(sg.queryBackend())),
        index_type: sg.IndexType.Uint16,
        cull_mode: sg.CullMode.Back,
        depth: {
            write_enabled: true,
            compare: sg.CompareFunc.Less_equal
        },
        label: "pipeline"
    };
    // dfmt on
    state.pip = sg.makePipeline(pld);

    // fill the resource bindings, note how the same vertex
    // buffer is bound to the first two slots, and the vertex-buffer-offsets
    // are used to point to the position- and color-components.
    state.bind.vertex_buffers[0] = sg.makeBuffer(vbufd);
    state.bind.vertex_buffers[1] = sg.makeBuffer(vbufd);
    // position vertex components are at the start of the buffer
    state.bind.vertex_buffer_offsets[0] = 0;
    // color vertex components follow after the positions
    state.bind.vertex_buffer_offsets[1] = 24 * 3 * float.sizeof;
    state.bind.index_buffer = sg.makeBuffer(ibufd);
}

void frame()
{
    immutable float t = cast(float)(app.frameDuration() * 60.0);

    state.rx += 1.0 * t;
    state.ry += 2.0 * t;

    shd.VsParams vsParams = {mvp: computeMvp(state.rx, state.ry)};

    sg.Pass pass = {action: state.passAction, swapchain: sglue.swapchain()};
    sg.beginPass(pass);
    sg.applyPipeline(state.pip);
    sg.applyBindings(state.bind);
    sg.Range r = {ptr: &vsParams, size: vsParams.sizeof};
    sg.applyUniforms(shd.UB_VS_PARAMS, r);
    sg.draw(0, 36, 1);
    sg.endPass();
    sg.commit();
}

void cleanup()
{
    sg.shutdown();
}

Mat4 computeMvp(float rx, float ry)
{
    immutable proj = Mat4.perspective(60.0, app.widthf() / app.heightf(), 0.01, 10.0);
    immutable rxm = Mat4.rotate(rx, Vec3(1.0, 0.0, 0.0));
    immutable rym = Mat4.rotate(ry, Vec3(0.0, 1.0, 0.0));
    immutable model = Mat4.mul(rxm, rym);
    immutable view_proj = Mat4.mul(proj, state.view());
    return Mat4.mul(view_proj, model);
}

// dfmt off
void main()
{
    app.Desc runner = {
        window_title: "noninterleaved.d",
        init_cb: &init,
        frame_cb: &frame,
        cleanup_cb: &cleanup,
        width: 800,
        height: 600,
        sample_count: 4,
        icon: {sokol_default: true},
        logger: {func: &log.func}
    };
    app.run(runner);
}
// dfmt on

version (WebAssembly)
{
    debug
    {
        import emscripten.assertd;
    }
}