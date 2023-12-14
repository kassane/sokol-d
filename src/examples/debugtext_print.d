//------------------------------------------------------------------------------
//  debugtext_print.d
//
//  Demonstrates formatted printing with sokol.debugtext
//------------------------------------------------------------------------------
module examples.debugtext_print;

import std.stdio;
import std.format;
import sokol.time;
import sokol.gfx;
import sokol.gfx_glue;
import sokol.app;
import sokol.debugtext;

alias sapp = sokol.app;
alias sgapp = sokol.gfx_glue;
alias sdtx = sokol.debugtext;
alias stm = sokol.time;

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
  sokol.gfx.PassAction passAction;
  uint frameCount;
  ulong timeStamp;

  immutable Color[3] colors = [
    Color(0xF4, 0x43, 0x36),
    Color(0x21, 0x96, 0xF3),
    Color(0x4C, 0xAF, 0x50)
  ];
}

State state;

void init()
{
  stm.setup();
  sokol.gfx.setup(sokol.gfx.Desc(sgapp.context()));

  sdtx.Desc desc = sdtx.Desc(sdtx.fontKc854, sdtx.fontC64, sdtx.fontOric);
  sdtx.setup(desc);

  state.passAction.colors[0].loadAction = sokol.gfx.LoadAction.CLEAR;
  state.passAction.colors[0].clearValue = sokol.gfx.Color(0, 0.125, 0.25, 1);
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
    sdtx.color(color.r, color.g, color.b);

    auto worldStr = (state.frameCount & (1 << 7)) ? "Welt" : "World";

    sdtx.print("Hello '%d'!\n", worldStr);
    sdtx.print("\tFrame Time:\t\t%d ms\n", frameTime);
    sdtx.print("\tFrame Count:\t%d\t0x{X:0>4}\n", state.frameCount, state.frameCount);
    sdtx.moveY(2);
  }

  sdtx.font(KC854);
  sdtx.color(255, 128, 0);

  sdtx.Writer writer;
  formattedWrite(&writer, "using std.format directly (%d)\n", state.frameCount);

  sokol.gfx.beginDefaultPass(state.passAction, sapp.width, sapp.height);
  sdtx.draw();
  sokol.gfx.endPass();
  sokol.gfx.commit();
}

void cleanup()
{
  sdtx.shutdown();
  sokol.gfx.shutdown();
}

void main()
{
  sapp.run(sapp.RunConfig(
      init, frame, cleanup, 640, 480,
      sapp.Icon(.sokol_default = true), "debugtext_print.d"));
}
