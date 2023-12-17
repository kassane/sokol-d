//------------------------------------------------------------------------------
//  clear.d
//
//  Just clear the framebuffer with an animated color.
//------------------------------------------------------------------------------
module examples.clear;

import std.stdio;
import sg = sokol.gfx;
import sgapp = sokol.glue;
import sapp = sokol.app;
import log = sokol.log;

static sg.PassAction pass_action;

void init()
{
    sg.Desc cd;
    cd.context = sgapp.context();
    cd.logger.func = &log.slog_func;
    sg.setup(cd);

    pass_action.colors[0].load_action = sg.LoadAction.CLEAR;
    pass_action.colors[0].clear_value.r = 1;
    pass_action.colors[0].clear_value.g = 1;
    pass_action.colors[0].clear_value.b = 0;
    pass_action.colors[0].clear_value.a = 1;

    writeln("Backend: ", sg.queryBackend());
}

void frame()
{
    auto g = pass_action.colors[0].clear_value.g + 0.01;
    pass_action.colors[0].clear_value.g = g > 1.0 ? 0.0 : g;
    sg.beginDefaultPass(pass_action, sapp.width(), sapp.height());
    sg.commit();
    sg.endPass();
}

void cleanup()
{
    sg.shutdown();
}

void main()
{
    sapp.IconDesc icon = {sokol_default: true};
    sapp.Desc runner = {window_title: "clear.d"};
    runner.init_cb = &init;
    runner.frame_cb = &frame;
    runner.cleanup_cb = &cleanup;
    runner.width = 640;
    runner.height = 480;
    runner.icon = icon;
    runner.win32_console_attach = true;
    runner.logger.func = &log.slog_func;
    sapp.run(runner);
}
