//------------------------------------------------------------------------------
//  clear.d
//
//  Just clear the framebuffer with an animated color.
//------------------------------------------------------------------------------
module examples.clear;

private:

import sg = sokol.gfx;
import sglue = sokol.glue;
import sapp = sokol.app;
import log = sokol.log;

extern (C):
@safe:

sg.PassAction pass_action = {
    colors: [
        {load_action: sg.LoadAction.Clear, clear_value: {r: 1, g: 1, b: 0, a: 1}}
    ]
};

static void init()
{
    sg.Desc gfx = {
        environment: sglue.environment(),
        logger: {func: &log.slog_func},
    };
    sg.setup(gfx);

    version (WebAssembly)
    { /* none */ }
    else version (D_BetterC)
    { /* none */ }
    else
    {
        import std.stdio : writeln;

        debug writeln("Backend: ", sg.queryBackend());
    }
}

static void frame()
{
    const g = pass_action.colors[0].clear_value.g + 0.01;
    pass_action.colors[0].clear_value.g = g > 1.0 ? 0.0 : g;
    sg.Pass pass = {action: pass_action, swapchain: sglue.swapchain};
    sg.beginPass(pass);
    sg.endPass();
    sg.commit();
}

static void cleanup()
{
    sg.shutdown();
}

void main()
{
    sapp.Desc runner = {
        window_title: "clear.d",
        init_cb: &init,
        frame_cb: &frame,
        cleanup_cb: &cleanup,
        width: 640,
        height: 480,
        win32_console_attach: true,
        icon: {sokol_default: true},
        logger: {func: &log.func}
    };
    sapp.run(runner);
}
