// machine generated, do not edit

module sokol.glue;
import sg = sokol.gfx;

// helper function to convert a C string to a D string
string cStrToDString(const(char*) c_str)
{
    import std.conv : to;

    return c_str.to!string;
}

extern (C) sg.ContextDesc sapp_sgcontext();
sg.ContextDesc context()
{
    return sapp_sgcontext();
}
