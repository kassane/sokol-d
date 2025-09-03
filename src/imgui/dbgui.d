module imgui.dbgui;

debug
{
    import cimgui = imgui.cimgui;
    import simgui = sokol.imgui;
    import sgimgui = sokol.gfximgui;
    import log = sokol.log;
    import sapp = sokol.app;

extern (C):

    static sgimgui.Sgimgui sgctx;

    void __dbgui_setup(int sample_count) @safe @nogc nothrow
    {
        // setup debug inspection
        sgimgui.Desc desc = {};
        sgimgui.init(sgctx, desc);

        //dfmt off
        // setup the sokol-imgui utility
        simgui.Desc simgui_desc = {
            sample_count: sample_count,
            logger: {func: &log.slog_func},
        };
        //dfmt on
        simgui.setup(simgui_desc);
    }

    void __dbgui_shutdown() @safe @nogc nothrow
    {
        sgimgui.discard(sgctx);
        simgui.shutdown;
    }

    void __dbgui_draw() @safe @nogc nothrow
    {
        //dfmt off
        simgui.FrameDesc sframe = {
            width: sapp.width,
            height: sapp.height,
            delta_time: sapp.frameDuration,
            dpi_scale: sapp.dpiScale,
        };
        //dfmt on

        simgui.newFrame(sframe);
        if (cimgui.BeginMainMenuBar)
        {
            sgimgui.drawMenu(sgctx, "sokol-gfx");
            cimgui.EndMainMenuBar;
        }
        sgimgui.draw(sgctx);
        simgui.render;
    }

    void __dbgui_event(const(sapp.Event)* ev) @trusted @nogc nothrow
    {
        simgui.simgui_handle_event(ev);
    }
}
