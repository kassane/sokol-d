/++
+ Machine generated D bindings for Sokol library.
+ 
+     Generated on: 2025-08-25 11:17:31
+ 
+     Source header: sokol_nuklear.h
+     Module: sokol.nuklear
+ 
+     Do not edit manually; regenerate using gen_d.py.
+/
module sokol.nuklear;
import sg = sokol.gfx;
import sapp = sokol.app;

/++ Nuklear external type declarations +/
extern(C) struct NkContext;
extern(C) union NkHandle {
    void* ptr;
    int id;
}
alias NkFlags = uint;
alias nk_plugin_filter = extern(C) int function(const(NkContext)*, NkHandle, int*, int) @system @nogc nothrow;
enum invalid_id = 0;
/++
+ snk_image_t
+ 
+     A combined texture-view / sampler pair used to inject custom images and samplers into Nuklear.
+ 
+     Create with snk_make_image(), and convert to an nk_handle via snk_nkhandle().
+/
extern(C) struct Image {
    uint id = 0;
}
/++
+ snk_image_desc_t
+ 
+     Descriptor struct for snk_make_image(). You must provide
+     at least an sg_view handle. Keeping the sg_sampler handle
+     zero-initialized will select the builtin default sampler
+     which uses linear filtering.
+/
extern(C) struct ImageDesc {
    sg.View texture_view = {};
    sg.Sampler sampler = {};
}
enum LogItem {
    Ok,
    Malloc_failed,
    Image_pool_exhausted,
}
/++
+ snk_allocator_t
+ 
+     Used in snk_desc_t to provide custom memory-alloc and -free functions
+     to sokol_nuklear.h. If memory management should be overridden, both the
+     alloc_fn and free_fn function must be provided (e.g. it's not valid to
+     override one function but not the other).
+/
extern(C) struct Allocator {
    extern(C) void* function(size_t, void*) alloc_fn = null;
    extern(C) void function(void*, void*) free_fn = null;
    void* user_data = null;
}
/++
+ snk_logger
+ 
+     Used in snk_desc_t to provide a logging function. Please be aware
+     that without logging function, sokol-nuklear will be completely
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
    int image_pool_size = 0;
    sg.PixelFormat color_format = sg.PixelFormat.Default;
    sg.PixelFormat depth_format = sg.PixelFormat.Default;
    int sample_count = 0;
    float dpi_scale = 0.0f;
    bool no_default_font = false;
    bool enable_set_mouse_cursor = false;
    Allocator allocator = {};
    Logger logger = {};
}
extern(C) void snk_setup(const Desc* desc) @system @nogc nothrow pure;
void setup(scope ref Desc desc) @trusted @nogc nothrow pure {
    snk_setup(&desc);
}
extern(C) void* snk_new_frame() @system @nogc nothrow pure;
void* newFrame() @trusted @nogc nothrow pure {
    return snk_new_frame();
}
extern(C) void snk_render(int width, int height) @system @nogc nothrow pure;
void render(int width, int height) @trusted @nogc nothrow pure {
    snk_render(width, height);
}
extern(C) Image snk_make_image(const ImageDesc* desc) @system @nogc nothrow pure;
Image makeImage(scope ref ImageDesc desc) @trusted @nogc nothrow pure {
    return snk_make_image(&desc);
}
extern(C) void snk_destroy_image(Image img) @system @nogc nothrow pure;
void destroyImage(Image img) @trusted @nogc nothrow pure {
    snk_destroy_image(img);
}
extern(C) ImageDesc snk_query_image_desc(Image img) @system @nogc nothrow pure;
ImageDesc queryImageDesc(Image img) @trusted @nogc nothrow pure {
    return snk_query_image_desc(img);
}
extern(C) NkHandle snk_nkhandle(Image img) @system @nogc nothrow pure;
NkHandle nkhandle(Image img) @trusted @nogc nothrow pure {
    return snk_nkhandle(img);
}
extern(C) Image snk_image_from_nkhandle(NkHandle handle) @system @nogc nothrow pure;
Image imageFromNkhandle(NkHandle handle) @trusted @nogc nothrow pure {
    return snk_image_from_nkhandle(handle);
}
extern(C) bool snk_handle_event(const sapp.Event* ev) @system @nogc nothrow pure;
bool handleEvent(scope ref sapp.Event ev) @trusted @nogc nothrow pure {
    return snk_handle_event(&ev);
}
extern(C) NkFlags snk_edit_string(void* ctx, NkFlags flags, char* memory, int* len, int max, nk_plugin_filter filter) @system @nogc nothrow pure;
NkFlags editString(void* ctx, NkFlags flags, char* memory, int* len, int max, nk_plugin_filter filter) @trusted @nogc nothrow pure {
    return snk_edit_string(ctx, flags, memory, len, max, filter);
}
extern(C) void snk_shutdown() @system @nogc nothrow pure;
void shutdown() @trusted @nogc nothrow pure {
    snk_shutdown();
}
