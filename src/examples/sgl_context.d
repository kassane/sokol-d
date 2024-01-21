//------------------------------------------------------------------------------
//  sgl-context.d
//
//  Demonstrates how to render into different render passes with sokol-gl.
//  using contexts.
//------------------------------------------------------------------------------
module examples.sgl_context;

import sg = sokol.gfx;
import sgapp = sokol.glue;
import sapp = sokol.app;
import slog = sokol.log;
import sgl = sokol.gl;
import handmade.math : sin, cos;

extern (C):
@safe:

struct Offscreen
{
    sg.PassAction pass_action;
    sg.Pass pass;
    sg.Image img;
    sgl.Context sgl_ctx;
}

struct Display
{
    sg.PassAction pass_action;
    sg.Sampler smp;
    sgl.Pipeline sgl_pip;
}

struct State
{
    static Display display;
    static Offscreen offscreen;
}

enum offscreen_pixel_format = sg.PixelFormat.Rgba8;
enum offscreen_sample_count = 1;
enum offscreen_width = 32;
enum offscreen_height = 32;


void init()
{
    sg.Desc gfxd = {
        context: sgapp.context(),
        logger: {func: &slog.func}
    };
    sg.setup(gfxd);

    // setup sokol-gl with the default context compatible with the default
    // render pass (which means just keep pixelformats and sample count at defaults)
    //
    // reduce the vertex- and command-count though, otherwise we just waste memory
    sgl.Desc gld = {
        max_vertices: 64,
        max_commands: 16,
        logger: {func: &slog.func}
    };
    sgl.setup(gld);

    State state;
    // initialize a pass action struct for the default pass to clear to a light-blue color
    state.display.pass_action.colors[0].load_action = sg.LoadAction.Clear;
    state.display.pass_action.colors[0].clear_value.r = 0.5;
    state.display.pass_action.colors[0].clear_value.g = 0.7;
    state.display.pass_action.colors[0].clear_value.b = 1.0;
    state.display.pass_action.colors[0].clear_value.a = 1.0;

    // create a sokol-gl pipeline object for 3D rendering into the default pass
    sg.PipelineDesc pld = {
        cull_mode: sg.CullMode.Back,
        depth: {write_enabled: true, compare: sg.CompareFunc.Less_equal}
    };
    state.display.sgl_pip = sgl.contextMakePipeline(sgl.defaultContext, pld);

    // create a sokol-gl context compatible with the offscreen render pass
    // (specific color pixel format, no depth-stencil-surface, no MSAA)
    sgl.ContextDesc ctd = {
        max_vertices: 8,
        max_commands: 4,
        color_format: offscreen_pixel_format,
        depth_format: sg.PixelFormat.None,
        sample_count: offscreen_sample_count
    };
    state.offscreen.sgl_ctx = sgl.makeContext(ctd);

    // create an offscreen render target texture, pass and pass-action
    sg.ImageDesc imgd = {
        render_target: true,
        width: offscreen_width,
        height: offscreen_height,
        pixel_format: offscreen_pixel_format,
        sample_count: offscreen_sample_count
    };
    state.offscreen.img = sg.makeImage(imgd);

    sg.PassDesc pass_desc;
    pass_desc.color_attachments[0].image = state.offscreen.img;
    state.offscreen.pass = sg.makePass(pass_desc);

    state.offscreen.pass_action.colors[0].load_action = sg.LoadAction.Clear;
    state.offscreen.pass_action.colors[0].clear_value.r = 0.0;
    state.offscreen.pass_action.colors[0].clear_value.g = 0.0;
    state.offscreen.pass_action.colors[0].clear_value.b = 0.0;
    state.offscreen.pass_action.colors[0].clear_value.a = 1.0;

    // sampler for sampling the offscreen render target
    sg.SamplerDesc smd = {
        wrap_u: sg.Wrap.Clamp_to_edge,
        wrap_v: sg.Wrap.Clamp_to_edge,
        min_filter: sg.Filter.Nearest,
        mag_filter: sg.Filter.Nearest
    };
    state.display.smp = sg.makeSampler(smd);
}

