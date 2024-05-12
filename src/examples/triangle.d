//------------------------------------------------------------------------------
//  triangle.d
//
//  Vertex buffer, shader, pipeline state object.
//------------------------------------------------------------------------------
module examples.triangle;

import sg = sokol.gfx;
import sapp = sokol.app;
import log = sokol.log;
import sglue = sokol.glue;
import shd = shaders.triangle;

extern (C):
@safe:

struct State {
    sg.Bindings bind;
    sg.Pipeline pip;
}
static State state;

static void init() {
    sg.Desc sg_desc = {
        environment: sglue.environment(),
        logger: { func: &log.slog_func },
    };
    sg.setup(sg_desc);

    // create vertex buffer with triangle vertices
    float[21] vertices = [
        // positions      colors
        0.0,   0.5, 0.5,  1.0, 0.0, 0.0, 1.0,
        0.5,  -0.5, 0.5,  0.0, 1.0, 0.0, 1.0,
        -0.5, -0.5, 0.5,  0.0, 0.0, 1.0, 1.0,
    ];
    sg.BufferDesc buf_desc = {
        data: {
            ptr: vertices.ptr,
            size: vertices.sizeof,
        }
    };
    state.bind.vertex_buffers[0] = sg.makeBuffer(buf_desc);

    // create a shader and pipeline object
    sg.PipelineDesc pip_desc = {
        shader: sg.makeShader(shd.triangle_shader_desc(sg.queryBackend())),
        layout: {
            attrs: [
                shd.ATTR_VS_POSITION: { format: sg.VertexFormat.Float3 },
                shd.ATTR_VS_COLOR0:   { format: sg.VertexFormat.Float4 },
            ],
        }
    };
    state.pip = sg.makePipeline(pip_desc);
}

static void frame() {
    // default pass-action clears to grey
    sg.Pass pass = { swapchain: sglue.swapchain() };
    sg.beginPass(pass);
    sg.applyPipeline(state.pip);
    sg.applyBindings(state.bind);
    sg.draw(0, 3, 1);
    sg.endPass();
    sg.commit();
}

static void cleanup() {
    sg.shutdown();
}

void main() {
    sapp.Desc runner = {
        window_title: "triangle.d",
        init_cb: &init,
        frame_cb: &frame,
        cleanup_cb: &cleanup,
        width: 800,
        height: 600,
        icon: {sokol_default: true},
        logger: {func: &log.func}
    };
    sapp.run(runner);
}
