// machine generated, do not edit

module sokol.glue;
import sg = sokol.gfx;

// helper functions
import sokol.utils: cStrTod;

extern(C) sg.ContextDesc sapp_sgcontext() @system @nogc nothrow;
sg.ContextDesc context() @trusted nothrow {
    return sapp_sgcontext();
}
