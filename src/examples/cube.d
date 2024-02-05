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
import sgutil = sokol.utils : asRange;

extern (C):
@safe:

struct State
{
    float rx;
    float ry;

    sg.Pipeline pip;
    sg.Bindings bind;
    sg.PassAction passAction = {
        colors: [
            {
                load_action: sg.LoadAction.Clear, clear_value: {
                    r: 0.25, g: 0.5, b: 0.75, a: 1.0
                }
            }
        ]
    };

    Mat4 view()
    {
        return Mat4.lookAt(Vec3(0.0, 1.5, 6.0), Vec3.zero(), Vec3.up());
    }
}

static State state;

void init() @trusted
{
    sg.Desc gfx = {context: sgapp.context(),
    logger: {func: &log.func}};
    sg.setup(gfx);

    float[168] vertices = [
        -1.0, -1.0, -1.0, 1.0, 0.0, 0.0, 1.0,
        1.0, -1.0, -1.0, 1.0, 0.0, 0.0, 1.0,
        1.0, 1.0, -1.0, 1.0, 0.0, 0.0, 1.0,
        -1.0, 1.0, -1.0, 1.0, 0.0, 0.0, 1.0,

        -1.0, -1.0, 1.0, 0.0, 1.0, 0.0, 1.0,
        1.0, -1.0, 1.0, 0.0, 1.0, 0.0, 1.0,
        1.0, 1.0, 1.0, 0.0, 1.0, 0.0, 1.0,
        -1.0, 1.0, 1.0, 0.0, 1.0, 0.0, 1.0,

        -1.0, -1.0, -1.0, 0.0, 0.0, 1.0, 1.0,
        -1.0, 1.0, -1.0, 0.0, 0.0, 1.0, 1.0,
        -1.0, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0,
        -1.0, -1.0, 1.0, 0.0, 0.0, 1.0, 1.0,

        1.0, -1.0, -1.0, 1.0, 0.5, 0.0, 1.0,
        1.0, 1.0, -1.0, 1.0, 0.5, 0.0, 1.0,
        1.0, 1.0, 1.0, 1.0, 0.5, 0.0, 1.0,
        1.0, -1.0, 1.0, 1.0, 0.5, 0.0, 1.0,

        -1.0, -1.0, -1.0, 0.0, 0.5, 1.0, 1.0,
        -1.0, -1.0, 1.0, 0.0, 0.5, 1.0, 1.0,
        1.0, -1.0, 1.0, 0.0, 0.5, 1.0, 1.0,
        1.0, -1.0, -1.0, 0.0, 0.5, 1.0, 1.0,

        -1.0, 1.0, -1.0, 1.0, 0.0, 0.5, 1.0,
        -1.0, 1.0, 1.0, 1.0, 0.0, 0.5, 1.0,
        1.0, 1.0, 1.0, 1.0, 0.0, 0.5, 1.0,
        1.0, 1.0, -1.0, 1.0, 0.0, 0.5, 1.0
    ];

    // Create vertex buffer
    sg.BufferDesc vbuffer = {data: sgutil.asRange(&vertices[0])};
    state.bind.vertex_buffers[0] = sg.makeBuffer(vbuffer);

    double[36] indices = [
        0, 1, 2, 0, 2, 3,
        6, 5, 4, 7, 6, 4,
        8, 9, 10, 8, 10, 11,
        14, 13, 12, 15, 14, 12,
        16, 17, 18, 16, 18, 19,
        22, 21, 20, 23, 22, 20,
    ];

    sg.BufferDesc ibuffer = {
        type: sg.BufferType.Indexbuffer,
        data: sgutil.asRange(&indices[0])
    };
    state.bind.index_buffer = sg.makeBuffer(ibuffer);

    sg.ShaderDesc cubeShader = shd.cube_shader_desc(sg.queryBackend());
    sg.PipelineDesc pld = {
        index_type: sg.IndexType.Uint16,
        cull_mode: sg.CullMode.Back,
        depth: {write_enabled: true, compare: sg.CompareFunc.Less_equal},
        layout: {buffers: [{stride: 28}]}
    };
    pld.shader = sg.makeShader(cubeShader);
    pld.layout.attrs[shd.ATTR_VS_POSITION].format = sg.VertexFormat.Float3;
    pld.layout.attrs[shd.ATTR_VS_COLOR0].format = sg.VertexFormat.Float4;
    state.pip = sg.makePipeline(pld);
}

void frame()
{
    immutable float t = cast(float)(app.frameDuration() * 60.0);

    state.rx += 1.0 * t;
    state.ry += 2.0 * t;

    shd.VsParams vsParams = {mvp: computeVsParams(state.rx, state.ry)};

    sg.beginDefaultPass(state.passAction, app.width(), app.height());

    sg.Range r = sgutil.asRange(vsParams);
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

Mat4 computeVsParams(float rx, float ry)
{
    immutable proj = Mat4.perspective(60.0, app.widthf() / app.heightf(), 0.01, 10.0);
    immutable rxm = Mat4.rotate(rx, Vec3(1.0, 0.0, 0.0));
    immutable rym = Mat4.rotate(ry, Vec3(0.0, 1.0, 0.0));
    immutable model = Mat4.mul(rxm, rym);
    immutable view_proj = Mat4.mul(proj, state.view());

    return Mat4.mul(view_proj, model);
}

void main()
{
    app.Desc runner = {
        window_title: "cube.d",
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
