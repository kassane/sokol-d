//------------------------------------------------------------------------------
//  mrt.d
//
//  Rendering with multiple-rendertargets, and reallocate render targets
//  on window resize events.
//
//  NOTE: the rotation direction will appear different on the different
//  backend 3D APIs. This is because of the different image origin conventions
//  in GL vs D3D vs Metal. We don't care about those differences in this sample
//  (using the sokol shader compiler allows to easily 'normalize' those differences.
//------------------------------------------------------------------------------
module examples.mrt;

private:

import sg = sokol.gfx;
import app = sokol.app;
import log = sokol.log;
import handmade.math : Mat4, Vec3, Vec2, sin, cos;
import sglue = sokol.glue;
import shd = examples.shaders.mrt;

extern (C):
@safe:

enum OFFSCREEN_SAMPLE_COUNT = 1;

struct Offscreen
{
    sg.AttachmentsDesc atts_desc;
    sg.Attachments atts;
    sg.Pipeline pip;
    sg.Bindings bind;
    sg.PassAction pass_action = {
        colors: [
            {
                load_action: sg.LoadAction.Clear, clear_value: {
                    r: 0.25, g: 0, b: 0, a: 1
                }
            },
            {
                load_action: sg.LoadAction.Clear, clear_value: {
                    r: 0, g: 0.25, b: 0, a: 1
                }
            },
            {
                load_action: sg.LoadAction.Clear, clear_value: {
                    r: 0, g: 0, b: 0.25, a: 1
                }
            },
        ]
    };
}

struct Fsq
{
    sg.Pipeline pip;
    sg.Bindings bind;
}

struct Dbg
{
    sg.Pipeline pip;
    sg.Bindings bind;
}

struct Dflt
{
    sg.PassAction pass_action = {
        colors: [{load_action: sg.LoadAction.Dontcare}],
        depth: {load_action: sg.LoadAction.Dontcare},
        stencil: {load_action: sg.LoadAction.Dontcare},
    };
}

struct State
{
    Offscreen offscreen;
    Fsq fsq;
    Dbg dbg;
    Dflt dflt;
    float rx = 0;
    float ry = 0;
    Mat4 view;
}

static State state;

