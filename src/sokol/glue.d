// machine generated, do not edit

module sokol.glue;
import sg = sokol.gfx;

extern(C) sg.ContextDesc sapp_sgcontext() @system @nogc nothrow;
sg.ContextDesc context() @trusted nothrow @nogc {
    return sapp_sgcontext();
}
