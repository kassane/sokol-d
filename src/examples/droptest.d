//------------------------------------------------------------------------------
//  droptest.d
//  Test drag'n'drop file loading.
//------------------------------------------------------------------------------

module examples.droptest;

import sg = sokol.gfx;
import sgapp = sokol.glue;
import sapp = sokol.app;
import sfetch = sokol.fetch;
import imgui = sokol.imgui;
import log = sokol.log;

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
    imgui.Desc imgui_desc = {0};
    imgui.setup(imgui_desc);

    // ifndef emscripten
    static if((){version(Emscripten) return false; else return true;}())
    {
        sfetch.Desc fetch_desc = {
            num_channels: 1,
            num_lanes: 1,
            logger: {func: &log.slog_func},
        };
        sfetch.setup(fetch_desc);
    }
}

extern (C) void frame() @trusted @nogc nothrow
{
    // ifndef emscripten
    static if((){version(Emscripten) return false;else return true;}())
    {
        sfetch.dowork;
    }
    imgui.FrameDesc imgui_desc = {
        width: sapp.width(),
        height: sapp.height(),
        delta_time: sapp.frameDuration(),
        dpi_scale: sapp.dpiScale(),
    };
    imgui.newFrame(imgui_desc);

    // /*=== UI CODE STARTS HERE ===*/
    const ImVec2 window_pos = {10, 10};
    const ImVec2 window_pos_pivot = {0, 0};
    const ImVec2 window_size = {600, 500};
    igSetNextWindowPos(window_pos, ImGuiCond_.ImGuiCond_Once, window_pos_pivot);
    igSetNextWindowSize(window_size, ImGuiCond_.ImGuiCond_Once);
    igBegin("Drop a file!".ptr, null, ImGuiWindowFlags_.ImGuiWindowFlags_None);
    if(state.load_state != LoadState.Unknown)
    {
        igText("%s:", sapp.getDroppedFilePath(0));
    }
    switch (state.load_state) {
        case LoadState.Failed:
            igText("LOAD FAILED!");
            break;
        case LoadState.FileTooBig:
            igText("FILE TOO BIG!");
            break;
        case LoadState.Success:
            igSeparator;
            renderFileContent;
            break;
        default:
            break;
    }
    igEnd();
    /*=== UI CODE ENDS HERE ===*/

    sg.Pass pass = {swapchain: sgapp.swapchain};
    sg.beginPass(pass);
    imgui.render;
    sg.endPass;
    sg.commit;
}

