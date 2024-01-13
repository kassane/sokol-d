module sokol.utils;

// helper function to convert a C string to a D string
string cStrTod(inout(char)* c_str) nothrow {
    auto start = c_str;
    auto end = cast(char*) c_str;
    for (; *end; end++){}
    return cast(string) c_str[0 .. end - start];
}

import sokol.gfx:Range;

// WIP: helper function to convert "anything" to a Range struct
Range asRange(T)(T val) @trusted {
    import std.traits;
    static if (isPointer!T) {
       return Range(val, T.sizeof);
    } else static if (is(T == float[]) || is(T == double[])) {
       auto arr = val.dup;
       return Range(&arr[0], arr.length * arr[0].sizeof);
    } else static if (is(T == struct)) {
       Range r = {ptr: cast(const(void)*)&val, size: T.sizeof};
       return r;
    } else {
       static assert(0, "Cannot convert to range");
    }
}
