//------------------------------------------------------------------------------
//  offscreen.d
//
//  Render to an offscreen rendertarget texture, and use this texture
//  for rendering to the display.
//------------------------------------------------------------------------------
module examples.offscreen;

private:

import sg = sokol.gfx;
import app = sokol.app;
import log = sokol.log;
import handmade.math : Mat4, Vec3;
import sglue = sokol.glue;
import sshape = sokol.shape;
import shd = shaders.offscreen;

extern (C):
@safe:

struct State
{
    float rx = 0;
    float ry = 0;
    struct OffScreen
    {
        sg.Pipeline pip;
        sg.Bindings bind;
        sg.Attachments attachments;
        sg.PassAction passAction;
    }

    OffScreen offScreen;

    struct Default
    {
        sg.Pipeline pip;
        sg.Bindings bind;
        sg.PassAction passAction;
    }

    Default default_;

    sshape.ElementRange sphere, donut;
}

static State state;

void init()
{
    sg.Desc gfxd = {environment: sglue.environment,
    logger: {func: &log.func}};
    sg.setup(gfxd);

    // default pass action: clear to blue-ish
    state.default_.passAction.colors[0].load_action = sg.LoadAction.Clear;
    state.default_.passAction.colors[0].clear_value.r = 0.25;
    state.default_.passAction.colors[0].clear_value.g = 0.45;
    state.default_.passAction.colors[0].clear_value.b = 0.65;
    state.default_.passAction.colors[0].clear_value.a = 1.0;
    // offscreen pass action: clear to black
    state.offScreen.passAction.colors[0].load_action = sg.LoadAction.Clear;
    state.offScreen.passAction.colors[0].clear_value.r = 0.25;
    state.offScreen.passAction.colors[0].clear_value.g = 0.25;
    state.offScreen.passAction.colors[0].clear_value.b = 0.25;
    state.offScreen.passAction.colors[0].clear_value.a = 1.0;

    // dfmt off
    // a render pass with one color- and one depth-attachment image
    sg.ImageDesc img_desc = {
        usage: { render_attachment: true },
        width: 256,
        height: 256,
        pixel_format: sg.PixelFormat.Rgba8,
        sample_count: 1,
    };
    // dfmt on

    const color_img = sg.makeImage(img_desc);
    img_desc.pixel_format = sg.PixelFormat.Depth;
    const depth_img = sg.makeImage(img_desc);
    sg.AttachmentsDesc atts_desc = {};
    atts_desc.colors[0].image = color_img;
    atts_desc.depth_stencil.image = depth_img;
    state.offScreen.attachments = sg.makeAttachments(atts_desc);

    // a donut shape which is rendered into the offscreen render target, and
    // a sphere shape which is rendered into the default framebuffer
    sshape.Vertex[4000] vertices;
    ushort[24_000] indices;
    // dfmt off
    sshape.Buffer buf = {
        vertices: {buffer: sshape.Range(&vertices, vertices.sizeof) },
        indices: { buffer: sshape.Range(&indices, indices.sizeof) },
    };
    buf = sshape.buildTorus(buf, sshape.Torus(
        radius: 0.5, 
        ring_radius: 0.3,
        sides: 20,
        rings: 36,
    ));
    // dfmt on
    state.donut = sshape.elementRange(buf);
    // dfmt off
    buf = sshape.buildSphere(buf, sshape.Sphere(
        radius: 0.5,
        slices: 72,
        stacks: 40,
    ));
    // dfmt on
    state.sphere = sshape.elementRange(buf);

    const vbuf = sg.makeBuffer(sshape.vertexBufferDesc(buf));
    const ibuf = sg.makeBuffer(sshape.indexBufferDesc(buf));

    // dfmt off
    // shader and pipeline object for offscreen rendering
    sg.PipelineDesc offscreen_pip_desc = {
        layout: {
            attrs: [
                shd.ATTR_OFFSCREEN_POSITION: sshape.positionVertexAttrState,
                shd.ATTR_OFFSCREEN_NORMAL: sshape.normalVertexAttrState,
            ],
            buffers: [sshape.vertexBufferLayoutState],
        },
        colors: [{pixel_format: sg.PixelFormat.Rgba8}],
        shader: sg.makeShader(shd.offscreenShaderDesc(sg.queryBackend)),
        index_type: sg.IndexType.Uint16,
        cull_mode: sg.CullMode.Back,
        sample_count: 1,
        depth: {
            pixel_format: sg.PixelFormat.Depth,
            write_enabled: true,
            compare: sg.CompareFunc.Less_equal
        },
    };
    sg.PipelineDesc default_pip_desc = {
        layout: {
            attrs: [
                shd.ATTR_DEFAULT_POSITION: sshape.positionVertexAttrState,
                shd.ATTR_DEFAULT_NORMAL: sshape.normalVertexAttrState,
                shd.ATTR_DEFAULT_TEXCOORD0: sshape.texcoordVertexAttrState,
            ],
            buffers: [sshape.vertexBufferLayoutState],
        },
        shader: sg.makeShader(shd.defaultShaderDesc(sg.queryBackend)),
        index_type: sg.IndexType.Uint16,
        cull_mode: sg.CullMode.Back,
        depth: {
            write_enabled: true,
            compare: sg.CompareFunc.Less_equal
        },
    };
    // dfmt on
    state.offScreen.pip = sg.makePipeline(offscreen_pip_desc);
    state.default_.pip = sg.makePipeline(default_pip_desc);

    // dfmt off
    // a sampler object for sampling the render target texture
    auto smp = sg.makeSampler (
        sg.SamplerDesc(
        min_filter: sg.Filter.Linear,
        mag_filter: sg.Filter.Linear,
        wrap_u: sg.Wrap.Repeat,
        wrap_v: sg.Wrap.Repeat)
    );
    // dfmt on
    // resource bindings to render a non-textured cube (into the offscreen render target)
    state.offScreen.bind.vertex_buffers[0] = vbuf;
    state.offScreen.bind.index_buffer = ibuf;

    // resource bindings to render a textured cube, using the offscreen render target as texture
    state.default_.bind.vertex_buffers[0] = vbuf;
    state.default_.bind.index_buffer = ibuf;
    state.default_.bind.images[shd.IMG_TEX] = color_img;
    state.default_.bind.samplers[shd.SMP_SMP] = smp;
}

