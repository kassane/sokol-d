//------------------------------------------------------------------------------
//  blend.d - Example Sokol Blend
//
//  Shader with uniform data.
//------------------------------------------------------------------------------
module examples.blend;

import sg = sokol.gfx;
import app = sokol.app;
import log = sokol.log;
import handmade.math : Mat4, Vec3;
import sglue = sokol.glue;
import sgutil = sokol.utils : asRange;
import shd = shaders.blend;

extern (C):
@safe:

immutable NUM_BLEND_FACTORS = 15;

struct State
{
    float r = 0.0f;
    sg.Pipeline bg_pip;
    sg.Pipeline[NUM_BLEND_FACTORS][NUM_BLEND_FACTORS] pips;
    sg.Bindings bind;
    sg.PassAction passAction = {
        colors: [
            {load_action: sg.LoadAction.Dontcare}
        ],
        depth: {load_action: sg.LoadAction.Dontcare},
        stencil: {load_action: sg.LoadAction.Dontcare}
    };
    shd.QuadVsParams quad_vs_params;
    shd.BgFsParams bg_fs_params;
}

static State state;

void init() @trusted
{
    sg.Desc gfx = {
        pipeline_pool_size: NUM_BLEND_FACTORS * NUM_BLEND_FACTORS + 1,
        environment: sglue.environment,
        logger: {func: &log.func}
    };
    sg.setup(gfx);

    float[28] vertices = [
        // pos            color
        -1.0, -1.0, 0.0, 1.0, 0.0, 0.0, 0.5,
        1.0, -1.0, 0.0, 0.0, 1.0, 0.0, 0.5,
        -1.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.5,
        1.0, 1.0, 0.0, 1.0, 1.0, 0.0, 0.5,
    ];

    // Create vertex buffer
    sg.BufferDesc vbuffer = {data: sgutil.asRange(&vertices[0])};
    state.bind.vertex_buffers[0] = sg.makeBuffer(vbuffer);

    sg.ShaderDesc bgShader = shd.bg_shader_desc(sg.queryBackend());
    sg.PipelineDesc pld = {
        layout: {buffers: [{stride: 28}]},
        primitive_type: sg.PrimitiveType.Triangle_strip
    };
    pld.shader = sg.makeShader(bgShader);
    pld.layout.attrs[shd.ATTR_VS_BG_POSITION].format = sg.VertexFormat.Float2;
    state.bg_pip = sg.makePipeline(pld);

    sg.ShaderDesc quadShader = shd.quad_shader_desc(sg.queryBackend());
    sg.PipelineDesc pip_desc = {
        layout: {buffers: [{stride: 28}]},
        primitive_type: sg.PrimitiveType.Triangle_strip,
        blend_color: {r: 1.0, g: 0.0, b: 0.0, a: 1.0},
        colors: [
            {
                blend: {
                    enabled: true,
                    src_factor_alpha: sg.BlendFactor.One,
                    dst_factor_alpha: sg.BlendFactor.Zero
                }
            }
        ]
    };
    pip_desc.shader = sg.makeShader(quadShader);
    pip_desc.layout.attrs[shd.ATTR_VS_QUAD_POSITION].format = sg.VertexFormat.Float3;
    pip_desc.layout.attrs[shd.ATTR_VS_QUAD_COLOR0].format = sg.VertexFormat.Float4;
    foreach (src; 0 .. NUM_BLEND_FACTORS)
    {
        foreach (dst; 0 .. NUM_BLEND_FACTORS)
        {
            pip_desc.colors[0].blend.src_factor_rgb = cast(sg.BlendFactor)(src + 1);
            pip_desc.colors[0].blend.dst_factor_rgb = cast(sg.BlendFactor)(dst + 1);
            state.pips[src][dst] = sg.makePipeline(pip_desc);
        }
    }
}

void frame()
{
    immutable float t = cast(float)(app.frameDuration() * 60.0);

    state.r += 0.6 * t;
    state.bg_fs_params.tick += 1.0 * t;

    // view-projection matrix
    immutable proj = Mat4.perspective(90.0, app.widthf() / app.heightf(), 0.01, 100.0);
    immutable view = Mat4.lookAt(Vec3(0.0, 0.0, 25.0), Vec3.zero(), Vec3.up());
    immutable view_proj = Mat4.mul(proj, view);

    sg.Pass pass = {action: state.passAction, swapchain: sglue.swapchain};
    sg.beginPass(pass);

    sg.Range r = sgutil.asRange(state.bg_fs_params);
    sg.applyPipeline(state.bg_pip);
    sg.applyBindings(state.bind);
    sg.applyUniforms(sg.ShaderStage.Fs, shd.SLOT_BG_FS_PARAMS, r);
    sg.draw(0, 4, 1);

    // draw the blended quads
    float r0 = state.r;
    foreach (src; 0 .. NUM_BLEND_FACTORS)
    {
        foreach (dst; 0 .. NUM_BLEND_FACTORS)
        {
            // compute model-view-proj matrix
            auto rm = Mat4.rotate(state.r, Vec3(0.0, 1.0, 0.0));
            immutable x = (dst - (NUM_BLEND_FACTORS / 2)) * 3.0;
            immutable y = (src - (NUM_BLEND_FACTORS / 2)) * 2.2;
            immutable model = Mat4.mul(Mat4.translate(Vec3(x, y, 0.0)), rm);
            state.quad_vs_params.mvp = Mat4.mul(view_proj, model);
            sg.Range rg = sgutil.asRange(state.quad_vs_params);

            sg.applyPipeline(state.pips[src][dst]);
            sg.applyBindings(state.bind);
            sg.applyUniforms(
                sg.ShaderStage.Vs,
                shd.SLOT_QUAD_VS_PARAMS,
                rg,
            );
            sg.draw(0, 4, 1);
            r0 += 0.6;
        }
    }
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
        window_title: "blend.d",
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
