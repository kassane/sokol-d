//------------------------------------------------------------------------------
//  clear.d
//
//  Just clear the framebuffer with an animated color.
//------------------------------------------------------------------------------
module examples.clear;

import sg = sokol.gfx;
import sglue = sokol.glue;
import sapp = sokol.app;
import log = sokol.log;

extern (C):

__gshared sg.PassAction pass_action;

void init()
{
    sg.Desc gfx = {
        environment: sglue.environment,
        logger: {func: &log.slog_func}
    };
    sg.setup(gfx);

    pass_action.colors[0].load_action = sg.LoadAction.Clear;
    pass_action.colors[0].clear_value.r = 1;
    pass_action.colors[0].clear_value.g = 1;
    pass_action.colors[0].clear_value.b = 0;
    pass_action.colors[0].clear_value.a = 1;

    debug
    {
        import std.stdio : writeln;

        try
        {
            writeln("Backend: ", sg.queryBackend());
        }
        catch (Exception)
        {
        }
    }
}

void frame()
{
    const g = pass_action.colors[0].clear_value.g + 0.01;
    pass_action.colors[0].clear_value.g = g > 1.0 ? 0.0 : g;
    sg.Pass pass = {action: pass_action, swapchain: sglue.swapchain};
    sg.beginPass(pass);
    sg.endPass();
    sg.commit();
}

void cleanup()
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
