//------------------------------------------------------------------------------
//  nuklear.d
//
//  Using nuklear + sokol
// https://github.com/floooh/sokol-samples/blob/master/sapp/nuklear-sapp.c
//------------------------------------------------------------------------------

module nuklear_app;

private:

import sg = sokol.gfx;
import sgapp = sokol.glue;
import sapp = sokol.app;
import log = sokol.log;
import snk = sokol.nuklear;
import nuklear;

extern (C):
@safe:

struct State
{
    sg.PassAction pass_action = {
        colors: [
            {
                load_action: sg.LoadAction.Clear,
                clear_value: {r: 0.25, g: 0.5, b: 0.7, a: 1.0},
            }
        ]
    };
}

State state;

void init() nothrow
{
    sg.Desc gfx = {
        environment: sgapp.environment,
        logger: {func: &log.slog_func}
    };
    sg.setup(gfx);
    snk.Desc nk_desc = {
        enable_set_mouse_cursor: true,
        dpi_scale: sapp.dpiScale,
        logger: {func: &log.slog_func},
    };
    snk.setup(nk_desc);
}

void frame() @trusted
{
    auto ctx = cast(nk_context*) snk.newFrame;

    // Show a basic Nuklear Window
    if (nk_begin(ctx, "Demo", nk_rect(50, 50, 200, 200),
        NK_WINDOW_BORDER|NK_WINDOW_MOVABLE|NK_WINDOW_SCALABLE|
        NK_WINDOW_CLOSABLE|NK_WINDOW_MINIMIZABLE|NK_WINDOW_TITLE))
    {
        nk_menubar_begin(ctx);
        nk_layout_row_begin(ctx, NK_STATIC, 25, 2);
        nk_layout_row_push(ctx, 45);
        if (nk_menu_begin_label(ctx, "FILE", NK_TEXT_LEFT, nk_vec2(120, 200))) {
            nk_layout_row_dynamic(ctx, 30, 1);
            nk_menu_item_label(ctx, "OPEN", NK_TEXT_LEFT);
            nk_menu_item_label(ctx, "CLOSE", NK_TEXT_LEFT);
            nk_menu_end(ctx);
        }
        nk_layout_row_push(ctx, 45);
        if (nk_menu_begin_label(ctx, "EDIT", NK_TEXT_LEFT, nk_vec2(120, 200))) {
            nk_layout_row_dynamic(ctx, 30, 1);
            nk_menu_item_label(ctx, "COPY", NK_TEXT_LEFT);
            nk_menu_item_label(ctx, "CUT", NK_TEXT_LEFT);
            nk_menu_item_label(ctx, "PASTE", NK_TEXT_LEFT);
            nk_menu_end(ctx);
        }
        nk_layout_row_end(ctx);
        nk_menubar_end(ctx);

        enum {EASY, HARD};
        static int op = EASY;
        static int property = 20;
        nk_layout_row_static(ctx, 30, 80, 1);
        if (nk_button_label(ctx, "button"))
            printf("button pressed\n");
        nk_layout_row_dynamic(ctx, 30, 2);
        if (nk_option_label(ctx, "easy", op == EASY)) op = EASY;
        if (nk_option_label(ctx, "hard", op == HARD)) op = HARD;
        nk_layout_row_dynamic(ctx, 25, 1);
        nk_property_int(ctx, "Compression:", 0, &property, 100, 10, 1);
    }
    nk_end(ctx);

    sg.Pass pass = {action: state.pass_action, swapchain: sgapp.swapchain};
    sg.beginPass(pass);
    snk.render(sapp.width, sapp.height);
    sg.endPass;
    sg.commit;
}

void event(const(sapp.Event)* ev) @trusted nothrow
{
    snk.snk_handle_event(ev);
}

void cleanup() @safe nothrow
{
    snk.shutdown;
    sg.shutdown;
}

void main() @safe nothrow
{
    sapp.Desc runner = {
        window_title: "nuklear.d",
        init_cb: &init,
        frame_cb: &frame,
        cleanup_cb: &cleanup,
        event_cb: &event,
        enable_clipboard: true,
        width: 800,
        height: 600,
        ios_keyboard_resizes_canvas: true,
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
