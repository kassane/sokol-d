/++
+ Machine generated D bindings for Sokol library.
+ 
+     Generated on: 2025-06-15 12:45:33
+ 
+     Source header: sokol_gl.h
+     Module: sokol.gl
+ 
+     Do not edit manually; regenerate using gen_d.py.
+/
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
/++
+ sgl_logger_t
+ 
+     Used in sgl_desc_t to provide a custom logging and error reporting
+     callback to sokol-gl.
+/
extern(C) struct Logger {
    extern(C) void function(const(char)*, uint, uint, const(char)*, uint, const(char)*, void*) func = null;
    void* user_data = null;
}
/++
+ sokol_gl pipeline handle (created with sgl_make_pipeline())
+/
extern(C) struct Pipeline {
    uint id = 0;
}
/++
+ a context handle (created with sgl_make_context())
+/
extern(C) struct Context {
    uint id = 0;
}
/++
+ sgl_error_t
+ 
+     Errors are reset each frame after calling sgl_draw(),
+     get the last error code with sgl_error()
+/
extern(C) struct Error {
    bool any = false;
    bool vertices_full = false;
    bool uniforms_full = false;
    bool commands_full = false;
    bool stack_overflow = false;
    bool stack_underflow = false;
    bool no_context = false;
}
/++
+ sgl_context_desc_t
+ 
+     Describes the initialization parameters of a rendering context.
+     Creating additional contexts is useful if you want to render
+     in separate sokol-gfx passes.
+/
extern(C) struct ContextDesc {
    int max_vertices = 0;
    int max_commands = 0;
    sg.PixelFormat color_format = sg.PixelFormat.Default;
    sg.PixelFormat depth_format = sg.PixelFormat.Default;
    int sample_count = 0;
}
/++
+ sgl_allocator_t
+ 
+     Used in sgl_desc_t to provide custom memory-alloc and -free functions
+     to sokol_gl.h. If memory management should be overridden, both the
+     alloc and free function must be provided (e.g. it's not valid to
+     override one function but not the other).
+/
extern(C) struct Allocator {
    extern(C) void* function(size_t, void*) alloc_fn = null;
    extern(C) void function(void*, void*) free_fn = null;
    void* user_data = null;
}
extern(C) struct Desc {
    int max_vertices = 0;
    int max_commands = 0;
    int context_pool_size = 0;
    int pipeline_pool_size = 0;
    sg.PixelFormat color_format = sg.PixelFormat.Default;
    sg.PixelFormat depth_format = sg.PixelFormat.Default;
    int sample_count = 0;
    sg.FaceWinding face_winding = sg.FaceWinding.Default;
    Allocator allocator = {};
    Logger logger = {};
}
/++
+ setup/shutdown/misc
+/
extern(C) void sgl_setup(const Desc* desc) @system @nogc nothrow pure;
void setup(scope ref Desc desc) @trusted @nogc nothrow pure {
    sgl_setup(&desc);
}
extern(C) void sgl_shutdown() @system @nogc nothrow pure;
void shutdown() @trusted @nogc nothrow pure {
    sgl_shutdown();
}
extern(C) float sgl_rad(float deg) @system @nogc nothrow pure;
float asRadians(float deg) @trusted @nogc nothrow pure {
    return sgl_rad(deg);
}
extern(C) float sgl_deg(float rad) @system @nogc nothrow pure;
float asDegrees(float rad) @trusted @nogc nothrow pure {
    return sgl_deg(rad);
}
extern(C) Error sgl_error() @system @nogc nothrow pure;
Error getError() @trusted @nogc nothrow pure {
    return sgl_error();
}
extern(C) Error sgl_context_error(Context ctx) @system @nogc nothrow pure;
Error contextError(Context ctx) @trusted @nogc nothrow pure {
    return sgl_context_error(ctx);
}
/++
+ context functions
+/
extern(C) Context sgl_make_context(const ContextDesc* desc) @system @nogc nothrow pure;
Context makeContext(scope ref ContextDesc desc) @trusted @nogc nothrow pure {
    return sgl_make_context(&desc);
}
extern(C) void sgl_destroy_context(Context ctx) @system @nogc nothrow pure;
void destroyContext(Context ctx) @trusted @nogc nothrow pure {
    sgl_destroy_context(ctx);
}
extern(C) void sgl_set_context(Context ctx) @system @nogc nothrow pure;
void setContext(Context ctx) @trusted @nogc nothrow pure {
    sgl_set_context(ctx);
}
extern(C) Context sgl_get_context() @system @nogc nothrow pure;
Context getContext() @trusted @nogc nothrow pure {
    return sgl_get_context();
}
extern(C) Context sgl_default_context() @system @nogc nothrow pure;
Context defaultContext() @trusted @nogc nothrow pure {
    return sgl_default_context();
}
/++
+ get information about recorded vertices and commands in current context
+/
extern(C) int sgl_num_vertices() @system @nogc nothrow pure;
int numVertices() @trusted @nogc nothrow pure {
    return sgl_num_vertices();
}
extern(C) int sgl_num_commands() @system @nogc nothrow pure;
int numCommands() @trusted @nogc nothrow pure {
    return sgl_num_commands();
}
/++
+ draw recorded commands (call inside a sokol-gfx render pass)
+/
extern(C) void sgl_draw() @system @nogc nothrow pure;
void draw() @trusted @nogc nothrow pure {
    sgl_draw();
}
extern(C) void sgl_context_draw(Context ctx) @system @nogc nothrow pure;
void contextDraw(Context ctx) @trusted @nogc nothrow pure {
    sgl_context_draw(ctx);
}
extern(C) void sgl_draw_layer(int layer_id) @system @nogc nothrow pure;
void drawLayer(int layer_id) @trusted @nogc nothrow pure {
    sgl_draw_layer(layer_id);
}
extern(C) void sgl_context_draw_layer(Context ctx, int layer_id) @system @nogc nothrow pure;
void contextDrawLayer(Context ctx, int layer_id) @trusted @nogc nothrow pure {
    sgl_context_draw_layer(ctx, layer_id);
}
/++
+ create and destroy pipeline objects
+/
extern(C) Pipeline sgl_make_pipeline(const sg.PipelineDesc* desc) @system @nogc nothrow pure;
Pipeline makePipeline(scope ref sg.PipelineDesc desc) @trusted @nogc nothrow pure {
    return sgl_make_pipeline(&desc);
}
extern(C) Pipeline sgl_context_make_pipeline(Context ctx, const sg.PipelineDesc* desc) @system @nogc nothrow pure;
Pipeline contextMakePipeline(Context ctx, scope ref sg.PipelineDesc desc) @trusted @nogc nothrow pure {
    return sgl_context_make_pipeline(ctx, &desc);
}
extern(C) void sgl_destroy_pipeline(Pipeline pip) @system @nogc nothrow pure;
void destroyPipeline(Pipeline pip) @trusted @nogc nothrow pure {
    sgl_destroy_pipeline(pip);
}
/++
+ render state functions
+/
extern(C) void sgl_defaults() @system @nogc nothrow pure;
void defaults() @trusted @nogc nothrow pure {
    sgl_defaults();
}
extern(C) void sgl_viewport(int x, int y, int w, int h, bool origin_top_left) @system @nogc nothrow pure;
void viewport(int x, int y, int w, int h, bool origin_top_left) @trusted @nogc nothrow pure {
    sgl_viewport(x, y, w, h, origin_top_left);
}
extern(C) void sgl_viewportf(float x, float y, float w, float h, bool origin_top_left) @system @nogc nothrow pure;
void viewportf(float x, float y, float w, float h, bool origin_top_left) @trusted @nogc nothrow pure {
    sgl_viewportf(x, y, w, h, origin_top_left);
}
extern(C) void sgl_scissor_rect(int x, int y, int w, int h, bool origin_top_left) @system @nogc nothrow pure;
void scissorRect(int x, int y, int w, int h, bool origin_top_left) @trusted @nogc nothrow pure {
    sgl_scissor_rect(x, y, w, h, origin_top_left);
}
extern(C) void sgl_scissor_rectf(float x, float y, float w, float h, bool origin_top_left) @system @nogc nothrow pure;
void scissorRectf(float x, float y, float w, float h, bool origin_top_left) @trusted @nogc nothrow pure {
    sgl_scissor_rectf(x, y, w, h, origin_top_left);
}
extern(C) void sgl_enable_texture() @system @nogc nothrow pure;
void enableTexture() @trusted @nogc nothrow pure {
    sgl_enable_texture();
}
extern(C) void sgl_disable_texture() @system @nogc nothrow pure;
void disableTexture() @trusted @nogc nothrow pure {
    sgl_disable_texture();
}
extern(C) void sgl_texture(sg.Image img, sg.Sampler smp) @system @nogc nothrow pure;
void texture(sg.Image img, sg.Sampler smp) @trusted @nogc nothrow pure {
    sgl_texture(img, smp);
}
extern(C) void sgl_layer(int layer_id) @system @nogc nothrow pure;
void layer(int layer_id) @trusted @nogc nothrow pure {
    sgl_layer(layer_id);
}
/++
+ pipeline stack functions
+/
extern(C) void sgl_load_default_pipeline() @system @nogc nothrow pure;
void loadDefaultPipeline() @trusted @nogc nothrow pure {
    sgl_load_default_pipeline();
}
extern(C) void sgl_load_pipeline(Pipeline pip) @system @nogc nothrow pure;
void loadPipeline(Pipeline pip) @trusted @nogc nothrow pure {
    sgl_load_pipeline(pip);
}
extern(C) void sgl_push_pipeline() @system @nogc nothrow pure;
void pushPipeline() @trusted @nogc nothrow pure {
    sgl_push_pipeline();
}
extern(C) void sgl_pop_pipeline() @system @nogc nothrow pure;
void popPipeline() @trusted @nogc nothrow pure {
    sgl_pop_pipeline();
}
/++
+ matrix stack functions
+/
extern(C) void sgl_matrix_mode_modelview() @system @nogc nothrow pure;
void matrixModeModelview() @trusted @nogc nothrow pure {
    sgl_matrix_mode_modelview();
}
extern(C) void sgl_matrix_mode_projection() @system @nogc nothrow pure;
void matrixModeProjection() @trusted @nogc nothrow pure {
    sgl_matrix_mode_projection();
}
extern(C) void sgl_matrix_mode_texture() @system @nogc nothrow pure;
void matrixModeTexture() @trusted @nogc nothrow pure {
    sgl_matrix_mode_texture();
}
extern(C) void sgl_load_identity() @system @nogc nothrow pure;
void loadIdentity() @trusted @nogc nothrow pure {
    sgl_load_identity();
}
extern(C) void sgl_load_matrix(const float* m) @system @nogc nothrow pure;
void loadMatrix(const float* m) @trusted @nogc nothrow pure {
    sgl_load_matrix(m);
}
extern(C) void sgl_load_transpose_matrix(const float* m) @system @nogc nothrow pure;
void loadTransposeMatrix(const float* m) @trusted @nogc nothrow pure {
    sgl_load_transpose_matrix(m);
}
extern(C) void sgl_mult_matrix(const float* m) @system @nogc nothrow pure;
void multMatrix(const float* m) @trusted @nogc nothrow pure {
    sgl_mult_matrix(m);
}
extern(C) void sgl_mult_transpose_matrix(const float* m) @system @nogc nothrow pure;
void multTransposeMatrix(const float* m) @trusted @nogc nothrow pure {
    sgl_mult_transpose_matrix(m);
}
extern(C) void sgl_rotate(float angle_rad, float x, float y, float z) @system @nogc nothrow pure;
void rotate(float angle_rad, float x, float y, float z) @trusted @nogc nothrow pure {
    sgl_rotate(angle_rad, x, y, z);
}
extern(C) void sgl_scale(float x, float y, float z) @system @nogc nothrow pure;
void scale(float x, float y, float z) @trusted @nogc nothrow pure {
    sgl_scale(x, y, z);
}
extern(C) void sgl_translate(float x, float y, float z) @system @nogc nothrow pure;
void translate(float x, float y, float z) @trusted @nogc nothrow pure {
    sgl_translate(x, y, z);
}
extern(C) void sgl_frustum(float l, float r, float b, float t, float n, float f) @system @nogc nothrow pure;
void frustum(float l, float r, float b, float t, float n, float f) @trusted @nogc nothrow pure {
    sgl_frustum(l, r, b, t, n, f);
}
extern(C) void sgl_ortho(float l, float r, float b, float t, float n, float f) @system @nogc nothrow pure;
void ortho(float l, float r, float b, float t, float n, float f) @trusted @nogc nothrow pure {
    sgl_ortho(l, r, b, t, n, f);
}
extern(C) void sgl_perspective(float fov_y, float aspect, float z_near, float z_far) @system @nogc nothrow pure;
void perspective(float fov_y, float aspect, float z_near, float z_far) @trusted @nogc nothrow pure {
    sgl_perspective(fov_y, aspect, z_near, z_far);
}
extern(C) void sgl_lookat(float eye_x, float eye_y, float eye_z, float center_x, float center_y, float center_z, float up_x, float up_y, float up_z) @system @nogc nothrow pure;
void lookat(float eye_x, float eye_y, float eye_z, float center_x, float center_y, float center_z, float up_x, float up_y, float up_z) @trusted @nogc nothrow pure {
    sgl_lookat(eye_x, eye_y, eye_z, center_x, center_y, center_z, up_x, up_y, up_z);
}
extern(C) void sgl_push_matrix() @system @nogc nothrow pure;
void pushMatrix() @trusted @nogc nothrow pure {
    sgl_push_matrix();
}
extern(C) void sgl_pop_matrix() @system @nogc nothrow pure;
void popMatrix() @trusted @nogc nothrow pure {
    sgl_pop_matrix();
}
/++
+ these functions only set the internal 'current texcoord / color / point size' (valid inside or outside begin/end)
+/
extern(C) void sgl_t2f(float u, float v) @system @nogc nothrow pure;
void t2f(float u, float v) @trusted @nogc nothrow pure {
    sgl_t2f(u, v);
}
extern(C) void sgl_c3f(float r, float g, float b) @system @nogc nothrow pure;
void c3f(float r, float g, float b) @trusted @nogc nothrow pure {
    sgl_c3f(r, g, b);
}
extern(C) void sgl_c4f(float r, float g, float b, float a) @system @nogc nothrow pure;
void c4f(float r, float g, float b, float a) @trusted @nogc nothrow pure {
    sgl_c4f(r, g, b, a);
}
extern(C) void sgl_c3b(ubyte r, ubyte g, ubyte b) @system @nogc nothrow pure;
void c3b(ubyte r, ubyte g, ubyte b) @trusted @nogc nothrow pure {
    sgl_c3b(r, g, b);
}
extern(C) void sgl_c4b(ubyte r, ubyte g, ubyte b, ubyte a) @system @nogc nothrow pure;
void c4b(ubyte r, ubyte g, ubyte b, ubyte a) @trusted @nogc nothrow pure {
    sgl_c4b(r, g, b, a);
}
extern(C) void sgl_c1i(uint rgba) @system @nogc nothrow pure;
void c1i(uint rgba) @trusted @nogc nothrow pure {
    sgl_c1i(rgba);
}
extern(C) void sgl_point_size(float s) @system @nogc nothrow pure;
void pointSize(float s) @trusted @nogc nothrow pure {
    sgl_point_size(s);
}
/++
+ define primitives, each begin/end is one draw command
+/
extern(C) void sgl_begin_points() @system @nogc nothrow pure;
void beginPoints() @trusted @nogc nothrow pure {
    sgl_begin_points();
}
extern(C) void sgl_begin_lines() @system @nogc nothrow pure;
void beginLines() @trusted @nogc nothrow pure {
    sgl_begin_lines();
}
extern(C) void sgl_begin_line_strip() @system @nogc nothrow pure;
void beginLineStrip() @trusted @nogc nothrow pure {
    sgl_begin_line_strip();
}
extern(C) void sgl_begin_triangles() @system @nogc nothrow pure;
void beginTriangles() @trusted @nogc nothrow pure {
    sgl_begin_triangles();
}
extern(C) void sgl_begin_triangle_strip() @system @nogc nothrow pure;
void beginTriangleStrip() @trusted @nogc nothrow pure {
    sgl_begin_triangle_strip();
}
extern(C) void sgl_begin_quads() @system @nogc nothrow pure;
void beginQuads() @trusted @nogc nothrow pure {
    sgl_begin_quads();
}
extern(C) void sgl_v2f(float x, float y) @system @nogc nothrow pure;
void v2f(float x, float y) @trusted @nogc nothrow pure {
    sgl_v2f(x, y);
}
extern(C) void sgl_v3f(float x, float y, float z) @system @nogc nothrow pure;
void v3f(float x, float y, float z) @trusted @nogc nothrow pure {
    sgl_v3f(x, y, z);
}
extern(C) void sgl_v2f_t2f(float x, float y, float u, float v) @system @nogc nothrow pure;
void v2fT2f(float x, float y, float u, float v) @trusted @nogc nothrow pure {
    sgl_v2f_t2f(x, y, u, v);
}
extern(C) void sgl_v3f_t2f(float x, float y, float z, float u, float v) @system @nogc nothrow pure;
void v3fT2f(float x, float y, float z, float u, float v) @trusted @nogc nothrow pure {
    sgl_v3f_t2f(x, y, z, u, v);
}
extern(C) void sgl_v2f_c3f(float x, float y, float r, float g, float b) @system @nogc nothrow pure;
void v2fC3f(float x, float y, float r, float g, float b) @trusted @nogc nothrow pure {
    sgl_v2f_c3f(x, y, r, g, b);
}
extern(C) void sgl_v2f_c3b(float x, float y, ubyte r, ubyte g, ubyte b) @system @nogc nothrow pure;
void v2fC3b(float x, float y, ubyte r, ubyte g, ubyte b) @trusted @nogc nothrow pure {
    sgl_v2f_c3b(x, y, r, g, b);
}
extern(C) void sgl_v2f_c4f(float x, float y, float r, float g, float b, float a) @system @nogc nothrow pure;
void v2fC4f(float x, float y, float r, float g, float b, float a) @trusted @nogc nothrow pure {
    sgl_v2f_c4f(x, y, r, g, b, a);
}
extern(C) void sgl_v2f_c4b(float x, float y, ubyte r, ubyte g, ubyte b, ubyte a) @system @nogc nothrow pure;
void v2fC4b(float x, float y, ubyte r, ubyte g, ubyte b, ubyte a) @trusted @nogc nothrow pure {
    sgl_v2f_c4b(x, y, r, g, b, a);
}
extern(C) void sgl_v2f_c1i(float x, float y, uint rgba) @system @nogc nothrow pure;
void v2fC1i(float x, float y, uint rgba) @trusted @nogc nothrow pure {
    sgl_v2f_c1i(x, y, rgba);
}
extern(C) void sgl_v3f_c3f(float x, float y, float z, float r, float g, float b) @system @nogc nothrow pure;
void v3fC3f(float x, float y, float z, float r, float g, float b) @trusted @nogc nothrow pure {
    sgl_v3f_c3f(x, y, z, r, g, b);
}
extern(C) void sgl_v3f_c3b(float x, float y, float z, ubyte r, ubyte g, ubyte b) @system @nogc nothrow pure;
void v3fC3b(float x, float y, float z, ubyte r, ubyte g, ubyte b) @trusted @nogc nothrow pure {
    sgl_v3f_c3b(x, y, z, r, g, b);
}
extern(C) void sgl_v3f_c4f(float x, float y, float z, float r, float g, float b, float a) @system @nogc nothrow pure;
void v3fC4f(float x, float y, float z, float r, float g, float b, float a) @trusted @nogc nothrow pure {
    sgl_v3f_c4f(x, y, z, r, g, b, a);
}
extern(C) void sgl_v3f_c4b(float x, float y, float z, ubyte r, ubyte g, ubyte b, ubyte a) @system @nogc nothrow pure;
void v3fC4b(float x, float y, float z, ubyte r, ubyte g, ubyte b, ubyte a) @trusted @nogc nothrow pure {
    sgl_v3f_c4b(x, y, z, r, g, b, a);
}
extern(C) void sgl_v3f_c1i(float x, float y, float z, uint rgba) @system @nogc nothrow pure;
void v3fC1i(float x, float y, float z, uint rgba) @trusted @nogc nothrow pure {
    sgl_v3f_c1i(x, y, z, rgba);
}
extern(C) void sgl_v2f_t2f_c3f(float x, float y, float u, float v, float r, float g, float b) @system @nogc nothrow pure;
void v2fT2fC3f(float x, float y, float u, float v, float r, float g, float b) @trusted @nogc nothrow pure {
    sgl_v2f_t2f_c3f(x, y, u, v, r, g, b);
}
extern(C) void sgl_v2f_t2f_c3b(float x, float y, float u, float v, ubyte r, ubyte g, ubyte b) @system @nogc nothrow pure;
void v2fT2fC3b(float x, float y, float u, float v, ubyte r, ubyte g, ubyte b) @trusted @nogc nothrow pure {
    sgl_v2f_t2f_c3b(x, y, u, v, r, g, b);
}
extern(C) void sgl_v2f_t2f_c4f(float x, float y, float u, float v, float r, float g, float b, float a) @system @nogc nothrow pure;
void v2fT2fC4f(float x, float y, float u, float v, float r, float g, float b, float a) @trusted @nogc nothrow pure {
    sgl_v2f_t2f_c4f(x, y, u, v, r, g, b, a);
}
extern(C) void sgl_v2f_t2f_c4b(float x, float y, float u, float v, ubyte r, ubyte g, ubyte b, ubyte a) @system @nogc nothrow pure;
void v2fT2fC4b(float x, float y, float u, float v, ubyte r, ubyte g, ubyte b, ubyte a) @trusted @nogc nothrow pure {
    sgl_v2f_t2f_c4b(x, y, u, v, r, g, b, a);
}
extern(C) void sgl_v2f_t2f_c1i(float x, float y, float u, float v, uint rgba) @system @nogc nothrow pure;
void v2fT2fC1i(float x, float y, float u, float v, uint rgba) @trusted @nogc nothrow pure {
    sgl_v2f_t2f_c1i(x, y, u, v, rgba);
}
extern(C) void sgl_v3f_t2f_c3f(float x, float y, float z, float u, float v, float r, float g, float b) @system @nogc nothrow pure;
void v3fT2fC3f(float x, float y, float z, float u, float v, float r, float g, float b) @trusted @nogc nothrow pure {
    sgl_v3f_t2f_c3f(x, y, z, u, v, r, g, b);
}
extern(C) void sgl_v3f_t2f_c3b(float x, float y, float z, float u, float v, ubyte r, ubyte g, ubyte b) @system @nogc nothrow pure;
void v3fT2fC3b(float x, float y, float z, float u, float v, ubyte r, ubyte g, ubyte b) @trusted @nogc nothrow pure {
    sgl_v3f_t2f_c3b(x, y, z, u, v, r, g, b);
}
extern(C) void sgl_v3f_t2f_c4f(float x, float y, float z, float u, float v, float r, float g, float b, float a) @system @nogc nothrow pure;
void v3fT2fC4f(float x, float y, float z, float u, float v, float r, float g, float b, float a) @trusted @nogc nothrow pure {
    sgl_v3f_t2f_c4f(x, y, z, u, v, r, g, b, a);
}
extern(C) void sgl_v3f_t2f_c4b(float x, float y, float z, float u, float v, ubyte r, ubyte g, ubyte b, ubyte a) @system @nogc nothrow pure;
void v3fT2fC4b(float x, float y, float z, float u, float v, ubyte r, ubyte g, ubyte b, ubyte a) @trusted @nogc nothrow pure {
    sgl_v3f_t2f_c4b(x, y, z, u, v, r, g, b, a);
}
extern(C) void sgl_v3f_t2f_c1i(float x, float y, float z, float u, float v, uint rgba) @system @nogc nothrow pure;
void v3fT2fC1i(float x, float y, float z, float u, float v, uint rgba) @trusted @nogc nothrow pure {
    sgl_v3f_t2f_c1i(x, y, z, u, v, rgba);
}
extern(C) void sgl_end() @system @nogc nothrow pure;
void end() @trusted @nogc nothrow pure {
    sgl_end();
}