extern (C) void event(const(sapp.Event)* ev) @trusted @nogc nothrow
{
    imgui.simgui_handle_event(ev);
    if (ev.type == sapp.EventType.Files_dropped)
    {
        version (Emscripten)
        {
            // on emscripten need to use the sokol-app helper function to load the file data
            sapp.Html5FetchRequest req = {
                dropped_file_index: 0,
                callback: &emsc_load_callback,
                buffer: {ptr: &state.buffer[0], size: state.buffer.sizeof}
            };
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
    static if((){version(Emscripten) return false;else return true;}())
    {
        sfetch.shutdown;
    }
    imgui.shutdown;
    sg.shutdown;
}

extern (C) void main() @safe @nogc nothrow
{
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
    sapp.run(runner);
}

void renderFileContent() @nogc nothrow
{
    immutable int bytes_per_line = 16; // keep this 2^N
    immutable int num_lines = (state.size + (bytes_per_line - 1)) / bytes_per_line;
    ImVec2 sz = {0, 0};
    igBeginChild_Str("##scrolling", sz, false, ImGuiWindowFlags_.ImGuiWindowFlags_NoMove | ImGuiWindowFlags_
            .ImGuiWindowFlags_NoNav);
    ImGuiListClipper* clipper = ImGuiListClipper_ImGuiListClipper();
    ImGuiListClipper_Begin(clipper, num_lines, igGetTextLineHeight());
    ImGuiListClipper_Step(clipper);
    for (int line_i = clipper.DisplayStart; line_i < clipper.DisplayEnd; line_i++)
    {
        int start_offset = line_i * bytes_per_line;
        int end_offset = start_offset + bytes_per_line;
        if (end_offset >= state.size)
        {
            end_offset = state.size;
        }
        igText("%04X: ", start_offset);
        for (int i = start_offset; i < end_offset; i++)
        {
            igSameLine(0.0f, 0.0f);
            igText("%02X ", state.buffer[i]);
        }
        igSameLine((6 * 7.0f) + (bytes_per_line * 3 * 7.0f) + (2 * 7.0f), 0.0f);
        for (int i = start_offset; i < end_offset; i++)
        {
            if (i != start_offset)
            {
                igSameLine(0.0f, 0.0f);
            }
            ubyte c = state.buffer[i];
            if ((c < 32) || (c > 127))
            {
                c = '.';
            }
            igText("%c", c);
        }
    }
    igText("EOF\n");
    ImGuiListClipper_End(clipper);
    ImGuiListClipper_destroy(clipper);
    igEndChild();
}

version (Emscripten)
{
    // the async-loading callback for sapp_html5_fetch_dropped_file
    extern (C) void emsc_load_callback(const (sapp.Html5FetchResponse*) response) @nogc nothrow
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
    extern (C) void native_load_callback(const (sfetch.Response*) response) @nogc nothrow
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

// -- CIMGUI -- //
@nogc nothrow:
extern (C) bool igBeginChild_Str(scope const(char)* str_id, const ImVec2 size, bool border, ImGuiWindowFlags flags);
extern (C) bool igBegin(const(char)* name, scope bool* p_open, ImGuiWindowFlags flags);
extern (C) void igEnd();
extern (C) void igSetNextWindowPos(const ImVec2 pos, ImGuiCond cond, const ImVec2 pivot);
extern (C) void igSetNextWindowSize(const ImVec2 size, ImGuiCond cond);
extern (C) void igText(scope const(char)* fmt, ...);
extern (C) void igSameLine(float offset_from_start_x, float spacing);
extern (C) scope ImGuiListClipper* ImGuiListClipper_ImGuiListClipper();
extern (C) void ImGuiListClipper_destroy(scope ImGuiListClipper* self);
extern (C) void ImGuiListClipper_Begin(scope ImGuiListClipper* self, int items_count, float items_height);
extern (C) void ImGuiListClipper_End(scope ImGuiListClipper* self);
extern (C) void igEndChild();
extern (C) void igSeparator();
extern (C) float igGetTextLineHeight();
extern (C) bool ImGuiListClipper_Step(scope ImGuiListClipper* self);

extern (C):
struct ImVec2
{
    float x = 0.0f;
    float y = 0.0f;
}

enum ImGuiColorEditFlags_
{
    ImGuiColorEditFlags_None = 0,
    ImGuiColorEditFlags_NoAlpha = 1 << 1,
    ImGuiColorEditFlags_NoPicker = 1 << 2,
    ImGuiColorEditFlags_NoOptions = 1 << 3,
    ImGuiColorEditFlags_NoSmallPreview = 1 << 4,
    ImGuiColorEditFlags_NoInputs = 1 << 5,
    ImGuiColorEditFlags_NoTooltip = 1 << 6,
    ImGuiColorEditFlags_NoLabel = 1 << 7,
    ImGuiColorEditFlags_NoSidePreview = 1 << 8,
    ImGuiColorEditFlags_NoDragDrop = 1 << 9,
    ImGuiColorEditFlags_NoBorder = 1 << 10,
    ImGuiColorEditFlags_AlphaBar = 1 << 16,
    ImGuiColorEditFlags_AlphaPreview = 1 << 17,
    ImGuiColorEditFlags_AlphaPreviewHalf = 1 << 18,
    ImGuiColorEditFlags_HDR = 1 << 19,
    ImGuiColorEditFlags_DisplayRGB = 1 << 20,
    ImGuiColorEditFlags_DisplayHSV = 1 << 21,
    ImGuiColorEditFlags_DisplayHex = 1 << 22,
    ImGuiColorEditFlags_Uint8 = 1 << 23,
    ImGuiColorEditFlags_Float = 1 << 24,
    ImGuiColorEditFlags_PickerHueBar = 1 << 25,
    ImGuiColorEditFlags_PickerHueWheel = 1 << 26,
    ImGuiColorEditFlags_InputRGB = 1 << 27,
    ImGuiColorEditFlags_InputHSV = 1 << 28,
    ImGuiColorEditFlags_DefaultOptions_
        = ImGuiColorEditFlags_Uint8 | ImGuiColorEditFlags_DisplayRGB
        | ImGuiColorEditFlags_InputRGB | ImGuiColorEditFlags_PickerHueBar,
    ImGuiColorEditFlags_DisplayMask_ = ImGuiColorEditFlags_DisplayRGB
        | ImGuiColorEditFlags_DisplayHSV | ImGuiColorEditFlags_DisplayHex,
    ImGuiColorEditFlags_DataTypeMask_ = ImGuiColorEditFlags_Uint8 | ImGuiColorEditFlags_Float,
    ImGuiColorEditFlags_PickerMask_
        = ImGuiColorEditFlags_PickerHueWheel | ImGuiColorEditFlags_PickerHueBar,
    ImGuiColorEditFlags_InputMask_ = ImGuiColorEditFlags_InputRGB | ImGuiColorEditFlags_InputHSV
}

enum ImGuiWindowFlags_
{
    ImGuiWindowFlags_None = 0,
    ImGuiWindowFlags_NoTitleBar = 1 << 0,
    ImGuiWindowFlags_NoResize = 1 << 1,
    ImGuiWindowFlags_NoMove = 1 << 2,
    ImGuiWindowFlags_NoScrollbar = 1 << 3,
    ImGuiWindowFlags_NoScrollWithMouse = 1 << 4,
    ImGuiWindowFlags_NoCollapse = 1 << 5,
    ImGuiWindowFlags_AlwaysAutoResize = 1 << 6,
    ImGuiWindowFlags_NoBackground = 1 << 7,
    ImGuiWindowFlags_NoSavedSettings = 1 << 8,
    ImGuiWindowFlags_NoMouseInputs = 1 << 9,
    ImGuiWindowFlags_MenuBar = 1 << 10,
    ImGuiWindowFlags_HorizontalScrollbar = 1 << 11,
    ImGuiWindowFlags_NoFocusOnAppearing = 1 << 12,
    ImGuiWindowFlags_NoBringToFrontOnFocus = 1 << 13,
    ImGuiWindowFlags_AlwaysVerticalScrollbar = 1 << 14,
    ImGuiWindowFlags_AlwaysHorizontalScrollbar = 1 << 15,
    ImGuiWindowFlags_AlwaysUseWindowPadding = 1 << 16,
    ImGuiWindowFlags_NoNavInputs = 1 << 18,
    ImGuiWindowFlags_NoNavFocus = 1 << 19,
    ImGuiWindowFlags_UnsavedDocument = 1 << 20,
    ImGuiWindowFlags_NoNav = ImGuiWindowFlags_NoNavInputs | ImGuiWindowFlags_NoNavFocus,
    ImGuiWindowFlags_NoDecoration = ImGuiWindowFlags_NoTitleBar
        | ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoScrollbar | ImGuiWindowFlags_NoCollapse,
    ImGuiWindowFlags_NoInputs = ImGuiWindowFlags_NoMouseInputs
        | ImGuiWindowFlags_NoNavInputs | ImGuiWindowFlags_NoNavFocus,
    ImGuiWindowFlags_NavFlattened = 1 << 23,
    ImGuiWindowFlags_ChildWindow = 1 << 24,
    ImGuiWindowFlags_Tooltip = 1 << 25,
    ImGuiWindowFlags_Popup = 1 << 26,
    ImGuiWindowFlags_Modal = 1 << 27,
    ImGuiWindowFlags_ChildMenu = 1 << 28
}

enum ImGuiCond_
{
    ImGuiCond_None = 0,
    ImGuiCond_Always = 1 << 0,
    ImGuiCond_Once = 1 << 1,
    ImGuiCond_FirstUseEver = 1 << 2,
    ImGuiCond_Appearing = 1 << 3
}

alias ImGuiCond = int;
alias ImGuiColorEditFlags = int;
alias ImGuiWindowFlags = int;
struct ImGuiListClipper
{
    ImGuiContext* Ctx = null;
    int DisplayStart = 0;
    int DisplayEnd = 0;
    int ItemsCount = 0;
    float ItemsHeight = 0.0f;
    float StartPosY = 0.0f;
    void* TempData = null;
}

struct ImGuiContext;
