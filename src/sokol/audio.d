/++
+ Machine generated D bindings for Sokol library.
+ 
+     Generated on: 2025-08-13 15:30:42
+ 
+     Source header: sokol_audio.h
+     Module: sokol.audio
+ 
+     Do not edit manually; regenerate using gen_d.py.
+/
module sokol.audio;

enum LogItem {
    Ok,
    Malloc_failed,
    Alsa_snd_pcm_open_failed,
    Alsa_float_samples_not_supported,
    Alsa_requested_buffer_size_not_supported,
    Alsa_requested_channel_count_not_supported,
    Alsa_snd_pcm_hw_params_set_rate_near_failed,
    Alsa_snd_pcm_hw_params_failed,
    Alsa_pthread_create_failed,
    Wasapi_create_event_failed,
    Wasapi_create_device_enumerator_failed,
    Wasapi_get_default_audio_endpoint_failed,
    Wasapi_device_activate_failed,
    Wasapi_audio_client_initialize_failed,
    Wasapi_audio_client_get_buffer_size_failed,
    Wasapi_audio_client_get_service_failed,
    Wasapi_audio_client_set_event_handle_failed,
    Wasapi_create_thread_failed,
    Aaudio_streambuilder_open_stream_failed,
    Aaudio_pthread_create_failed,
    Aaudio_restarting_stream_after_error,
    Using_aaudio_backend,
    Aaudio_create_streambuilder_failed,
    Coreaudio_new_output_failed,
    Coreaudio_allocate_buffer_failed,
    Coreaudio_start_failed,
    Backend_buffer_size_isnt_multiple_of_packet_size,
}
/++
+ saudio_logger
+ 
+     Used in saudio_desc to provide a custom logging and error reporting
+     callback to sokol-audio.
+/
extern(C) struct Logger {
    extern(C) void function(const(char)*, uint, uint, const(char)*, uint, const(char)*, void*) func = null;
    void* user_data = null;
}
/++
+ saudio_allocator
+ 
+     Used in saudio_desc to provide custom memory-alloc and -free functions
+     to sokol_audio.h. If memory management should be overridden, both the
+     alloc_fn and free_fn function must be provided (e.g. it's not valid to
+     override one function but not the other).
+/
extern(C) struct Allocator {
    extern(C) void* function(size_t, void*) alloc_fn = null;
    extern(C) void function(void*, void*) free_fn = null;
    void* user_data = null;
}
extern(C) struct Desc {
    int sample_rate = 0;
    int num_channels = 0;
    int buffer_frames = 0;
    int packet_frames = 0;
    int num_packets = 0;
    extern(C) void function(float*, int, int) stream_cb = null;
    extern(C) void function(float*, int, int, void*) stream_userdata_cb = null;
    void* user_data = null;
    Allocator allocator = {};
    Logger logger = {};
}
/++
+ setup sokol-audio
+/
extern(C) void saudio_setup(const Desc* desc) @system @nogc nothrow pure;
void setup(scope ref Desc desc) @trusted @nogc nothrow pure {
    saudio_setup(&desc);
}
/++
+ shutdown sokol-audio
+/
extern(C) void saudio_shutdown() @system @nogc nothrow pure;
void shutdown() @trusted @nogc nothrow pure {
    saudio_shutdown();
}
/++
+ true after setup if audio backend was successfully initialized
+/
extern(C) bool saudio_isvalid() @system @nogc nothrow pure;
bool isvalid() @trusted @nogc nothrow pure {
    return saudio_isvalid();
}
/++
+ return the saudio_desc.user_data pointer
+/
extern(C) void* saudio_userdata() @system @nogc nothrow pure;
void* userdata() @trusted @nogc nothrow pure {
    return saudio_userdata();
}
/++
+ return a copy of the original saudio_desc struct
+/
extern(C) Desc saudio_query_desc() @system @nogc nothrow pure;
Desc queryDesc() @trusted @nogc nothrow pure {
    return saudio_query_desc();
}
/++
+ actual sample rate
+/
extern(C) int saudio_sample_rate() @system @nogc nothrow pure;
int sampleRate() @trusted @nogc nothrow pure {
    return saudio_sample_rate();
}
/++
+ return actual backend buffer size in number of frames
+/
extern(C) int saudio_buffer_frames() @system @nogc nothrow pure;
int bufferFrames() @trusted @nogc nothrow pure {
    return saudio_buffer_frames();
}
/++
+ actual number of channels
+/
extern(C) int saudio_channels() @system @nogc nothrow pure;
int channels() @trusted @nogc nothrow pure {
    return saudio_channels();
}
/++
+ return true if audio context is currently suspended (only in WebAudio backend, all other backends return false)
+/
extern(C) bool saudio_suspended() @system @nogc nothrow pure;
bool suspended() @trusted @nogc nothrow pure {
    return saudio_suspended();
}
/++
+ get current number of frames to fill packet queue
+/
extern(C) int saudio_expect() @system @nogc nothrow pure;
int expect() @trusted @nogc nothrow pure {
    return saudio_expect();
}
/++
+ push sample frames from main thread, returns number of frames actually pushed
+/
extern(C) int saudio_push(const float* frames, int num_frames) @system @nogc nothrow pure;
int push(const float* frames, int num_frames) @trusted @nogc nothrow pure {
    return saudio_push(frames, num_frames);
}