void init()
{
    sg.Desc gfxd = {
        environment: sglue.environment,
        logger: {func: &log.slog_func}
    };
    sg.setup(gfxd);

    // setup the offscreen render pass and render target images,
    // this will also be called when the window resizes
    createOffscreenAttachments(app.width(), app.height());

    // create vertex buffer for a cube
    float[96] vertices = [
        // positions        brightness
        -1.0, -1.0, -1.0, 1.0,
        1.0, -1.0, -1.0, 1.0,
        1.0, 1.0, -1.0, 1.0,
        -1.0, 1.0, -1.0, 1.0,

        -1.0, -1.0, 1.0, 0.8,
        1.0, -1.0, 1.0, 0.8,
        1.0, 1.0, 1.0, 0.8,
        -1.0, 1.0, 1.0, 0.8,

        -1.0, -1.0, -1.0, 0.6,
        -1.0, 1.0, -1.0, 0.6,
        -1.0, 1.0, 1.0, 0.6,
        -1.0, -1.0, 1.0, 0.6,

        1.0, -1.0, -1.0, 0.0,
        1.0, 1.0, -1.0, 0.0,
        1.0, 1.0, 1.0, 0.0,
        1.0, -1.0, 1.0, 0.0,

        -1.0, -1.0, -1.0, 0.5,
        -1.0, -1.0, 1.0, 0.5,
        1.0, -1.0, 1.0, 0.5,
        1.0, -1.0, -1.0, 0.5,

        -1.0, 1.0, -1.0, 0.7,
        -1.0, 1.0, 1.0, 0.7,
        1.0, 1.0, 1.0, 0.7,
        1.0, 1.0, -1.0, 0.7,
    ];
    sg.BufferDesc cube_vbuf_desc = {
        data: {ptr: vertices.ptr,
        size: vertices.sizeof,},
    };
    const cube_vbuf = sg.makeBuffer(cube_vbuf_desc);

    // index buffer for a cube
    ushort[36] indices = [
        0, 1, 2, 0, 2, 3,
        6, 5, 4, 7, 6, 4,
        8, 9, 10, 8, 10, 11,
        14, 13, 12, 15, 14, 12,
        16, 17, 18, 16, 18, 19,
        22, 21, 20, 23, 22, 20,
    ];
    sg.BufferDesc cube_ibuf_desc = {
        usage: { index_buffer: true },
        data: {ptr: indices.ptr, size: indices.sizeof},
    };
    const cube_ibuf = sg.makeBuffer(cube_ibuf_desc);

    // resource bindings for offscreen rendering
    state.offscreen.bind.vertex_buffers[0] = cube_vbuf;
    state.offscreen.bind.index_buffer = cube_ibuf;

    // shader and pipeline state object for rendering cube into MRT render targets
    sg.PipelineDesc offscreen_pip_desc = {
        layout: {
            attrs: [
                shd.ATTR_OFFSCREEN_POS: {format: sg.VertexFormat.Float3},
                shd.ATTR_OFFSCREEN_BRIGHT0: {format: sg.VertexFormat.Float},
            ]
        },
        shader: sg.makeShader(shd.offscreenShaderDesc(sg.queryBackend())),
        index_type: sg.IndexType.Uint16,
        cull_mode: sg.CullMode.Back,
        sample_count: OFFSCREEN_SAMPLE_COUNT,
        depth: {
            pixel_format: sg.PixelFormat.Depth,
            compare: sg.CompareFunc.Less_equal,
            write_enabled: true,
        },
        color_count: 3,
    };
    state.offscreen.pip = sg.makePipeline(offscreen_pip_desc);

    // a vertex buffer to render a fullscreen quad
    float[8] quad_vertices = [0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 1.0, 1.0];
    sg.BufferDesc quad_vbuf_desc = {
        data: {ptr: quad_vertices.ptr, size: quad_vertices.sizeof},
    };
    const quad_vbuf = sg.makeBuffer(quad_vbuf_desc);

    // shader and pipeline object to render a fullscreen quad which composes
    // the 3 offscreen render targets into the default framebuffer
    sg.PipelineDesc fsq_pip_desc = {
        layout: {attrs: [
            shd.ATTR_FSQ_POS: {format: sg.VertexFormat.Float2},
        ]},
        shader: sg.makeShader(shd.fsqShaderDesc(sg.queryBackend())),
        primitive_type: sg.PrimitiveType.Triangle_strip,
    };
    state.fsq.pip = sg.makePipeline(fsq_pip_desc);

    // a sampler to sample the offscreen render targets as texture
    sg.SamplerDesc smp_desc = {
        min_filter: sg.Filter.Linear,
        mag_filter: sg.Filter.Linear,
        wrap_u: sg.Wrap.Clamp_to_edge,
        wrap_v: sg.Wrap.Clamp_to_edge,
    };
    const smp = sg.makeSampler(smp_desc);

    // resource bindings to render the fullscreen quad (composed from the
    // offscreen render target textures
    state.fsq.bind.vertex_buffers[0] = quad_vbuf;
    foreach (i; [0, 1, 2])
    {
        state.fsq.bind.images[i] = state.offscreen.atts_desc.colors[i].image;
    }
    state.fsq.bind.samplers[shd.SMP_SMP] = smp;

    // shader, pipeline and resource bindings to render debug visualization quads
    sg.PipelineDesc dbg_pip_desc = {
        layout: {attrs: [
            shd.ATTR_DBG_POS: {format: sg.VertexFormat.Float2},
        ]},
        shader: sg.makeShader(shd.dbgShaderDesc(sg.queryBackend())),
        primitive_type: sg.PrimitiveType.Triangle_strip,
    };
    state.dbg.pip = sg.makePipeline(dbg_pip_desc);

    // resource bindings to render the debug visualization
    // (the required images will be filled in during rendering)
    state.dbg.bind.vertex_buffers[0] = quad_vbuf;
    state.dbg.bind.samplers[shd.SMP_SMP] = smp;
}

