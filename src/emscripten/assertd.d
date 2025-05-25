module emscripten.assertd;

extern (C):

version (Emscripten)
{
    union fpos_t
    {
        char[16] __opaque = 0;
        long __lldata;
        double __align;
    }

    struct _IO_FILE;
    alias _IO_FILE _iobuf; // for phobos2 compat
    alias shared(_IO_FILE) FILE;

    extern __gshared FILE* stdin;
    extern __gshared FILE* stdout;
    extern __gshared FILE* stderr;
    enum
    {
        _IOFBF = 0,
        _IOLBF = 1,
        _IONBF = 2,
    }

    // D runtime hooks for assert failures and array bounds checking

    void __assert(scope const(char)* msg, scope const(char)* file, uint line) @nogc nothrow @trusted
    {
        fprintf(stderr, "Assertion failed in %s:%u: %s\n", file, line, msg);
        abort();
    }

    void _d_assert(string file, uint line) @nogc nothrow @trusted
    {
        fprintf(stderr, "Assertion failed in %s:%u\n", file.ptr, line);
        abort();
    }

    void _d_assert_msg(string msg, string file, uint line) @nogc nothrow @trusted
    {
        __assert(msg.ptr, file.ptr, line);
    }

    void abort() @nogc nothrow;

    pragma(printf)
    int fprintf(FILE* __restrict, scope const(char)* __restrict, scope...) @nogc nothrow;

    // boundchecking
    void _d_arraybounds_index(string file, uint line, size_t index, size_t length) @nogc nothrow @trusted
    {
        if (index >= length)
            __assert("Array index out of bounds".ptr, file.ptr, line);
    }
}
