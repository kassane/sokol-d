// machine generated, do not edit

module sokol.memtrack;

extern(C)
struct Info {
    int num_allocs = 0;
    int num_bytes = 0;
}
extern(C) Info smemtrack_info() @system @nogc nothrow;
Info info() @trusted @nogc nothrow {
    return smemtrack_info();
}
extern(C) void* smemtrack_alloc(size_t, void*) @system @nogc nothrow;
scope void* alloc(size_t size, scope void* user_data) @trusted @nogc nothrow {
    return smemtrack_alloc(size, user_data);
}
extern(C) void smemtrack_free(void*, void*) @system @nogc nothrow;
void free(scope void* ptr, scope void* user_data) @trusted @nogc nothrow {
    smemtrack_free(ptr, user_data);
}
