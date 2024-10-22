// machine generated, do not edit

module sokol.imgui;
import sg = sokol.gfx;
import sapp = sokol.app;

enum invalid_id = 0;
extern(C)
struct Image {
    uint id = 0;
}
extern(C)
struct ImageDesc {
    sg.Image image;
    sg.Sampler sampler;
}
enum LogItem {
    Ok,
    Malloc_failed,
    Image_pool_exhausted,
}
extern(C)
struct Allocator {
    extern(C) void* function(size_t, void*) alloc_fn = null;
    extern(C) void function(void*, void*) free_fn = null;
    void* user_data = null;
}
extern(C)
struct Logger {
    extern(C) void function(const(char)*, uint, uint, const(char)*, uint, const(char)*, void*) func = null;
    void* user_data = null;
}
extern(C)
struct Desc {
    int max_vertices = 0;
    int image_pool_size = 0;
    sg.PixelFormat color_format;
    sg.PixelFormat depth_format;
    int sample_count = 0;
    const(char)* ini_filename = null;
    bool no_default_font = false;
    bool disable_paste_override = false;
    bool disable_set_mouse_cursor = false;
    bool disable_windows_resize_from_edges = false;
    bool write_alpha_channel = false;
    Allocator allocator;
    Logger logger;
}
extern(C)
struct FrameDesc {
    int width = 0;
    int height = 0;
    double delta_time = 0.0;
    float dpi_scale = 0.0f;
}
extern(C)
struct FontTexDesc {
    sg.Filter min_filter;
    sg.Filter mag_filter;
}
extern(C) void simgui_setup(const Desc *) @system @nogc nothrow;
void setup(scope ref Desc desc) @trusted @nogc nothrow {
    simgui_setup(&desc);
}
extern(C) void simgui_new_frame(const FrameDesc *) @system @nogc nothrow;
void newFrame(scope ref FrameDesc desc) @trusted @nogc nothrow {
    simgui_new_frame(&desc);
}
extern(C) void simgui_render() @system @nogc nothrow;
void render() @trusted @nogc nothrow {
    simgui_render();
}
extern(C) Image simgui_make_image(const ImageDesc *) @system @nogc nothrow;
Image makeImage(scope ref ImageDesc desc) @trusted @nogc nothrow {
    return simgui_make_image(&desc);
}
extern(C) void simgui_destroy_image(Image) @system @nogc nothrow;
void destroyImage(Image img) @trusted @nogc nothrow {
    simgui_destroy_image(img);
}
extern(C) ImageDesc simgui_query_image_desc(Image) @system @nogc nothrow;
ImageDesc queryImageDesc(Image img) @trusted @nogc nothrow {
    return simgui_query_image_desc(img);
}
extern(C) ulong simgui_imtextureid(Image) @system @nogc nothrow;
ulong imtextureid(Image img) @trusted @nogc nothrow {
    return simgui_imtextureid(img);
}
extern(C) Image simgui_image_from_imtextureid(ulong) @system @nogc nothrow;
Image imageFromImtextureid(ulong im_texture_id) @trusted @nogc nothrow {
    return simgui_image_from_imtextureid(im_texture_id);
}
extern(C) void simgui_add_focus_event(bool) @system @nogc nothrow;
void addFocusEvent(bool focus) @trusted @nogc nothrow {
    simgui_add_focus_event(focus);
}
extern(C) void simgui_add_mouse_pos_event(float, float) @system @nogc nothrow;
void addMousePosEvent(float x, float y) @trusted @nogc nothrow {
    simgui_add_mouse_pos_event(x, y);
}
extern(C) void simgui_add_touch_pos_event(float, float) @system @nogc nothrow;
void addTouchPosEvent(float x, float y) @trusted @nogc nothrow {
    simgui_add_touch_pos_event(x, y);
}
extern(C) void simgui_add_mouse_button_event(int, bool) @system @nogc nothrow;
void addMouseButtonEvent(int mouse_button, bool down) @trusted @nogc nothrow {
    simgui_add_mouse_button_event(mouse_button, down);
}
extern(C) void simgui_add_mouse_wheel_event(float, float) @system @nogc nothrow;
void addMouseWheelEvent(float wheel_x, float wheel_y) @trusted @nogc nothrow {
    simgui_add_mouse_wheel_event(wheel_x, wheel_y);
}
extern(C) void simgui_add_key_event(int, bool) @system @nogc nothrow;
void addKeyEvent(int imgui_key, bool down) @trusted @nogc nothrow {
    simgui_add_key_event(imgui_key, down);
}
extern(C) void simgui_add_input_character(uint) @system @nogc nothrow;
void addInputCharacter(uint c) @trusted @nogc nothrow {
    simgui_add_input_character(c);
}
extern(C) void simgui_add_input_characters_utf8(const(char)*) @system @nogc nothrow;
void addInputCharactersUtf8(scope const(char)* c) @trusted @nogc nothrow {
    simgui_add_input_characters_utf8(c);
}
extern(C) void simgui_add_touch_button_event(int, bool) @system @nogc nothrow;
void addTouchButtonEvent(int mouse_button, bool down) @trusted @nogc nothrow {
    simgui_add_touch_button_event(mouse_button, down);
}
extern(C) bool simgui_handle_event(const sapp.Event *) @system @nogc nothrow;
bool handleEvent(scope ref sapp.Event ev) @trusted @nogc nothrow {
    return simgui_handle_event(&ev);
}
extern(C) int simgui_map_keycode(sapp.Keycode) @system @nogc nothrow;
int mapKeycode(sapp.Keycode keycode) @trusted @nogc nothrow {
    return simgui_map_keycode(keycode);
}
extern(C) void simgui_shutdown() @system @nogc nothrow;
void shutdown() @trusted @nogc nothrow {
    simgui_shutdown();
}
extern(C) void simgui_create_fonts_texture(const FontTexDesc *) @system @nogc nothrow;
void createFontsTexture(scope ref FontTexDesc desc) @trusted @nogc nothrow {
    simgui_create_fonts_texture(&desc);
}
extern(C) void simgui_destroy_fonts_texture() @system @nogc nothrow;
void destroyFontsTexture() @trusted @nogc nothrow {
    simgui_destroy_fonts_texture();
}
