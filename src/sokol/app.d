/++
+ Machine generated D bindings for Sokol library.
+ 
+     Generated on: 2025-06-30 14:41:18
+ 
+     Source header: sokol_app.h
+     Module: sokol.app
+ 
+     Do not edit manually; regenerate using gen_d.py.
+/
module sokol.app;

/++
+ misc constants
+/
enum max_touchpoints = 8;
enum max_mousebuttons = 3;
enum max_keycodes = 512;
enum max_iconimages = 8;
/++
+ sapp_event_type
+ 
+     The type of event that's passed to the event handler callback
+     in the sapp_event.type field. These are not just "traditional"
+     input events, but also notify the application about state changes
+     or other user-invoked actions.
+/
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
/++
+ sapp_keycode
+ 
+     The 'virtual keycode' of a KEY_DOWN or KEY_UP event in the
+     struct field sapp_event.key_code.
+ 
+     Note that the keycode values are identical with GLFW.
+/
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
/++
+ Android specific 'tool type' enum for touch events. This lets the
+     application check what type of input device was used for
+     touch events.
+ 
+     NOTE: the values must remain in sync with the corresponding
+     Android SDK type, so don't change those.
+ 
+     See https://developer.android.com/reference/android/view/MotionEvent#TOOL_TYPE_UNKNOWN
+/
enum AndroidTooltype {
    Unknown = 0,
    Finger = 1,
    Stylus = 2,
    Mouse = 3,
}
/++
+ sapp_touchpoint
+ 
+     Describes a single touchpoint in a multitouch event (TOUCHES_BEGAN,
+     TOUCHES_MOVED, TOUCHES_ENDED).
+ 
+     Touch points are stored in the nested array sapp_event.touches[],
+     and the number of touches is stored in sapp_event.num_touches.
+/
extern(C) struct Touchpoint {
    ulong identifier = 0;
    float pos_x = 0.0f;
    float pos_y = 0.0f;
    AndroidTooltype android_tooltype = AndroidTooltype.Unknown;
    bool changed = false;
}
/++
+ sapp_mousebutton
+ 
+     The currently pressed mouse button in the events MOUSE_DOWN
+     and MOUSE_UP, stored in the struct field sapp_event.mouse_button.
+/
enum Mousebutton {
    Left = 0,
    Right = 1,
    Middle = 2,
    Invalid = 256,
}
/++
+ These are currently pressed modifier keys (and mouse buttons) which are
+     passed in the event struct field sapp_event.modifiers.
+/
enum modifier_shift = 1;
enum modifier_ctrl = 2;
enum modifier_alt = 4;
enum modifier_super = 8;
enum modifier_lmb = 256;
enum modifier_rmb = 512;
enum modifier_mmb = 1024;
/++
+ sapp_event
+ 
+     This is an all-in-one event struct passed to the event handler
+     user callback function. Note that it depends on the event
+     type what struct fields actually contain useful values, so you
+     should first check the event type before reading other struct
+     fields.
+/
extern(C) struct Event {
    ulong frame_count = 0;
    EventType type = EventType.Invalid;
    Keycode key_code = Keycode.Invalid;
    uint char_code = 0;
    bool key_repeat = false;
    uint modifiers = 0;
    Mousebutton mouse_button = Mousebutton.Left;
    float mouse_x = 0.0f;
    float mouse_y = 0.0f;
    float mouse_dx = 0.0f;
    float mouse_dy = 0.0f;
    float scroll_x = 0.0f;
    float scroll_y = 0.0f;
    int num_touches = 0;
    Touchpoint[8] touches = [];
    int window_width = 0;
    int window_height = 0;
    int framebuffer_width = 0;
    int framebuffer_height = 0;
}
/++
+ sg_range
+ 
+     A general pointer/size-pair struct and constructor macros for passing binary blobs
+     into sokol_app.h.
+/
extern(C) struct Range {
    const(void)* ptr = null;
    size_t size = 0;
}
/++
+ sapp_image_desc
+ 
+     This is used to describe image data to sokol_app.h (at first, window
+     icons, later maybe cursor images).
+ 
+     Note that the actual image pixel format depends on the use case:
+ 
+     - window icon pixels are RGBA8
+/
extern(C) struct ImageDesc {
    int width = 0;
    int height = 0;
    Range pixels = {};
}
/++
+ sapp_icon_desc
+ 
+     An icon description structure for use in sapp_desc.icon and
+     sapp_set_icon().
+ 
+     When setting a custom image, the application can provide a number of
+     candidates differing in size, and sokol_app.h will pick the image(s)
+     closest to the size expected by the platform's window system.
+ 
+     To set sokol-app's default icon, set .sokol_default to true.
+ 
+     Otherwise provide candidate images of different sizes in the
+     images[] array.
+ 
+     If both the sokol_default flag is set to true, any image candidates
+     will be ignored and the sokol_app.h default icon will be set.
+/
extern(C) struct IconDesc {
    bool sokol_default = false;
    ImageDesc[8] images = [];
}
/++
+ sapp_allocator
+ 
+     Used in sapp_desc to provide custom memory-alloc and -free functions
+     to sokol_app.h. If memory management should be overridden, both the
+     alloc_fn and free_fn function must be provided (e.g. it's not valid to
+     override one function but not the other).
+/
extern(C) struct Allocator {
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
    Win32_wgl_opengl_version_not_supported,
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
    Linux_x11_failed_to_become_owner_of_clipboard,
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
    Wgpu_swapchain_surface_get_capabilities_failed,
    Wgpu_swapchain_create_depth_stencil_texture_failed,
    Wgpu_swapchain_create_depth_stencil_view_failed,
    Wgpu_swapchain_create_msaa_texture_failed,
    Wgpu_swapchain_create_msaa_view_failed,
    Wgpu_swapchain_getcurrenttexture_failed,
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
/++
+ sapp_logger
+ 
+     Used in sapp_desc to provide a logging function. Please be aware that
+     without logging function, sokol-app will be completely silent, e.g. it will
+     not report errors or warnings. For maximum error verbosity, compile in
+     debug mode (e.g. NDEBUG *not* defined) and install a logger (for instance
+     the standard logging function from sokol_log.h).
+/
extern(C) struct Logger {
    extern(C) void function(const(char)*, uint, uint, const(char)*, uint, const(char)*, void*) func = null;
    void* user_data = null;
}
/++
+ sokol-app initialization options, used as return value of sokol_main()
+     or sapp_run() argument.
+/
extern(C) struct Desc {
    extern(C) void function() init_cb = null;
    extern(C) void function() frame_cb = null;
    extern(C) void function() cleanup_cb = null;
    extern(C) void function(const Event*) event_cb = null;
    void* user_data = null;
    extern(C) void function(void*) init_userdata_cb = null;
    extern(C) void function(void*) frame_userdata_cb = null;
    extern(C) void function(void*) cleanup_userdata_cb = null;
    extern(C) void function(const Event*, void*) event_userdata_cb = null;
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
    IconDesc icon = {};
    Allocator allocator = {};
    Logger logger = {};
    int gl_major_version = 0;
    int gl_minor_version = 0;
    bool win32_console_utf8 = false;
    bool win32_console_create = false;
    bool win32_console_attach = false;
    const(char)* html5_canvas_selector = null;
    bool html5_canvas_resize = false;
    bool html5_preserve_drawing_buffer = false;
    bool html5_premultiplied_alpha = false;
    bool html5_ask_leave_site = false;
    bool html5_update_document_title = false;
    bool html5_bubble_mouse_events = false;
    bool html5_bubble_touch_events = false;
    bool html5_bubble_wheel_events = false;
    bool html5_bubble_key_events = false;
    bool html5_bubble_char_events = false;
    bool html5_use_emsc_set_main_loop = false;
    bool html5_emsc_set_main_loop_simulate_infinite_loop = false;
    bool ios_keyboard_resizes_canvas = false;
}
/++
+ HTML5 specific: request and response structs for
+    asynchronously loading dropped-file content.
+/
enum Html5FetchError {
    Fetch_error_no_error,
    Fetch_error_buffer_too_small,
    Fetch_error_other,
}
extern(C) struct Html5FetchResponse {
    bool succeeded = false;
    Html5FetchError error_code = Html5FetchError.Fetch_error_no_error;
    int file_index = 0;
    Range data = {};
    Range buffer = {};
    void* user_data = null;
}
extern(C) struct Html5FetchRequest {
    int dropped_file_index = 0;
    extern(C) void function(const Html5FetchResponse*) callback = null;
    Range buffer = {};
    void* user_data = null;
}
/++
+ sapp_mouse_cursor
+ 
+     Predefined cursor image definitions, set with sapp_set_mouse_cursor(sapp_mouse_cursor cursor)
+/
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
/++
+ returns true after sokol-app has been initialized
+/
extern(C) bool sapp_isvalid() @system @nogc nothrow pure;
bool isvalid() @trusted @nogc nothrow pure {
    return sapp_isvalid();
}
/++
+ returns the current framebuffer width in pixels
+/
extern(C) int sapp_width() @system @nogc nothrow pure;
int width() @trusted @nogc nothrow pure {
    return sapp_width();
}
/++
+ same as sapp_width(), but returns float
+/
extern(C) float sapp_widthf() @system @nogc nothrow pure;
float widthf() @trusted @nogc nothrow pure {
    return sapp_widthf();
}
/++
+ returns the current framebuffer height in pixels
+/
extern(C) int sapp_height() @system @nogc nothrow pure;
int height() @trusted @nogc nothrow pure {
    return sapp_height();
}
/++
+ same as sapp_height(), but returns float
+/
extern(C) float sapp_heightf() @system @nogc nothrow pure;
float heightf() @trusted @nogc nothrow pure {
    return sapp_heightf();
}
/++
+ get default framebuffer color pixel format
+/
extern(C) int sapp_color_format() @system @nogc nothrow pure;
int colorFormat() @trusted @nogc nothrow pure {
    return sapp_color_format();
}
/++
+ get default framebuffer depth pixel format
+/
extern(C) int sapp_depth_format() @system @nogc nothrow pure;
int depthFormat() @trusted @nogc nothrow pure {
    return sapp_depth_format();
}
/++
+ get default framebuffer sample count
+/
extern(C) int sapp_sample_count() @system @nogc nothrow pure;
int sampleCount() @trusted @nogc nothrow pure {
    return sapp_sample_count();
}
/++
+ returns true when high_dpi was requested and actually running in a high-dpi scenario
+/
extern(C) bool sapp_high_dpi() @system @nogc nothrow pure;
bool highDpi() @trusted @nogc nothrow pure {
    return sapp_high_dpi();
}
/++
+ returns the dpi scaling factor (window pixels to framebuffer pixels)
+/
extern(C) float sapp_dpi_scale() @system @nogc nothrow pure;
float dpiScale() @trusted @nogc nothrow pure {
    return sapp_dpi_scale();
}
/++
+ show or hide the mobile device onscreen keyboard
+/
extern(C) void sapp_show_keyboard(bool show) @system @nogc nothrow pure;
void showKeyboard(bool show) @trusted @nogc nothrow pure {
    sapp_show_keyboard(show);
}
/++
+ return true if the mobile device onscreen keyboard is currently shown
+/
extern(C) bool sapp_keyboard_shown() @system @nogc nothrow pure;
bool keyboardShown() @trusted @nogc nothrow pure {
    return sapp_keyboard_shown();
}
/++
+ query fullscreen mode
+/
extern(C) bool sapp_is_fullscreen() @system @nogc nothrow pure;
bool isFullscreen() @trusted @nogc nothrow pure {
    return sapp_is_fullscreen();
}
/++
+ toggle fullscreen mode
+/
extern(C) void sapp_toggle_fullscreen() @system @nogc nothrow pure;
void toggleFullscreen() @trusted @nogc nothrow pure {
    sapp_toggle_fullscreen();
}
/++
+ show or hide the mouse cursor
+/
extern(C) void sapp_show_mouse(bool show) @system @nogc nothrow pure;
void showMouse(bool show) @trusted @nogc nothrow pure {
    sapp_show_mouse(show);
}
/++
+ show or hide the mouse cursor
+/
extern(C) bool sapp_mouse_shown() @system @nogc nothrow pure;
bool mouseShown() @trusted @nogc nothrow pure {
    return sapp_mouse_shown();
}
/++
+ enable/disable mouse-pointer-lock mode
+/
extern(C) void sapp_lock_mouse(bool lock) @system @nogc nothrow pure;
void lockMouse(bool lock) @trusted @nogc nothrow pure {
    sapp_lock_mouse(lock);
}
/++
+ return true if in mouse-pointer-lock mode (this may toggle a few frames later)
+/
extern(C) bool sapp_mouse_locked() @system @nogc nothrow pure;
bool mouseLocked() @trusted @nogc nothrow pure {
    return sapp_mouse_locked();
}
/++
+ set mouse cursor type
+/
extern(C) void sapp_set_mouse_cursor(MouseCursor cursor) @system @nogc nothrow pure;
void setMouseCursor(MouseCursor cursor) @trusted @nogc nothrow pure {
    sapp_set_mouse_cursor(cursor);
}
/++
+ get current mouse cursor type
+/
extern(C) MouseCursor sapp_get_mouse_cursor() @system @nogc nothrow pure;
MouseCursor getMouseCursor() @trusted @nogc nothrow pure {
    return sapp_get_mouse_cursor();
}
/++
+ return the userdata pointer optionally provided in sapp_desc
+/
extern(C) void* sapp_userdata() @system @nogc nothrow pure;
void* userdata() @trusted @nogc nothrow pure {
    return sapp_userdata();
}
/++
+ return a copy of the sapp_desc structure
+/
extern(C) Desc sapp_query_desc() @system @nogc nothrow pure;
Desc queryDesc() @trusted @nogc nothrow pure {
    return sapp_query_desc();
}
/++
+ initiate a "soft quit" (sends SAPP_EVENTTYPE_QUIT_REQUESTED)
+/
extern(C) void sapp_request_quit() @system @nogc nothrow pure;
void requestQuit() @trusted @nogc nothrow pure {
    sapp_request_quit();
}
/++
+ cancel a pending quit (when SAPP_EVENTTYPE_QUIT_REQUESTED has been received)
+/
extern(C) void sapp_cancel_quit() @system @nogc nothrow pure;
void cancelQuit() @trusted @nogc nothrow pure {
    sapp_cancel_quit();
}
/++
+ initiate a "hard quit" (quit application without sending SAPP_EVENTTYPE_QUIT_REQUESTED)
+/
extern(C) void sapp_quit() @system @nogc nothrow pure;
void quit() @trusted @nogc nothrow pure {
    sapp_quit();
}
/++
+ call from inside event callback to consume the current event (don't forward to platform)
+/
extern(C) void sapp_consume_event() @system @nogc nothrow pure;
void consumeEvent() @trusted @nogc nothrow pure {
    sapp_consume_event();
}
/++
+ get the current frame counter (for comparison with sapp_event.frame_count)
+/
extern(C) ulong sapp_frame_count() @system @nogc nothrow pure;
ulong frameCount() @trusted @nogc nothrow pure {
    return sapp_frame_count();
}
/++
+ get an averaged/smoothed frame duration in seconds
+/
extern(C) double sapp_frame_duration() @system @nogc nothrow pure;
double frameDuration() @trusted @nogc nothrow pure {
    return sapp_frame_duration();
}
/++
+ write string into clipboard
+/
extern(C) void sapp_set_clipboard_string(const(char)* str) @system @nogc nothrow pure;
void setClipboardString(const(char)* str) @trusted @nogc nothrow pure {
    sapp_set_clipboard_string(str);
}
/++
+ read string from clipboard (usually during SAPP_EVENTTYPE_CLIPBOARD_PASTED)
+/
extern(C) const(char)* sapp_get_clipboard_string() @system @nogc nothrow pure;
const(char)* getClipboardString() @trusted @nogc nothrow pure {
    return sapp_get_clipboard_string();
}
/++
+ set the window title (only on desktop platforms)
+/
extern(C) void sapp_set_window_title(const(char)* str) @system @nogc nothrow pure;
void setWindowTitle(const(char)* str) @trusted @nogc nothrow pure {
    sapp_set_window_title(str);
}
/++
+ set the window icon (only on Windows and Linux)
+/
extern(C) void sapp_set_icon(const IconDesc* icon_desc) @system @nogc nothrow pure;
void setIcon(scope ref IconDesc icon_desc) @trusted @nogc nothrow pure {
    sapp_set_icon(&icon_desc);
}
/++
+ gets the total number of dropped files (after an SAPP_EVENTTYPE_FILES_DROPPED event)
+/
extern(C) int sapp_get_num_dropped_files() @system @nogc nothrow pure;
int getNumDroppedFiles() @trusted @nogc nothrow pure {
    return sapp_get_num_dropped_files();
}
/++
+ gets the dropped file paths
+/
extern(C) const(char)* sapp_get_dropped_file_path(int index) @system @nogc nothrow pure;
const(char)* getDroppedFilePath(int index) @trusted @nogc nothrow pure {
    return sapp_get_dropped_file_path(index);
}
/++
+ special run-function for SOKOL_NO_ENTRY (in standard mode this is an empty stub)
+/
extern(C) void sapp_run(const Desc* desc) @system @nogc nothrow pure;
void run(scope ref Desc desc) @trusted @nogc nothrow pure {
    sapp_run(&desc);
}
/++
+ EGL: get EGLDisplay object
+/
extern(C) const(void)* sapp_egl_get_display() @system @nogc nothrow pure;
const(void)* eglGetDisplay() @trusted @nogc nothrow pure {
    return sapp_egl_get_display();
}
/++
+ EGL: get EGLContext object
+/
extern(C) const(void)* sapp_egl_get_context() @system @nogc nothrow pure;
const(void)* eglGetContext() @trusted @nogc nothrow pure {
    return sapp_egl_get_context();
}
/++
+ HTML5: enable or disable the hardwired "Leave Site?" dialog box
+/
extern(C) void sapp_html5_ask_leave_site(bool ask) @system @nogc nothrow pure;
void html5AskLeaveSite(bool ask) @trusted @nogc nothrow pure {
    sapp_html5_ask_leave_site(ask);
}
/++
+ HTML5: get byte size of a dropped file
+/
extern(C) uint sapp_html5_get_dropped_file_size(int index) @system @nogc nothrow pure;
uint html5GetDroppedFileSize(int index) @trusted @nogc nothrow pure {
    return sapp_html5_get_dropped_file_size(index);
}
/++
+ HTML5: asynchronously load the content of a dropped file
+/
extern(C) void sapp_html5_fetch_dropped_file(const Html5FetchRequest* request) @system @nogc nothrow pure;
void html5FetchDroppedFile(scope ref Html5FetchRequest request) @trusted @nogc nothrow pure {
    sapp_html5_fetch_dropped_file(&request);
}
/++
+ Metal: get bridged pointer to Metal device object
+/
extern(C) const(void)* sapp_metal_get_device() @system @nogc nothrow pure;
const(void)* metalGetDevice() @trusted @nogc nothrow pure {
    return sapp_metal_get_device();
}
/++
+ Metal: get bridged pointer to MTKView's current drawable of type CAMetalDrawable
+/
extern(C) const(void)* sapp_metal_get_current_drawable() @system @nogc nothrow pure;
const(void)* metalGetCurrentDrawable() @trusted @nogc nothrow pure {
    return sapp_metal_get_current_drawable();
}
/++
+ Metal: get bridged pointer to MTKView's depth-stencil texture of type MTLTexture
+/
extern(C) const(void)* sapp_metal_get_depth_stencil_texture() @system @nogc nothrow pure;
const(void)* metalGetDepthStencilTexture() @trusted @nogc nothrow pure {
    return sapp_metal_get_depth_stencil_texture();
}
/++
+ Metal: get bridged pointer to MTKView's msaa-color-texture of type MTLTexture (may be null)
+/
extern(C) const(void)* sapp_metal_get_msaa_color_texture() @system @nogc nothrow pure;
const(void)* metalGetMsaaColorTexture() @trusted @nogc nothrow pure {
    return sapp_metal_get_msaa_color_texture();
}
/++
+ macOS: get bridged pointer to macOS NSWindow
+/
extern(C) const(void)* sapp_macos_get_window() @system @nogc nothrow pure;
const(void)* macosGetWindow() @trusted @nogc nothrow pure {
    return sapp_macos_get_window();
}
/++
+ iOS: get bridged pointer to iOS UIWindow
+/
extern(C) const(void)* sapp_ios_get_window() @system @nogc nothrow pure;
const(void)* iosGetWindow() @trusted @nogc nothrow pure {
    return sapp_ios_get_window();
}
/++
+ D3D11: get pointer to ID3D11Device object
+/
extern(C) const(void)* sapp_d3d11_get_device() @system @nogc nothrow pure;
const(void)* d3d11GetDevice() @trusted @nogc nothrow pure {
    return sapp_d3d11_get_device();
}
/++
+ D3D11: get pointer to ID3D11DeviceContext object
+/
extern(C) const(void)* sapp_d3d11_get_device_context() @system @nogc nothrow pure;
const(void)* d3d11GetDeviceContext() @trusted @nogc nothrow pure {
    return sapp_d3d11_get_device_context();
}
/++
+ D3D11: get pointer to IDXGISwapChain object
+/
extern(C) const(void)* sapp_d3d11_get_swap_chain() @system @nogc nothrow pure;
const(void)* d3d11GetSwapChain() @trusted @nogc nothrow pure {
    return sapp_d3d11_get_swap_chain();
}
/++
+ D3D11: get pointer to ID3D11RenderTargetView object for rendering
+/
extern(C) const(void)* sapp_d3d11_get_render_view() @system @nogc nothrow pure;
const(void)* d3d11GetRenderView() @trusted @nogc nothrow pure {
    return sapp_d3d11_get_render_view();
}
/++
+ D3D11: get pointer ID3D11RenderTargetView object for msaa-resolve (may return null)
+/
extern(C) const(void)* sapp_d3d11_get_resolve_view() @system @nogc nothrow pure;
const(void)* d3d11GetResolveView() @trusted @nogc nothrow pure {
    return sapp_d3d11_get_resolve_view();
}
/++
+ D3D11: get pointer ID3D11DepthStencilView
+/
extern(C) const(void)* sapp_d3d11_get_depth_stencil_view() @system @nogc nothrow pure;
const(void)* d3d11GetDepthStencilView() @trusted @nogc nothrow pure {
    return sapp_d3d11_get_depth_stencil_view();
}
/++
+ Win32: get the HWND window handle
+/
extern(C) const(void)* sapp_win32_get_hwnd() @system @nogc nothrow pure;
const(void)* win32GetHwnd() @trusted @nogc nothrow pure {
    return sapp_win32_get_hwnd();
}
/++
+ WebGPU: get WGPUDevice handle
+/
extern(C) const(void)* sapp_wgpu_get_device() @system @nogc nothrow pure;
const(void)* wgpuGetDevice() @trusted @nogc nothrow pure {
    return sapp_wgpu_get_device();
}
/++
+ WebGPU: get swapchain's WGPUTextureView handle for rendering
+/
extern(C) const(void)* sapp_wgpu_get_render_view() @system @nogc nothrow pure;
const(void)* wgpuGetRenderView() @trusted @nogc nothrow pure {
    return sapp_wgpu_get_render_view();
}
/++
+ WebGPU: get swapchain's MSAA-resolve WGPUTextureView (may return null)
+/
extern(C) const(void)* sapp_wgpu_get_resolve_view() @system @nogc nothrow pure;
const(void)* wgpuGetResolveView() @trusted @nogc nothrow pure {
    return sapp_wgpu_get_resolve_view();
}
/++
+ WebGPU: get swapchain's WGPUTextureView for the depth-stencil surface
+/
extern(C) const(void)* sapp_wgpu_get_depth_stencil_view() @system @nogc nothrow pure;
const(void)* wgpuGetDepthStencilView() @trusted @nogc nothrow pure {
    return sapp_wgpu_get_depth_stencil_view();
}
/++
+ GL: get framebuffer object
+/
extern(C) uint sapp_gl_get_framebuffer() @system @nogc nothrow pure;
uint glGetFramebuffer() @trusted @nogc nothrow pure {
    return sapp_gl_get_framebuffer();
}
/++
+ GL: get major version
+/
extern(C) int sapp_gl_get_major_version() @system @nogc nothrow pure;
int glGetMajorVersion() @trusted @nogc nothrow pure {
    return sapp_gl_get_major_version();
}
/++
+ GL: get minor version
+/
extern(C) int sapp_gl_get_minor_version() @system @nogc nothrow pure;
int glGetMinorVersion() @trusted @nogc nothrow pure {
    return sapp_gl_get_minor_version();
}
/++
+ GL: return true if the context is GLES
+/
extern(C) bool sapp_gl_is_gles() @system @nogc nothrow pure;
bool glIsGles() @trusted @nogc nothrow pure {
    return sapp_gl_is_gles();
}
/++
+ X11: get Window
+/
extern(C) const(void)* sapp_x11_get_window() @system @nogc nothrow pure;
const(void)* x11GetWindow() @trusted @nogc nothrow pure {
    return sapp_x11_get_window();
}
/++
+ X11: get Display
+/
extern(C) const(void)* sapp_x11_get_display() @system @nogc nothrow pure;
const(void)* x11GetDisplay() @trusted @nogc nothrow pure {
    return sapp_x11_get_display();
}
/++
+ Android: get native activity handle
+/
extern(C) const(void)* sapp_android_get_native_activity() @system @nogc nothrow pure;
const(void)* androidGetNativeActivity() @trusted @nogc nothrow pure {
    return sapp_android_get_native_activity();
}
