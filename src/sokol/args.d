/++
+ Machine generated D bindings for Sokol library.
+ 
+     Generated on: 2025-08-12 18:30:18
+ 
+     Source header: sokol_args.h
+     Module: sokol.args
+ 
+     Do not edit manually; regenerate using gen_d.py.
+/
module sokol.args;

/++
+ sargs_allocator
+ 
+     Used in sargs_desc to provide custom memory-alloc and -free functions
+     to sokol_args.h. If memory management should be overridden, both the
+     alloc_fn and free_fn function must be provided (e.g. it's not valid to
+     override one function but not the other).
+/
extern(C) struct Allocator {
    extern(C) void* function(size_t, void*) alloc_fn = null;
    extern(C) void function(void*, void*) free_fn = null;
    void* user_data = null;
}
extern(C) struct Desc {
    int argc = 0;
    void* argv;
    int max_args = 0;
    int buf_size = 0;
    Allocator allocator = {};
}
/++
+ setup sokol-args
+/
extern(C) void sargs_setup(const Desc* desc) @system @nogc nothrow pure;
void setup(scope ref Desc desc) @trusted @nogc nothrow pure {
    sargs_setup(&desc);
}
/++
+ shutdown sokol-args
+/
extern(C) void sargs_shutdown() @system @nogc nothrow pure;
void shutdown() @trusted @nogc nothrow pure {
    sargs_shutdown();
}
/++
+ true between sargs_setup() and sargs_shutdown()
+/
extern(C) bool sargs_isvalid() @system @nogc nothrow pure;
bool isvalid() @trusted @nogc nothrow pure {
    return sargs_isvalid();
}
/++
+ test if an argument exists by key name
+/
extern(C) bool sargs_exists(const(char)* key) @system @nogc nothrow pure;
bool exists(const(char)* key) @trusted @nogc nothrow pure {
    return sargs_exists(key);
}
/++
+ get value by key name, return empty string if key doesn't exist or an existing key has no value
+/
extern(C) const(char)* sargs_value(const(char)* key) @system @nogc nothrow pure;
const(char)* value(const(char)* key) @trusted @nogc nothrow pure {
    return sargs_value(key);
}
/++
+ get value by key name, return provided default if key doesn't exist or has no value
+/
extern(C) const(char)* sargs_value_def(const(char)* key, const(char)* def) @system @nogc nothrow pure;
const(char)* valueDef(const(char)* key, const(char)* def) @trusted @nogc nothrow pure {
    return sargs_value_def(key, def);
}
/++
+ return true if val arg matches the value associated with key
+/
extern(C) bool sargs_equals(const(char)* key, const(char)* val) @system @nogc nothrow pure;
bool equals(const(char)* key, const(char)* val) @trusted @nogc nothrow pure {
    return sargs_equals(key, val);
}
/++
+ return true if key's value is "true", "yes", "on" or an existing key has no value
+/
extern(C) bool sargs_boolean(const(char)* key) @system @nogc nothrow pure;
bool boolean(const(char)* key) @trusted @nogc nothrow pure {
    return sargs_boolean(key);
}
/++
+ get index of arg by key name, return -1 if not exists
+/
extern(C) int sargs_find(const(char)* key) @system @nogc nothrow pure;
int find(const(char)* key) @trusted @nogc nothrow pure {
    return sargs_find(key);
}
/++
+ get number of parsed arguments
+/
extern(C) int sargs_num_args() @system @nogc nothrow pure;
int numArgs() @trusted @nogc nothrow pure {
    return sargs_num_args();
}
/++
+ get key name of argument at index, or empty string
+/
extern(C) const(char)* sargs_key_at(int index) @system @nogc nothrow pure;
const(char)* keyAt(int index) @trusted @nogc nothrow pure {
    return sargs_key_at(index);
}
/++
+ get value string of argument at index, or empty string
+/
extern(C) const(char)* sargs_value_at(int index) @system @nogc nothrow pure;
const(char)* valueAt(int index) @trusted @nogc nothrow pure {
    return sargs_value_at(index);
}
