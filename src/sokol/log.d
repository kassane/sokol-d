// machine generated, do not edit

module sokol.log;

// helper function to convert a C string to a D string
string cStrToDString(const(char*) c_str)
{
    import std.conv : to;

    return c_str.to!string;
}

extern (C) void slog_func(const(char*), uint, uint, const(char*), uint, const(char*), void*);
alias func = slog_func;
