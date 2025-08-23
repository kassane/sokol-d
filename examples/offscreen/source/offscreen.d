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
    struct Offscreen
    {
        sg.Pipeline pip;
        sg.Bindings bind;
        sg.Pass pass;
    }

    Offscreen offscreen;

    struct Display
    {
        sg.Pipeline pip;
        sg.Bindings bind;
        sg.PassAction pass_action;
    }

    Display display;

    sshape.ElementRange sphere, donut;
}

static State state;

void init()
{
    sg.Desc gfxd = {environment: sglue.environment,
    logger: {func: &log.func}};
    sg.setup(gfxd);

    // default pass action: clear to blue-ish
    state.display.pass_action.colors[0].load_action = sg.LoadAction.Clear;
    state.display.pass_action.colors[0].clear_value.r = 0.25;
    state.display.pass_action.colors[0].clear_value.g = 0.45;
    state.display.pass_action.colors[0].clear_value.b = 0.65;
    state.display.pass_action.colors[0].clear_value.a = 1.0;
    // offscreen pass action: clear to black
    state.offscreen.pass.action.colors[0].load_action = sg.LoadAction.Clear;
    state.offscreen.pass.action.colors[0].clear_value.r = 0.25;
    state.offscreen.pass.action.colors[0].clear_value.g = 0.25;
    state.offscreen.pass.action.colors[0].clear_value.b = 0.25;
    state.offscreen.pass.action.colors[0].clear_value.a = 1.0;

    // setup the color- and depth-stencil-attachment images and views
    int offscreen_width = 256;
    int offscreen_height = 256;
    int offscreen_sample_count = 1;
    sg.ImageDesc color_img_desc = {
        usage: { color_attachment: true },
        width: offscreen_width,
        height: offscreen_height,
        pixel_format: sg.PixelFormat.Rgba8,
        sample_count: offscreen_sample_count,
    };
    const color_img = sg.makeImage(color_img_desc);
    sg.ImageDesc depth_img_desc = {
        usage: { depth_stencil_attachment: true },
        width: offscreen_width,
        height: offscreen_height,
        pixel_format: sg.PixelFormat.Depth,
        sample_count: offscreen_sample_count,
    };
    const depth_img = sg.makeImage(depth_img_desc);

    // the offscreen render pass needs a color- and depth-stencil-attachment view
    sg.ViewDesc color_attview_desc = {
        color_attachment: { image: color_img },
    };
    state.offscreen.pass.attachments.colors[0] = sg.makeView(color_attview_desc);
    sg.ViewDesc depth_attview_desc = {
        depth_stencil_attachment: { image: depth_img },
    };
    state.offscreen.pass.attachments.depth_stencil = sg.makeView(depth_attview_desc);

    // the display render pass needs a texture view on the color image
    sg.ViewDesc color_texview_desc = {
        texture: { image: color_img },
    };
    state.display.bind.views[shd.VIEW_TEX] = sg.makeView(color_texview_desc);

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
    state.offscreen.bind.vertex_buffers[0] = vbuf;
    state.display.bind.vertex_buffers[0] = vbuf;
    const ibuf = sg.makeBuffer(sshape.indexBufferDesc(buf));
    state.offscreen.bind.index_buffer = ibuf;
    state.display.bind.index_buffer = ibuf;

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
    state.offscreen.pip = sg.makePipeline(offscreen_pip_desc);
    state.display.pip = sg.makePipeline(default_pip_desc);

    // dfmt off
    // a sampler object for sampling the render target texture
    state.display.bind.samplers[shd.SMP_SMP] = sg.makeSampler (
        sg.SamplerDesc(
        min_filter: sg.Filter.Linear,
        mag_filter: sg.Filter.Linear,
        wrap_u: sg.Wrap.Repeat,
        wrap_v: sg.Wrap.Repeat)
    );
    // dfmt on
}

void frame()
{
    immutable float t = cast(float)(app.frameDuration() * 60.0);
    immutable float aspect = app.widthf / app.heightf;

    state.rx += 1.0 * t;
    state.ry += 2.0 * t;

    shd.VsParams offscreenVsParams = computeMvp(state.rx, state.ry, 1.0, 2.5);
    shd.VsParams defaultVsParams = computeMvp(-state.rx * 0.25, state.ry * 0.25, aspect, 2);

    sg.beginPass(state.offscreen.pass);
    sg.applyPipeline(state.offscreen.pip);
    sg.applyBindings(state.offscreen.bind);
    sg.applyUniforms(shd.UB_VS_PARAMS, sg.Range(&offscreenVsParams, offscreenVsParams.sizeof));
    sg.draw(state.donut.base_element, state.donut.num_elements, 1);
    sg.endPass();

    // dfmt off
    sg.beginPass(sg.Pass(
        action: state.display.pass_action,
        swapchain: sglue.swapchain
    ));
    // dfmt on
    sg.applyPipeline(state.display.pip);
    sg.applyBindings(state.display.bind);
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
