//------------------------------------------------------------------------------
//  cube.d - Example Sokol Cube
//
//  Shader with uniform data.
//------------------------------------------------------------------------------
module examples.cube;

import sg = sokol.gfx;
import app = sokol.app;
import log = sokol.log;
import handmade.math : Mat4, Vec3;
import sgapp = sokol.glue;
import shd = shaders.cube;

extern(C):
@safe:

struct State
{
    @disable this();
    float rx = 0.0f;
    float ry = 0.0f;

    sg.Pipeline pip;
    sg.Bindings bind;
    sg.PassAction passAction;

    static Mat4 view()
    {
        return Mat4.lookAt(Vec3(0.0f, 1.5f, 6.0f), Vec3.zero(), Vec3.up());
    }
}

static State state = {};

void init()
{
    sg.Desc gfx = {
        context: sgapp.context(),
        logger: {func: &log.func}
    };
    sg.setup(gfx);

    float[] vertices = [
        -1.0, -1.0, -1.0,   1.0, 0.0, 0.0, 1.0,
         1.0, -1.0, -1.0,   1.0, 0.0, 0.0, 1.0,
         1.0,  1.0, -1.0,   1.0, 0.0, 0.0, 1.0,
        -1.0,  1.0, -1.0,   1.0, 0.0, 0.0, 1.0,

        -1.0, -1.0,  1.0,   0.0, 1.0, 0.0, 1.0,
         1.0, -1.0,  1.0,   0.0, 1.0, 0.0, 1.0,
         1.0,  1.0,  1.0,   0.0, 1.0, 0.0, 1.0,
        -1.0,  1.0,  1.0,   0.0, 1.0, 0.0, 1.0,

        -1.0, -1.0, -1.0,   0.0, 0.0, 1.0, 1.0,
        -1.0,  1.0, -1.0,   0.0, 0.0, 1.0, 1.0,
        -1.0,  1.0,  1.0,   0.0, 0.0, 1.0, 1.0,
        -1.0, -1.0,  1.0,   0.0, 0.0, 1.0, 1.0,

        1.0, -1.0, -1.0,    1.0, 0.5, 0.0, 1.0,
        1.0,  1.0, -1.0,    1.0, 0.5, 0.0, 1.0,
        1.0,  1.0,  1.0,    1.0, 0.5, 0.0, 1.0,
        1.0, -1.0,  1.0,    1.0, 0.5, 0.0, 1.0,

        -1.0, -1.0, -1.0,   0.0, 0.5, 1.0, 1.0,
        -1.0, -1.0,  1.0,   0.0, 0.5, 1.0, 1.0,
         1.0, -1.0,  1.0,   0.0, 0.5, 1.0, 1.0,
         1.0, -1.0, -1.0,   0.0, 0.5, 1.0, 1.0,

        -1.0,  1.0, -1.0,   1.0, 0.0, 0.5, 1.0,
        -1.0,  1.0,  1.0,   1.0, 0.0, 0.5, 1.0,
         1.0,  1.0,  1.0,   1.0, 0.0, 0.5, 1.0,
         1.0,  1.0, -1.0,   1.0, 0.0, 0.5, 1.0
    ];

    // Create vertex buffer
    sg.BufferDesc buffer = {
        size: vertices.length,
        type: sg.BufferType.Indexbuffer,
        usage: sg.Usage.Immutable,
        label: "cube-vertices",
        data: sg.asRange(vertices)
    };
    state.bind.vertex_buffers[0] = sg.makeBuffer(buffer);

    // shader and pipeline object
    sg.PipelineDesc pld = {
        index_type: sg.IndexType.Uint16,
        cull_mode: sg.CullMode.Back,
        depth: {write_enabled: true, compare: sg.CompareFunc.Less_equal}
    };
    pld.layout.buffers[0].stride = 28;
    pld.layout.attrs[shd.ATTR_VS_POSITION].format = sg.VertexFormat.Float3;
    pld.layout.attrs[shd.ATTR_VS_COLOR0].format = sg.VertexFormat.Float4;
    state.pip = sg.makePipeline(pld);

    // framebuffer clear color
    state.passAction.colors[0].load_action = sg.LoadAction.Clear;
    state.passAction.colors[0].clear_value.r = 0.25;
    state.passAction.colors[0].clear_value.g = 0.5;
    state.passAction.colors[0].clear_value.b = 0.75;
    state.passAction.colors[0].clear_value.a = 1;
}

sg.Range ranging(ref shd.VsParams params) @trusted{
    return cast(sg.Range)&params;
}
void frame()
{
    float dt = cast(float) app.frameDuration() * 60;

    state.rx += dt;
    state.ry += dt;

    auto vsParams = computeVsParams(state.rx, state.ry);

    sg.beginDefaultPass(state.passAction, app.width(), app.height());

    sg.Range r = ranging(vsParams);
    sg.applyPipeline(state.pip);
    sg.applyBindings(state.bind);
    sg.applyUniforms(sg.ShaderStage.Vs, shd.SLOT_VS_PARAMS, r);

    sg.draw(0, 36, 1);

    sg.endPass();
    sg.commit();
}

void cleanup()
{
    sg.shutdown();
}

void main()
{
    app.Desc runner = {
        window_title: "cube.d",
        init_cb: &init,
        frame_cb: &frame,
        cleanup_cb: &cleanup,
        width: 640,
        height: 480,
        win32_console_attach: true,
        icon: {sokol_default: true},
        logger: {func: &log.func}
    };
    app.run(runner);
}

shd.VsParams computeVsParams(float rx, float ry) 
{
    auto rxm = Mat4.rotate(rx, Vec3(1, 0, 0));
    auto rym = Mat4.rotate(ry, Vec3(0, 1, 0));
    auto model = Mat4.mul(rxm, rym);

    auto aspect = app.width() / app.height();
    auto proj = Mat4.perspective(60, aspect, 0.01f, 10);
    shd.VsParams params = {mvp: Mat4.mul(Mat4.mul(proj, state.view), model)};
    return params;
}