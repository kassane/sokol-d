/++
+ Machine generated D bindings for Sokol library.
+ 
+     Generated on: 2025-09-03 13:27:49
+ 
+     Source header: sokol_memtrack.h
+     Module: sokol.memtrack
+ 
+     Do not edit manually; regenerate using gen_d.py.
+/
module sokol.memtrack;

extern(C) struct Info {
    int num_allocs = 0;
    int num_bytes = 0;
}
extern(C) Info smemtrack_info() @system @nogc nothrow pure;
Info info() @trusted @nogc nothrow pure {
    return smemtrack_info();
}
extern(C) void* smemtrack_alloc(size_t size, void* user_data) @system @nogc nothrow pure;
void* alloc(size_t size, void* user_data) @trusted @nogc nothrow pure {
    return smemtrack_alloc(size, user_data);
}
extern(C) void smemtrack_free(void* ptr, void* user_data) @system @nogc nothrow pure;
void free(void* ptr, void* user_data) @trusted @nogc nothrow pure {
    smemtrack_free(ptr, user_data);
}