void frame()
{
    immutable float t = cast(float)(app.frameDuration() * 60.0);
    immutable float aspect = app.widthf / app.heightf;

    state.rx += 1.0 * t;
    state.ry += 2.0 * t;

    shd.VsParams offscreenVsParams = computeMvp(state.rx, state.ry, 1.0, 2.5);
    shd.VsParams defaultVsParams = computeMvp(-state.rx * 0.25, state.ry * 0.25, aspect, 2);

    // dfmt off
    sg.beginPass(sg.Pass(
        action: state.offScreen.passAction,
        attachments: state.offScreen.attachments
    ));
    // dfmt on
    sg.applyPipeline(state.offScreen.pip);
    sg.applyBindings(state.offScreen.bind);
    sg.applyUniforms(shd.UB_VS_PARAMS, sg.Range(&offscreenVsParams, offscreenVsParams.sizeof));
    sg.draw(state.donut.base_element, state.donut.num_elements, 1);
    sg.endPass();

    // dfmt off
    sg.beginPass(sg.Pass(
        action: state.default_.passAction,
        swapchain: sglue.swapchain
    ));
    // dfmt on
    sg.applyPipeline(state.default_.pip);
    sg.applyBindings(state.default_.bind);
    sg.applyUniforms(shd.UB_VS_PARAMS, sg.Range(&defaultVsParams, defaultVsParams.sizeof));
    sg.draw(state.sphere.base_element, state.sphere.num_elements, 1);
    sg.endPass();

    sg.commit();
}

void cleanup()
{
    sg.shutdown();
}

shd.VsParams computeMvp(float rx, float ry, float aspect, float eye_dist)
{
    immutable proj = Mat4.perspective(60.0, aspect, 0.01, 10.0);
    immutable view = Mat4.lookAt(Vec3(0.0, 0.0, eye_dist), Vec3.zero, Vec3.up);
    immutable rxm = Mat4.rotate(rx, Vec3(1.0, 0.0, 0.0));
    immutable rym = Mat4.rotate(ry, Vec3(0.0, 1.0, 0.0));
    immutable model = Mat4.mul(rxm, rym);
    immutable view_proj = Mat4.mul(proj, view);
    return shd.VsParams(mvp : Mat4.mul(view_proj, model));
}

void main()
{
    // dfmt off
    app.Desc runner = {
        window_title: "offscreen.d",
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
    // dfmt on
}

version (WebAssembly)
{
    debug
    {
        import emscripten.assertd;
    }
}
