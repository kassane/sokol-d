// machine generated, do not edit

extern(C):

// helper function to convert a C string to a D string
string cStrToDString(const(char*) c_str) {
    import std.conv: to;
    return c_str.to!string;
}
enum LogItem {
    OK,
    MALLOC_FAILED,
    ALSA_SND_PCM_OPEN_FAILED,
    ALSA_FLOAT_SAMPLES_NOT_SUPPORTED,
    ALSA_REQUESTED_BUFFER_SIZE_NOT_SUPPORTED,
    ALSA_REQUESTED_CHANNEL_COUNT_NOT_SUPPORTED,
    ALSA_SND_PCM_HW_PARAMS_SET_RATE_NEAR_FAILED,
    ALSA_SND_PCM_HW_PARAMS_FAILED,
    ALSA_PTHREAD_CREATE_FAILED,
    WASAPI_CREATE_EVENT_FAILED,
    WASAPI_CREATE_DEVICE_ENUMERATOR_FAILED,
    WASAPI_GET_DEFAULT_AUDIO_ENDPOINT_FAILED,
    WASAPI_DEVICE_ACTIVATE_FAILED,
    WASAPI_AUDIO_CLIENT_INITIALIZE_FAILED,
    WASAPI_AUDIO_CLIENT_GET_BUFFER_SIZE_FAILED,
    WASAPI_AUDIO_CLIENT_GET_SERVICE_FAILED,
    WASAPI_AUDIO_CLIENT_SET_EVENT_HANDLE_FAILED,
    WASAPI_CREATE_THREAD_FAILED,
    AAUDIO_STREAMBUILDER_OPEN_STREAM_FAILED,
    AAUDIO_PTHREAD_CREATE_FAILED,
    AAUDIO_RESTARTING_STREAM_AFTER_ERROR,
    USING_AAUDIO_BACKEND,
    AAUDIO_CREATE_STREAMBUILDER_FAILED,
    USING_SLES_BACKEND,
    SLES_CREATE_ENGINE_FAILED,
    SLES_ENGINE_GET_ENGINE_INTERFACE_FAILED,
    SLES_CREATE_OUTPUT_MIX_FAILED,
    SLES_MIXER_GET_VOLUME_INTERFACE_FAILED,
    SLES_ENGINE_CREATE_AUDIO_PLAYER_FAILED,
    SLES_PLAYER_GET_PLAY_INTERFACE_FAILED,
    SLES_PLAYER_GET_VOLUME_INTERFACE_FAILED,
    SLES_PLAYER_GET_BUFFERQUEUE_INTERFACE_FAILED,
    COREAUDIO_NEW_OUTPUT_FAILED,
    COREAUDIO_ALLOCATE_BUFFER_FAILED,
    COREAUDIO_START_FAILED,
    BACKEND_BUFFER_SIZE_ISNT_MULTIPLE_OF_PACKET_SIZE,
}
struct Logger {
    void function(const (char*), uint, uint, const (char*), uint, const (char*), void*) func;
    void* user_data;
}
struct Allocator {
    void* function(size_t, void*) alloc_fn;
    void function(void*, void*) free_fn;
    void* user_data;
}
struct Desc {
    int sample_rate;
    int num_channels;
    int buffer_frames;
    int packet_frames;
    int num_packets;
    void function(float *, int, int) stream_cb;
    void function(float *, int, int, void*) stream_userdata_cb;
    void* user_data;
    Allocator allocator;
    Logger logger;
}
void saudio_setup(const Desc *);
void setup(Desc desc) {
    saudio_setup(&desc);
}
void saudio_shutdown();
void shutdown() {
    saudio_shutdown();
}
bool saudio_isvalid();
bool isvalid() {
    return saudio_isvalid();
}
void* saudio_userdata();
void* userdata() {
    return saudio_userdata();
}
Desc saudio_query_desc();
Desc queryDesc() {
    return saudio_query_desc();
}
int saudio_sample_rate();
int sampleRate() {
    return saudio_sample_rate();
}
int saudio_buffer_frames();
int bufferFrames() {
    return saudio_buffer_frames();
}
int saudio_channels();
int channels() {
    return saudio_channels();
}
bool saudio_suspended();
bool suspended() {
    return saudio_suspended();
}
int saudio_expect();
int expect() {
    return saudio_expect();
}
int saudio_push(const float *, int);
int push(const float * frames, int num_frames) {
    return saudio_push(frames, num_frames);
}
