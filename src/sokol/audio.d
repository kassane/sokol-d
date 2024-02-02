// machine generated, do not edit

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
    Using_sles_backend,
    Sles_create_engine_failed,
    Sles_engine_get_engine_interface_failed,
    Sles_create_output_mix_failed,
    Sles_mixer_get_volume_interface_failed,
    Sles_engine_create_audio_player_failed,
    Sles_player_get_play_interface_failed,
    Sles_player_get_volume_interface_failed,
    Sles_player_get_bufferqueue_interface_failed,
    Coreaudio_new_output_failed,
    Coreaudio_allocate_buffer_failed,
    Coreaudio_start_failed,
    Backend_buffer_size_isnt_multiple_of_packet_size,
}
extern(C)
struct Logger {
    extern(C) void function(scope const(char)*, uint, uint, scope const(char)*, uint, scope const(char)*, void*) func;
    void* user_data;
}
extern(C)
struct Allocator {
    extern(C) void* function(size_t, void*) alloc_fn;
    extern(C) void function(void*, void*) free_fn;
    void* user_data;
}
extern(C)
struct Desc {
    int sample_rate = 0;
    int num_channels = 0;
    int buffer_frames = 0;
    int packet_frames = 0;
    int num_packets = 0;
    extern(C) void function(float *, int, int) stream_cb;
    extern(C) void function(float *, int, int, void*) stream_userdata_cb;
    void* user_data;
    Allocator allocator;
    Logger logger;
}
extern(C) void saudio_setup(const Desc *) @system @nogc nothrow;
void setup(ref Desc desc) @trusted @nogc nothrow {
    saudio_setup(&desc);
}
extern(C) void saudio_shutdown() @system @nogc nothrow;
void shutdown() @trusted @nogc nothrow {
    saudio_shutdown();
}
extern(C) bool saudio_isvalid() @system @nogc nothrow;
bool isvalid() @trusted @nogc nothrow {
    return saudio_isvalid();
}
extern(C) void* saudio_userdata() @system @nogc nothrow;
scope void* userdata() @trusted @nogc nothrow {
    return saudio_userdata();
}
extern(C) Desc saudio_query_desc() @system @nogc nothrow;
Desc queryDesc() @trusted @nogc nothrow {
    return saudio_query_desc();
}
extern(C) int saudio_sample_rate() @system @nogc nothrow;
int sampleRate() @trusted @nogc nothrow {
    return saudio_sample_rate();
}
extern(C) int saudio_buffer_frames() @system @nogc nothrow;
int bufferFrames() @trusted @nogc nothrow {
    return saudio_buffer_frames();
}
extern(C) int saudio_channels() @system @nogc nothrow;
int channels() @trusted @nogc nothrow {
    return saudio_channels();
}
extern(C) bool saudio_suspended() @system @nogc nothrow;
bool suspended() @trusted @nogc nothrow {
    return saudio_suspended();
}
extern(C) int saudio_expect() @system @nogc nothrow;
int expect() @trusted @nogc nothrow {
    return saudio_expect();
}
extern(C) int saudio_push(const float *, int) @system @nogc nothrow;
int push(const float * frames, int num_frames) @trusted @nogc nothrow {
    return saudio_push(frames, num_frames);
}
