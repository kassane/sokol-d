// machine generated, do not edit

extern(C):

// helper function to convert a C string to a D string
string cStrToDString(const(char*) c_str) {
    import std.conv: to;
    return c_str.to!string;
}
enum max_touchpoints = 8;
enum max_mousebuttons = 3;
enum max_keycodes = 512;
enum max_iconimages = 8;
enum EventType {
    INVALID,
    KEY_DOWN,
    KEY_UP,
    CHAR,
    MOUSE_DOWN,
    MOUSE_UP,
    MOUSE_SCROLL,
    MOUSE_MOVE,
    MOUSE_ENTER,
    MOUSE_LEAVE,
    TOUCHES_BEGAN,
    TOUCHES_MOVED,
    TOUCHES_ENDED,
    TOUCHES_CANCELLED,
    RESIZED,
    ICONIFIED,
    RESTORED,
    FOCUSED,
    UNFOCUSED,
    SUSPENDED,
    RESUMED,
    QUIT_REQUESTED,
    CLIPBOARD_PASTED,
    FILES_DROPPED,
    NUM,
};
enum Keycode {
    INVALID = 0,
    SPACE = 32,
    APOSTROPHE = 39,
    COMMA = 44,
    MINUS = 45,
    PERIOD = 46,
    SLASH = 47,
    _0 = 48,
    _1 = 49,
    _2 = 50,
    _3 = 51,
    _4 = 52,
    _5 = 53,
    _6 = 54,
    _7 = 55,
    _8 = 56,
    _9 = 57,
    SEMICOLON = 59,
    EQUAL = 61,
    A = 65,
    B = 66,
    C = 67,
    D = 68,
    E = 69,
    F = 70,
    G = 71,
    H = 72,
    I = 73,
    J = 74,
    K = 75,
    L = 76,
    M = 77,
    N = 78,
    O = 79,
    P = 80,
    Q = 81,
    R = 82,
    S = 83,
    T = 84,
    U = 85,
    V = 86,
    W = 87,
    X = 88,
    Y = 89,
    Z = 90,
    LEFT_BRACKET = 91,
    BACKSLASH = 92,
    RIGHT_BRACKET = 93,
    GRAVE_ACCENT = 96,
    WORLD_1 = 161,
    WORLD_2 = 162,
    ESCAPE = 256,
    ENTER = 257,
    TAB = 258,
    BACKSPACE = 259,
    INSERT = 260,
    DELETE = 261,
    RIGHT = 262,
    LEFT = 263,
    DOWN = 264,
    UP = 265,
    PAGE_UP = 266,
    PAGE_DOWN = 267,
    HOME = 268,
    END = 269,
    CAPS_LOCK = 280,
    SCROLL_LOCK = 281,
    NUM_LOCK = 282,
    PRINT_SCREEN = 283,
    PAUSE = 284,
    F1 = 290,
    F2 = 291,
    F3 = 292,
    F4 = 293,
    F5 = 294,
    F6 = 295,
    F7 = 296,
    F8 = 297,
    F9 = 298,
    F10 = 299,
    F11 = 300,
    F12 = 301,
    F13 = 302,
    F14 = 303,
    F15 = 304,
    F16 = 305,
    F17 = 306,
    F18 = 307,
    F19 = 308,
    F20 = 309,
    F21 = 310,
    F22 = 311,
    F23 = 312,
    F24 = 313,
    F25 = 314,
    KP_0 = 320,
    KP_1 = 321,
    KP_2 = 322,
    KP_3 = 323,
    KP_4 = 324,
    KP_5 = 325,
    KP_6 = 326,
    KP_7 = 327,
    KP_8 = 328,
    KP_9 = 329,
    KP_DECIMAL = 330,
    KP_DIVIDE = 331,
    KP_MULTIPLY = 332,
    KP_SUBTRACT = 333,
    KP_ADD = 334,
    KP_ENTER = 335,
    KP_EQUAL = 336,
    LEFT_SHIFT = 340,
    LEFT_CONTROL = 341,
    LEFT_ALT = 342,
    LEFT_SUPER = 343,
    RIGHT_SHIFT = 344,
    RIGHT_CONTROL = 345,
    RIGHT_ALT = 346,
    RIGHT_SUPER = 347,
    MENU = 348,
};
enum AndroidTooltype {
    UNKNOWN = 0,
    FINGER = 1,
    STYLUS = 2,
    MOUSE = 3,
};
struct Touchpoint {
    size_t identifier;
    float pos_x;
    float pos_y;
    AndroidTooltype android_tooltype;
    bool changed;
};
enum Mousebutton {
    LEFT = 0,
    RIGHT = 1,
    MIDDLE = 2,
    INVALID = 256,
};
enum modifier_shift = 1;
enum modifier_ctrl = 2;
enum modifier_alt = 4;
enum modifier_super = 8;
enum modifier_lmb = 256;
enum modifier_rmb = 512;
enum modifier_mmb = 1024;
struct Event {
    ulong frame_count;
    EventType type;
    Keycode key_code;
    uint char_code;
    bool key_repeat;
    uint modifiers;
    Mousebutton mouse_button;
    float mouse_x;
    float mouse_y;
    float mouse_dx;
    float mouse_dy;
    float scroll_x;
    float scroll_y;
    int num_touches;
    Touchpoint[8] touches;
    int window_width;
    int window_height;
    int framebuffer_width;
    int framebuffer_height;
};
struct Range {
    const void* ptr;
    size_t size;
};
struct ImageDesc {
    int width;
    int height;
    Range pixels;
};
struct IconDesc {
    bool sokol_default;
    ImageDesc[8] images;
};
struct Allocator {
    void* function(size_t, void*) alloc_fn;
    void function(void*, void*) free_fn;
    void* user_data;
};
enum LogItem {
    OK,
    MALLOC_FAILED,
    MACOS_INVALID_NSOPENGL_PROFILE,
    WIN32_LOAD_OPENGL32_DLL_FAILED,
    WIN32_CREATE_HELPER_WINDOW_FAILED,
    WIN32_HELPER_WINDOW_GETDC_FAILED,
    WIN32_DUMMY_CONTEXT_SET_PIXELFORMAT_FAILED,
    WIN32_CREATE_DUMMY_CONTEXT_FAILED,
    WIN32_DUMMY_CONTEXT_MAKE_CURRENT_FAILED,
    WIN32_GET_PIXELFORMAT_ATTRIB_FAILED,
    WIN32_WGL_FIND_PIXELFORMAT_FAILED,
    WIN32_WGL_DESCRIBE_PIXELFORMAT_FAILED,
    WIN32_WGL_SET_PIXELFORMAT_FAILED,
    WIN32_WGL_ARB_CREATE_CONTEXT_REQUIRED,
    WIN32_WGL_ARB_CREATE_CONTEXT_PROFILE_REQUIRED,
    WIN32_WGL_OPENGL_3_2_NOT_SUPPORTED,
    WIN32_WGL_OPENGL_PROFILE_NOT_SUPPORTED,
    WIN32_WGL_INCOMPATIBLE_DEVICE_CONTEXT,
    WIN32_WGL_CREATE_CONTEXT_ATTRIBS_FAILED_OTHER,
    WIN32_D3D11_CREATE_DEVICE_AND_SWAPCHAIN_WITH_DEBUG_FAILED,
    WIN32_D3D11_GET_IDXGIFACTORY_FAILED,
    WIN32_D3D11_GET_IDXGIADAPTER_FAILED,
    WIN32_D3D11_QUERY_INTERFACE_IDXGIDEVICE1_FAILED,
    WIN32_REGISTER_RAW_INPUT_DEVICES_FAILED_MOUSE_LOCK,
    WIN32_REGISTER_RAW_INPUT_DEVICES_FAILED_MOUSE_UNLOCK,
    WIN32_GET_RAW_INPUT_DATA_FAILED,
    LINUX_GLX_LOAD_LIBGL_FAILED,
    LINUX_GLX_LOAD_ENTRY_POINTS_FAILED,
    LINUX_GLX_EXTENSION_NOT_FOUND,
    LINUX_GLX_QUERY_VERSION_FAILED,
    LINUX_GLX_VERSION_TOO_LOW,
    LINUX_GLX_NO_GLXFBCONFIGS,
    LINUX_GLX_NO_SUITABLE_GLXFBCONFIG,
    LINUX_GLX_GET_VISUAL_FROM_FBCONFIG_FAILED,
    LINUX_GLX_REQUIRED_EXTENSIONS_MISSING,
    LINUX_GLX_CREATE_CONTEXT_FAILED,
    LINUX_GLX_CREATE_WINDOW_FAILED,
    LINUX_X11_CREATE_WINDOW_FAILED,
    LINUX_EGL_BIND_OPENGL_API_FAILED,
    LINUX_EGL_BIND_OPENGL_ES_API_FAILED,
    LINUX_EGL_GET_DISPLAY_FAILED,
    LINUX_EGL_INITIALIZE_FAILED,
    LINUX_EGL_NO_CONFIGS,
    LINUX_EGL_NO_NATIVE_VISUAL,
    LINUX_EGL_GET_VISUAL_INFO_FAILED,
    LINUX_EGL_CREATE_WINDOW_SURFACE_FAILED,
    LINUX_EGL_CREATE_CONTEXT_FAILED,
    LINUX_EGL_MAKE_CURRENT_FAILED,
    LINUX_X11_OPEN_DISPLAY_FAILED,
    LINUX_X11_QUERY_SYSTEM_DPI_FAILED,
    LINUX_X11_DROPPED_FILE_URI_WRONG_SCHEME,
    ANDROID_UNSUPPORTED_INPUT_EVENT_INPUT_CB,
    ANDROID_UNSUPPORTED_INPUT_EVENT_MAIN_CB,
    ANDROID_READ_MSG_FAILED,
    ANDROID_WRITE_MSG_FAILED,
    ANDROID_MSG_CREATE,
    ANDROID_MSG_RESUME,
    ANDROID_MSG_PAUSE,
    ANDROID_MSG_FOCUS,
    ANDROID_MSG_NO_FOCUS,
    ANDROID_MSG_SET_NATIVE_WINDOW,
    ANDROID_MSG_SET_INPUT_QUEUE,
    ANDROID_MSG_DESTROY,
    ANDROID_UNKNOWN_MSG,
    ANDROID_LOOP_THREAD_STARTED,
    ANDROID_LOOP_THREAD_DONE,
    ANDROID_NATIVE_ACTIVITY_ONSTART,
    ANDROID_NATIVE_ACTIVITY_ONRESUME,
    ANDROID_NATIVE_ACTIVITY_ONSAVEINSTANCESTATE,
    ANDROID_NATIVE_ACTIVITY_ONWINDOWFOCUSCHANGED,
    ANDROID_NATIVE_ACTIVITY_ONPAUSE,
    ANDROID_NATIVE_ACTIVITY_ONSTOP,
    ANDROID_NATIVE_ACTIVITY_ONNATIVEWINDOWCREATED,
    ANDROID_NATIVE_ACTIVITY_ONNATIVEWINDOWDESTROYED,
    ANDROID_NATIVE_ACTIVITY_ONINPUTQUEUECREATED,
    ANDROID_NATIVE_ACTIVITY_ONINPUTQUEUEDESTROYED,
    ANDROID_NATIVE_ACTIVITY_ONCONFIGURATIONCHANGED,
    ANDROID_NATIVE_ACTIVITY_ONLOWMEMORY,
    ANDROID_NATIVE_ACTIVITY_ONDESTROY,
    ANDROID_NATIVE_ACTIVITY_DONE,
    ANDROID_NATIVE_ACTIVITY_ONCREATE,
    ANDROID_CREATE_THREAD_PIPE_FAILED,
    ANDROID_NATIVE_ACTIVITY_CREATE_SUCCESS,
    WGPU_SWAPCHAIN_CREATE_SURFACE_FAILED,
    WGPU_SWAPCHAIN_CREATE_SWAPCHAIN_FAILED,
    WGPU_SWAPCHAIN_CREATE_DEPTH_STENCIL_TEXTURE_FAILED,
    WGPU_SWAPCHAIN_CREATE_DEPTH_STENCIL_VIEW_FAILED,
    WGPU_SWAPCHAIN_CREATE_MSAA_TEXTURE_FAILED,
    WGPU_SWAPCHAIN_CREATE_MSAA_VIEW_FAILED,
    WGPU_REQUEST_DEVICE_STATUS_ERROR,
    WGPU_REQUEST_DEVICE_STATUS_UNKNOWN,
    WGPU_REQUEST_ADAPTER_STATUS_UNAVAILABLE,
    WGPU_REQUEST_ADAPTER_STATUS_ERROR,
    WGPU_REQUEST_ADAPTER_STATUS_UNKNOWN,
    WGPU_CREATE_INSTANCE_FAILED,
    IMAGE_DATA_SIZE_MISMATCH,
    DROPPED_FILE_PATH_TOO_LONG,
    CLIPBOARD_STRING_TOO_BIG,
};
struct Logger {
    void function(const (char*), uint, uint, const (char*), uint, const (char*), void*) func;
    void* user_data;
};
struct Desc {
    void function() init_cb;
    void function() frame_cb;
    void function() cleanup_cb;
    void function(const Event *) event_cb;
    void* user_data;
    void function(void*) init_userdata_cb;
    void function(void*) frame_userdata_cb;
    void function(void*) cleanup_userdata_cb;
    void function(const Event *, void*) event_userdata_cb;
    int width;
    int height;
    int sample_count;
    int swap_interval;
    bool high_dpi;
    bool fullscreen;
    bool alpha;
    const (char*) window_title;
    bool enable_clipboard;
    int clipboard_size;
    bool enable_dragndrop;
    int max_dropped_files;
    int max_dropped_file_path_length;
    IconDesc icon;
    Allocator allocator;
    Logger logger;
    int gl_major_version;
    int gl_minor_version;
    bool win32_console_utf8;
    bool win32_console_create;
    bool win32_console_attach;
    const (char*) html5_canvas_name;
    bool html5_canvas_resize;
    bool html5_preserve_drawing_buffer;
    bool html5_premultiplied_alpha;
    bool html5_ask_leave_site;
    bool ios_keyboard_resizes_canvas;
};
enum Html5FetchError {
    FETCH_ERROR_NO_ERROR,
    FETCH_ERROR_BUFFER_TOO_SMALL,
    FETCH_ERROR_OTHER,
};
struct Html5FetchResponse {
    bool succeeded;
    Html5FetchError error_code;
    int file_index;
    Range data;
    Range buffer;
    void* user_data;
};
struct Html5FetchRequest {
    int dropped_file_index;
    void function(const Html5FetchResponse *) callback;
    Range buffer;
    void* user_data;
};
enum MouseCursor {
    DEFAULT = 0,
    ARROW,
    IBEAM,
    CROSSHAIR,
    POINTING_HAND,
    RESIZE_EW,
    RESIZE_NS,
    RESIZE_NWSE,
    RESIZE_NESW,
    RESIZE_ALL,
    NOT_ALLOWED,
    NUM,
};
bool sapp_isvalid();
bool isvalid() {
    return sapp_isvalid();
}
int sapp_width();
int width() {
    return sapp_width();
}
float sapp_widthf();
float widthf() {
    return sapp_widthf();
}
int sapp_height();
int height() {
    return sapp_height();
}
float sapp_heightf();
float heightf() {
    return sapp_heightf();
}
int sapp_color_format();
int colorFormat() {
    return sapp_color_format();
}
int sapp_depth_format();
int depthFormat() {
    return sapp_depth_format();
}
int sapp_sample_count();
int sampleCount() {
    return sapp_sample_count();
}
bool sapp_high_dpi();
bool highDpi() {
    return sapp_high_dpi();
}
float sapp_dpi_scale();
float dpiScale() {
    return sapp_dpi_scale();
}
void sapp_show_keyboard(bool);
void showKeyboard(bool show) {
    sapp_show_keyboard(show);
}
bool sapp_keyboard_shown();
bool keyboardShown() {
    return sapp_keyboard_shown();
}
bool sapp_is_fullscreen();
bool isFullscreen() {
    return sapp_is_fullscreen();
}
void sapp_toggle_fullscreen();
void toggleFullscreen() {
    sapp_toggle_fullscreen();
}
void sapp_show_mouse(bool);
void showMouse(bool show) {
    sapp_show_mouse(show);
}
bool sapp_mouse_shown();
bool mouseShown() {
    return sapp_mouse_shown();
}
void sapp_lock_mouse(bool);
void lockMouse(bool lock) {
    sapp_lock_mouse(lock);
}
bool sapp_mouse_locked();
bool mouseLocked() {
    return sapp_mouse_locked();
}
void sapp_set_mouse_cursor(MouseCursor);
void setMouseCursor(MouseCursor cursor) {
    sapp_set_mouse_cursor(cursor);
}
MouseCursor sapp_get_mouse_cursor();
MouseCursor getMouseCursor() {
    return sapp_get_mouse_cursor();
}
void* sapp_userdata();
void* userdata() {
    return sapp_userdata();
}
Desc sapp_query_desc();
Desc queryDesc() {
    return sapp_query_desc();
}
void sapp_request_quit();
void requestQuit() {
    sapp_request_quit();
}
void sapp_cancel_quit();
void cancelQuit() {
    sapp_cancel_quit();
}
void sapp_quit();
void quit() {
    sapp_quit();
}
void sapp_consume_event();
void consumeEvent() {
    sapp_consume_event();
}
ulong sapp_frame_count();
ulong frameCount() {
    return sapp_frame_count();
}
double sapp_frame_duration();
double frameDuration() {
    return sapp_frame_duration();
}
void sapp_set_clipboard_string(const (char*));
void setClipboardString(const (char*) str) {
    sapp_set_clipboard_string(str);
}
const (char*) sapp_get_clipboard_string();
const (char*) getClipboardString() {
    return cStrTod(sapp_get_clipboard_string());
}
void sapp_set_window_title(const (char*));
void setWindowTitle(const (char*) str) {
    sapp_set_window_title(str);
}
void sapp_set_icon(const IconDesc *);
void setIcon(IconDesc icon_desc) {
    sapp_set_icon(&icon_desc);
}
int sapp_get_num_dropped_files();
int getNumDroppedFiles() {
    return sapp_get_num_dropped_files();
}
const (char*) sapp_get_dropped_file_path(int);
const (char*) getDroppedFilePath(int index) {
    return cStrTod(sapp_get_dropped_file_path(index));
}
void sapp_run(const Desc *);
void run(Desc desc) {
    sapp_run(&desc);
}
const void* sapp_egl_get_display();
const void* eglGetDisplay() {
    return sapp_egl_get_display();
}
const void* sapp_egl_get_context();
const void* eglGetContext() {
    return sapp_egl_get_context();
}
void sapp_html5_ask_leave_site(bool);
void html5AskLeaveSite(bool ask) {
    sapp_html5_ask_leave_site(ask);
}
uint sapp_html5_get_dropped_file_size(int);
uint html5GetDroppedFileSize(int index) {
    return sapp_html5_get_dropped_file_size(index);
}
void sapp_html5_fetch_dropped_file(const Html5FetchRequest *);
void html5FetchDroppedFile(Html5FetchRequest request) {
    sapp_html5_fetch_dropped_file(&request);
}
const void* sapp_metal_get_device();
const void* metalGetDevice() {
    return sapp_metal_get_device();
}
const void* sapp_metal_get_renderpass_descriptor();
const void* metalGetRenderpassDescriptor() {
    return sapp_metal_get_renderpass_descriptor();
}
const void* sapp_metal_get_drawable();
const void* metalGetDrawable() {
    return sapp_metal_get_drawable();
}
const void* sapp_macos_get_window();
const void* macosGetWindow() {
    return sapp_macos_get_window();
}
const void* sapp_ios_get_window();
const void* iosGetWindow() {
    return sapp_ios_get_window();
}
const void* sapp_d3d11_get_device();
const void* d3d11GetDevice() {
    return sapp_d3d11_get_device();
}
const void* sapp_d3d11_get_device_context();
const void* d3d11GetDeviceContext() {
    return sapp_d3d11_get_device_context();
}
const void* sapp_d3d11_get_swap_chain();
const void* d3d11GetSwapChain() {
    return sapp_d3d11_get_swap_chain();
}
const void* sapp_d3d11_get_render_target_view();
const void* d3d11GetRenderTargetView() {
    return sapp_d3d11_get_render_target_view();
}
const void* sapp_d3d11_get_depth_stencil_view();
const void* d3d11GetDepthStencilView() {
    return sapp_d3d11_get_depth_stencil_view();
}
const void* sapp_win32_get_hwnd();
const void* win32GetHwnd() {
    return sapp_win32_get_hwnd();
}
const void* sapp_wgpu_get_device();
const void* wgpuGetDevice() {
    return sapp_wgpu_get_device();
}
const void* sapp_wgpu_get_render_view();
const void* wgpuGetRenderView() {
    return sapp_wgpu_get_render_view();
}
const void* sapp_wgpu_get_resolve_view();
const void* wgpuGetResolveView() {
    return sapp_wgpu_get_resolve_view();
}
const void* sapp_wgpu_get_depth_stencil_view();
const void* wgpuGetDepthStencilView() {
    return sapp_wgpu_get_depth_stencil_view();
}
const void* sapp_android_get_native_activity();
const void* androidGetNativeActivity() {
    return sapp_android_get_native_activity();
}
