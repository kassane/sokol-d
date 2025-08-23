//------------------------------------------------------------------------------
//  vertexpull.d
//
//  Pull vertices from a storage buffer instead of using fixed-function
//  vertex input.
//------------------------------------------------------------------------------
module examples.vertexpull;

private:

import sg = sokol.gfx;
import app = sokol.app;
import log = sokol.log;
import handmade.math : Mat4, Vec3;
import sglue = sokol.glue;
import shd = shaders.vertexpull;

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

    // if storage buffers are not supported on the current backend, just render a red screen
    if (!sg.queryFeatures.compute)
    {
        state.passAction.colors[0].load_action = sg.LoadAction.Clear;
        state.passAction.colors[0].clear_value.r = 1.0;
        state.passAction.colors[0].clear_value.g = 0.0;
        state.passAction.colors[0].clear_value.b = 0.0;
        state.passAction.colors[0].clear_value.a = 1.0;
        return;
    }
    // otherwise set regular clear color
    state.passAction.colors[0].load_action = sg.LoadAction.Clear;
    state.passAction.colors[0].clear_value.r = 0.75;
    state.passAction.colors[0].clear_value.g = 0.5;
    state.passAction.colors[0].clear_value.b = 0.25;
    state.passAction.colors[0].clear_value.a = 1.0;

    shd.SbVertex[24] vertices = [
        {pos: [-1.0, -1.0, -1.0], color: [1.0, 0.0, 0.0, 1.0]},
        {pos: [1.0, -1.0, -1.0], color: [1.0, 0.0, 0.0, 1.0]},
        {pos: [1.0, 1.0, -1.0], color: [1.0, 0.0, 0.0, 1.0]},
        {pos: [-1.0, 1.0, -1.0], color: [1.0, 0.0, 0.0, 1.0]},
        {pos: [-1.0, -1.0, 1.0], color: [0.0, 1.0, 0.0, 1.0]},
        {pos: [1.0, -1.0, 1.0], color: [0.0, 1.0, 0.0, 1.0]},
        {pos: [1.0, 1.0, 1.0], color: [0.0, 1.0, 0.0, 1.0]},
        {pos: [-1.0, 1.0, 1.0], color: [0.0, 1.0, 0.0, 1.0]},
        {pos: [-1.0, -1.0, -1.0], color: [0.0, 0.0, 1.0, 1.0]},
        {pos: [-1.0, 1.0, -1.0], color: [0.0, 0.0, 1.0, 1.0]},
        {pos: [-1.0, 1.0, 1.0], color: [0.0, 0.0, 1.0, 1.0]},
        {pos: [-1.0, -1.0, 1.0], color: [0.0, 0.0, 1.0, 1.0]},
        {pos: [1.0, -1.0, -1.0], color: [1.0, 0.5, 0.0, 1.0]},
        {pos: [1.0, 1.0, -1.0], color: [1.0, 0.5, 0.0, 1.0]},
        {pos: [1.0, 1.0, 1.0], color: [1.0, 0.5, 0.0, 1.0]},
        {pos: [1.0, -1.0, 1.0], color: [1.0, 0.5, 0.0, 1.0]},
        {pos: [-1.0, -1.0, -1.0], color: [0.0, 0.5, 1.0, 1.0]},
        {pos: [-1.0, -1.0, 1.0], color: [0.0, 0.5, 1.0, 1.0]},
        {pos: [1.0, -1.0, 1.0], color: [0.0, 0.5, 1.0, 1.0]},
        {pos: [1.0, -1.0, -1.0], color: [0.0, 0.5, 1.0, 1.0]},
        {pos: [-1.0, 1.0, -1.0], color: [1.0, 0.0, 0.5, 1.0]},
        {pos: [-1.0, 1.0, 1.0], color: [1.0, 0.0, 0.5, 1.0]},
        {pos: [1.0, 1.0, 1.0], color: [1.0, 0.0, 0.5, 1.0]},
        {pos: [1.0, 1.0, -1.0], color: [1.0, 0.0, 0.5, 1.0]},
    ];

    // dfmt off
    sg.BufferDesc sbuf_desc = {
        usage: { storage_buffer: true },
        data:
        {
            ptr: vertices.ptr,
            size: vertices.sizeof
        },
        label: "vertices",
    };
    // dfmt on
    auto sbuf = sg.makeBuffer(sbuf_desc);
    sg.ViewDesc sbuf_view_desc = {
        storage_buffer: { buffer: sbuf },
    };
    state.bind.views[shd.VIEW_SSBO] = sg.makeView(sbuf_view_desc);

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
    state.bind.index_buffer = sg.makeBuffer(ibufd);

    sg.PipelineDesc pld = {
        shader: sg.makeShader(shd.vertexpullShaderDesc(sg.queryBackend())),
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
        window_title: "vertexpull.d",
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
