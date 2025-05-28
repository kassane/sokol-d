//------------------------------------------------------------------------------
//  quad.d
//
//  Simple 2D rendering with vertex- and index-buffer.
//------------------------------------------------------------------------------
module examples.quad;

private:

import sg = sokol.gfx;
import app = sokol.app;
import log = sokol.log;
import sglue = sokol.glue;
import shd = shaders.quad;

extern (C):
@safe:

struct State
{
    sg.Pipeline pip;
    sg.Bindings bind;
    sg.PassAction passAction = {};
}

static State state;

void init()
{
    sg.Desc gfxd = {environment: sglue.environment,
    logger: {func: &log.func}};
    sg.setup(gfxd);

    float[28] vertices = [
        // positions      colors
        -0.5, 0.5, 0.5, 1.0, 0.0, 0.0, 1.0,
        0.5, 0.5, 0.5, 0.0, 1.0, 0.0, 1.0,
        0.5, -0.5, 0.5, 0.0, 0.0, 1.0, 1.0,
        -0.5, -0.5, 0.5, 1.0, 1.0, 0.0, 1.0,
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

    state.bind.vertex_buffers[0] = sg.makeBuffer(vbufd);

    ushort[6] indices = [
        0, 1, 2, 0, 2, 3,
    ];

    // dfmt off
    sg.BufferDesc ibufd = {
        usage: { index_buffer: true },
        data: {ptr: indices.ptr, size: indices.sizeof},
    };
    state.bind.index_buffer = sg.makeBuffer(ibufd);

    sg.PipelineDesc pld = {
        layout: {
            attrs: [
                shd.ATTR_QUAD_POSITION: {format: sg.VertexFormat.Float3},
                shd.ATTR_QUAD_COLOR0: {format: sg.VertexFormat.Float4},
            ],
        },
        shader: sg.makeShader(shd.quadShaderDesc(sg.queryBackend())),
        index_type: sg.IndexType.Uint16,
        label: "pipeline"
    };
    // dfmt on
    state.pip = sg.makePipeline(pld);

    state.passAction.colors[0].load_action = sg.LoadAction.Clear;
    state.passAction.colors[0].clear_value.r = 0.0;
    state.passAction.colors[0].clear_value.g = 0.0;
    state.passAction.colors[0].clear_value.b = 0.0;
    state.passAction.colors[0].clear_value.a = 1.0;
}

void frame()
{
    sg.Pass pass = {action: state.passAction, swapchain: sglue.swapchain()};
    sg.beginPass(pass);
    sg.applyPipeline(state.pip);
    sg.applyBindings(state.bind);
    sg.draw(0, 6, 1);
    sg.endPass();
    sg.commit();
}

void cleanup()
{
    sg.shutdown();
}

// dfmt off
void main()
{
    app.Desc runner = {
        window_title: "quad.d",
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
