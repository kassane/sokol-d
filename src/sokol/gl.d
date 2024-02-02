// machine generated, do not edit

module sokol.gl;
import sg = sokol.gfx;

enum LogItem {
    Ok,
    Malloc_failed,
    Make_pipeline_failed,
    Pipeline_pool_exhausted,
    Add_commit_listener_failed,
    Context_pool_exhausted,
    Cannot_destroy_default_context,
}
extern(C)
struct Logger {
    extern(C) void function(scope const(char)*, uint, uint, scope const(char)*, uint, scope const(char)*, void*) func;
    void* user_data;
}
extern(C)
struct Pipeline {
    uint id = 0;
}
extern(C)
struct Context {
    uint id = 0;
}
enum Error {
    No_error = 0,
    Vertices_full,
    Uniforms_full,
    Commands_full,
    Stack_overflow,
    Stack_underflow,
    No_context,
}
extern(C)
struct ContextDesc {
    int max_vertices = 0;
    int max_commands = 0;
    sg.PixelFormat color_format;
    sg.PixelFormat depth_format;
    int sample_count = 0;
}
extern(C)
struct Allocator {
    extern(C) void* function(size_t, void*) alloc_fn;
    extern(C) void function(void*, void*) free_fn;
    void* user_data;
}
extern(C)
struct Desc {
    int max_vertices = 0;
    int max_commands = 0;
    int context_pool_size = 0;
    int pipeline_pool_size = 0;
    sg.PixelFormat color_format;
    sg.PixelFormat depth_format;
    int sample_count = 0;
    sg.FaceWinding face_winding;
    Allocator allocator;
    Logger logger;
}
extern(C) void sgl_setup(const Desc *) @system @nogc nothrow;
void setup(ref Desc desc) @trusted @nogc nothrow {
    sgl_setup(&desc);
}
extern(C) void sgl_shutdown() @system @nogc nothrow;
void shutdown() @trusted @nogc nothrow {
    sgl_shutdown();
}
extern(C) float sgl_rad(float) @system @nogc nothrow;
float asRadians(float deg) @trusted @nogc nothrow {
    return sgl_rad(deg);
}
extern(C) float sgl_deg(float) @system @nogc nothrow;
float asDegrees(float rad) @trusted @nogc nothrow {
    return sgl_deg(rad);
}
extern(C) Error sgl_error() @system @nogc nothrow;
Error getError() @trusted @nogc nothrow {
    return sgl_error();
}
extern(C) Error sgl_context_error(Context) @system @nogc nothrow;
Error contextError(Context ctx) @trusted @nogc nothrow {
    return sgl_context_error(ctx);
}
extern(C) Context sgl_make_context(const ContextDesc *) @system @nogc nothrow;
Context makeContext(ref ContextDesc desc) @trusted @nogc nothrow {
    return sgl_make_context(&desc);
}
extern(C) void sgl_destroy_context(Context) @system @nogc nothrow;
void destroyContext(Context ctx) @trusted @nogc nothrow {
    sgl_destroy_context(ctx);
}
extern(C) void sgl_set_context(Context) @system @nogc nothrow;
void setContext(Context ctx) @trusted @nogc nothrow {
    sgl_set_context(ctx);
}
extern(C) Context sgl_get_context() @system @nogc nothrow;
Context getContext() @trusted @nogc nothrow {
    return sgl_get_context();
}
extern(C) Context sgl_default_context() @system @nogc nothrow;
Context defaultContext() @trusted @nogc nothrow {
    return sgl_default_context();
}
extern(C) void sgl_draw() @system @nogc nothrow;
void draw() @trusted @nogc nothrow {
    sgl_draw();
}
extern(C) void sgl_context_draw(Context) @system @nogc nothrow;
void contextDraw(Context ctx) @trusted @nogc nothrow {
    sgl_context_draw(ctx);
}
extern(C) void sgl_draw_layer(int) @system @nogc nothrow;
void drawLayer(int layer_id) @trusted @nogc nothrow {
    sgl_draw_layer(layer_id);
}
extern(C) void sgl_context_draw_layer(Context, int) @system @nogc nothrow;
void contextDrawLayer(Context ctx, int layer_id) @trusted @nogc nothrow {
    sgl_context_draw_layer(ctx, layer_id);
}
extern(C) Pipeline sgl_make_pipeline(const sg.PipelineDesc *) @system @nogc nothrow;
Pipeline makePipeline(ref sg.PipelineDesc desc) @trusted @nogc nothrow {
    return sgl_make_pipeline(&desc);
}
extern(C) Pipeline sgl_context_make_pipeline(Context, const sg.PipelineDesc *) @system @nogc nothrow;
Pipeline contextMakePipeline(Context ctx, ref sg.PipelineDesc desc) @trusted @nogc nothrow {
    return sgl_context_make_pipeline(ctx, &desc);
}
extern(C) void sgl_destroy_pipeline(Pipeline) @system @nogc nothrow;
void destroyPipeline(Pipeline pip) @trusted @nogc nothrow {
    sgl_destroy_pipeline(pip);
}
extern(C) void sgl_defaults() @system @nogc nothrow;
void defaults() @trusted @nogc nothrow {
    sgl_defaults();
}
extern(C) void sgl_viewport(int, int, int, int, bool) @system @nogc nothrow;
void viewport(int x, int y, int w, int h, bool origin_top_left) @trusted @nogc nothrow {
    sgl_viewport(x, y, w, h, origin_top_left);
}
extern(C) void sgl_viewportf(float, float, float, float, bool) @system @nogc nothrow;
void viewportf(float x, float y, float w, float h, bool origin_top_left) @trusted @nogc nothrow {
    sgl_viewportf(x, y, w, h, origin_top_left);
}
extern(C) void sgl_scissor_rect(int, int, int, int, bool) @system @nogc nothrow;
void scissorRect(int x, int y, int w, int h, bool origin_top_left) @trusted @nogc nothrow {
    sgl_scissor_rect(x, y, w, h, origin_top_left);
}
extern(C) void sgl_scissor_rectf(float, float, float, float, bool) @system @nogc nothrow;
void scissorRectf(float x, float y, float w, float h, bool origin_top_left) @trusted @nogc nothrow {
    sgl_scissor_rectf(x, y, w, h, origin_top_left);
}
extern(C) void sgl_enable_texture() @system @nogc nothrow;
void enableTexture() @trusted @nogc nothrow {
    sgl_enable_texture();
}
extern(C) void sgl_disable_texture() @system @nogc nothrow;
void disableTexture() @trusted @nogc nothrow {
    sgl_disable_texture();
}
extern(C) void sgl_texture(sg.Image, sg.Sampler) @system @nogc nothrow;
void texture(sg.Image img, sg.Sampler smp) @trusted @nogc nothrow {
    sgl_texture(img, smp);
}
extern(C) void sgl_layer(int) @system @nogc nothrow;
void layer(int layer_id) @trusted @nogc nothrow {
    sgl_layer(layer_id);
}
extern(C) void sgl_load_default_pipeline() @system @nogc nothrow;
void loadDefaultPipeline() @trusted @nogc nothrow {
    sgl_load_default_pipeline();
}
extern(C) void sgl_load_pipeline(Pipeline) @system @nogc nothrow;
void loadPipeline(Pipeline pip) @trusted @nogc nothrow {
    sgl_load_pipeline(pip);
}
extern(C) void sgl_push_pipeline() @system @nogc nothrow;
void pushPipeline() @trusted @nogc nothrow {
    sgl_push_pipeline();
}
extern(C) void sgl_pop_pipeline() @system @nogc nothrow;
void popPipeline() @trusted @nogc nothrow {
    sgl_pop_pipeline();
}
extern(C) void sgl_matrix_mode_modelview() @system @nogc nothrow;
void matrixModeModelview() @trusted @nogc nothrow {
    sgl_matrix_mode_modelview();
}
extern(C) void sgl_matrix_mode_projection() @system @nogc nothrow;
void matrixModeProjection() @trusted @nogc nothrow {
    sgl_matrix_mode_projection();
}
extern(C) void sgl_matrix_mode_texture() @system @nogc nothrow;
void matrixModeTexture() @trusted @nogc nothrow {
    sgl_matrix_mode_texture();
}
extern(C) void sgl_load_identity() @system @nogc nothrow;
void loadIdentity() @trusted @nogc nothrow {
    sgl_load_identity();
}
extern(C) void sgl_load_matrix(const float *) @system @nogc nothrow;
void loadMatrix(const float * m) @trusted @nogc nothrow {
    sgl_load_matrix(m);
}
extern(C) void sgl_load_transpose_matrix(const float *) @system @nogc nothrow;
void loadTransposeMatrix(const float * m) @trusted @nogc nothrow {
    sgl_load_transpose_matrix(m);
}
extern(C) void sgl_mult_matrix(const float *) @system @nogc nothrow;
void multMatrix(const float * m) @trusted @nogc nothrow {
    sgl_mult_matrix(m);
}
extern(C) void sgl_mult_transpose_matrix(const float *) @system @nogc nothrow;
void multTransposeMatrix(const float * m) @trusted @nogc nothrow {
    sgl_mult_transpose_matrix(m);
}
extern(C) void sgl_rotate(float, float, float, float) @system @nogc nothrow;
void rotate(float angle_rad, float x, float y, float z) @trusted @nogc nothrow {
    sgl_rotate(angle_rad, x, y, z);
}
extern(C) void sgl_scale(float, float, float) @system @nogc nothrow;
void scale(float x, float y, float z) @trusted @nogc nothrow {
    sgl_scale(x, y, z);
}
extern(C) void sgl_translate(float, float, float) @system @nogc nothrow;
void translate(float x, float y, float z) @trusted @nogc nothrow {
    sgl_translate(x, y, z);
}
extern(C) void sgl_frustum(float, float, float, float, float, float) @system @nogc nothrow;
void frustum(float l, float r, float b, float t, float n, float f) @trusted @nogc nothrow {
    sgl_frustum(l, r, b, t, n, f);
}
extern(C) void sgl_ortho(float, float, float, float, float, float) @system @nogc nothrow;
void ortho(float l, float r, float b, float t, float n, float f) @trusted @nogc nothrow {
    sgl_ortho(l, r, b, t, n, f);
}
extern(C) void sgl_perspective(float, float, float, float) @system @nogc nothrow;
void perspective(float fov_y, float aspect, float z_near, float z_far) @trusted @nogc nothrow {
    sgl_perspective(fov_y, aspect, z_near, z_far);
}
extern(C) void sgl_lookat(float, float, float, float, float, float, float, float, float) @system @nogc nothrow;
void lookat(float eye_x, float eye_y, float eye_z, float center_x, float center_y, float center_z, float up_x, float up_y, float up_z) @trusted @nogc nothrow {
    sgl_lookat(eye_x, eye_y, eye_z, center_x, center_y, center_z, up_x, up_y, up_z);
}
extern(C) void sgl_push_matrix() @system @nogc nothrow;
void pushMatrix() @trusted @nogc nothrow {
    sgl_push_matrix();
}
extern(C) void sgl_pop_matrix() @system @nogc nothrow;
void popMatrix() @trusted @nogc nothrow {
    sgl_pop_matrix();
}
extern(C) void sgl_t2f(float, float) @system @nogc nothrow;
void t2f(float u, float v) @trusted @nogc nothrow {
    sgl_t2f(u, v);
}
extern(C) void sgl_c3f(float, float, float) @system @nogc nothrow;
void c3f(float r, float g, float b) @trusted @nogc nothrow {
    sgl_c3f(r, g, b);
}
extern(C) void sgl_c4f(float, float, float, float) @system @nogc nothrow;
void c4f(float r, float g, float b, float a) @trusted @nogc nothrow {
    sgl_c4f(r, g, b, a);
}
extern(C) void sgl_c3b(ubyte, ubyte, ubyte) @system @nogc nothrow;
void c3b(ubyte r, ubyte g, ubyte b) @trusted @nogc nothrow {
    sgl_c3b(r, g, b);
}
extern(C) void sgl_c4b(ubyte, ubyte, ubyte, ubyte) @system @nogc nothrow;
void c4b(ubyte r, ubyte g, ubyte b, ubyte a) @trusted @nogc nothrow {
    sgl_c4b(r, g, b, a);
}
extern(C) void sgl_c1i(uint) @system @nogc nothrow;
void c1i(uint rgba) @trusted @nogc nothrow {
    sgl_c1i(rgba);
}
extern(C) void sgl_point_size(float) @system @nogc nothrow;
void pointSize(float s) @trusted @nogc nothrow {
    sgl_point_size(s);
}
extern(C) void sgl_begin_points() @system @nogc nothrow;
void beginPoints() @trusted @nogc nothrow {
    sgl_begin_points();
}
extern(C) void sgl_begin_lines() @system @nogc nothrow;
void beginLines() @trusted @nogc nothrow {
    sgl_begin_lines();
}
extern(C) void sgl_begin_line_strip() @system @nogc nothrow;
void beginLineStrip() @trusted @nogc nothrow {
    sgl_begin_line_strip();
}
extern(C) void sgl_begin_triangles() @system @nogc nothrow;
void beginTriangles() @trusted @nogc nothrow {
    sgl_begin_triangles();
}
extern(C) void sgl_begin_triangle_strip() @system @nogc nothrow;
void beginTriangleStrip() @trusted @nogc nothrow {
    sgl_begin_triangle_strip();
}
extern(C) void sgl_begin_quads() @system @nogc nothrow;
void beginQuads() @trusted @nogc nothrow {
    sgl_begin_quads();
}
extern(C) void sgl_v2f(float, float) @system @nogc nothrow;
void v2f(float x, float y) @trusted @nogc nothrow {
    sgl_v2f(x, y);
}
extern(C) void sgl_v3f(float, float, float) @system @nogc nothrow;
void v3f(float x, float y, float z) @trusted @nogc nothrow {
    sgl_v3f(x, y, z);
}
extern(C) void sgl_v2f_t2f(float, float, float, float) @system @nogc nothrow;
void v2fT2f(float x, float y, float u, float v) @trusted @nogc nothrow {
    sgl_v2f_t2f(x, y, u, v);
}
extern(C) void sgl_v3f_t2f(float, float, float, float, float) @system @nogc nothrow;
void v3fT2f(float x, float y, float z, float u, float v) @trusted @nogc nothrow {
    sgl_v3f_t2f(x, y, z, u, v);
}
extern(C) void sgl_v2f_c3f(float, float, float, float, float) @system @nogc nothrow;
void v2fC3f(float x, float y, float r, float g, float b) @trusted @nogc nothrow {
    sgl_v2f_c3f(x, y, r, g, b);
}
extern(C) void sgl_v2f_c3b(float, float, ubyte, ubyte, ubyte) @system @nogc nothrow;
void v2fC3b(float x, float y, ubyte r, ubyte g, ubyte b) @trusted @nogc nothrow {
    sgl_v2f_c3b(x, y, r, g, b);
}
extern(C) void sgl_v2f_c4f(float, float, float, float, float, float) @system @nogc nothrow;
void v2fC4f(float x, float y, float r, float g, float b, float a) @trusted @nogc nothrow {
    sgl_v2f_c4f(x, y, r, g, b, a);
}
extern(C) void sgl_v2f_c4b(float, float, ubyte, ubyte, ubyte, ubyte) @system @nogc nothrow;
void v2fC4b(float x, float y, ubyte r, ubyte g, ubyte b, ubyte a) @trusted @nogc nothrow {
    sgl_v2f_c4b(x, y, r, g, b, a);
}
extern(C) void sgl_v2f_c1i(float, float, uint) @system @nogc nothrow;
void v2fC1i(float x, float y, uint rgba) @trusted @nogc nothrow {
    sgl_v2f_c1i(x, y, rgba);
}
extern(C) void sgl_v3f_c3f(float, float, float, float, float, float) @system @nogc nothrow;
void v3fC3f(float x, float y, float z, float r, float g, float b) @trusted @nogc nothrow {
    sgl_v3f_c3f(x, y, z, r, g, b);
}
extern(C) void sgl_v3f_c3b(float, float, float, ubyte, ubyte, ubyte) @system @nogc nothrow;
void v3fC3b(float x, float y, float z, ubyte r, ubyte g, ubyte b) @trusted @nogc nothrow {
    sgl_v3f_c3b(x, y, z, r, g, b);
}
extern(C) void sgl_v3f_c4f(float, float, float, float, float, float, float) @system @nogc nothrow;
void v3fC4f(float x, float y, float z, float r, float g, float b, float a) @trusted @nogc nothrow {
    sgl_v3f_c4f(x, y, z, r, g, b, a);
}
extern(C) void sgl_v3f_c4b(float, float, float, ubyte, ubyte, ubyte, ubyte) @system @nogc nothrow;
void v3fC4b(float x, float y, float z, ubyte r, ubyte g, ubyte b, ubyte a) @trusted @nogc nothrow {
    sgl_v3f_c4b(x, y, z, r, g, b, a);
}
extern(C) void sgl_v3f_c1i(float, float, float, uint) @system @nogc nothrow;
void v3fC1i(float x, float y, float z, uint rgba) @trusted @nogc nothrow {
    sgl_v3f_c1i(x, y, z, rgba);
}
extern(C) void sgl_v2f_t2f_c3f(float, float, float, float, float, float, float) @system @nogc nothrow;
void v2fT2fC3f(float x, float y, float u, float v, float r, float g, float b) @trusted @nogc nothrow {
    sgl_v2f_t2f_c3f(x, y, u, v, r, g, b);
}
extern(C) void sgl_v2f_t2f_c3b(float, float, float, float, ubyte, ubyte, ubyte) @system @nogc nothrow;
void v2fT2fC3b(float x, float y, float u, float v, ubyte r, ubyte g, ubyte b) @trusted @nogc nothrow {
    sgl_v2f_t2f_c3b(x, y, u, v, r, g, b);
}
extern(C) void sgl_v2f_t2f_c4f(float, float, float, float, float, float, float, float) @system @nogc nothrow;
void v2fT2fC4f(float x, float y, float u, float v, float r, float g, float b, float a) @trusted @nogc nothrow {
    sgl_v2f_t2f_c4f(x, y, u, v, r, g, b, a);
}
extern(C) void sgl_v2f_t2f_c4b(float, float, float, float, ubyte, ubyte, ubyte, ubyte) @system @nogc nothrow;
void v2fT2fC4b(float x, float y, float u, float v, ubyte r, ubyte g, ubyte b, ubyte a) @trusted @nogc nothrow {
    sgl_v2f_t2f_c4b(x, y, u, v, r, g, b, a);
}
extern(C) void sgl_v2f_t2f_c1i(float, float, float, float, uint) @system @nogc nothrow;
void v2fT2fC1i(float x, float y, float u, float v, uint rgba) @trusted @nogc nothrow {
    sgl_v2f_t2f_c1i(x, y, u, v, rgba);
}
extern(C) void sgl_v3f_t2f_c3f(float, float, float, float, float, float, float, float) @system @nogc nothrow;
void v3fT2fC3f(float x, float y, float z, float u, float v, float r, float g, float b) @trusted @nogc nothrow {
    sgl_v3f_t2f_c3f(x, y, z, u, v, r, g, b);
}
extern(C) void sgl_v3f_t2f_c3b(float, float, float, float, float, ubyte, ubyte, ubyte) @system @nogc nothrow;
void v3fT2fC3b(float x, float y, float z, float u, float v, ubyte r, ubyte g, ubyte b) @trusted @nogc nothrow {
    sgl_v3f_t2f_c3b(x, y, z, u, v, r, g, b);
}
extern(C) void sgl_v3f_t2f_c4f(float, float, float, float, float, float, float, float, float) @system @nogc nothrow;
void v3fT2fC4f(float x, float y, float z, float u, float v, float r, float g, float b, float a) @trusted @nogc nothrow {
    sgl_v3f_t2f_c4f(x, y, z, u, v, r, g, b, a);
}
extern(C) void sgl_v3f_t2f_c4b(float, float, float, float, float, ubyte, ubyte, ubyte, ubyte) @system @nogc nothrow;
void v3fT2fC4b(float x, float y, float z, float u, float v, ubyte r, ubyte g, ubyte b, ubyte a) @trusted @nogc nothrow {
    sgl_v3f_t2f_c4b(x, y, z, u, v, r, g, b, a);
}
extern(C) void sgl_v3f_t2f_c1i(float, float, float, float, float, uint) @system @nogc nothrow;
void v3fT2fC1i(float x, float y, float z, float u, float v, uint rgba) @trusted @nogc nothrow {
    sgl_v3f_t2f_c1i(x, y, z, u, v, rgba);
}
extern(C) void sgl_end() @system @nogc nothrow;
void end() @trusted @nogc nothrow {
    sgl_end();
}
