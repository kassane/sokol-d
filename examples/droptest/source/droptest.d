//------------------------------------------------------------------------------
//  droptest.d
//  Test drag'n'drop file loading.
//------------------------------------------------------------------------------

module examples.droptest;

private:

import sg = sokol.gfx;
import sgapp = sokol.glue;
import sapp = sokol.app;
import sfetch = sokol.fetch;
import simgui = sokol.imgui;
import log = sokol.log;
import imgui.cimgui;

enum MAX_FILE_SIZE = 1024 * 1024;

enum LoadState
{
    Unknown = 0,
    Success,
    Failed,
    FileTooBig,
}

struct State
{
    LoadState load_state = LoadState.Unknown;
    uint size = 0;
    ubyte[MAX_FILE_SIZE] buffer = 0;
}

static State state;

extern (C) void init() @safe @nogc nothrow
{
    sg.Desc gfx = {
        environment: sgapp.environment,
        logger: {func: &log.slog_func}
    };
    sg.setup(gfx);
    simgui.Desc imgui_desc = {0};
    simgui.setup(imgui_desc);

    // ifndef emscripten
    // dfmt off
    static if((){version(Emscripten) return false; else return true;}())
    {
        sfetch.Desc fetch_desc = {
            num_channels: 1,
            num_lanes: 1,
            logger: {func: &log.slog_func},
        };
        sfetch.setup(fetch_desc);
    }
    // dfmt on
}

extern (C) void frame() @trusted @nogc nothrow
{
    // ifndef emscripten
    // dfmt off
    static if((){version(Emscripten) return false;else return true;}())
    {
        sfetch.dowork;
    }
    simgui.FrameDesc imgui_desc = {
        width: sapp.width(),
        height: sapp.height(),
        delta_time: sapp.frameDuration(),
        dpi_scale: sapp.dpiScale(),
    };
    // dfmt on
    simgui.newFrame(imgui_desc);

    // /*=== UI CODE STARTS HERE ===*/
    const ImVec2 window_pos = {10, 10};
    const ImVec2 window_size = {600, 500};
    SetNextWindowPos(window_pos, ImGuiCond_.ImGuiCond_Once);
    SetNextWindowSize(window_size, ImGuiCond_.ImGuiCond_Once);
    Begin("Drop a file!".ptr, null, ImGuiWindowFlags_.ImGuiWindowFlags_None);
    if (state.load_state != LoadState.Unknown)
    {
        Text("%s:", sapp.getDroppedFilePath(0));
    }
    switch (state.load_state)
    {
    case LoadState.Failed:
        Text("LOAD FAILED!");
        break;
    case LoadState.FileTooBig:
        Text("FILE TOO BIG!");
        break;
    case LoadState.Success:
        Separator;
        renderFileContent;
        break;
    default:
        break;
    }
    End();
    /*=== UI CODE ENDS HERE ===*/

    sg.Pass pass = {swapchain: sgapp.swapchain};
    sg.beginPass(pass);
    simgui.render;
    sg.endPass;
    sg.commit;
}

extern (C) void event(const(sapp.Event)* ev) @trusted @nogc nothrow
{
    simgui.simgui_handle_event(ev);
    if (ev.type == sapp.EventType.Files_dropped)
    {
        version (Emscripten)
        {
            // on emscripten need to use the sokol-app helper function to load the file data
            sapp.Html5FetchRequest req = {
                dropped_file_index: 0,
                callback: &emsc_load_callback,
                buffer: {ptr: &state.buffer[0], size: state.buffer.sizeof}};
                sapp.html5FetchDroppedFile(req);
            }
        else
            {
                // native platform: use sokol-fetch to load file content
                sfetch.Request req = {
                    path: sapp.getDroppedFilePath(0),
                    callback: &native_load_callback,
                    buffer: {ptr: &state.buffer[0], size: state.buffer.sizeof}
            };
            sfetch.send(req);
        }
    }
}

extern (C) void cleanup() @safe @nogc nothrow
{
    // ifndef emscripten
    // dfmt off
    static if((){version(Emscripten) return false;else return true;}())
    {
        sfetch.shutdown;
    }
    // dfmt on
    simgui.shutdown;
    sg.shutdown;
}

extern (C) void main() @safe @nogc nothrow
{
    // dfmt off
    sapp.Desc runner = {
        window_title: "droptest.d",
        init_cb: &init,
        frame_cb: &frame,
        cleanup_cb: &cleanup,
        event_cb: &event,
        width: 800,
        height: 600,
        enable_dragndrop: true,
        max_dropped_files: 1,
        icon: {sokol_default: true},
        logger: {func: &log.func}
    };
    // dfmt on
    sapp.run(runner);
}

void renderFileContent() @trusted @nogc nothrow
{
    immutable int bytes_per_line = 16; // keep this 2^N
    immutable int num_lines = (state.size + (bytes_per_line - 1)) / bytes_per_line;
    ImVec2 sz = {0, 0};
    BeginChild("##scrolling", sz, false, ImGuiWindowFlags_
            .ImGuiWindowFlags_NoMove | ImGuiWindowFlags_
            .ImGuiWindowFlags_NoNav);
    ImGuiListClipper clipper = {};
    ImGuiListClipper_Begin(&clipper, num_lines, GetTextLineHeight);
    ImGuiListClipper_Step(&clipper);
    for (int line_i = clipper.DisplayStart; line_i < clipper.DisplayEnd; line_i++)
    {
        int start_offset = line_i * bytes_per_line;
        int end_offset = start_offset + bytes_per_line;
        if (end_offset >= state.size)
        {
            end_offset = state.size;
        }
        Text("%04X: ", start_offset);
        for (int i = start_offset; i < end_offset; i++)
        {
            SameLine;
            Text("%02X ", state.buffer[i]);
        }
        SameLineEx((6 * 7.0f) + (bytes_per_line * 3 * 7.0f) + (2 * 7.0f), 0.0f);
        for (int i = start_offset; i < end_offset; i++)
        {
            if (i != start_offset)
            {
                SameLine;
            }
            ubyte c = state.buffer[i];
            if ((c < 32) || (c > 127))
            {
                c = '.';
            }
            Text("%c", c);
        }
    }
    Text("EOF\n");
    ImGuiListClipper_End(&clipper);
    EndChild();
}

version (Emscripten)
{
    // the async-loading callback for sapp_html5_fetch_dropped_file
    extern (C) void emsc_load_callback(const(sapp.Html5FetchResponse*) response) @safe @nogc nothrow
    {
        if (response.succeeded)
        {
            state.load_state = LoadState.Success;
            state.size = cast(uint) response.data.size;
        }
        else if (response.error_code == sapp.Html5FetchError.Fetch_error_buffer_too_small)
        {
            state.load_state = LoadState.FileTooBig;
        }
        else
        {
            state.load_state = LoadState.Failed;
        }
    }
}
else
{
    // the async-loading callback for native platforms
    extern (C) void native_load_callback(const(sfetch.Response*) response) @safe @nogc nothrow
    {
        if (response.fetched)
        {
            state.load_state = LoadState.Success;
            state.size = cast(uint) response.data.size;
        }
        else if (response.error_code == sfetch.Error.Buffer_too_small)
        {
            state.load_state = LoadState.FileTooBig;
        }
        else
        {
            state.load_state = LoadState.Failed;
        }
    }
}

version (WebAssembly)
{
    debug
    {
        import emscripten.assertd;
    }
}
