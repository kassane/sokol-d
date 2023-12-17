//------------------------------------------------------------------------------
//  debugtext_print.d
//
//  Demonstrates formatted printing with sokol.debugtext
//------------------------------------------------------------------------------
module examples.debugtext_print;

import std.stdio;
import stm = sokol.time;
import sg = sokol.gfx;
import sgapp = sokol.glue;
import sapp = sokol.app;
import sdtx = sokol.debugtext;

// Font slots
enum KC854 = 0;
enum C64 = 1;
enum ORIC = 2;

struct Color
{
  ubyte r, g, b;
}

struct State
{
  sg.PassAction passAction;
  uint frameCount;
  ulong timeStamp;

  immutable Color[3] colors = [
    Color(0xF4, 0x43, 0x36),
    Color(0x21, 0x96, 0xF3),
    Color(0x4C, 0xAF, 0x50)
  ];
}

static State state;

void init()
{
  stm.setup();
  sg.Desc cd;
  cd.context = sgapp.context();
  sg.setup(cd);

  sdtx.Desc desc;
  desc.fonts[0] = sdtx.fontKc854();
  desc.fonts[1] = sdtx.fontC64();
  desc.fonts[3] = sdtx.fontOric();
  sdtx.setup(desc);
}

void frame()
{
  state.frameCount++;

  auto frameTime = stm.ms(stm.laptime(&state.timeStamp));

  sdtx.canvas(sapp.widthf() / 2, sapp.heightf() / 2);
  sdtx.origin(3, 3);

  foreach (font; [KC854, C64, ORIC])
  {
    auto color = state.colors[font];
    sdtx.font(font);
    sdtx.color3b(color.r, color.g, color.b);

    auto worldStr = (state.frameCount & (1 << 7)) ? "Welt" : "World";

    writeln("Hello ", worldStr," !");
    writeln("\tFrame Time:\t\t", frameTime,"ms");
    writef("\tFrame Count:\t%d\t%0.4f\n", state.frameCount, state.frameCount);
    sdtx.moveY(2);
  }

  sdtx.font(KC854);
  sdtx.color3b(255, 128, 0);

  // writeln("using std.format directly ", state.frameCount);

  sg.beginDefaultPass(state.passAction, sapp.width, sapp.height);
  sdtx.draw();
  sg.endPass();
  sg.commit();
}

void cleanup()
{
  sdtx.shutdown();
  sg.shutdown();
}

extern(C) void main()
{
  sapp.IconDesc icon = {sokol_default: true};
  sapp.Desc runner = {window_title: "debugtext_print.d"};
  runner.init_cb = &init;
  runner.frame_cb = &frame;
  runner.cleanup_cb = &cleanup;
  runner.width = 640;
  runner.height = 480;
  runner.icon = icon;
  sapp.run(runner);
}
