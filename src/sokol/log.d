// machine generated, do not edit

module sokol.log;

// helper function to convert a C string to a D string
string cStrTod(T)(scope T c_str) nothrow {
    import std.conv: to;
    return c_str.to!string;
}
extern(C) void slog_func(scope const(char)*, uint, uint, scope const(char)*, uint, scope const(char)*, void*) @system @nogc nothrow;
alias func = slog_func;
