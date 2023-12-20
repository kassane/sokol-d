// machine generated, do not edit

module sokol.debugtext;
import sg = sokol.gfx;

// helper function to convert a C string to a D string
string cStrTod(const(char*) c_str) {
    import std.conv: to;
    return c_str.to!string;
}
// helper function to convert "anything" to a Range struct

Range asRange(T)(T val) {
    static if (isPointer!T) {
       return Range(val, __traits(classInstanceSize, T));
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
    OK,
    MALLOC_FAILED,
    ADD_COMMIT_LISTENER_FAILED,
    COMMAND_BUFFER_FULL,
    CONTEXT_POOL_EXHAUSTED,
    CANNOT_DESTROY_DEFAULT_CONTEXT,
}
struct Logger {
    extern(C) void function(const(char*), uint, uint, const(char*), uint, const(char*), void*) func;
    void* user_data;
}
struct Context {
    uint id;
}
struct Range {
    const(void)* ptr;
    size_t size;
}
struct FontDesc {
    Range data;
    ubyte first_char;
    ubyte last_char;
}
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
struct Allocator {
    extern(C) void* function(size_t, void*) alloc_fn;
    extern(C) void function(void*, void*) free_fn;
    void* user_data;
}
struct Desc {
    int context_pool_size;
    int printf_buf_size;
    FontDesc[8] fonts;
    ContextDesc context;
    Allocator allocator;
    Logger logger;
}
extern(C) void sdtx_setup(const Desc *);
void setup(Desc desc) {
    sdtx_setup(&desc);
}
extern(C) void sdtx_shutdown();
void shutdown() {
    sdtx_shutdown();
}
extern(C) FontDesc sdtx_font_kc853();
FontDesc fontKc853() {
    return sdtx_font_kc853();
}
extern(C) FontDesc sdtx_font_kc854();
FontDesc fontKc854() {
    return sdtx_font_kc854();
}
extern(C) FontDesc sdtx_font_z1013();
FontDesc fontZ1013() {
    return sdtx_font_z1013();
}
extern(C) FontDesc sdtx_font_cpc();
FontDesc fontCpc() {
    return sdtx_font_cpc();
}
extern(C) FontDesc sdtx_font_c64();
FontDesc fontC64() {
    return sdtx_font_c64();
}
extern(C) FontDesc sdtx_font_oric();
FontDesc fontOric() {
    return sdtx_font_oric();
}
extern(C) Context sdtx_make_context(const ContextDesc *);
Context makeContext(ContextDesc desc) {
    return sdtx_make_context(&desc);
}
extern(C) void sdtx_destroy_context(Context);
void destroyContext(Context ctx) {
    sdtx_destroy_context(ctx);
}
extern(C) void sdtx_set_context(Context);
void setContext(Context ctx) {
    sdtx_set_context(ctx);
}
extern(C) Context sdtx_get_context();
Context getContext() {
    return sdtx_get_context();
}
extern(C) Context sdtx_default_context();
Context defaultContext() {
    return sdtx_default_context();
}
extern(C) void sdtx_draw();
void draw() {
    sdtx_draw();
}
extern(C) void sdtx_context_draw(Context);
void contextDraw(Context ctx) {
    sdtx_context_draw(ctx);
}
extern(C) void sdtx_draw_layer(int);
void drawLayer(int layer_id) {
    sdtx_draw_layer(layer_id);
}
extern(C) void sdtx_context_draw_layer(Context, int);
void contextDrawLayer(Context ctx, int layer_id) {
    sdtx_context_draw_layer(ctx, layer_id);
}
extern(C) void sdtx_layer(int);
void layer(int layer_id) {
    sdtx_layer(layer_id);
}
extern(C) void sdtx_font(uint);
void font(uint font_index) {
    sdtx_font(font_index);
}
extern(C) void sdtx_canvas(float, float);
void canvas(float w, float h) {
    sdtx_canvas(w, h);
}
extern(C) void sdtx_origin(float, float);
void origin(float x, float y) {
    sdtx_origin(x, y);
}
extern(C) void sdtx_home();
void home() {
    sdtx_home();
}
extern(C) void sdtx_pos(float, float);
void pos(float x, float y) {
    sdtx_pos(x, y);
}
extern(C) void sdtx_pos_x(float);
void posX(float x) {
    sdtx_pos_x(x);
}
extern(C) void sdtx_pos_y(float);
void posY(float y) {
    sdtx_pos_y(y);
}
extern(C) void sdtx_move(float, float);
void move(float dx, float dy) {
    sdtx_move(dx, dy);
}
extern(C) void sdtx_move_x(float);
void moveX(float dx) {
    sdtx_move_x(dx);
}
extern(C) void sdtx_move_y(float);
void moveY(float dy) {
    sdtx_move_y(dy);
}
extern(C) void sdtx_crlf();
void crlf() {
    sdtx_crlf();
}
extern(C) void sdtx_color3b(ubyte, ubyte, ubyte);
void color3b(ubyte r, ubyte g, ubyte b) {
    sdtx_color3b(r, g, b);
}
extern(C) void sdtx_color3f(float, float, float);
void color3f(float r, float g, float b) {
    sdtx_color3f(r, g, b);
}
extern(C) void sdtx_color4b(ubyte, ubyte, ubyte, ubyte);
void color4b(ubyte r, ubyte g, ubyte b, ubyte a) {
    sdtx_color4b(r, g, b, a);
}
extern(C) void sdtx_color4f(float, float, float, float);
void color4f(float r, float g, float b, float a) {
    sdtx_color4f(r, g, b, a);
}
extern(C) void sdtx_color1i(uint);
void color1i(uint rgba) {
    sdtx_color1i(rgba);
}
extern(C) void sdtx_putc(char);
void putc(char c) {
    sdtx_putc(c);
}
extern(C) void sdtx_puts(const(char*));
void puts(scope const(char*) str) {
    sdtx_puts(str);
}
extern(C) void sdtx_putr(const(char*), int);
void putr(scope const(char*) str, int len) {
    sdtx_putr(str, len);
}
