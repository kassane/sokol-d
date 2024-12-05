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
import cimgui.cimgui;

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

void init() nothrow
{
    sg.Desc gfx = {
        environment: sgapp.environment,
        logger: {func: &log.slog_func}
    };
    sg.setup(gfx);
    imgui.Desc imgui_desc = {0};
    imgui.setup(imgui_desc);
}

void frame() @trusted
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
    const ImVec2 window_size = {400, 100};
    igSetNextWindowPos(window_pos, ImGuiCond_.ImGuiCond_Once);
    igSetNextWindowSize(window_size, ImGuiCond_.ImGuiCond_Once);
    igBegin("Hello Dear ImGui!".ptr, null, ImGuiWindowFlags_.ImGuiWindowFlags_None);
    const(char)* label = "Background";
    float[3] rgb = [
        state.pass_action.colors[0].clear_value.r,
        state.pass_action.colors[0].clear_value.g,
        state.pass_action.colors[0].clear_value.b
    ];
    igColorEdit3(label, &rgb[0], ImGuiColorEditFlags_.ImGuiColorEditFlags_None);
    igEnd();
    /*=== UI CODE ENDS HERE ===*/

    sg.Pass pass = {action: state.pass_action, swapchain: sgapp.swapchain};
    sg.beginPass(pass);
    imgui.render;
    sg.endPass;
    sg.commit;
}

void event(const(sapp.Event)* ev) @trusted nothrow
{
    imgui.simgui_handle_event(ev);
}

void cleanup() @safe nothrow
{
    imgui.shutdown;
    sg.shutdown;
}

void main() @safe nothrow
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
