//------------------------------------------------------------------------------
//  imgui.d
//
//  Using cimgui + sokol, based on https://github.com/floooh/sokol-zig-imgui-sample
//------------------------------------------------------------------------------

module examples.imgui;

import sg = sokol.gfx;
import sgapp = sokol.glue;
import sapp = sokol.app;
import imgui = sokol.imgui;
import log = sokol.log;

extern (C):
@safe:

struct State
{
    sg.PassAction pass_action = {
        colors: [
            {
                load_action: sg.LoadAction.Clear,
                clear_value: {r: 0.0, g: 0.5, b: 1.0, a: 1.0},
            }
        ]
    };
}

static State state;

void init() @safe @nogc nothrow
{
    sg.Desc gfx = {
        environment: sgapp.environment,
        logger: {func: &log.slog_func}
    };
    sg.setup(gfx);
    imgui.Desc imgui_desc = {0};
    imgui.setup(imgui_desc);
}

void frame() @trusted @nogc nothrow
{
    imgui.FrameDesc imgui_desc = {
        width: sapp.width(),
        height: sapp.height(),
        delta_time: sapp.frameDuration(),
        dpi_scale: sapp.dpiScale(),
    };
    imgui.newFrame(imgui_desc);

    /*=== UI CODE STARTS HERE ===*/
    const ImVec2 window_pos = {10, 10};
    const ImVec2 window_pos_pivot = {0, 0};
    const ImVec2 window_size = {400, 100};
    igSetNextWindowPos(window_pos, ImGuiCond_.ImGuiCond_Once, window_pos_pivot);
    igSetNextWindowSize(window_size, ImGuiCond_.ImGuiCond_Once);
    igBegin("Hello Dear ImGui!".ptr, null, ImGuiWindowFlags_.ImGuiWindowFlags_None);
    const(char)* label = "Background";
    float[3] rgb = [
        state.pass_action.colors[0].clear_value.r,
        state.pass_action.colors[0].clear_value.g,
        state.pass_action.colors[0].clear_value.b
    ];
    igColorEdit3(label, rgb, ImGuiColorEditFlags_.ImGuiColorEditFlags_None);
    igEnd();
    /*=== UI CODE ENDS HERE ===*/

    sg.Pass pass = {action: state.pass_action, swapchain: sgapp.swapchain};
    sg.beginPass(pass);
    imgui.render;
    sg.endPass;
    sg.commit;
}

void event(const(sapp.Event)* ev) @trusted @nogc nothrow
{
    imgui.simgui_handle_event(ev);
}

void cleanup() @safe @nogc nothrow
{
    imgui.shutdown;
    sg.shutdown;
}

void main() @safe @nogc nothrow
{
    sapp.Desc runner = {
        window_title: "imgui.d",
        init_cb: &init,
        frame_cb: &frame,
        cleanup_cb: &cleanup,
        event_cb: &event,
        width: 800,
        height: 600,
        icon: {sokol_default: true},
        logger: {func: &log.func}
    };
    sapp.run(runner);
}

// -- CIMGUI -- //
@nogc nothrow:
extern (C) bool igBegin(scope const(char)* name, scope bool* p_open, ImGuiWindowFlags flags);
extern (C) void igEnd();
extern (C) void igSetNextWindowPos(const ImVec2 pos, ImGuiCond cond, const ImVec2 pivot);
extern (C) void igSetNextWindowSize(const ImVec2 size, ImGuiCond cond);
extern (C) bool igColorEdit3(scope const(char)* label, ref float[3] col, ImGuiColorEditFlags flags);

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
