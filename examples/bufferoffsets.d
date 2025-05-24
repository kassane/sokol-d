//------------------------------------------------------------------------------
//  bufferoffsets.d
//
//  Render separate geometries in vertex- and index-buffers with
//  buffer offsets.
//------------------------------------------------------------------------------
module examples.bufferoffsets;

private:

import sg = sokol.gfx;
import app = sokol.app;
import log = sokol.log;
import sglue = sokol.glue;
import shd = examples.shaders.bufferoffsets;

extern (C):
@safe:

struct State
{
    sg.Pipeline pip;
    sg.Bindings bind;
    sg.PassAction passAction = {};
}

struct Vertex
{
    float x = 0.0f, y = 0.0f;
    float r = 0.0f, g = 0.0f, b = 0.0f;
}

static State state;

void init()
{
    sg.Desc gfxd = {environment: sglue.environment,
    logger: {func: &log.func}};
    sg.setup(gfxd);

    state.passAction.colors[0].load_action = sg.LoadAction.Clear;
    state.passAction.colors[0].clear_value.r = 0.5;
    state.passAction.colors[0].clear_value.g = 0.5;
    state.passAction.colors[0].clear_value.b = 1.0;
    state.passAction.colors[0].clear_value.a = 1.0;

    Vertex[7] vertices = [
        Vertex(0.0, 0.55, 1.0, 0.0, 0.0),
        Vertex(0.25, 0.05, 0.0, 1.0, 0.0),
        Vertex(-0.25, 0.05, 0.0, 0.0, 1.0),

        Vertex(-0.25, -0.05, 0.0, 0.0, 1.0),
        Vertex(0.25, -0.05, 0.0, 1.0, 0.0),
        Vertex(0.25, -0.55, 1.0, 0.0, 0.0),
        Vertex(-0.25, -0.55, 1.0, 1.0, 0.0),
    ];

    sg.BufferDesc vbufd = {data: {ptr: vertices.ptr, size: vertices.sizeof},};
    state.bind.vertex_buffers[0] = sg.makeBuffer(vbufd);

    ushort[9] indices = [
        0, 1, 2,
        0, 1, 2,
        0, 2, 3,
    ];

    // dfmt off
    sg.BufferDesc ibufd = {
        usage: {index_buffer: true},
        data: {ptr: indices.ptr, size: indices.sizeof},
    };
    state.bind.index_buffer = sg.makeBuffer(ibufd);

    sg.PipelineDesc pld = {
        layout: {
            attrs: [
                shd.ATTR_BUFFEROFFSETS_POSITION: {format: sg.VertexFormat.Float2},
                shd.ATTR_BUFFEROFFSETS_COLOR0: {format: sg.VertexFormat.Float3},
            ],
        },
        shader: sg.makeShader(shd.bufferoffsetsShaderDesc(sg.queryBackend())),
        index_type: sg.IndexType.Uint16,
    };
    // dfmt on
    state.pip = sg.makePipeline(pld);
}

void frame()
{
    sg.Pass pass = {action: state.passAction, swapchain: sglue.swapchain()};
    sg.beginPass(pass);
    sg.applyPipeline(state.pip);

    // render the triangle
    state.bind.vertex_buffer_offsets[0] = 0;
    state.bind.index_buffer_offset = 0;
    sg.applyBindings(state.bind);
    sg.draw(0, 3, 1);

    // render the quad
    state.bind.vertex_buffer_offsets[0] = 3 * Vertex.sizeof;
    state.bind.index_buffer_offset = 3 * ushort.sizeof;
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
        window_title: "bufferoffsets.d",
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
