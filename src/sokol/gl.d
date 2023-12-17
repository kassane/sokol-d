// machine generated, do not edit

module sokol.gl;
import sg = sokol.gfx;

// helper function to convert a C string to a D string
string cStrToDString(const(char*) c_str) {
    import std.conv: to;
    return c_str.to!string;
}
enum LogItem {
    OK,
    MALLOC_FAILED,
    MAKE_PIPELINE_FAILED,
    PIPELINE_POOL_EXHAUSTED,
    ADD_COMMIT_LISTENER_FAILED,
    CONTEXT_POOL_EXHAUSTED,
    CANNOT_DESTROY_DEFAULT_CONTEXT,
}
struct Logger {
    extern(C) void function(const (char*), uint, uint, const (char*), uint, const (char*), void*) func;
    void* user_data;
}
struct Pipeline {
    uint id;
}
struct Context {
    uint id;
}
enum Error {
    NO_ERROR = 0,
    VERTICES_FULL,
    UNIFORMS_FULL,
    COMMANDS_FULL,
    STACK_OVERFLOW,
    STACK_UNDERFLOW,
    NO_CONTEXT,
}
struct ContextDesc {
    int max_vertices;
    int max_commands;
    sg.PixelFormat color_format;
    sg.PixelFormat depth_format;
    int sample_count;
}
struct Allocator {
    void* function(size_t, void*) alloc_fn;
    void function(void*, void*) free_fn;
    void* user_data;
}
struct Desc {
    int max_vertices;
    int max_commands;
    int context_pool_size;
    int pipeline_pool_size;
    sg.PixelFormat color_format;
    sg.PixelFormat depth_format;
    int sample_count;
    sg.FaceWinding face_winding;
    Allocator allocator;
    Logger logger;
}
extern(C) void sgl_setup(const Desc *);
void setup(Desc desc) {
    sgl_setup(&desc);
}
extern(C) void sgl_shutdown();
void shutdown() {
    sgl_shutdown();
}
extern(C) float sgl_rad(float);
float asRadians(float deg) {
    return sgl_rad(deg);
}
extern(C) float sgl_deg(float);
float asDegrees(float rad) {
    return sgl_deg(rad);
}
extern(C) Error sgl_error();
Error getError() {
    return sgl_error();
}
extern(C) Error sgl_context_error(Context);
Error contextError(Context ctx) {
    return sgl_context_error(ctx);
}
extern(C) Context sgl_make_context(const ContextDesc *);
Context makeContext(ContextDesc desc) {
    return sgl_make_context(&desc);
}
extern(C) void sgl_destroy_context(Context);
void destroyContext(Context ctx) {
    sgl_destroy_context(ctx);
}
extern(C) void sgl_set_context(Context);
void setContext(Context ctx) {
    sgl_set_context(ctx);
}
extern(C) Context sgl_get_context();
Context getContext() {
    return sgl_get_context();
}
extern(C) Context sgl_default_context();
Context defaultContext() {
    return sgl_default_context();
}
extern(C) void sgl_draw();
void draw() {
    sgl_draw();
}
extern(C) void sgl_context_draw(Context);
void contextDraw(Context ctx) {
    sgl_context_draw(ctx);
}
extern(C) void sgl_draw_layer(int);
void drawLayer(int layer_id) {
    sgl_draw_layer(layer_id);
}
extern(C) void sgl_context_draw_layer(Context, int);
void contextDrawLayer(Context ctx, int layer_id) {
    sgl_context_draw_layer(ctx, layer_id);
}
extern(C) Pipeline sgl_make_pipeline(const sg.PipelineDesc *);
Pipeline makePipeline(sg.PipelineDesc desc) {
    return sgl_make_pipeline(&desc);
}
extern(C) Pipeline sgl_context_make_pipeline(Context, const sg.PipelineDesc *);
Pipeline contextMakePipeline(Context ctx, sg.PipelineDesc desc) {
    return sgl_context_make_pipeline(ctx, &desc);
}
extern(C) void sgl_destroy_pipeline(Pipeline);
void destroyPipeline(Pipeline pip) {
    sgl_destroy_pipeline(pip);
}
extern(C) void sgl_defaults();
void defaults() {
    sgl_defaults();
}
extern(C) void sgl_viewport(int, int, int, int, bool);
void viewport(int x, int y, int w, int h, bool origin_top_left) {
    sgl_viewport(x, y, w, h, origin_top_left);
}
extern(C) void sgl_viewportf(float, float, float, float, bool);
void viewportf(float x, float y, float w, float h, bool origin_top_left) {
    sgl_viewportf(x, y, w, h, origin_top_left);
}
extern(C) void sgl_scissor_rect(int, int, int, int, bool);
void scissorRect(int x, int y, int w, int h, bool origin_top_left) {
    sgl_scissor_rect(x, y, w, h, origin_top_left);
}
extern(C) void sgl_scissor_rectf(float, float, float, float, bool);
void scissorRectf(float x, float y, float w, float h, bool origin_top_left) {
    sgl_scissor_rectf(x, y, w, h, origin_top_left);
}
extern(C) void sgl_enable_texture();
void enableTexture() {
    sgl_enable_texture();
}
extern(C) void sgl_disable_texture();
void disableTexture() {
    sgl_disable_texture();
}
extern(C) void sgl_texture(sg.Image, sg.Sampler);
void texture(sg.Image img, sg.Sampler smp) {
    sgl_texture(img, smp);
}
extern(C) void sgl_layer(int);
void layer(int layer_id) {
    sgl_layer(layer_id);
}
extern(C) void sgl_load_default_pipeline();
void loadDefaultPipeline() {
    sgl_load_default_pipeline();
}
extern(C) void sgl_load_pipeline(Pipeline);
void loadPipeline(Pipeline pip) {
    sgl_load_pipeline(pip);
}
extern(C) void sgl_push_pipeline();
void pushPipeline() {
    sgl_push_pipeline();
}
extern(C) void sgl_pop_pipeline();
void popPipeline() {
    sgl_pop_pipeline();
}
extern(C) void sgl_matrix_mode_modelview();
void matrixModeModelview() {
    sgl_matrix_mode_modelview();
}
extern(C) void sgl_matrix_mode_projection();
void matrixModeProjection() {
    sgl_matrix_mode_projection();
}
extern(C) void sgl_matrix_mode_texture();
void matrixModeTexture() {
    sgl_matrix_mode_texture();
}
extern(C) void sgl_load_identity();
void loadIdentity() {
    sgl_load_identity();
}
extern(C) void sgl_load_matrix(const float *);
void loadMatrix(const float * m) {
    sgl_load_matrix(m);
}
extern(C) void sgl_load_transpose_matrix(const float *);
void loadTransposeMatrix(const float * m) {
    sgl_load_transpose_matrix(m);
}
extern(C) void sgl_mult_matrix(const float *);
void multMatrix(const float * m) {
    sgl_mult_matrix(m);
}
extern(C) void sgl_mult_transpose_matrix(const float *);
void multTransposeMatrix(const float * m) {
    sgl_mult_transpose_matrix(m);
}
extern(C) void sgl_rotate(float, float, float, float);
void rotate(float angle_rad, float x, float y, float z) {
    sgl_rotate(angle_rad, x, y, z);
}
extern(C) void sgl_scale(float, float, float);
void scale(float x, float y, float z) {
    sgl_scale(x, y, z);
}
extern(C) void sgl_translate(float, float, float);
void translate(float x, float y, float z) {
    sgl_translate(x, y, z);
}
extern(C) void sgl_frustum(float, float, float, float, float, float);
void frustum(float l, float r, float b, float t, float n, float f) {
    sgl_frustum(l, r, b, t, n, f);
}
extern(C) void sgl_ortho(float, float, float, float, float, float);
void ortho(float l, float r, float b, float t, float n, float f) {
    sgl_ortho(l, r, b, t, n, f);
}
extern(C) void sgl_perspective(float, float, float, float);
void perspective(float fov_y, float aspect, float z_near, float z_far) {
    sgl_perspective(fov_y, aspect, z_near, z_far);
}
extern(C) void sgl_lookat(float, float, float, float, float, float, float, float, float);
void lookat(float eye_x, float eye_y, float eye_z, float center_x, float center_y, float center_z, float up_x, float up_y, float up_z) {
    sgl_lookat(eye_x, eye_y, eye_z, center_x, center_y, center_z, up_x, up_y, up_z);
}
extern(C) void sgl_push_matrix();
void pushMatrix() {
    sgl_push_matrix();
}
extern(C) void sgl_pop_matrix();
void popMatrix() {
    sgl_pop_matrix();
}
extern(C) void sgl_t2f(float, float);
void t2f(float u, float v) {
    sgl_t2f(u, v);
}
extern(C) void sgl_c3f(float, float, float);
void c3f(float r, float g, float b) {
    sgl_c3f(r, g, b);
}
extern(C) void sgl_c4f(float, float, float, float);
void c4f(float r, float g, float b, float a) {
    sgl_c4f(r, g, b, a);
}
extern(C) void sgl_c3b(ubyte, ubyte, ubyte);
void c3b(ubyte r, ubyte g, ubyte b) {
    sgl_c3b(r, g, b);
}
extern(C) void sgl_c4b(ubyte, ubyte, ubyte, ubyte);
void c4b(ubyte r, ubyte g, ubyte b, ubyte a) {
    sgl_c4b(r, g, b, a);
}
extern(C) void sgl_c1i(uint);
void c1i(uint rgba) {
    sgl_c1i(rgba);
}
extern(C) void sgl_point_size(float);
void pointSize(float s) {
    sgl_point_size(s);
}
extern(C) void sgl_begin_points();
void beginPoints() {
    sgl_begin_points();
}
extern(C) void sgl_begin_lines();
void beginLines() {
    sgl_begin_lines();
}
extern(C) void sgl_begin_line_strip();
void beginLineStrip() {
    sgl_begin_line_strip();
}
extern(C) void sgl_begin_triangles();
void beginTriangles() {
    sgl_begin_triangles();
}
extern(C) void sgl_begin_triangle_strip();
void beginTriangleStrip() {
    sgl_begin_triangle_strip();
}
extern(C) void sgl_begin_quads();
void beginQuads() {
    sgl_begin_quads();
}
extern(C) void sgl_v2f(float, float);
void v2f(float x, float y) {
    sgl_v2f(x, y);
}
extern(C) void sgl_v3f(float, float, float);
void v3f(float x, float y, float z) {
    sgl_v3f(x, y, z);
}
extern(C) void sgl_v2f_t2f(float, float, float, float);
void v2fT2f(float x, float y, float u, float v) {
    sgl_v2f_t2f(x, y, u, v);
}
extern(C) void sgl_v3f_t2f(float, float, float, float, float);
void v3fT2f(float x, float y, float z, float u, float v) {
    sgl_v3f_t2f(x, y, z, u, v);
}
extern(C) void sgl_v2f_c3f(float, float, float, float, float);
void v2fC3f(float x, float y, float r, float g, float b) {
    sgl_v2f_c3f(x, y, r, g, b);
}
extern(C) void sgl_v2f_c3b(float, float, ubyte, ubyte, ubyte);
void v2fC3b(float x, float y, ubyte r, ubyte g, ubyte b) {
    sgl_v2f_c3b(x, y, r, g, b);
}
extern(C) void sgl_v2f_c4f(float, float, float, float, float, float);
void v2fC4f(float x, float y, float r, float g, float b, float a) {
    sgl_v2f_c4f(x, y, r, g, b, a);
}
extern(C) void sgl_v2f_c4b(float, float, ubyte, ubyte, ubyte, ubyte);
void v2fC4b(float x, float y, ubyte r, ubyte g, ubyte b, ubyte a) {
    sgl_v2f_c4b(x, y, r, g, b, a);
}
extern(C) void sgl_v2f_c1i(float, float, uint);
void v2fC1i(float x, float y, uint rgba) {
    sgl_v2f_c1i(x, y, rgba);
}
extern(C) void sgl_v3f_c3f(float, float, float, float, float, float);
void v3fC3f(float x, float y, float z, float r, float g, float b) {
    sgl_v3f_c3f(x, y, z, r, g, b);
}
extern(C) void sgl_v3f_c3b(float, float, float, ubyte, ubyte, ubyte);
void v3fC3b(float x, float y, float z, ubyte r, ubyte g, ubyte b) {
    sgl_v3f_c3b(x, y, z, r, g, b);
}
extern(C) void sgl_v3f_c4f(float, float, float, float, float, float, float);
void v3fC4f(float x, float y, float z, float r, float g, float b, float a) {
    sgl_v3f_c4f(x, y, z, r, g, b, a);
}
extern(C) void sgl_v3f_c4b(float, float, float, ubyte, ubyte, ubyte, ubyte);
void v3fC4b(float x, float y, float z, ubyte r, ubyte g, ubyte b, ubyte a) {
    sgl_v3f_c4b(x, y, z, r, g, b, a);
}
extern(C) void sgl_v3f_c1i(float, float, float, uint);
void v3fC1i(float x, float y, float z, uint rgba) {
    sgl_v3f_c1i(x, y, z, rgba);
}
extern(C) void sgl_v2f_t2f_c3f(float, float, float, float, float, float, float);
void v2fT2fC3f(float x, float y, float u, float v, float r, float g, float b) {
    sgl_v2f_t2f_c3f(x, y, u, v, r, g, b);
}
extern(C) void sgl_v2f_t2f_c3b(float, float, float, float, ubyte, ubyte, ubyte);
void v2fT2fC3b(float x, float y, float u, float v, ubyte r, ubyte g, ubyte b) {
    sgl_v2f_t2f_c3b(x, y, u, v, r, g, b);
}
extern(C) void sgl_v2f_t2f_c4f(float, float, float, float, float, float, float, float);
void v2fT2fC4f(float x, float y, float u, float v, float r, float g, float b, float a) {
    sgl_v2f_t2f_c4f(x, y, u, v, r, g, b, a);
}
extern(C) void sgl_v2f_t2f_c4b(float, float, float, float, ubyte, ubyte, ubyte, ubyte);
void v2fT2fC4b(float x, float y, float u, float v, ubyte r, ubyte g, ubyte b, ubyte a) {
    sgl_v2f_t2f_c4b(x, y, u, v, r, g, b, a);
}
extern(C) void sgl_v2f_t2f_c1i(float, float, float, float, uint);
void v2fT2fC1i(float x, float y, float u, float v, uint rgba) {
    sgl_v2f_t2f_c1i(x, y, u, v, rgba);
}
extern(C) void sgl_v3f_t2f_c3f(float, float, float, float, float, float, float, float);
void v3fT2fC3f(float x, float y, float z, float u, float v, float r, float g, float b) {
    sgl_v3f_t2f_c3f(x, y, z, u, v, r, g, b);
}
extern(C) void sgl_v3f_t2f_c3b(float, float, float, float, float, ubyte, ubyte, ubyte);
void v3fT2fC3b(float x, float y, float z, float u, float v, ubyte r, ubyte g, ubyte b) {
    sgl_v3f_t2f_c3b(x, y, z, u, v, r, g, b);
}
extern(C) void sgl_v3f_t2f_c4f(float, float, float, float, float, float, float, float, float);
void v3fT2fC4f(float x, float y, float z, float u, float v, float r, float g, float b, float a) {
    sgl_v3f_t2f_c4f(x, y, z, u, v, r, g, b, a);
}
extern(C) void sgl_v3f_t2f_c4b(float, float, float, float, float, ubyte, ubyte, ubyte, ubyte);
void v3fT2fC4b(float x, float y, float z, float u, float v, ubyte r, ubyte g, ubyte b, ubyte a) {
    sgl_v3f_t2f_c4b(x, y, z, u, v, r, g, b, a);
}
extern(C) void sgl_v3f_t2f_c1i(float, float, float, float, float, uint);
void v3fT2fC1i(float x, float y, float z, float u, float v, uint rgba) {
    sgl_v3f_t2f_c1i(x, y, z, u, v, rgba);
}
extern(C) void sgl_end();
void end() {
    sgl_end();
}
