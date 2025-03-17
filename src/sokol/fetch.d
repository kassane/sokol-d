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
/// sfetch_logger_t
/// 
/// Used in sfetch_desc_t to provide a custom logging and error reporting
/// callback to sokol-fetch.
extern(C)
struct Logger {
    extern(C) void function(const(char)*, uint, uint, const(char)*, uint, const(char)*, void*) func = null;
    void* user_data = null;
}
/// sfetch_range_t
/// 
/// A pointer-size pair struct to pass memory ranges into and out of sokol-fetch.
/// When initialized from a value type (array or struct) you can use the
/// SFETCH_RANGE() helper macro to build an sfetch_range_t struct.
extern(C)
struct Range {
    const(void)* ptr = null;
    size_t size = 0;
}
/// sfetch_allocator_t
/// 
/// Used in sfetch_desc_t to provide custom memory-alloc and -free functions
/// to sokol_fetch.h. If memory management should be overridden, both the
/// alloc and free function must be provided (e.g. it's not valid to
/// override one function but not the other).
extern(C)
struct Allocator {
    extern(C) void* function(size_t, void*) alloc_fn = null;
    extern(C) void function(void*, void*) free_fn = null;
    void* user_data = null;
}
/// configuration values for sfetch_setup()
extern(C)
struct Desc {
    uint max_requests = 0;
    uint num_channels = 0;
    uint num_lanes = 0;
    Allocator allocator;
    Logger logger;
}
/// a request handle to identify an active fetch request, returned by sfetch_send()
extern(C)
struct Handle {
    uint id = 0;
}
/// error codes
enum Error {
    No_error,
    File_not_found,
    No_buffer,
    Buffer_too_small,
    Unexpected_eof,
    Invalid_http_status,
    Cancelled,
    Js_other,
}
/// the response struct passed to the response callback
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
/// request parameters passed to sfetch_send()
extern(C)
struct Request {
    uint channel = 0;
    const(char)* path = null;
    extern(C) void function(const Response *) callback = null;
    uint chunk_size = 0;
    Range buffer;
    Range user_data;
}
/// setup sokol-fetch (can be called on multiple threads)
extern(C) void sfetch_setup(const Desc *) @system @nogc nothrow;
/// setup sokol-fetch (can be called on multiple threads)
void setup(scope ref Desc desc) @trusted @nogc nothrow {
    sfetch_setup(&desc);
}
/// discard a sokol-fetch context
extern(C) void sfetch_shutdown() @system @nogc nothrow;
/// discard a sokol-fetch context
void shutdown() @trusted @nogc nothrow {
    sfetch_shutdown();
}
/// return true if sokol-fetch has been setup
extern(C) bool sfetch_valid() @system @nogc nothrow;
/// return true if sokol-fetch has been setup
bool valid() @trusted @nogc nothrow {
    return sfetch_valid();
}
/// get the desc struct that was passed to sfetch_setup()
extern(C) Desc sfetch_desc() @system @nogc nothrow;
/// get the desc struct that was passed to sfetch_setup()
Desc desc() @trusted @nogc nothrow {
    return sfetch_desc();
}
/// return the max userdata size in number of bytes (SFETCH_MAX_USERDATA_UINT64 * sizeof(uint64_t))
extern(C) int sfetch_max_userdata_bytes() @system @nogc nothrow;
/// return the max userdata size in number of bytes (SFETCH_MAX_USERDATA_UINT64 * sizeof(uint64_t))
int maxUserdataBytes() @trusted @nogc nothrow {
    return sfetch_max_userdata_bytes();
}
/// return the value of the SFETCH_MAX_PATH implementation config value
extern(C) int sfetch_max_path() @system @nogc nothrow;
/// return the value of the SFETCH_MAX_PATH implementation config value
int maxPath() @trusted @nogc nothrow {
    return sfetch_max_path();
}
/// send a fetch-request, get handle to request back
extern(C) Handle sfetch_send(const Request *) @system @nogc nothrow;
/// send a fetch-request, get handle to request back
Handle send(scope ref Request request) @trusted @nogc nothrow {
    return sfetch_send(&request);
}
/// return true if a handle is valid *and* the request is alive
extern(C) bool sfetch_handle_valid(Handle) @system @nogc nothrow;
/// return true if a handle is valid *and* the request is alive
bool handleValid(Handle h) @trusted @nogc nothrow {
    return sfetch_handle_valid(h);
}
/// do per-frame work, moves requests into and out of IO threads, and invokes response-callbacks
extern(C) void sfetch_dowork() @system @nogc nothrow;
/// do per-frame work, moves requests into and out of IO threads, and invokes response-callbacks
void dowork() @trusted @nogc nothrow {
    sfetch_dowork();
}
/// bind a data buffer to a request (request must not currently have a buffer bound, must be called from response callback
extern(C) void sfetch_bind_buffer(Handle, Range) @system @nogc nothrow;
/// bind a data buffer to a request (request must not currently have a buffer bound, must be called from response callback
void bindBuffer(Handle h, Range buffer) @trusted @nogc nothrow {
    sfetch_bind_buffer(h, buffer);
}
/// clear the 'buffer binding' of a request, returns previous buffer pointer (can be 0), must be called from response callback
extern(C) void* sfetch_unbind_buffer(Handle) @system @nogc nothrow;
/// clear the 'buffer binding' of a request, returns previous buffer pointer (can be 0), must be called from response callback
scope void* unbindBuffer(Handle h) @trusted @nogc nothrow {
    return sfetch_unbind_buffer(h);
}
/// cancel a request that's in flight (will call response callback with .cancelled + .finished)
extern(C) void sfetch_cancel(Handle) @system @nogc nothrow;
/// cancel a request that's in flight (will call response callback with .cancelled + .finished)
void cancel(Handle h) @trusted @nogc nothrow {
    sfetch_cancel(h);
}
/// pause a request (will call response callback each frame with .paused)
extern(C) void sfetch_pause(Handle) @system @nogc nothrow;
/// pause a request (will call response callback each frame with .paused)
void pause(Handle h) @trusted @nogc nothrow {
    sfetch_pause(h);
}
/// continue a paused request
extern(C) void sfetch_continue(Handle) @system @nogc nothrow;
/// continue a paused request
void continueFetching(Handle h) @trusted @nogc nothrow {
    sfetch_continue(h);
}