void frame() @trusted
{
    immutable(float) dt = (app.frameDuration() * 60.0);
    state.rx += 1.0 * dt;
    state.ry += 2.0 * dt;

    // compute shader uniform data
    shd.OffscreenParams offscreen_params = {
        mvp: computeMvp(state.rx, state.ry),
    };
    shd.FsqParams fsq_params = {
        offset: Vec2(sin(state.rx * 0.01) * 0.1, cos(state.ry * 0.01) * 0.1),
    };

    // render cube into MRT offscreen render targets
    sg.Pass pass_atts = {
        action: state.offscreen.pass_action, attachments: state.offscreen.atts
    };
    sg.beginPass(pass_atts);
    sg.applyPipeline(state.offscreen.pip);
    sg.applyBindings(state.offscreen.bind);
    sg.Range offs_rg = {ptr: &offscreen_params, offscreen_params.sizeof};
    sg.applyUniforms(shd.UB_OFFSCREEN_PARAMS, offs_rg);
    sg.draw(0, 36, 1);
    sg.endPass();

    // render fullscreen quad with the composed offscreen-render images,
    // 3 a small debug view quads at the bottom of the screen
    sg.Pass pass_swap = {
        action: state.dflt.pass_action, swapchain: sglue.swapchain
    };
    sg.beginPass(pass_swap);
    sg.applyPipeline(state.fsq.pip);
    sg.applyBindings(state.fsq.bind);
    sg.Range fsq_rg = {ptr: &fsq_params, size: fsq_params.sizeof};
    sg.applyUniforms(shd.UB_FSQ_PARAMS, fsq_rg);
    sg.draw(0, 4, 1);
    sg.applyPipeline(state.dbg.pip);
    foreach (i; [0, 1, 2])
    {
        sg.applyViewport(i * 100, 0, 100, 100, false);
        state.dbg.bind.images[shd.IMG_TEX] = state.offscreen.atts_desc.colors[i].image;
        sg.applyBindings(state.dbg.bind);
        sg.draw(0, 4, 1);
    }
    sg.endPass();
    sg.commit();
}

void event(const app.Event* ev)
{
    if (ev.type == app.EventType.Resized)
    {
        createOffscreenAttachments(ev.framebuffer_width, ev.framebuffer_height);
    }
}

void cleanup()
{
    sg.shutdown();
}

void main()
{
    app.Desc runner = {
        window_title: "mrt.d",
        init_cb: &init,
        frame_cb: &frame,
        cleanup_cb: &cleanup,
        event_cb: &event,
        width: 800,
        height: 600,
        sample_count: 1,
        icon: {sokol_default: true},
        logger: {func: &log.func}
    };
    app.run(runner);
}

void createOffscreenAttachments(int width, int height)
{
    // destroy previous resources (can be called with invalid ids)
    sg.destroyAttachments(state.offscreen.atts);
    foreach (att; state.offscreen.atts_desc.colors)
    {
        sg.destroyImage(att.image);
    }
    sg.destroyImage(state.offscreen.atts_desc.depth_stencil.image);

    // create offscreen render target images and pass
    sg.ImageDesc color_img_desc = {
        usage: { render_attachment: true },
        width: width,
        height: height,
        sample_count: OFFSCREEN_SAMPLE_COUNT,
    };
    sg.ImageDesc depth_img_desc = color_img_desc;
    depth_img_desc.pixel_format = sg.PixelFormat.Depth;

    foreach (i; [0, 1, 2])
    {
        state.offscreen.atts_desc.colors[i].image = sg.makeImage(color_img_desc);
    }
    state.offscreen.atts_desc.depth_stencil.image = sg.makeImage(depth_img_desc);
    state.offscreen.atts = sg.makeAttachments(state.offscreen.atts_desc);

    // update the fullscreen-quad texture bindings
    foreach (i; [0, 1, 2])
    {
        state.fsq.bind.images[i] = state.offscreen.atts_desc.colors[i].image;
    }
}

Mat4 computeMvp(float rx, float ry)
{
    immutable proj = Mat4.perspective(60.0, app.widthf() / app.heightf(), 0.01, 10.0);
    immutable view = Mat4.lookAt(Vec3(0.0, 1.5, 6.0), Vec3.zero, Vec3.up);
    immutable rxm = Mat4.rotate(rx, Vec3(1.0, 0.0, 0.0));
    immutable rym = Mat4.rotate(ry, Vec3(0.0, 1.0, 0.0));
    immutable model = Mat4.mul(rxm, rym);
    immutable view_proj = Mat4.mul(proj, view);

    return Mat4.mul(view_proj, model);
}
