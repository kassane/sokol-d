//------------------------------------------------------------------------------
//  imgui.d
//
//  Using cimgui + sokol, based on https://github.com/floooh/sokol-zig-imgui-sample
//------------------------------------------------------------------------------

module examples.imgui;

private:

import sg = sokol.gfx;
import sgapp = sokol.glue;
import sapp = sokol.app;
import simgui = sokol.imgui;
import log = sokol.log;
import imgui;

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
    simgui.Desc imgui_desc = {0};
    simgui.setup(imgui_desc);
}

void frame() @trusted
{
    simgui.FrameDesc imgui_desc = {
        width: sapp.width(),
        height: sapp.height(),
        delta_time: sapp.frameDuration(),
        dpi_scale: sapp.dpiScale(),
    };
    simgui.newFrame(imgui_desc);

    /*=== UI CODE STARTS HERE ===*/
    const ImVec2 window_pos = {10, 10};
    const ImVec2 window_size = {400, 100};
    SetNextWindowPos(window_pos, ImGuiCond_.ImGuiCond_Once);
    SetNextWindowSize(window_size, ImGuiCond_.ImGuiCond_Once);
    Begin("Hello Dear ImGui!".ptr, null, ImGuiWindowFlags_.ImGuiWindowFlags_None);
    const(char)* label = "Background";
    float[3] rgb = [
        state.pass_action.colors[0].clear_value.r,
        state.pass_action.colors[0].clear_value.g,
        state.pass_action.colors[0].clear_value.b
    ];
    ColorEdit3(label, rgb, ImGuiColorEditFlags_.ImGuiColorEditFlags_None);
    End();
    /*=== UI CODE ENDS HERE ===*/

    sg.Pass pass = {action: state.pass_action, swapchain: sgapp.swapchain};
    sg.beginPass(pass);
    simgui.render;
    sg.endPass;
    sg.commit;
}

void event(const(sapp.Event)* ev) @trusted nothrow
{
    simgui.simgui_handle_event(ev);
}

void cleanup() @safe nothrow
{
    simgui.shutdown;
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
