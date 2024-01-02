// machine generated, do not edit

module sokol.debugtext;
import sg = sokol.gfx;

// helper function to convert a C string to a D string
string cStrTod(T)(scope T c_str) nothrow {
    import std.conv: to;
    return c_str.to!string;
}

// WIP: helper function to convert "anything" to a Range struct
Range asRange(T)(T val) @safe {
    import std.traits;
    static if (isPointer!T) {
       return Range(val, T.sizeof);
    } else static if (is(T == float[])) {
       auto arr = val.dup;
       return Range(&arr[0], arr.length * arr[0].sizeof);
    } else static if (is(T == struct)) {
       return Range(val.tupleof);
    } else {
       static assert(0, "Cannot convert to range");
    }
}

struct Writer {
    void write(R)(R range) if (isInputRange!R && is(ElementType!R : const(ubyte))) {
        foreach (b; range) {
            putc(b);
        }
    }
    void writeMultiple(ubyte b, ulong n) @trusted {
        foreach(_; 0..n) {
            putc(cast(int) b);
        }
    }
}

void print(Args...)(const char[] fmt, Args args) @safe {
    import std.array;
    import std.format;
    auto w = appender!string();
    formattedWrite(w, fmt, args);
}

enum LogItem {
    Ok,
    Malloc_failed,
    Add_commit_listener_failed,
    Command_buffer_full,
    Context_pool_exhausted,
    Cannot_destroy_default_context,
}
extern(C)
struct Logger {
    extern(C) void function(scope const(char)*, uint, uint, scope const(char)*, uint, scope const(char)*, void*) func;
    void* user_data;
}
extern(C)
struct Context {
    uint id;
}
extern(C)
struct Range {
    const(void)* ptr;
    size_t size;
}
extern(C)
struct FontDesc {
    Range data;
    ubyte first_char;
    ubyte last_char;
}
extern(C)
struct ContextDesc {
    int max_commands;
    int char_buf_size;
    float canvas_width;
    float canvas_height;
    int tab_width;
    sg.PixelFormat color_format;
    sg.PixelFormat depth_format;
    int sample_count;
}
extern(C)
struct Allocator {
    extern(C) void* function(size_t, void*) alloc_fn;
    extern(C) void function(void*, void*) free_fn;
    void* user_data;
}
extern(C)
struct Desc {
    int context_pool_size;
    int printf_buf_size;
    FontDesc[8] fonts;
    ContextDesc context;
    Allocator allocator;
    Logger logger;
}
extern(C) void sdtx_setup(const Desc *) @system @nogc nothrow;
void setup(ref Desc desc) @trusted nothrow {
    sdtx_setup(&desc);
}
extern(C) void sdtx_shutdown() @system @nogc nothrow;
void shutdown() @trusted nothrow {
    sdtx_shutdown();
}
extern(C) FontDesc sdtx_font_kc853() @system @nogc nothrow;
FontDesc fontKc853() @trusted nothrow {
    return sdtx_font_kc853();
}
extern(C) FontDesc sdtx_font_kc854() @system @nogc nothrow;
FontDesc fontKc854() @trusted nothrow {
    return sdtx_font_kc854();
}
extern(C) FontDesc sdtx_font_z1013() @system @nogc nothrow;
FontDesc fontZ1013() @trusted nothrow {
    return sdtx_font_z1013();
}
extern(C) FontDesc sdtx_font_cpc() @system @nogc nothrow;
FontDesc fontCpc() @trusted nothrow {
    return sdtx_font_cpc();
}
extern(C) FontDesc sdtx_font_c64() @system @nogc nothrow;
FontDesc fontC64() @trusted nothrow {
    return sdtx_font_c64();
}
extern(C) FontDesc sdtx_font_oric() @system @nogc nothrow;
FontDesc fontOric() @trusted nothrow {
    return sdtx_font_oric();
}
extern(C) Context sdtx_make_context(const ContextDesc *) @system @nogc nothrow;
Context makeContext(ref ContextDesc desc) @trusted nothrow {
    return sdtx_make_context(&desc);
}
extern(C) void sdtx_destroy_context(Context) @system @nogc nothrow;
void destroyContext(Context ctx) @trusted nothrow {
    sdtx_destroy_context(ctx);
}
extern(C) void sdtx_set_context(Context) @system @nogc nothrow;
void setContext(Context ctx) @trusted nothrow {
    sdtx_set_context(ctx);
}
extern(C) Context sdtx_get_context() @system @nogc nothrow;
Context getContext() @trusted nothrow {
    return sdtx_get_context();
}
extern(C) Context sdtx_default_context() @system @nogc nothrow;
Context defaultContext() @trusted nothrow {
    return sdtx_default_context();
}
extern(C) void sdtx_draw() @system @nogc nothrow;
void draw() @trusted nothrow {
    sdtx_draw();
}
extern(C) void sdtx_context_draw(Context) @system @nogc nothrow;
void contextDraw(Context ctx) @trusted nothrow {
    sdtx_context_draw(ctx);
}
extern(C) void sdtx_draw_layer(int) @system @nogc nothrow;
void drawLayer(int layer_id) @trusted nothrow {
    sdtx_draw_layer(layer_id);
}
extern(C) void sdtx_context_draw_layer(Context, int) @system @nogc nothrow;
void contextDrawLayer(Context ctx, int layer_id) @trusted nothrow {
    sdtx_context_draw_layer(ctx, layer_id);
}
extern(C) void sdtx_layer(int) @system @nogc nothrow;
void layer(int layer_id) @trusted nothrow {
    sdtx_layer(layer_id);
}
extern(C) void sdtx_font(uint) @system @nogc nothrow;
void font(uint font_index) @trusted nothrow {
    sdtx_font(font_index);
}
extern(C) void sdtx_canvas(float, float) @system @nogc nothrow;
void canvas(float w, float h) @trusted nothrow {
    sdtx_canvas(w, h);
}
extern(C) void sdtx_origin(float, float) @system @nogc nothrow;
void origin(float x, float y) @trusted nothrow {
    sdtx_origin(x, y);
}
extern(C) void sdtx_home() @system @nogc nothrow;
void home() @trusted nothrow {
    sdtx_home();
}
extern(C) void sdtx_pos(float, float) @system @nogc nothrow;
void pos(float x, float y) @trusted nothrow {
    sdtx_pos(x, y);
}
extern(C) void sdtx_pos_x(float) @system @nogc nothrow;
void posX(float x) @trusted nothrow {
    sdtx_pos_x(x);
}
extern(C) void sdtx_pos_y(float) @system @nogc nothrow;
void posY(float y) @trusted nothrow {
    sdtx_pos_y(y);
}
extern(C) void sdtx_move(float, float) @system @nogc nothrow;
void move(float dx, float dy) @trusted nothrow {
    sdtx_move(dx, dy);
}
extern(C) void sdtx_move_x(float) @system @nogc nothrow;
void moveX(float dx) @trusted nothrow {
    sdtx_move_x(dx);
}
extern(C) void sdtx_move_y(float) @system @nogc nothrow;
void moveY(float dy) @trusted nothrow {
    sdtx_move_y(dy);
}
extern(C) void sdtx_crlf() @system @nogc nothrow;
void crlf() @trusted nothrow {
    sdtx_crlf();
}
extern(C) void sdtx_color3b(ubyte, ubyte, ubyte) @system @nogc nothrow;
void color3b(ubyte r, ubyte g, ubyte b) @trusted nothrow {
    sdtx_color3b(r, g, b);
}
extern(C) void sdtx_color3f(float, float, float) @system @nogc nothrow;
void color3f(float r, float g, float b) @trusted nothrow {
    sdtx_color3f(r, g, b);
}
extern(C) void sdtx_color4b(ubyte, ubyte, ubyte, ubyte) @system @nogc nothrow;
void color4b(ubyte r, ubyte g, ubyte b, ubyte a) @trusted nothrow {
    sdtx_color4b(r, g, b, a);
}
extern(C) void sdtx_color4f(float, float, float, float) @system @nogc nothrow;
void color4f(float r, float g, float b, float a) @trusted nothrow {
    sdtx_color4f(r, g, b, a);
}
extern(C) void sdtx_color1i(uint) @system @nogc nothrow;
void color1i(uint rgba) @trusted nothrow {
    sdtx_color1i(rgba);
}
extern(C) void sdtx_putc(char) @system @nogc nothrow;
void putc(char c) @trusted nothrow {
    sdtx_putc(c);
}
extern(C) void sdtx_puts(scope const(char)*) @system @nogc nothrow;
void puts(string str) @trusted nothrow {
    sdtx_puts(str.ptr);
}
extern(C) void sdtx_putr(scope const(char)*, int) @system @nogc nothrow;
void putr(string str, int len) @trusted nothrow {
    sdtx_putr(str.ptr, len);
}
