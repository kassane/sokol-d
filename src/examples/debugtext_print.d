//------------------------------------------------------------------------------
//  debugtext_print.d
//
//  Demonstrates formatted printing with sokol.debugtext
//------------------------------------------------------------------------------
module examples.debugtext_print;

import stm = sokol.time;
import sg = sokol.gfx;
import sgapp = sokol.glue;
import sapp = sokol.app;
import sdtx = sokol.debugtext;
import log = sokol.log;

// Font slots
enum KC854 = 0;
enum C64 = 1;
enum ORIC = 2;

extern(C)
struct Color
{
    @disable this();
    this(ubyte r, ubyte g, ubyte b){
      this.r = r;
      this.g = g;
      this.b = b;
    }
    ubyte r, g, b;
}

extern(C)
struct State
{
    @disable this();
    sg.PassAction passAction;
    uint frameCount;
    ulong timeStamp;

    immutable Color[3] colors = [
        Color(0xF4, 0x43, 0x36),
        Color(0x21, 0x96, 0xF3),
        Color(0x4C, 0xAF, 0x50)
    ];
}

__gshared State state = {};

extern (C) void init()
{
    stm.setup();
    sg.Desc cd;
    cd.context = sgapp.context();
    cd.logger.func = &log.func;
    sg.setup(cd);

    sdtx.Desc desc;
    desc.logger.func = &log.func;
    desc.fonts[0] = sdtx.fontKc854();
    desc.fonts[1] = sdtx.fontC64();
    desc.fonts[3] = sdtx.fontOric();
    sdtx.setup(desc);

    state.passAction.colors[0].load_action = sg.LoadAction.CLEAR;
    state.passAction.colors[0].clear_value.r = 0;
    state.passAction.colors[0].clear_value.g = 0.125;
    state.passAction.colors[0].clear_value.b = 0.25;
    state.passAction.colors[0].clear_value.a = 1;
}

extern (C) void frame()
{
    state.frameCount++;

    const frameTime = stm.ms(stm.laptime(&state.timeStamp));

    sdtx.canvas(sapp.widthf() / 2, sapp.heightf() / 2);
    sdtx.origin(3, 3);

    foreach (font; [KC854, C64, ORIC])
    {
        const color = state.colors[font];
        sdtx.font(font);
        sdtx.color3b(color.r, color.g, color.b);

        const worldStr = (state.frameCount & (1 << 7)) ? "Welt" : "World";

        sdtx.print("Hello '%s'!\n", worldStr);
        sdtx.print("\tFrame Time:\t\t %0.3f ms", frameTime);
        sdtx.print("\tFrame Count:\t%d\t%x\n", state.frameCount, state.frameCount);
        sdtx.moveY(2);
    }

    sdtx.font(KC854);
    sdtx.color3b(255, 128, 0);

    sg.beginDefaultPass(state.passAction, sapp.width, sapp.height);
    sdtx.draw();
    sg.endPass();
    sg.commit();
}

extern (C) void cleanup()
{
    sdtx.shutdown();
    sg.shutdown();
}

void main()
{
    sapp.IconDesc icon = {sokol_default: true};
    sapp.Desc runner = {
        window_title: "debugtext_print.d",
        init_cb: &init,
        frame_cb: &frame,
        cleanup_cb: &cleanup,
        width: 640,
        height: 480
    };
    runner.icon = icon;
    runner.logger.func = &log.func;
    sapp.run(runner);
}
