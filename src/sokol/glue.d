// machine generated, do not edit

module sokol.glue;
import sg = sokol.gfx;

// helper function to convert a C string to a D string
string cStrTod(T)(scope T c_str) nothrow {
    import std.conv: to;
    return c_str.to!string;
}
extern(C) sg.ContextDesc sapp_sgcontext() @system @nogc nothrow;
sg.ContextDesc context() @trusted nothrow {
    return sapp_sgcontext();
}
