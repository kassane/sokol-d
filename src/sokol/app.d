// machine generated, do not edit

module sokol.app;

enum max_touchpoints = 8;
enum max_mousebuttons = 3;
enum max_keycodes = 512;
enum max_iconimages = 8;
enum EventType {
    Invalid,
    Key_down,
    Key_up,
    Char,
    Mouse_down,
    Mouse_up,
    Mouse_scroll,
    Mouse_move,
    Mouse_enter,
    Mouse_leave,
    Touches_began,
    Touches_moved,
    Touches_ended,
    Touches_cancelled,
    Resized,
    Iconified,
    Restored,
    Focused,
    Unfocused,
    Suspended,
    Resumed,
    Quit_requested,
    Clipboard_pasted,
    Files_dropped,
    Num,
}
enum Keycode {
    Invalid = 0,
    Space = 32,
    Apostrophe = 39,
    Comma = 44,
    Minus = 45,
    Period = 46,
    Slash = 47,
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
    Semicolon = 59,
    Equal = 61,
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
    Left_bracket = 91,
    Backslash = 92,
    Right_bracket = 93,
    Grave_accent = 96,
    World_1 = 161,
    World_2 = 162,
    Escape = 256,
    Enter = 257,
    Tab = 258,
    Backspace = 259,
    Insert = 260,
    Delete = 261,
    Right = 262,
    Left = 263,
    Down = 264,
    Up = 265,
    Page_up = 266,
    Page_down = 267,
    Home = 268,
    End = 269,
    Caps_lock = 280,
    Scroll_lock = 281,
    Num_lock = 282,
    Print_screen = 283,
    Pause = 284,
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
    Kp_0 = 320,
    Kp_1 = 321,
    Kp_2 = 322,
    Kp_3 = 323,
    Kp_4 = 324,
    Kp_5 = 325,
    Kp_6 = 326,
    Kp_7 = 327,
    Kp_8 = 328,
    Kp_9 = 329,
    Kp_decimal = 330,
    Kp_divide = 331,
    Kp_multiply = 332,
    Kp_subtract = 333,
    Kp_add = 334,
    Kp_enter = 335,
    Kp_equal = 336,
    Left_shift = 340,
    Left_control = 341,
    Left_alt = 342,
    Left_super = 343,
    Right_shift = 344,
    Right_control = 345,
    Right_alt = 346,
    Right_super = 347,
    Menu = 348,
}
enum AndroidTooltype {
    Unknown = 0,
    Finger = 1,
    Stylus = 2,
    Mouse = 3,
}
extern(C)
struct Touchpoint {
    ulong identifier = 0;
    float pos_x = 0.0;
    float pos_y = 0.0;
    AndroidTooltype android_tooltype;
    bool changed = false;
}
enum Mousebutton {
    Left = 0,
    Right = 1,
    Middle = 2,
    Invalid = 256,
}
enum modifier_shift = 1;
enum modifier_ctrl = 2;
enum modifier_alt = 4;
enum modifier_super = 8;
enum modifier_lmb = 256;
enum modifier_rmb = 512;
enum modifier_mmb = 1024;
extern(C)
struct Event {
    ulong frame_count = 0;
    EventType type;
    Keycode key_code;
    uint char_code = 0;
    bool key_repeat = false;
    uint modifiers = 0;
    Mousebutton mouse_button;
    float mouse_x = 0.0;
    float mouse_y = 0.0;
    float mouse_dx = 0.0;
    float mouse_dy = 0.0;
    float scroll_x = 0.0;
    float scroll_y = 0.0;
    int num_touches = 0;
    Touchpoint[8] touches;
    int window_width = 0;
    int window_height = 0;
    int framebuffer_width = 0;
    int framebuffer_height = 0;
}
extern(C)
struct Range {
    const(void)* ptr = null;
    size_t size = 0;
}
extern(C)
struct ImageDesc {
    int width = 0;
    int height = 0;
    Range pixels;
}
extern(C)
struct IconDesc {
    bool sokol_default = false;
    ImageDesc[8] images;
}
extern(C)
struct Allocator {
    extern(C) void* function(size_t, void*) alloc_fn = null;
    extern(C) void function(void*, void*) free_fn = null;
    void* user_data = null;
}
enum LogItem {
    Ok,
    Malloc_failed,
    Macos_invalid_nsopengl_profile,
    Win32_load_opengl32_dll_failed,
    Win32_create_helper_window_failed,
    Win32_helper_window_getdc_failed,
    Win32_dummy_context_set_pixelformat_failed,
    Win32_create_dummy_context_failed,
    Win32_dummy_context_make_current_failed,
    Win32_get_pixelformat_attrib_failed,
    Win32_wgl_find_pixelformat_failed,
    Win32_wgl_describe_pixelformat_failed,
    Win32_wgl_set_pixelformat_failed,
    Win32_wgl_arb_create_context_required,
    Win32_wgl_arb_create_context_profile_required,
    Win32_wgl_opengl_3_2_not_supported,
    Win32_wgl_opengl_profile_not_supported,
    Win32_wgl_incompatible_device_context,
    Win32_wgl_create_context_attribs_failed_other,
    Win32_d3d11_create_device_and_swapchain_with_debug_failed,
    Win32_d3d11_get_idxgifactory_failed,
    Win32_d3d11_get_idxgiadapter_failed,
    Win32_d3d11_query_interface_idxgidevice1_failed,
    Win32_register_raw_input_devices_failed_mouse_lock,
    Win32_register_raw_input_devices_failed_mouse_unlock,
    Win32_get_raw_input_data_failed,
    Linux_glx_load_libgl_failed,
    Linux_glx_load_entry_points_failed,
    Linux_glx_extension_not_found,
    Linux_glx_query_version_failed,
    Linux_glx_version_too_low,
    Linux_glx_no_glxfbconfigs,
    Linux_glx_no_suitable_glxfbconfig,
    Linux_glx_get_visual_from_fbconfig_failed,
    Linux_glx_required_extensions_missing,
    Linux_glx_create_context_failed,
    Linux_glx_create_window_failed,
    Linux_x11_create_window_failed,
    Linux_egl_bind_opengl_api_failed,
    Linux_egl_bind_opengl_es_api_failed,
    Linux_egl_get_display_failed,
    Linux_egl_initialize_failed,
    Linux_egl_no_configs,
    Linux_egl_no_native_visual,
    Linux_egl_get_visual_info_failed,
    Linux_egl_create_window_surface_failed,
    Linux_egl_create_context_failed,
    Linux_egl_make_current_failed,
    Linux_x11_open_display_failed,
    Linux_x11_query_system_dpi_failed,
    Linux_x11_dropped_file_uri_wrong_scheme,
    Android_unsupported_input_event_input_cb,
    Android_unsupported_input_event_main_cb,
    Android_read_msg_failed,
    Android_write_msg_failed,
    Android_msg_create,
    Android_msg_resume,
    Android_msg_pause,
    Android_msg_focus,
    Android_msg_no_focus,
    Android_msg_set_native_window,
    Android_msg_set_input_queue,
    Android_msg_destroy,
    Android_unknown_msg,
    Android_loop_thread_started,
    Android_loop_thread_done,
    Android_native_activity_onstart,
    Android_native_activity_onresume,
    Android_native_activity_onsaveinstancestate,
    Android_native_activity_onwindowfocuschanged,
    Android_native_activity_onpause,
    Android_native_activity_onstop,
    Android_native_activity_onnativewindowcreated,
    Android_native_activity_onnativewindowdestroyed,
    Android_native_activity_oninputqueuecreated,
    Android_native_activity_oninputqueuedestroyed,
    Android_native_activity_onconfigurationchanged,
    Android_native_activity_onlowmemory,
    Android_native_activity_ondestroy,
    Android_native_activity_done,
    Android_native_activity_oncreate,
    Android_create_thread_pipe_failed,
    Android_native_activity_create_success,
    Wgpu_swapchain_create_surface_failed,
    Wgpu_swapchain_create_swapchain_failed,
    Wgpu_swapchain_create_depth_stencil_texture_failed,
    Wgpu_swapchain_create_depth_stencil_view_failed,
    Wgpu_swapchain_create_msaa_texture_failed,
    Wgpu_swapchain_create_msaa_view_failed,
    Wgpu_request_device_status_error,
    Wgpu_request_device_status_unknown,
    Wgpu_request_adapter_status_unavailable,
    Wgpu_request_adapter_status_error,
    Wgpu_request_adapter_status_unknown,
    Wgpu_create_instance_failed,
    Image_data_size_mismatch,
    Dropped_file_path_too_long,
    Clipboard_string_too_big,
}
extern(C)
struct Logger {
    extern(C) void function(scope const(char)*, uint, uint, scope const(char)*, uint, scope const(char)*, void*) func = null;
    void* user_data = null;
}
extern(C)
struct Desc {
    extern(C) void function() init_cb = null;
    extern(C) void function() frame_cb = null;
    extern(C) void function() cleanup_cb = null;
    extern(C) void function(const Event *) event_cb = null;
    void* user_data = null;
    extern(C) void function(void*) init_userdata_cb = null;
    extern(C) void function(void*) frame_userdata_cb = null;
    extern(C) void function(void*) cleanup_userdata_cb = null;
    extern(C) void function(const Event *, void*) event_userdata_cb = null;
    int width = 0;
    int height = 0;
    int sample_count = 0;
    int swap_interval = 0;
    bool high_dpi = false;
    bool fullscreen = false;
    bool alpha = false;
    const(char)* window_title = null;
    bool enable_clipboard = false;
    int clipboard_size = 0;
    bool enable_dragndrop = false;
    int max_dropped_files = 0;
    int max_dropped_file_path_length = 0;
    IconDesc icon;
    Allocator allocator;
    Logger logger;
    int gl_major_version = 0;
    int gl_minor_version = 0;
    bool win32_console_utf8 = false;
    bool win32_console_create = false;
    bool win32_console_attach = false;
    const(char)* html5_canvas_name = null;
    bool html5_canvas_resize = false;
    bool html5_preserve_drawing_buffer = false;
    bool html5_premultiplied_alpha = false;
    bool html5_ask_leave_site = false;
    bool html5_bubble_mouse_events = false;
    bool html5_bubble_touch_events = false;
    bool html5_bubble_wheel_events = false;
    bool html5_bubble_key_events = false;
    bool html5_bubble_char_events = false;
    bool ios_keyboard_resizes_canvas = false;
}
enum Html5FetchError {
    Fetch_error_no_error,
    Fetch_error_buffer_too_small,
    Fetch_error_other,
}
extern(C)
struct Html5FetchResponse {
    bool succeeded = false;
    Html5FetchError error_code;
    int file_index = 0;
    Range data;
    Range buffer;
    void* user_data = null;
}
extern(C)
struct Html5FetchRequest {
    int dropped_file_index = 0;
    extern(C) void function(const Html5FetchResponse *) callback = null;
    Range buffer;
    void* user_data = null;
}
enum MouseCursor {
    Default = 0,
    Arrow,
    Ibeam,
    Crosshair,
    Pointing_hand,
    Resize_ew,
    Resize_ns,
    Resize_nwse,
    Resize_nesw,
    Resize_all,
    Not_allowed,
    Num,
}
extern(C) bool sapp_isvalid() @system @nogc nothrow;
bool isvalid() @trusted @nogc nothrow {
    return sapp_isvalid();
}
extern(C) int sapp_width() @system @nogc nothrow;
int width() @trusted @nogc nothrow {
    return sapp_width();
}
extern(C) float sapp_widthf() @system @nogc nothrow;
float widthf() @trusted @nogc nothrow {
    return sapp_widthf();
}
extern(C) int sapp_height() @system @nogc nothrow;
int height() @trusted @nogc nothrow {
    return sapp_height();
}
extern(C) float sapp_heightf() @system @nogc nothrow;
float heightf() @trusted @nogc nothrow {
    return sapp_heightf();
}
extern(C) int sapp_color_format() @system @nogc nothrow;
int colorFormat() @trusted @nogc nothrow {
    return sapp_color_format();
}
extern(C) int sapp_depth_format() @system @nogc nothrow;
int depthFormat() @trusted @nogc nothrow {
    return sapp_depth_format();
}
extern(C) int sapp_sample_count() @system @nogc nothrow;
int sampleCount() @trusted @nogc nothrow {
    return sapp_sample_count();
}
extern(C) bool sapp_high_dpi() @system @nogc nothrow;
bool highDpi() @trusted @nogc nothrow {
    return sapp_high_dpi();
}
extern(C) float sapp_dpi_scale() @system @nogc nothrow;
float dpiScale() @trusted @nogc nothrow {
    return sapp_dpi_scale();
}
extern(C) void sapp_show_keyboard(bool) @system @nogc nothrow;
void showKeyboard(bool show) @trusted @nogc nothrow {
    sapp_show_keyboard(show);
}
extern(C) bool sapp_keyboard_shown() @system @nogc nothrow;
bool keyboardShown() @trusted @nogc nothrow {
    return sapp_keyboard_shown();
}
extern(C) bool sapp_is_fullscreen() @system @nogc nothrow;
bool isFullscreen() @trusted @nogc nothrow {
    return sapp_is_fullscreen();
}
extern(C) void sapp_toggle_fullscreen() @system @nogc nothrow;
void toggleFullscreen() @trusted @nogc nothrow {
    sapp_toggle_fullscreen();
}
extern(C) void sapp_show_mouse(bool) @system @nogc nothrow;
void showMouse(bool show) @trusted @nogc nothrow {
    sapp_show_mouse(show);
}
extern(C) bool sapp_mouse_shown() @system @nogc nothrow;
bool mouseShown() @trusted @nogc nothrow {
    return sapp_mouse_shown();
}
extern(C) void sapp_lock_mouse(bool) @system @nogc nothrow;
void lockMouse(bool lock) @trusted @nogc nothrow {
    sapp_lock_mouse(lock);
}
extern(C) bool sapp_mouse_locked() @system @nogc nothrow;
bool mouseLocked() @trusted @nogc nothrow {
    return sapp_mouse_locked();
}
extern(C) void sapp_set_mouse_cursor(MouseCursor) @system @nogc nothrow;
void setMouseCursor(MouseCursor cursor) @trusted @nogc nothrow {
    sapp_set_mouse_cursor(cursor);
}
extern(C) MouseCursor sapp_get_mouse_cursor() @system @nogc nothrow;
MouseCursor getMouseCursor() @trusted @nogc nothrow {
    return sapp_get_mouse_cursor();
}
extern(C) void* sapp_userdata() @system @nogc nothrow;
scope void* userdata() @trusted @nogc nothrow {
    return sapp_userdata();
}
extern(C) Desc sapp_query_desc() @system @nogc nothrow;
Desc queryDesc() @trusted @nogc nothrow {
    return sapp_query_desc();
}
extern(C) void sapp_request_quit() @system @nogc nothrow;
void requestQuit() @trusted @nogc nothrow {
    sapp_request_quit();
}
extern(C) void sapp_cancel_quit() @system @nogc nothrow;
void cancelQuit() @trusted @nogc nothrow {
    sapp_cancel_quit();
}
extern(C) void sapp_quit() @system @nogc nothrow;
void quit() @trusted @nogc nothrow {
    sapp_quit();
}
extern(C) void sapp_consume_event() @system @nogc nothrow;
void consumeEvent() @trusted @nogc nothrow {
    sapp_consume_event();
}
extern(C) ulong sapp_frame_count() @system @nogc nothrow;
ulong frameCount() @trusted @nogc nothrow {
    return sapp_frame_count();
}
extern(C) double sapp_frame_duration() @system @nogc nothrow;
double frameDuration() @trusted @nogc nothrow {
    return sapp_frame_duration();
}
extern(C) void sapp_set_clipboard_string(scope const(char)*) @system @nogc nothrow;
void setClipboardString(scope const(char)* str) @trusted @nogc nothrow {
    sapp_set_clipboard_string(str);
}
extern(C) scope const(char)* sapp_get_clipboard_string() @system @nogc nothrow;
scope const(char)* getClipboardString() @trusted @nogc nothrow {
    return sapp_get_clipboard_string();
}
extern(C) void sapp_set_window_title(scope const(char)*) @system @nogc nothrow;
void setWindowTitle(scope const(char)* str) @trusted @nogc nothrow {
    sapp_set_window_title(str);
}
extern(C) void sapp_set_icon(const IconDesc *) @system @nogc nothrow;
void setIcon(ref IconDesc icon_desc) @trusted @nogc nothrow {
    sapp_set_icon(&icon_desc);
}
extern(C) int sapp_get_num_dropped_files() @system @nogc nothrow;
int getNumDroppedFiles() @trusted @nogc nothrow {
    return sapp_get_num_dropped_files();
}
extern(C) scope const(char)* sapp_get_dropped_file_path(int) @system @nogc nothrow;
scope const(char)* getDroppedFilePath(int index) @trusted @nogc nothrow {
    return sapp_get_dropped_file_path(index);
}
extern(C) void sapp_run(const Desc *) @system @nogc nothrow;
void run(ref Desc desc) @trusted @nogc nothrow {
    sapp_run(&desc);
}
extern(C) scope const(void)* sapp_egl_get_display() @system @nogc nothrow;
scope const(void)* eglGetDisplay() @trusted @nogc nothrow {
    return sapp_egl_get_display();
}
extern(C) scope const(void)* sapp_egl_get_context() @system @nogc nothrow;
scope const(void)* eglGetContext() @trusted @nogc nothrow {
    return sapp_egl_get_context();
}
extern(C) void sapp_html5_ask_leave_site(bool) @system @nogc nothrow;
void html5AskLeaveSite(bool ask) @trusted @nogc nothrow {
    sapp_html5_ask_leave_site(ask);
}
extern(C) uint sapp_html5_get_dropped_file_size(int) @system @nogc nothrow;
uint html5GetDroppedFileSize(int index) @trusted @nogc nothrow {
    return sapp_html5_get_dropped_file_size(index);
}
extern(C) void sapp_html5_fetch_dropped_file(const Html5FetchRequest *) @system @nogc nothrow;
void html5FetchDroppedFile(ref Html5FetchRequest request) @trusted @nogc nothrow {
    sapp_html5_fetch_dropped_file(&request);
}
extern(C) scope const(void)* sapp_metal_get_device() @system @nogc nothrow;
scope const(void)* metalGetDevice() @trusted @nogc nothrow {
    return sapp_metal_get_device();
}
extern(C) scope const(void)* sapp_metal_get_renderpass_descriptor() @system @nogc nothrow;
scope const(void)* metalGetRenderpassDescriptor() @trusted @nogc nothrow {
    return sapp_metal_get_renderpass_descriptor();
}
extern(C) scope const(void)* sapp_metal_get_drawable() @system @nogc nothrow;
scope const(void)* metalGetDrawable() @trusted @nogc nothrow {
    return sapp_metal_get_drawable();
}
extern(C) scope const(void)* sapp_macos_get_window() @system @nogc nothrow;
scope const(void)* macosGetWindow() @trusted @nogc nothrow {
    return sapp_macos_get_window();
}
extern(C) scope const(void)* sapp_ios_get_window() @system @nogc nothrow;
scope const(void)* iosGetWindow() @trusted @nogc nothrow {
    return sapp_ios_get_window();
}
extern(C) scope const(void)* sapp_d3d11_get_device() @system @nogc nothrow;
scope const(void)* d3d11GetDevice() @trusted @nogc nothrow {
    return sapp_d3d11_get_device();
}
extern(C) scope const(void)* sapp_d3d11_get_device_context() @system @nogc nothrow;
scope const(void)* d3d11GetDeviceContext() @trusted @nogc nothrow {
    return sapp_d3d11_get_device_context();
}
extern(C) scope const(void)* sapp_d3d11_get_swap_chain() @system @nogc nothrow;
scope const(void)* d3d11GetSwapChain() @trusted @nogc nothrow {
    return sapp_d3d11_get_swap_chain();
}
extern(C) scope const(void)* sapp_d3d11_get_render_target_view() @system @nogc nothrow;
scope const(void)* d3d11GetRenderTargetView() @trusted @nogc nothrow {
    return sapp_d3d11_get_render_target_view();
}
extern(C) scope const(void)* sapp_d3d11_get_depth_stencil_view() @system @nogc nothrow;
scope const(void)* d3d11GetDepthStencilView() @trusted @nogc nothrow {
    return sapp_d3d11_get_depth_stencil_view();
}
extern(C) scope const(void)* sapp_win32_get_hwnd() @system @nogc nothrow;
scope const(void)* win32GetHwnd() @trusted @nogc nothrow {
    return sapp_win32_get_hwnd();
}
extern(C) scope const(void)* sapp_wgpu_get_device() @system @nogc nothrow;
scope const(void)* wgpuGetDevice() @trusted @nogc nothrow {
    return sapp_wgpu_get_device();
}
extern(C) scope const(void)* sapp_wgpu_get_render_view() @system @nogc nothrow;
scope const(void)* wgpuGetRenderView() @trusted @nogc nothrow {
    return sapp_wgpu_get_render_view();
}
extern(C) scope const(void)* sapp_wgpu_get_resolve_view() @system @nogc nothrow;
scope const(void)* wgpuGetResolveView() @trusted @nogc nothrow {
    return sapp_wgpu_get_resolve_view();
}
extern(C) scope const(void)* sapp_wgpu_get_depth_stencil_view() @system @nogc nothrow;
scope const(void)* wgpuGetDepthStencilView() @trusted @nogc nothrow {
    return sapp_wgpu_get_depth_stencil_view();
}
extern(C) scope const(void)* sapp_android_get_native_activity() @system @nogc nothrow;
scope const(void)* androidGetNativeActivity() @trusted @nogc nothrow {
    return sapp_android_get_native_activity();
}
