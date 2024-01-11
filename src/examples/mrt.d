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

import sg = sokol.gfx;
import app = sokol.app;
import log = sokol.log;
import handmade.math : Mat4, Vec3, Vec2;
import sgapp = sokol.glue;
import shd = shaders.mrt;

extern (C):
@safe:

enum offscreen_sample_count = 1;

struct Offscreen {
    sg.PassAction pass_action;
    sg.PassDesc pass_desc;
    sg.Pass pass;
    sg.Pipeline pip;
    sg.Bindings bind;
}

struct Fsq {
    sg.Pipeline pip;
    sg.Bindings bind;
}

struct Dbg {
    sg.Pipeline pip;
    sg.Bindings bind;
}

struct Dflt {
    sg.PassAction pass_action;
}

struct State {
    Offscreen offscreen;
    Fsq fsq;
    Dbg dbg;
    Dflt dflt;
    float rx;
    float ry;
    Mat4 view;
}

static State state;

void init()
{
    sg.Desc gfx = {
        context: sgapp.context(),
        logger: {func: &log.slog_func}
    };
    sg.setup(gfx);
}

void frame()
{
    //
}

void event(const app.Event* ev)
{
    if(ev.type == app.EventType.Resized){
        createOffscreenPass(ev.framebuffer_width, ev.framebuffer_height);
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

void createOffscreenPass(int width, int height)
{
    // destroy previous resources (can be called with invalid ids)
    sg.destroyPass(state.offscreen.pass);
    foreach (att; state.offscreen.pass_desc.color_attachments) {
        sg.destroyImage(att.image);
    }
    sg.destroyImage(state.offscreen.pass_desc.depth_stencil_attachment.image);

    // create offscreen render target images and pass
    sg.ImageDesc color_img_desc = {
        render_target: true,
        width: width,
        height: height,
        sample_count: offscreen_sample_count,
    };
    sg.ImageDesc depth_img_desc = color_img_desc;
    depth_img_desc.pixel_format = sg.PixelFormat.Depth;

    foreach (i; [0, 1, 2]) {
        state.offscreen.pass_desc.color_attachments[i].image = sg.makeImage(color_img_desc);
    }
    state.offscreen.pass_desc.depth_stencil_attachment.image = sg.makeImage(depth_img_desc);
    state.offscreen.pass = sg.makePass(state.offscreen.pass_desc);

    // update the fullscreen-quad texture bindings
    foreach (i; [0, 1, 2]) {
        state.fsq.bind.fs.images[i] = state.offscreen.pass_desc.color_attachments[i].image;
    }

}

Mat4 compute_mvp(float rx, float ry) 
{
    immutable proj = Mat4.perspective(60.0, app.widthf() / app.heightf(), 0.01, 10.0);
    immutable view = Mat4.lookAt(Vec3(0.0, 1.5, 6.0), Vec3.zero, Vec3.up);
    immutable rxm = Mat4.rotate(rx, Vec3(1.0, 0.0, 0.0));
    immutable rym = Mat4.rotate(ry, Vec3(0.0, 1.0, 0.0));
    immutable model = Mat4.mul(rxm, rym);
    immutable view_proj = Mat4.mul(proj, view);

    return Mat4.mul(view_proj, model);
}