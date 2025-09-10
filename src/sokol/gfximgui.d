/++
+ Machine generated D bindings for Sokol library.
+ 
+     Source header: sokol_gfx_imgui.h
+     Module: sokol.gfximgui
+ 
+     Do not edit manually; regenerate using gen_d.py.
+/
module sokol.gfximgui;
import sg = sokol.gfx;
import sapp = sokol.app;

extern(C) struct Str {
    char[96] buf = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
}
extern(C) struct Buffer {
    sg.Buffer res_id = {};
    Str label = {};
    sg.BufferDesc desc = {};
}
extern(C) struct Image {
    sg.Image res_id = {};
    float ui_scale = 0.0f;
    Str label = {};
    sg.ImageDesc desc = {};
}
extern(C) struct Sampler {
    sg.Sampler res_id = {};
    Str label = {};
    sg.SamplerDesc desc = {};
}
extern(C) struct Shader {
    sg.Shader res_id = {};
    Str label = {};
    Str vs_entry = {};
    Str vs_d3d11_target = {};
    Str fs_entry = {};
    Str fs_d3d11_target = {};
    Str[16] glsl_texture_sampler_name = [];
    Str[8][16] glsl_uniform_name = [];
    Str[16] attr_glsl_name = [];
    Str[16] attr_hlsl_sem_name = [];
    sg.ShaderDesc desc = {};
}
extern(C) struct Pipeline {
    sg.Pipeline res_id = {};
    Str label = {};
    sg.PipelineDesc desc = {};
}
extern(C) struct View {
    sg.View res_id = {};
    float ui_scale = 0.0f;
    Str label = {};
    sg.ViewDesc desc = {};
}
extern(C) struct BufferWindow {
    bool open = false;
    sg.Buffer sel_buf = {};
    int num_slots = 0;
    Buffer* slots = null;
}
extern(C) struct ImageWindow {
    bool open = false;
    sg.Image sel_img = {};
    int num_slots = 0;
    Image* slots = null;
}
extern(C) struct SamplerWindow {
    bool open = false;
    sg.Sampler sel_smp = {};
    int num_slots = 0;
    Sampler* slots = null;
}
extern(C) struct ShaderWindow {
    bool open = false;
    sg.Shader sel_shd = {};
    int num_slots = 0;
    Shader* slots = null;
}
extern(C) struct PipelineWindow {
    bool open = false;
    sg.Pipeline sel_pip = {};
    int num_slots = 0;
    Pipeline* slots = null;
}
extern(C) struct ViewWindow {
    bool open = false;
    sg.View sel_view = {};
    int num_slots = 0;
    View* slots = null;
}
enum Cmd {
    Invalid,
    Reset_state_cache,
    Make_buffer,
    Make_image,
    Make_sampler,
    Make_shader,
    Make_pipeline,
    Make_view,
    Destroy_buffer,
    Destroy_image,
    Destroy_sampler,
    Destroy_shader,
    Destroy_pipeline,
    Destroy_view,
    Update_buffer,
    Update_image,
    Append_buffer,
    Begin_pass,
    Apply_viewport,
    Apply_scissor_rect,
    Apply_pipeline,
    Apply_bindings,
    Apply_uniforms,
    Draw,
    Dispatch,
    End_pass,
    Commit,
    Alloc_buffer,
    Alloc_image,
    Alloc_sampler,
    Alloc_shader,
    Alloc_pipeline,
    Alloc_view,
    Dealloc_buffer,
    Dealloc_image,
    Dealloc_sampler,
    Dealloc_shader,
    Dealloc_pipeline,
    Dealloc_view,
    Init_buffer,
    Init_image,
    Init_sampler,
    Init_shader,
    Init_pipeline,
    Init_view,
    Uninit_buffer,
    Uninit_image,
    Uninit_sampler,
    Uninit_shader,
    Uninit_pipeline,
    Uninit_view,
    Fail_buffer,
    Fail_image,
    Fail_sampler,
    Fail_shader,
    Fail_pipeline,
    Fail_view,
    Push_debug_group,
    Pop_debug_group,
}
extern(C) struct ArgsMakeBuffer {
    sg.Buffer result = {};
}
extern(C) struct ArgsMakeImage {
    sg.Image result = {};
}
extern(C) struct ArgsMakeSampler {
    sg.Sampler result = {};
}
extern(C) struct ArgsMakeShader {
    sg.Shader result = {};
}
extern(C) struct ArgsMakePipeline {
    sg.Pipeline result = {};
}
extern(C) struct ArgsMakeView {
    sg.View result = {};
}
extern(C) struct ArgsDestroyBuffer {
    sg.Buffer buffer = {};
}
extern(C) struct ArgsDestroyImage {
    sg.Image image = {};
}
extern(C) struct ArgsDestroySampler {
    sg.Sampler sampler = {};
}
extern(C) struct ArgsDestroyShader {
    sg.Shader shader = {};
}
extern(C) struct ArgsDestroyPipeline {
    sg.Pipeline pipeline = {};
}
extern(C) struct ArgsDestroyView {
    sg.View view = {};
}
extern(C) struct ArgsUpdateBuffer {
    sg.Buffer buffer = {};
    size_t data_size = 0;
}
extern(C) struct ArgsUpdateImage {
    sg.Image image = {};
}
extern(C) struct ArgsAppendBuffer {
    sg.Buffer buffer = {};
    size_t data_size = 0;
    int result = 0;
}
extern(C) struct ArgsBeginPass {
    sg.Pass pass = {};
}
extern(C) struct ArgsApplyViewport {
    int x = 0;
    int y = 0;
    int width = 0;
    int height = 0;
    bool origin_top_left = false;
}
extern(C) struct ArgsApplyScissorRect {
    int x = 0;
    int y = 0;
    int width = 0;
    int height = 0;
    bool origin_top_left = false;
}
extern(C) struct ArgsApplyPipeline {
    sg.Pipeline pipeline = {};
}
extern(C) struct ArgsApplyBindings {
    sg.Bindings bindings = {};
}
extern(C) struct ArgsApplyUniforms {
    int ub_slot = 0;
    size_t data_size = 0;
    sg.Pipeline pipeline = {};
    size_t ubuf_pos = 0;
}
extern(C) struct ArgsDraw {
    int base_element = 0;
    int num_elements = 0;
    int num_instances = 0;
}
extern(C) struct ArgsDispatch {
    int num_groups_x = 0;
    int num_groups_y = 0;
    int num_groups_z = 0;
}
extern(C) struct ArgsAllocBuffer {
    sg.Buffer result = {};
}
extern(C) struct ArgsAllocImage {
    sg.Image result = {};
}
extern(C) struct ArgsAllocSampler {
    sg.Sampler result = {};
}
extern(C) struct ArgsAllocShader {
    sg.Shader result = {};
}
extern(C) struct ArgsAllocPipeline {
    sg.Pipeline result = {};
}
extern(C) struct ArgsAllocView {
    sg.View result = {};
}
extern(C) struct ArgsDeallocBuffer {
    sg.Buffer buffer = {};
}
extern(C) struct ArgsDeallocImage {
    sg.Image image = {};
}
extern(C) struct ArgsDeallocSampler {
    sg.Sampler sampler = {};
}
extern(C) struct ArgsDeallocShader {
    sg.Shader shader = {};
}
extern(C) struct ArgsDeallocPipeline {
    sg.Pipeline pipeline = {};
}
extern(C) struct ArgsDeallocView {
    sg.View view = {};
}
extern(C) struct ArgsInitBuffer {
    sg.Buffer buffer = {};
}
extern(C) struct ArgsInitImage {
    sg.Image image = {};
}
extern(C) struct ArgsInitSampler {
    sg.Sampler sampler = {};
}
extern(C) struct ArgsInitShader {
    sg.Shader shader = {};
}
extern(C) struct ArgsInitPipeline {
    sg.Pipeline pipeline = {};
}
extern(C) struct ArgsInitView {
    sg.View view = {};
}
extern(C) struct ArgsUninitBuffer {
    sg.Buffer buffer = {};
}
extern(C) struct ArgsUninitImage {
    sg.Image image = {};
}
extern(C) struct ArgsUninitSampler {
    sg.Sampler sampler = {};
}
extern(C) struct ArgsUninitShader {
    sg.Shader shader = {};
}
extern(C) struct ArgsUninitPipeline {
    sg.Pipeline pipeline = {};
}
extern(C) struct ArgsUninitView {
    sg.View view = {};
}
extern(C) struct ArgsFailBuffer {
    sg.Buffer buffer = {};
}
extern(C) struct ArgsFailImage {
    sg.Image image = {};
}
extern(C) struct ArgsFailSampler {
    sg.Sampler sampler = {};
}
extern(C) struct ArgsFailShader {
    sg.Shader shader = {};
}
extern(C) struct ArgsFailPipeline {
    sg.Pipeline pipeline = {};
}
extern(C) struct ArgsFailView {
    sg.View view = {};
}
extern(C) struct ArgsPushDebugGroup {
    Str name = {};
}
extern(C) struct Args {
    ArgsMakeBuffer make_buffer = {};
    ArgsMakeImage make_image = {};
    ArgsMakeSampler make_sampler = {};
    ArgsMakeShader make_shader = {};
    ArgsMakePipeline make_pipeline = {};
    ArgsMakeView make_view = {};
    ArgsDestroyBuffer destroy_buffer = {};
    ArgsDestroyImage destroy_image = {};
    ArgsDestroySampler destroy_sampler = {};
    ArgsDestroyShader destroy_shader = {};
    ArgsDestroyPipeline destroy_pipeline = {};
    ArgsDestroyView destroy_view = {};
    ArgsUpdateBuffer update_buffer = {};
    ArgsUpdateImage update_image = {};
    ArgsAppendBuffer append_buffer = {};
    ArgsBeginPass begin_pass = {};
    ArgsApplyViewport apply_viewport = {};
    ArgsApplyScissorRect apply_scissor_rect = {};
    ArgsApplyPipeline apply_pipeline = {};
    ArgsApplyBindings apply_bindings = {};
    ArgsApplyUniforms apply_uniforms = {};
    ArgsDraw draw = {};
    ArgsDispatch dispatch = {};
    ArgsAllocBuffer alloc_buffer = {};
    ArgsAllocImage alloc_image = {};
    ArgsAllocSampler alloc_sampler = {};
    ArgsAllocShader alloc_shader = {};
    ArgsAllocPipeline alloc_pipeline = {};
    ArgsAllocView alloc_view = {};
    ArgsDeallocBuffer dealloc_buffer = {};
    ArgsDeallocImage dealloc_image = {};
    ArgsDeallocSampler dealloc_sampler = {};
    ArgsDeallocShader dealloc_shader = {};
    ArgsDeallocPipeline dealloc_pipeline = {};
    ArgsDeallocView dealloc_view = {};
    ArgsInitBuffer init_buffer = {};
    ArgsInitImage init_image = {};
    ArgsInitSampler init_sampler = {};
    ArgsInitShader init_shader = {};
    ArgsInitPipeline init_pipeline = {};
    ArgsInitView init_view = {};
    ArgsUninitBuffer uninit_buffer = {};
    ArgsUninitImage uninit_image = {};
    ArgsUninitSampler uninit_sampler = {};
    ArgsUninitShader uninit_shader = {};
    ArgsUninitPipeline uninit_pipeline = {};
    ArgsUninitView uninit_view = {};
    ArgsFailBuffer fail_buffer = {};
    ArgsFailImage fail_image = {};
    ArgsFailSampler fail_sampler = {};
    ArgsFailShader fail_shader = {};
    ArgsFailPipeline fail_pipeline = {};
    ArgsFailView fail_view = {};
    ArgsPushDebugGroup push_debug_group = {};
}
extern(C) struct CaptureItem {
    Cmd cmd = Cmd.Invalid;
    uint color = 0;
    Args args = {};
}
extern(C) struct CaptureBucket {
    size_t ubuf_size = 0;
    size_t ubuf_pos = 0;
    ubyte* ubuf;
    int num_items = 0;
    CaptureItem[4096] items = [];
}
/++
+ double-buffered call-capture buckets, one bucket is currently recorded,
+    the previous bucket is displayed
+/
extern(C) struct CaptureWindow {
    bool open = false;
    int bucket_index = 0;
    int sel_item = 0;
    CaptureBucket[2] bucket = [];
}
extern(C) struct CapsWindow {
    bool open = false;
}
extern(C) struct FrameStatsWindow {
    bool open = false;
    bool disable_sokol_imgui_stats = false;
    bool in_sokol_imgui = false;
    sg.FrameStats stats = {};
}
/++
+ sgimgui_allocator_t
+ 
+     Used in sgimgui_desc_t to provide custom memory-alloc and -free functions
+     to sokol_gfx_imgui.h. If memory management should be overridden, both the
+     alloc and free function must be provided (e.g. it's not valid to
+     override one function but not the other).
+/
extern(C) struct Allocator {
    extern(C) void* function(size_t, void*) alloc_fn = null;
    extern(C) void function(void*, void*) free_fn = null;
    void* user_data = null;
}
/++
+ sgimgui_desc_t
+ 
+     Initialization options for sgimgui_init().
+/
extern(C) struct Desc {
    Allocator allocator = {};
}
extern(C) struct Sgimgui {
    uint init_tag = 0;
    Desc desc = {};
    BufferWindow buffer_window = {};
    ImageWindow image_window = {};
    SamplerWindow sampler_window = {};
    ShaderWindow shader_window = {};
    PipelineWindow pipeline_window = {};
    ViewWindow view_window = {};
    CaptureWindow capture_window = {};
    CapsWindow caps_window = {};
    FrameStatsWindow frame_stats_window = {};
    sg.Pipeline cur_pipeline = {};
    sg.TraceHooks hooks = {};
}
extern(C) void sgimgui_init(const Sgimgui* ctx, const Desc* desc) @system @nogc nothrow pure;
void init(scope ref Sgimgui ctx, scope ref Desc desc) @trusted @nogc nothrow pure {
    sgimgui_init(&ctx, &desc);
}
extern(C) void sgimgui_discard(const Sgimgui* ctx) @system @nogc nothrow pure;
void discard(scope ref Sgimgui ctx) @trusted @nogc nothrow pure {
    sgimgui_discard(&ctx);
}
extern(C) void sgimgui_draw(const Sgimgui* ctx) @system @nogc nothrow pure;
void draw(scope ref Sgimgui ctx) @trusted @nogc nothrow pure {
    sgimgui_draw(&ctx);
}
extern(C) void sgimgui_draw_menu(const Sgimgui* ctx, const(char)* title) @system @nogc nothrow pure;
void drawMenu(scope ref Sgimgui ctx, const(char)* title) @trusted @nogc nothrow pure {
    sgimgui_draw_menu(&ctx, title);
}
extern(C) void sgimgui_draw_buffer_window_content(const Sgimgui* ctx) @system @nogc nothrow pure;
void drawBufferWindowContent(scope ref Sgimgui ctx) @trusted @nogc nothrow pure {
    sgimgui_draw_buffer_window_content(&ctx);
}
extern(C) void sgimgui_draw_image_window_content(const Sgimgui* ctx) @system @nogc nothrow pure;
void drawImageWindowContent(scope ref Sgimgui ctx) @trusted @nogc nothrow pure {
    sgimgui_draw_image_window_content(&ctx);
}
extern(C) void sgimgui_draw_sampler_window_content(const Sgimgui* ctx) @system @nogc nothrow pure;
void drawSamplerWindowContent(scope ref Sgimgui ctx) @trusted @nogc nothrow pure {
    sgimgui_draw_sampler_window_content(&ctx);
}
extern(C) void sgimgui_draw_shader_window_content(const Sgimgui* ctx) @system @nogc nothrow pure;
void drawShaderWindowContent(scope ref Sgimgui ctx) @trusted @nogc nothrow pure {
    sgimgui_draw_shader_window_content(&ctx);
}
extern(C) void sgimgui_draw_pipeline_window_content(const Sgimgui* ctx) @system @nogc nothrow pure;
void drawPipelineWindowContent(scope ref Sgimgui ctx) @trusted @nogc nothrow pure {
    sgimgui_draw_pipeline_window_content(&ctx);
}
extern(C) void sgimgui_draw_view_window_content(const Sgimgui* ctx) @system @nogc nothrow pure;
void drawViewWindowContent(scope ref Sgimgui ctx) @trusted @nogc nothrow pure {
    sgimgui_draw_view_window_content(&ctx);
}
extern(C) void sgimgui_draw_capture_window_content(const Sgimgui* ctx) @system @nogc nothrow pure;
void drawCaptureWindowContent(scope ref Sgimgui ctx) @trusted @nogc nothrow pure {
    sgimgui_draw_capture_window_content(&ctx);
}
extern(C) void sgimgui_draw_capabilities_window_content(const Sgimgui* ctx) @system @nogc nothrow pure;
void drawCapabilitiesWindowContent(scope ref Sgimgui ctx) @trusted @nogc nothrow pure {
    sgimgui_draw_capabilities_window_content(&ctx);
}
extern(C) void sgimgui_draw_frame_stats_window_content(const Sgimgui* ctx) @system @nogc nothrow pure;
void drawFrameStatsWindowContent(scope ref Sgimgui ctx) @trusted @nogc nothrow pure {
    sgimgui_draw_frame_stats_window_content(&ctx);
}
extern(C) void sgimgui_draw_buffer_window(const Sgimgui* ctx) @system @nogc nothrow pure;
void drawBufferWindow(scope ref Sgimgui ctx) @trusted @nogc nothrow pure {
    sgimgui_draw_buffer_window(&ctx);
}
extern(C) void sgimgui_draw_image_window(const Sgimgui* ctx) @system @nogc nothrow pure;
void drawImageWindow(scope ref Sgimgui ctx) @trusted @nogc nothrow pure {
    sgimgui_draw_image_window(&ctx);
}
extern(C) void sgimgui_draw_sampler_window(const Sgimgui* ctx) @system @nogc nothrow pure;
void drawSamplerWindow(scope ref Sgimgui ctx) @trusted @nogc nothrow pure {
    sgimgui_draw_sampler_window(&ctx);
}
extern(C) void sgimgui_draw_shader_window(const Sgimgui* ctx) @system @nogc nothrow pure;
void drawShaderWindow(scope ref Sgimgui ctx) @trusted @nogc nothrow pure {
    sgimgui_draw_shader_window(&ctx);
}
extern(C) void sgimgui_draw_pipeline_window(const Sgimgui* ctx) @system @nogc nothrow pure;
void drawPipelineWindow(scope ref Sgimgui ctx) @trusted @nogc nothrow pure {
    sgimgui_draw_pipeline_window(&ctx);
}
extern(C) void sgimgui_draw_view_window(const Sgimgui* ctx) @system @nogc nothrow pure;
void drawViewWindow(scope ref Sgimgui ctx) @trusted @nogc nothrow pure {
    sgimgui_draw_view_window(&ctx);
}
extern(C) void sgimgui_draw_capture_window(const Sgimgui* ctx) @system @nogc nothrow pure;
void drawCaptureWindow(scope ref Sgimgui ctx) @trusted @nogc nothrow pure {
    sgimgui_draw_capture_window(&ctx);
}
extern(C) void sgimgui_draw_capabilities_window(const Sgimgui* ctx) @system @nogc nothrow pure;
void drawCapabilitiesWindow(scope ref Sgimgui ctx) @trusted @nogc nothrow pure {
    sgimgui_draw_capabilities_window(&ctx);
}
extern(C) void sgimgui_draw_frame_stats_window(const Sgimgui* ctx) @system @nogc nothrow pure;
void drawFrameStatsWindow(scope ref Sgimgui ctx) @trusted @nogc nothrow pure {
    sgimgui_draw_frame_stats_window(&ctx);
}
