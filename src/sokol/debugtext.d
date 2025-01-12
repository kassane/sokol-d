// machine generated, do not edit

module sokol.debugtext;
import sg = sokol.gfx;

enum LogItem {
    Ok,
    Malloc_failed,
    Add_commit_listener_failed,
    Command_buffer_full,
    Context_pool_exhausted,
    Cannot_destroy_default_context,
}
/// sdtx_logger_t
/// 
/// Used in sdtx_desc_t to provide a custom logging and error reporting
/// callback to sokol-debugtext
extern(C)
struct Logger {
    extern(C) void function(const(char)*, uint, uint, const(char)*, uint, const(char)*, void*) func = null;
    void* user_data = null;
}
/// a rendering context handle
extern(C)
struct Context {
    uint id = 0;
}
/// sdtx_range is a pointer-size-pair struct used to pass memory
/// blobs into sokol-debugtext. When initialized from a value type
/// (array or struct), use the SDTX_RANGE() macro to build
/// an sdtx_range struct
extern(C)
struct Range {
    const(void)* ptr = null;
    size_t size = 0;
}
extern(C)
struct FontDesc {
    Range data;
    ubyte first_char = 0;
    ubyte last_char = 0;
}
/// sdtx_context_desc_t
/// 
/// Describes the initialization parameters of a rendering context. Creating
/// additional rendering contexts is useful if you want to render in
/// different sokol-gfx rendering passes, or when rendering several layers
/// of text
extern(C)
struct ContextDesc {
    int max_commands = 0;
    int char_buf_size = 0;
    float canvas_width = 0.0f;
    float canvas_height = 0.0f;
    int tab_width = 0;
    sg.PixelFormat color_format;
    sg.PixelFormat depth_format;
    int sample_count = 0;
}
/// sdtx_allocator_t
/// 
/// Used in sdtx_desc_t to provide custom memory-alloc and -free functions
/// to sokol_debugtext.h. If memory management should be overridden, both the
/// alloc_fn and free_fn function must be provided (e.g. it's not valid to
/// override one function but not the other)
extern(C)
struct Allocator {
    extern(C) void* function(size_t, void*) alloc_fn = null;
    extern(C) void function(void*, void*) free_fn = null;
    void* user_data = null;
}
/// sdtx_desc_t
/// 
/// Describes the sokol-debugtext API initialization parameters. Passed
/// to the sdtx_setup() function.
/// 
/// NOTE: to populate the fonts item array with builtin fonts, use any
/// of the following functions:
/// 
///     sdtx_font_kc853()
///     sdtx_font_kc854()
///     sdtx_font_z1013()
///     sdtx_font_cpc()
///     sdtx_font_c64()
///     sdtx_font_oric(
extern(C)
struct Desc {
    int context_pool_size = 0;
    int printf_buf_size = 0;
    FontDesc[8] fonts;
    ContextDesc context;
    Allocator allocator;
    Logger logger;
}
/// initialization/shutdown
extern(C) void sdtx_setup(const Desc *) @system @nogc nothrow;
/// initialization/shutdown
void setup(scope ref Desc desc) @trusted @nogc nothrow {
    sdtx_setup(&desc);
}
extern(C) void sdtx_shutdown() @system @nogc nothrow;
void shutdown() @trusted @nogc nothrow {
    sdtx_shutdown();
}
/// builtin font data (use to populate sdtx_desc.font[])
extern(C) FontDesc sdtx_font_kc853() @system @nogc nothrow;
/// builtin font data (use to populate sdtx_desc.font[])
FontDesc fontKc853() @trusted @nogc nothrow {
    return sdtx_font_kc853();
}
extern(C) FontDesc sdtx_font_kc854() @system @nogc nothrow;
FontDesc fontKc854() @trusted @nogc nothrow {
    return sdtx_font_kc854();
}
extern(C) FontDesc sdtx_font_z1013() @system @nogc nothrow;
FontDesc fontZ1013() @trusted @nogc nothrow {
    return sdtx_font_z1013();
}
extern(C) FontDesc sdtx_font_cpc() @system @nogc nothrow;
FontDesc fontCpc() @trusted @nogc nothrow {
    return sdtx_font_cpc();
}
extern(C) FontDesc sdtx_font_c64() @system @nogc nothrow;
FontDesc fontC64() @trusted @nogc nothrow {
    return sdtx_font_c64();
}
extern(C) FontDesc sdtx_font_oric() @system @nogc nothrow;
FontDesc fontOric() @trusted @nogc nothrow {
    return sdtx_font_oric();
}
/// context functions
extern(C) Context sdtx_make_context(const ContextDesc *) @system @nogc nothrow;
/// context functions
Context makeContext(scope ref ContextDesc desc) @trusted @nogc nothrow {
    return sdtx_make_context(&desc);
}
extern(C) void sdtx_destroy_context(Context) @system @nogc nothrow;
void destroyContext(Context ctx) @trusted @nogc nothrow {
    sdtx_destroy_context(ctx);
}
extern(C) void sdtx_set_context(Context) @system @nogc nothrow;
void setContext(Context ctx) @trusted @nogc nothrow {
    sdtx_set_context(ctx);
}
extern(C) Context sdtx_get_context() @system @nogc nothrow;
Context getContext() @trusted @nogc nothrow {
    return sdtx_get_context();
}
extern(C) Context sdtx_default_context() @system @nogc nothrow;
Context defaultContext() @trusted @nogc nothrow {
    return sdtx_default_context();
}
/// drawing functions (call inside sokol-gfx render pass)
extern(C) void sdtx_draw() @system @nogc nothrow;
/// drawing functions (call inside sokol-gfx render pass)
void draw() @trusted @nogc nothrow {
    sdtx_draw();
}
extern(C) void sdtx_context_draw(Context) @system @nogc nothrow;
void contextDraw(Context ctx) @trusted @nogc nothrow {
    sdtx_context_draw(ctx);
}
extern(C) void sdtx_draw_layer(int) @system @nogc nothrow;
void drawLayer(int layer_id) @trusted @nogc nothrow {
    sdtx_draw_layer(layer_id);
}
extern(C) void sdtx_context_draw_layer(Context, int) @system @nogc nothrow;
void contextDrawLayer(Context ctx, int layer_id) @trusted @nogc nothrow {
    sdtx_context_draw_layer(ctx, layer_id);
}
/// switch render layer
extern(C) void sdtx_layer(int) @system @nogc nothrow;
/// switch render layer
void layer(int layer_id) @trusted @nogc nothrow {
    sdtx_layer(layer_id);
}
/// switch to a different font
extern(C) void sdtx_font(uint) @system @nogc nothrow;
/// switch to a different font
void font(uint font_index) @trusted @nogc nothrow {
    sdtx_font(font_index);
}
/// set a new virtual canvas size in screen pixels
extern(C) void sdtx_canvas(float, float) @system @nogc nothrow;
/// set a new virtual canvas size in screen pixels
void canvas(float w, float h) @trusted @nogc nothrow {
    sdtx_canvas(w, h);
}
/// set a new origin in character grid coordinates
extern(C) void sdtx_origin(float, float) @system @nogc nothrow;
/// set a new origin in character grid coordinates
void origin(float x, float y) @trusted @nogc nothrow {
    sdtx_origin(x, y);
}
/// cursor movement functions (relative to origin in character grid coordinates)
extern(C) void sdtx_home() @system @nogc nothrow;
/// cursor movement functions (relative to origin in character grid coordinates)
void home() @trusted @nogc nothrow {
    sdtx_home();
}
extern(C) void sdtx_pos(float, float) @system @nogc nothrow;
void pos(float x, float y) @trusted @nogc nothrow {
    sdtx_pos(x, y);
}
extern(C) void sdtx_pos_x(float) @system @nogc nothrow;
void posX(float x) @trusted @nogc nothrow {
    sdtx_pos_x(x);
}
extern(C) void sdtx_pos_y(float) @system @nogc nothrow;
void posY(float y) @trusted @nogc nothrow {
    sdtx_pos_y(y);
}
extern(C) void sdtx_move(float, float) @system @nogc nothrow;
void move(float dx, float dy) @trusted @nogc nothrow {
    sdtx_move(dx, dy);
}
extern(C) void sdtx_move_x(float) @system @nogc nothrow;
void moveX(float dx) @trusted @nogc nothrow {
    sdtx_move_x(dx);
}
extern(C) void sdtx_move_y(float) @system @nogc nothrow;
void moveY(float dy) @trusted @nogc nothrow {
    sdtx_move_y(dy);
}
extern(C) void sdtx_crlf() @system @nogc nothrow;
void crlf() @trusted @nogc nothrow {
    sdtx_crlf();
}
/// set the current text color
extern(C) void sdtx_color3b(ubyte, ubyte, ubyte) @system @nogc nothrow;
/// set the current text color
void color3b(ubyte r, ubyte g, ubyte b) @trusted @nogc nothrow {
    sdtx_color3b(r, g, b);
}
extern(C) void sdtx_color3f(float, float, float) @system @nogc nothrow;
void color3f(float r, float g, float b) @trusted @nogc nothrow {
    sdtx_color3f(r, g, b);
}
extern(C) void sdtx_color4b(ubyte, ubyte, ubyte, ubyte) @system @nogc nothrow;
void color4b(ubyte r, ubyte g, ubyte b, ubyte a) @trusted @nogc nothrow {
    sdtx_color4b(r, g, b, a);
}
extern(C) void sdtx_color4f(float, float, float, float) @system @nogc nothrow;
void color4f(float r, float g, float b, float a) @trusted @nogc nothrow {
    sdtx_color4f(r, g, b, a);
}
extern(C) void sdtx_color1i(uint) @system @nogc nothrow;
void color1i(uint rgba) @trusted @nogc nothrow {
    sdtx_color1i(rgba);
}
/// text rendering
extern(C) void sdtx_putc(char) @system @nogc nothrow;
/// text rendering
void putc(char c) @trusted @nogc nothrow {
    sdtx_putc(c);
}
extern(C) void sdtx_puts(const(char)*) @system @nogc nothrow;
void puts(scope const(char)* str) @trusted @nogc nothrow {
    sdtx_puts(str);
}
extern(C) void sdtx_putr(const(char)*, int) @system @nogc nothrow;
void putr(scope const(char)* str, int len) @trusted @nogc nothrow {
    sdtx_putr(str, len);
}
