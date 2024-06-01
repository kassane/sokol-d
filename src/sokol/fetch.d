// machine generated, do not edit

module sokol.fetch;

enum LogItem {
    Ok,
    Malloc_failed,
    File_path_utf8_decoding_failed,
    Send_queue_full,
    Request_channel_index_too_big,
    Request_path_is_null,
    Request_path_too_long,
    Request_callback_missing,
    Request_chunk_size_greater_buffer_size,
    Request_userdata_ptr_is_set_but_userdata_size_is_null,
    Request_userdata_ptr_is_null_but_userdata_size_is_not,
    Request_userdata_size_too_big,
    Clamping_num_channels_to_max_channels,
    Request_pool_exhausted,
}
extern(C)
struct Logger {
    extern(C) void function(const(char)*, uint, uint, const(char)*, uint, const(char)*, void*) func = null;
    void* user_data = null;
}
extern(C)
struct Range {
    const(void)* ptr = null;
    size_t size = 0;
}
extern(C)
struct Allocator {
    extern(C) void* function(size_t, void*) alloc_fn = null;
    extern(C) void function(void*, void*) free_fn = null;
    void* user_data = null;
}
extern(C)
struct Desc {
    uint max_requests = 0;
    uint num_channels = 0;
    uint num_lanes = 0;
    Allocator allocator;
    Logger logger;
}
extern(C)
struct Handle {
    uint id = 0;
}
enum Error {
    No_error,
    File_not_found,
    No_buffer,
    Buffer_too_small,
    Unexpected_eof,
    Invalid_http_status,
    Cancelled,
}
extern(C)
struct Response {
    Handle handle;
    bool dispatched = false;
    bool fetched = false;
    bool paused = false;
    bool finished = false;
    bool failed = false;
    bool cancelled = false;
    Error error_code;
    uint channel = 0;
    uint lane = 0;
    const(char)* path = null;
    void* user_data = null;
    uint data_offset = 0;
    Range data;
    Range buffer;
}
extern(C)
struct Request {
    uint channel = 0;
    const(char)* path = null;
    extern(C) void function(const Response *) callback = null;
    uint chunk_size = 0;
    Range buffer;
    Range user_data;
}
extern(C) void sfetch_setup(const Desc *) @system @nogc nothrow;
void setup(scope ref Desc desc) @trusted @nogc nothrow {
    sfetch_setup(&desc);
}
extern(C) void sfetch_shutdown() @system @nogc nothrow;
void shutdown() @trusted @nogc nothrow {
    sfetch_shutdown();
}
extern(C) bool sfetch_valid() @system @nogc nothrow;
bool valid() @trusted @nogc nothrow {
    return sfetch_valid();
}
extern(C) Desc sfetch_desc() @system @nogc nothrow;
Desc desc() @trusted @nogc nothrow {
    return sfetch_desc();
}
extern(C) int sfetch_max_userdata_bytes() @system @nogc nothrow;
int maxUserdataBytes() @trusted @nogc nothrow {
    return sfetch_max_userdata_bytes();
}
extern(C) int sfetch_max_path() @system @nogc nothrow;
int maxPath() @trusted @nogc nothrow {
    return sfetch_max_path();
}
extern(C) Handle sfetch_send(const Request *) @system @nogc nothrow;
Handle send(scope ref Request request) @trusted @nogc nothrow {
    return sfetch_send(&request);
}
extern(C) bool sfetch_handle_valid(Handle) @system @nogc nothrow;
bool handleValid(Handle h) @trusted @nogc nothrow {
    return sfetch_handle_valid(h);
}
extern(C) void sfetch_dowork() @system @nogc nothrow;
void dowork() @trusted @nogc nothrow {
    sfetch_dowork();
}
extern(C) void sfetch_bind_buffer(Handle, Range) @system @nogc nothrow;
void bindBuffer(Handle h, Range buffer) @trusted @nogc nothrow {
    sfetch_bind_buffer(h, buffer);
}
extern(C) void* sfetch_unbind_buffer(Handle) @system @nogc nothrow;
scope void* unbindBuffer(Handle h) @trusted @nogc nothrow {
    return sfetch_unbind_buffer(h);
}
extern(C) void sfetch_cancel(Handle) @system @nogc nothrow;
void cancel(Handle h) @trusted @nogc nothrow {
    sfetch_cancel(h);
}
extern(C) void sfetch_pause(Handle) @system @nogc nothrow;
void pause(Handle h) @trusted @nogc nothrow {
    sfetch_pause(h);
}
extern(C) void sfetch_continue(Handle) @system @nogc nothrow;
void continueFetching(Handle h) @trusted @nogc nothrow {
    sfetch_continue(h);
}