void frame()
{
    immutable float a = sgl.asRadians(sapp.frameCount());
    State state;

    // draw a rotating quad into the offscreen render target texture
    sgl.setContext(state.offscreen.sgl_ctx);
    sgl.defaults();
    sgl.matrixModeModelview();
    sgl.rotate(a, 0.0, 0.0, 1.0);
    draw_quad();

    // draw a rotating 3D cube, using the offscreen render target as texture
    sgl.setContext(sgl.defaultContext());
    sgl.defaults();
    sgl.enableTexture();
    sgl.texture(state.offscreen.img, state.display.smp);
    sgl.loadPipeline(state.display.sgl_pip);
    sgl.matrixModeProjection();
    sgl.perspective(sgl.asRadians(45.0), sapp.widthf() / sapp.heightf(), 0.1, 100.0);
    immutable (float)[3] eye = [sin(a) * 6.0, sin(a) * 3.0, cos(a) * 6.0];
    sgl.matrixModeModelview();
    sgl.lookat(eye[0], eye[1], eye[2], 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
    draw_cube();

    // do the actual offscreen and display rendering in sokol-gfx passes
    sg.beginPass(state.offscreen.pass, state.offscreen.pass_action);
    sgl.contextDraw(state.offscreen.sgl_ctx);
    sg.endPass();
    sg.beginDefaultPass(state.display.pass_action, sapp.width(), sapp.height());
    sgl.contextDraw(sgl.defaultContext());
    sg.endPass();
    sg.commit();
}

void cleanup()
{
    sgl.shutdown();
    sg.shutdown();
}

void main()
{
    sapp.Desc runner = {
        window_title: "sgl-context.d",
        init_cb: &init,
        frame_cb: &frame,
        cleanup_cb: &cleanup,
        width: 800,
        height: 600,
        sample_count: 4,
        logger: {func: &slog.func},
        icon: {sokol_default: true}
    };
    sapp.run(runner);
}

void draw_quad()
{
    sgl.beginQuads();
    sgl.v2fC3b(0.0, -1.0, 255, 0, 0);
    sgl.v2fC3b(1.0, 0.0, 0, 0, 255);
    sgl.v2fC3b(0.0, 1.0, 0, 255, 255);
    sgl.v2fC3b(-1.0, 0.0, 0, 255, 0);
    sgl.end();
}

void draw_cube()
{
    sgl.beginQuads();
    sgl.v3fT2f(-1.0, 1.0, -1.0, 0.0, 1.0);
    sgl.v3fT2f(1.0, 1.0, -1.0, 1.0, 1.0);
    sgl.v3fT2f(1.0, -1.0, -1.0, 1.0, 0.0);
    sgl.v3fT2f(-1.0, -1.0, -1.0, 0.0, 0.0);
    sgl.v3fT2f(-1.0, -1.0, 1.0, 0.0, 1.0);
    sgl.v3fT2f(1.0, -1.0, 1.0, 1.0, 1.0);
    sgl.v3fT2f(1.0, 1.0, 1.0, 1.0, 0.0);
    sgl.v3fT2f(-1.0, 1.0, 1.0, 0.0, 0.0);
    sgl.v3fT2f(-1.0, -1.0, 1.0, 0.0, 1.0);
    sgl.v3fT2f(-1.0, 1.0, 1.0, 1.0, 1.0);
    sgl.v3fT2f(-1.0, 1.0, -1.0, 1.0, 0.0);
    sgl.v3fT2f(-1.0, -1.0, -1.0, 0.0, 0.0);
    sgl.v3fT2f(1.0, -1.0, 1.0, 0.0, 1.0);
    sgl.v3fT2f(1.0, -1.0, -1.0, 1.0, 1.0);
    sgl.v3fT2f(1.0, 1.0, -1.0, 1.0, 0.0);
    sgl.v3fT2f(1.0, 1.0, 1.0, 0.0, 0.0);
    sgl.v3fT2f(1.0, -1.0, -1.0, 0.0, 1.0);
    sgl.v3fT2f(1.0, -1.0, 1.0, 1.0, 1.0);
    sgl.v3fT2f(-1.0, -1.0, 1.0, 1.0, 0.0);
    sgl.v3fT2f(-1.0, -1.0, -1.0, 0.0, 0.0);
    sgl.v3fT2f(-1.0, 1.0, -1.0, 0.0, 1.0);
    sgl.v3fT2f(-1.0, 1.0, 1.0, 1.0, 1.0);
    sgl.v3fT2f(1.0, 1.0, 1.0, 1.0, 0.0);
    sgl.v3fT2f(1.0, 1.0, -1.0, 0.0, 0.0);
    sgl.end();
}
