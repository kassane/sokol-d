module examples.user_data;

private:

import sg = sokol.gfx;
import sapp = sokol.app;
import log = sokol.log;
import sglue = sokol.glue;

extern (C):

struct ExampleUserData
{
    ubyte data;
    int[ubyte] map; // need druntime
}

void init() @safe
{
    sg.Desc gfx = {
        environment: sglue.environment,
        logger: {func: &log.slog_func}
    };
    sg.setup(gfx);
}

void frame_userdata(scope void* userdata) @trusted
{
    auto state = cast(ExampleUserData*) userdata;

    state.data++;
    version (WebAssembly)
    {
        // TODO support
    }
    else
    {
        if (state.data % 13 == 0)
        {
            state.map[state.data] = state.data * 13 / 3;
        }
        if (state.data % 12 == 0 && state.data % 15 == 0)
        {
            state.map.clear();
        }
        debug
        {
            import std.stdio : writeln;

            try
            {
                writeln(*state);
            }
            catch (Exception)
            {
            }
        }
    }

    sg.Pass pass = {swapchain: sglue.swapchain};
    sg.beginPass(pass);
    sg.endPass();
    sg.commit();
}

void cleanup() @safe
{
    sg.shutdown();
}

void main()
{
    auto userData = ExampleUserData(0, null);
    sapp.Desc runner = {
        window_title: "user-data.d",
        init_cb: &init,
        frame_userdata_cb: &frame_userdata,
        cleanup_cb: &cleanup,
        user_data: &userData,
        width: 640,
        height: 480,
        sample_count: 4,
        win32_console_attach: true,
        icon: {sokol_default: true},
        logger: {func: &log.func}
    };
    sapp.run(runner);
}

version (WebAssembly)
{
    debug
    {
        import emscripten.assertd;
    }
}
