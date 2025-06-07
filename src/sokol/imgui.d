/++
+ Machine generated D bindings for Sokol library.
+ 
+     Generated on: 2025-06-07 08:25:53
+ 
+     Source header: sokol_imgui.h
+     Module: sokol.imgui
+ 
+     Do not edit manually; regenerate using gen_d.py.
+/
module sokol.imgui;
import sg = sokol.gfx;
import sapp = sokol.app;

enum LogItem {
    Ok,
    Malloc_failed,
}
/++
+ simgui_allocator_t
+ 
+     Used in simgui_desc_t to provide custom memory-alloc and -free functions
+     to sokol_imgui.h. If memory management should be overridden, both the
+     alloc_fn and free_fn function must be provided (e.g. it's not valid to
+     override one function but not the other).
+/
extern(C) struct Allocator {
    extern(C) void* function(size_t, void*) alloc_fn = null;
    extern(C) void function(void*, void*) free_fn = null;
    void* user_data = null;
}
/++
+ simgui_logger
+ 
+     Used in simgui_desc_t to provide a logging function. Please be aware
+     that without logging function, sokol-imgui will be completely
+     silent, e.g. it will not report errors, warnings and
+     validation layer messages. For maximum error verbosity,
+     compile in debug mode (e.g. NDEBUG *not* defined) and install
+     a logger (for instance the standard logging function from sokol_log.h).
+/
extern(C) struct Logger {
    extern(C) void function(const(char)*, uint, uint, const(char)*, uint, const(char)*, void*) func = null;
    void* user_data = null;
}
extern(C) struct Desc {
    int max_vertices = 0;
    sg.PixelFormat color_format = sg.PixelFormat.Default;
    sg.PixelFormat depth_format = sg.PixelFormat.Default;
    int sample_count = 0;
    const(char)* ini_filename = null;
    bool no_default_font = false;
    bool disable_paste_override = false;
    bool disable_set_mouse_cursor = false;
    bool disable_windows_resize_from_edges = false;
    bool write_alpha_channel = false;
    Allocator allocator = {};
    Logger logger = {};
}
extern(C) struct FrameDesc {
    int width = 0;
    int height = 0;
    double delta_time = 0.0;
    float dpi_scale = 0.0f;
}
extern(C) struct FontTexDesc {
    sg.Filter min_filter = sg.Filter.Default;
    sg.Filter mag_filter = sg.Filter.Default;
}
extern(C) void simgui_setup(const Desc* desc) @system @nogc nothrow pure;
void setup(scope ref Desc desc) @trusted @nogc nothrow pure {
    simgui_setup(&desc);
}
extern(C) void simgui_new_frame(const FrameDesc* desc) @system @nogc nothrow pure;
void newFrame(scope ref FrameDesc desc) @trusted @nogc nothrow pure {
    simgui_new_frame(&desc);
}
extern(C) void simgui_render() @system @nogc nothrow pure;
void render() @trusted @nogc nothrow pure {
    simgui_render();
}
extern(C) ulong simgui_imtextureid(sg.Image img) @system @nogc nothrow pure;
ulong imtextureid(sg.Image img) @trusted @nogc nothrow pure {
    return simgui_imtextureid(img);
}
extern(C) ulong simgui_imtextureid_with_sampler(sg.Image img, sg.Sampler smp) @system @nogc nothrow pure;
ulong imtextureidWithSampler(sg.Image img, sg.Sampler smp) @trusted @nogc nothrow pure {
    return simgui_imtextureid_with_sampler(img, smp);
}
extern(C) sg.Image simgui_image_from_imtextureid(ulong imtex_id) @system @nogc nothrow pure;
sg.Image imageFromImtextureid(ulong imtex_id) @trusted @nogc nothrow pure {
    return simgui_image_from_imtextureid(imtex_id);
}
extern(C) sg.Sampler simgui_sampler_from_imtextureid(ulong imtex_id) @system @nogc nothrow pure;
sg.Sampler samplerFromImtextureid(ulong imtex_id) @trusted @nogc nothrow pure {
    return simgui_sampler_from_imtextureid(imtex_id);
}
extern(C) void simgui_add_focus_event(bool focus) @system @nogc nothrow pure;
void addFocusEvent(bool focus) @trusted @nogc nothrow pure {
    simgui_add_focus_event(focus);
}
extern(C) void simgui_add_mouse_pos_event(float x, float y) @system @nogc nothrow pure;
void addMousePosEvent(float x, float y) @trusted @nogc nothrow pure {
    simgui_add_mouse_pos_event(x, y);
}
extern(C) void simgui_add_touch_pos_event(float x, float y) @system @nogc nothrow pure;
void addTouchPosEvent(float x, float y) @trusted @nogc nothrow pure {
    simgui_add_touch_pos_event(x, y);
}
extern(C) void simgui_add_mouse_button_event(int mouse_button, bool down) @system @nogc nothrow pure;
void addMouseButtonEvent(int mouse_button, bool down) @trusted @nogc nothrow pure {
    simgui_add_mouse_button_event(mouse_button, down);
}
extern(C) void simgui_add_mouse_wheel_event(float wheel_x, float wheel_y) @system @nogc nothrow pure;
void addMouseWheelEvent(float wheel_x, float wheel_y) @trusted @nogc nothrow pure {
    simgui_add_mouse_wheel_event(wheel_x, wheel_y);
}
extern(C) void simgui_add_key_event(int imgui_key, bool down) @system @nogc nothrow pure;
void addKeyEvent(int imgui_key, bool down) @trusted @nogc nothrow pure {
    simgui_add_key_event(imgui_key, down);
}
extern(C) void simgui_add_input_character(uint c) @system @nogc nothrow pure;
void addInputCharacter(uint c) @trusted @nogc nothrow pure {
    simgui_add_input_character(c);
}
extern(C) void simgui_add_input_characters_utf8(const(char)* c) @system @nogc nothrow pure;
void addInputCharactersUtf8(const(char)* c) @trusted @nogc nothrow pure {
    simgui_add_input_characters_utf8(c);
}
extern(C) void simgui_add_touch_button_event(int mouse_button, bool down) @system @nogc nothrow pure;
void addTouchButtonEvent(int mouse_button, bool down) @trusted @nogc nothrow pure {
    simgui_add_touch_button_event(mouse_button, down);
}
extern(C) bool simgui_handle_event(const sapp.Event* ev) @system @nogc nothrow pure;
bool handleEvent(scope ref sapp.Event ev) @trusted @nogc nothrow pure {
    return simgui_handle_event(&ev);
}
extern(C) int simgui_map_keycode(sapp.Keycode keycode) @system @nogc nothrow pure;
int mapKeycode(sapp.Keycode keycode) @trusted @nogc nothrow pure {
    return simgui_map_keycode(keycode);
}
extern(C) void simgui_shutdown() @system @nogc nothrow pure;
void shutdown() @trusted @nogc nothrow pure {
    simgui_shutdown();
}
extern(C) void simgui_create_fonts_texture(const FontTexDesc* desc) @system @nogc nothrow pure;
void createFontsTexture(scope ref FontTexDesc desc) @trusted @nogc nothrow pure {
    simgui_create_fonts_texture(&desc);
}
extern(C) void simgui_destroy_fonts_texture() @system @nogc nothrow pure;
void destroyFontsTexture() @trusted @nogc nothrow pure {
    simgui_destroy_fonts_texture();
}
