//------------------------------------------------------------------------------
//  debugtext.d
//
//  Test sokol_debugtext.h
//------------------------------------------------------------------------------
module examples.debugtext;

import sg = sokol.gfx;
import sglue = sokol.glue;
import sapp = sokol.app;
import sdtx = sokol.debugtext;
import log = sokol.log;

extern (C):
@safe:

// Font slots
immutable FONT_KC853 = 0;
immutable FONT_KC854 = 1;
immutable FONT_KC85 = 1;
immutable FONT_Z1013 = 2;
immutable FONT_CPC = 3;
immutable FONT_C64 = 4;
immutable FONT_ORIC = 5;

struct State {
    // background color
    sg.PassAction passAction = {
        colors: [
            {
                load_action: sg.LoadAction.Clear,
                clear_value: { r: 0.0, g: 0.125, b: 0.25, a: 1.0 }
            }
        ]
    };
}
static State state;

void init() {
    sg.Desc gfx = {
        environment: sglue.environment(),
        logger: { func: &log.func }
    };
    sg.setup(gfx);

    sdtx.Desc desc = {
        fonts: [
            sdtx.fontKc853(),
            sdtx.fontKc854(),
            sdtx.fontZ1013(),
            sdtx.fontCpc(),
            sdtx.fontC64(),
            sdtx.fontOric()
        ],
        logger: { func: &log.func },
    };
    sdtx.setup(desc);
}

void print_font(uint font_index, string title, ubyte r, ubyte g, ubyte b) {
    sdtx.font(font_index);
    sdtx.color3b(r, g, b);
    sdtx.puts(&title[0]);
    foreach (c; 32 .. 255) {
        sdtx.putc(cast(char) c);
        if (((c + 1) & 63) == 0) {
            sdtx.crlf();
        }
    }
    sdtx.crlf();
}

void frame() {
    sdtx.canvas(sapp.widthf() * 0.5, sapp.heightf() * 0.5);
    sdtx.origin(0.0, 2.0);
    sdtx.home();

    print_font(FONT_KC853, "KC85/3:\n", 0xf4, 0x43, 0x36);
    print_font(FONT_KC854, "KC85/4:\n", 0x21, 0x96, 0xf3);
    print_font(FONT_Z1013, "Z1013:\n", 0x4c, 0xaf, 0x50);
    print_font(FONT_CPC, "Amstrad CPC:\n", 0xff, 0xeb, 0x3b);
    print_font(FONT_C64, "C64:\n", 0x79, 0x86, 0xcb);
    print_font(FONT_ORIC, "Oric Atmos:\n", 0xff, 0x98, 0x00);

    sg.Pass pass = { action: state.passAction, swapchain: sglue.swapchain() };
    sg.beginPass(pass);
    sdtx.draw();
    sg.endPass();
    sg.commit();
}

void cleanup() {
    sdtx.shutdown();
    sg.shutdown();
}

void main() {
    sapp.Desc runner = {
        window_title: "debugtext.d",
        init_cb: &init,
        frame_cb: &frame,
        cleanup_cb: &cleanup,
        width: 1024,
        height: 600,
        icon: {sokol_default: true},
        logger: {func: &log.func}
    };
    sapp.run(runner);
}
