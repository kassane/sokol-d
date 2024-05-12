// machine generated, do not edit

module sokol.gfx;

extern(C)
struct Buffer {
    uint id = 0;
}
extern(C)
struct Image {
    uint id = 0;
}
extern(C)
struct Sampler {
    uint id = 0;
}
extern(C)
struct Shader {
    uint id = 0;
}
extern(C)
struct Pipeline {
    uint id = 0;
}
extern(C)
struct Attachments {
    uint id = 0;
}
extern(C)
struct Range {
    const(void)* ptr = null;
    size_t size = 0;
}
enum invalid_id = 0;
enum num_shader_stages = 2;
enum num_inflight_frames = 2;
enum max_color_attachments = 4;
enum max_vertex_buffers = 8;
enum max_shaderstage_images = 12;
enum max_shaderstage_samplers = 8;
enum max_shaderstage_imagesamplerpairs = 12;
enum max_shaderstage_storagebuffers = 8;
enum max_shaderstage_ubs = 4;
enum max_ub_members = 16;
enum max_vertex_attributes = 16;
enum max_mipmaps = 16;
enum max_texturearray_layers = 128;
extern(C)
struct Color {
    float r = 0.0f;
    float g = 0.0f;
    float b = 0.0f;
    float a = 0.0f;
}
enum Backend {
    Glcore,
    Gles3,
    D3d11,
    Metal_ios,
    Metal_macos,
    Metal_simulator,
    Wgpu,
    Dummy,
}
enum PixelFormat {
    Default,
    None,
    R8,
    R8sn,
    R8ui,
    R8si,
    R16,
    R16sn,
    R16ui,
    R16si,
    R16f,
    Rg8,
    Rg8sn,
    Rg8ui,
    Rg8si,
    R32ui,
    R32si,
    R32f,
    Rg16,
    Rg16sn,
    Rg16ui,
    Rg16si,
    Rg16f,
    Rgba8,
    Srgb8a8,
    Rgba8sn,
    Rgba8ui,
    Rgba8si,
    Bgra8,
    Rgb10a2,
    Rg11b10f,
    Rgb9e5,
    Rg32ui,
    Rg32si,
    Rg32f,
    Rgba16,
    Rgba16sn,
    Rgba16ui,
    Rgba16si,
    Rgba16f,
    Rgba32ui,
    Rgba32si,
    Rgba32f,
    Depth,
    Depth_stencil,
    Bc1_rgba,
    Bc2_rgba,
    Bc3_rgba,
    Bc3_srgba,
    Bc4_r,
    Bc4_rsn,
    Bc5_rg,
    Bc5_rgsn,
    Bc6h_rgbf,
    Bc6h_rgbuf,
    Bc7_rgba,
    Bc7_srgba,
    Pvrtc_rgb_2bpp,
    Pvrtc_rgb_4bpp,
    Pvrtc_rgba_2bpp,
    Pvrtc_rgba_4bpp,
    Etc2_rgb8,
    Etc2_srgb8,
    Etc2_rgb8a1,
    Etc2_rgba8,
    Etc2_srgb8a8,
    Eac_r11,
    Eac_r11sn,
    Eac_rg11,
    Eac_rg11sn,
    Astc_4x4_rgba,
    Astc_4x4_srgba,
    Num,
}
extern(C)
struct PixelformatInfo {
    bool sample = false;
    bool filter = false;
    bool render = false;
    bool blend = false;
    bool msaa = false;
    bool depth = false;
    bool compressed = false;
    int bytes_per_pixel = 0;
}
extern(C)
struct Features {
    bool origin_top_left = false;
    bool image_clamp_to_border = false;
    bool mrt_independent_blend_state = false;
    bool mrt_independent_write_mask = false;
    bool storage_buffer = false;
}
extern(C)
struct Limits {
    int max_image_size_2d = 0;
    int max_image_size_cube = 0;
    int max_image_size_3d = 0;
    int max_image_size_array = 0;
    int max_image_array_layers = 0;
    int max_vertex_attrs = 0;
    int gl_max_vertex_uniform_components = 0;
    int gl_max_combined_texture_image_units = 0;
}
enum ResourceState {
    Initial,
    Alloc,
    Valid,
    Failed,
    Invalid,
}
enum Usage {
    Default,
    Immutable,
    Dynamic,
    Stream,
    Num,
}
enum BufferType {
    Default,
    Vertexbuffer,
    Indexbuffer,
    Storagebuffer,
    Num,
}
enum IndexType {
    Default,
    None,
    Uint16,
    Uint32,
    Num,
}
enum ImageType {
    Default,
    _2d,
    Cube,
    _3d,
    Array,
    Num,
}
enum ImageSampleType {
    Default,
    Float,
    Depth,
    Sint,
    Uint,
    Unfilterable_float,
    Num,
}
enum SamplerType {
    Default,
    Filtering,
    Nonfiltering,
    Comparison,
    Num,
}
enum CubeFace {
    Pos_x,
    Neg_x,
    Pos_y,
    Neg_y,
    Pos_z,
    Neg_z,
    Num,
}
enum ShaderStage {
    Vs,
    Fs,
}
enum PrimitiveType {
    Default,
    Points,
    Lines,
    Line_strip,
    Triangles,
    Triangle_strip,
    Num,
}
enum Filter {
    Default,
    None,
    Nearest,
    Linear,
    Num,
}
enum Wrap {
    Default,
    Repeat,
    Clamp_to_edge,
    Clamp_to_border,
    Mirrored_repeat,
    Num,
}
enum BorderColor {
    Default,
    Transparent_black,
    Opaque_black,
    Opaque_white,
    Num,
}
enum VertexFormat {
    Invalid,
    Float,
    Float2,
    Float3,
    Float4,
    Byte4,
    Byte4n,
    Ubyte4,
    Ubyte4n,
    Short2,
    Short2n,
    Ushort2n,
    Short4,
    Short4n,
    Ushort4n,
    Uint10_n2,
    Half2,
    Half4,
    Num,
}
enum VertexStep {
    Default,
    Per_vertex,
    Per_instance,
    Num,
}
enum UniformType {
    Invalid,
    Float,
    Float2,
    Float3,
    Float4,
    Int,
    Int2,
    Int3,
    Int4,
    Mat4,
    Num,
}
enum UniformLayout {
    Default,
    Native,
    Std140,
    Num,
}
enum CullMode {
    Default,
    None,
    Front,
    Back,
    Num,
}
enum FaceWinding {
    Default,
    Ccw,
    Cw,
    Num,
}
enum CompareFunc {
    Default,
    Never,
    Less,
    Equal,
    Less_equal,
    Greater,
    Not_equal,
    Greater_equal,
    Always,
    Num,
}
enum StencilOp {
    Default,
    Keep,
    Zero,
    Replace,
    Incr_clamp,
    Decr_clamp,
    Invert,
    Incr_wrap,
    Decr_wrap,
    Num,
}
enum BlendFactor {
    Default,
    Zero,
    One,
    Src_color,
    One_minus_src_color,
    Src_alpha,
    One_minus_src_alpha,
    Dst_color,
    One_minus_dst_color,
    Dst_alpha,
    One_minus_dst_alpha,
    Src_alpha_saturated,
    Blend_color,
    One_minus_blend_color,
    Blend_alpha,
    One_minus_blend_alpha,
    Num,
}
enum BlendOp {
    Default,
    Add,
    Subtract,
    Reverse_subtract,
    Num,
}
enum ColorMask {
    Default = 0,
    None = 16,
    R = 1,
    G = 2,
    Rg = 3,
    B = 4,
    Rb = 5,
    Gb = 6,
    Rgb = 7,
    A = 8,
    Ra = 9,
    Ga = 10,
    Rga = 11,
    Ba = 12,
    Rba = 13,
    Gba = 14,
    Rgba = 15,
}
enum LoadAction {
    Default,
    Clear,
    Load,
    Dontcare,
}
enum StoreAction {
    Default,
    Store,
    Dontcare,
}
extern(C)
struct ColorAttachmentAction {
    LoadAction load_action;
    StoreAction store_action;
    Color clear_value;
}
extern(C)
struct DepthAttachmentAction {
    LoadAction load_action;
    StoreAction store_action;
    float clear_value = 0.0f;
}
extern(C)
struct StencilAttachmentAction {
    LoadAction load_action;
    StoreAction store_action;
    ubyte clear_value = 0;
}
extern(C)
struct PassAction {
    ColorAttachmentAction[4] colors;
    DepthAttachmentAction depth;
    StencilAttachmentAction stencil;
}
extern(C)
struct MetalSwapchain {
    const(void)* current_drawable = null;
    const(void)* depth_stencil_texture = null;
    const(void)* msaa_color_texture = null;
}
extern(C)
struct D3d11Swapchain {
    const(void)* render_view = null;
    const(void)* resolve_view = null;
    const(void)* depth_stencil_view = null;
}
extern(C)
struct WgpuSwapchain {
    const(void)* render_view = null;
    const(void)* resolve_view = null;
    const(void)* depth_stencil_view = null;
}
extern(C)
struct GlSwapchain {
    uint framebuffer = 0;
}
extern(C)
struct Swapchain {
    int width = 0;
    int height = 0;
    int sample_count = 0;
    PixelFormat color_format;
    PixelFormat depth_format;
    MetalSwapchain metal;
    D3d11Swapchain d3d11;
    WgpuSwapchain wgpu;
    GlSwapchain gl;
}
extern(C)
struct Pass {
    uint _start_canary = 0;
    PassAction action;
    Attachments attachments;
    Swapchain swapchain;
    const(char)* label = null;
    uint _end_canary = 0;
}
extern(C)
struct StageBindings {
    Image[12] images;
    Sampler[8] samplers;
    Buffer[8] storage_buffers;
}
extern(C)
struct Bindings {
    uint _start_canary = 0;
    Buffer[8] vertex_buffers;
    int[8] vertex_buffer_offsets = 0;
    Buffer index_buffer;
    int index_buffer_offset = 0;
    StageBindings vs;
    StageBindings fs;
    uint _end_canary = 0;
}
extern(C)
struct BufferDesc {
    uint _start_canary = 0;
    size_t size = 0;
    BufferType type;
    Usage usage;
    Range data;
    const(char)* label = null;
    uint[2] gl_buffers = 0;
    const(void)*[2] mtl_buffers = null;
    const(void)* d3d11_buffer = null;
    const(void)* wgpu_buffer = null;
    uint _end_canary = 0;
}
extern(C)
struct ImageData {
    Range[6][16] subimage;
}
extern(C)
struct ImageDesc {
    uint _start_canary = 0;
    ImageType type;
    bool render_target = false;
    int width = 0;
    int height = 0;
    int num_slices = 0;
    int num_mipmaps = 0;
    Usage usage;
    PixelFormat pixel_format;
    int sample_count = 0;
    ImageData data;
    const(char)* label = null;
    uint[2] gl_textures = 0;
    uint gl_texture_target = 0;
    const(void)*[2] mtl_textures = null;
    const(void)* d3d11_texture = null;
    const(void)* d3d11_shader_resource_view = null;
    const(void)* wgpu_texture = null;
    const(void)* wgpu_texture_view = null;
    uint _end_canary = 0;
}
extern(C)
struct SamplerDesc {
    uint _start_canary = 0;
    Filter min_filter;
    Filter mag_filter;
    Filter mipmap_filter;
    Wrap wrap_u;
    Wrap wrap_v;
    Wrap wrap_w;
    float min_lod = 0.0f;
    float max_lod = 0.0f;
    BorderColor border_color;
    CompareFunc compare;
    uint max_anisotropy = 0;
    const(char)* label = null;
    uint gl_sampler = 0;
    const(void)* mtl_sampler = null;
    const(void)* d3d11_sampler = null;
    const(void)* wgpu_sampler = null;
    uint _end_canary = 0;
}
extern(C)
struct ShaderAttrDesc {
    const(char)* name = null;
    const(char)* sem_name = null;
    int sem_index = 0;
}
extern(C)
struct ShaderUniformDesc {
    const(char)* name = null;
    UniformType type;
    int array_count = 0;
}
extern(C)
struct ShaderUniformBlockDesc {
    size_t size = 0;
    UniformLayout layout;
    ShaderUniformDesc[16] uniforms;
}
extern(C)
struct ShaderStorageBufferDesc {
    bool used = false;
    bool readonly = false;
}
extern(C)
struct ShaderImageDesc {
    bool used = false;
    bool multisampled = false;
    ImageType image_type;
    ImageSampleType sample_type;
}
extern(C)
struct ShaderSamplerDesc {
    bool used = false;
    SamplerType sampler_type;
}
extern(C)
struct ShaderImageSamplerPairDesc {
    bool used = false;
    int image_slot = 0;
    int sampler_slot = 0;
    const(char)* glsl_name = null;
}
extern(C)
struct ShaderStageDesc {
    const(char)* source = null;
    Range bytecode;
    const(char)* entry = null;
    const(char)* d3d11_target = null;
    ShaderUniformBlockDesc[4] uniform_blocks;
    ShaderStorageBufferDesc[8] storage_buffers;
    ShaderImageDesc[12] images;
    ShaderSamplerDesc[8] samplers;
    ShaderImageSamplerPairDesc[12] image_sampler_pairs;
}
extern(C)
struct ShaderDesc {
    uint _start_canary = 0;
    ShaderAttrDesc[16] attrs;
    ShaderStageDesc vs;
    ShaderStageDesc fs;
    const(char)* label = null;
    uint _end_canary = 0;
}
extern(C)
struct VertexBufferLayoutState {
    int stride = 0;
    VertexStep step_func;
    int step_rate = 0;
}
extern(C)
struct VertexAttrState {
    int buffer_index = 0;
    int offset = 0;
    VertexFormat format;
}
extern(C)
struct VertexLayoutState {
    VertexBufferLayoutState[8] buffers;
    VertexAttrState[16] attrs;
}
extern(C)
struct StencilFaceState {
    CompareFunc compare;
    StencilOp fail_op;
    StencilOp depth_fail_op;
    StencilOp pass_op;
}
extern(C)
struct StencilState {
    bool enabled = false;
    StencilFaceState front;
    StencilFaceState back;
    ubyte read_mask = 0;
    ubyte write_mask = 0;
    ubyte _ref = 0;
}
extern(C)
struct DepthState {
    PixelFormat pixel_format;
    CompareFunc compare;
    bool write_enabled = false;
    float bias = 0.0f;
    float bias_slope_scale = 0.0f;
    float bias_clamp = 0.0f;
}
extern(C)
struct BlendState {
    bool enabled = false;
    BlendFactor src_factor_rgb;
    BlendFactor dst_factor_rgb;
    BlendOp op_rgb;
    BlendFactor src_factor_alpha;
    BlendFactor dst_factor_alpha;
    BlendOp op_alpha;
}
extern(C)
struct ColorTargetState {
    PixelFormat pixel_format;
    ColorMask write_mask;
    BlendState blend;
}
extern(C)
struct PipelineDesc {
    uint _start_canary = 0;
    Shader shader;
    VertexLayoutState layout;
    DepthState depth;
    StencilState stencil;
    int color_count = 0;
    ColorTargetState[4] colors;
    PrimitiveType primitive_type;
    IndexType index_type;
    CullMode cull_mode;
    FaceWinding face_winding;
    int sample_count = 0;
    Color blend_color;
    bool alpha_to_coverage_enabled = false;
    const(char)* label = null;
    uint _end_canary = 0;
}
extern(C)
struct AttachmentDesc {
    Image image;
    int mip_level = 0;
    int slice = 0;
}
extern(C)
struct AttachmentsDesc {
    uint _start_canary = 0;
    AttachmentDesc[4] colors;
    AttachmentDesc[4] resolves;
    AttachmentDesc depth_stencil;
    const(char)* label = null;
    uint _end_canary = 0;
}
extern(C)
struct TraceHooks {
    void* user_data = null;
    extern(C) void function(void*) reset_state_cache = null;
    extern(C) void function(const BufferDesc *, Buffer, void*) make_buffer = null;
    extern(C) void function(const ImageDesc *, Image, void*) make_image = null;
    extern(C) void function(const SamplerDesc *, Sampler, void*) make_sampler = null;
    extern(C) void function(const ShaderDesc *, Shader, void*) make_shader = null;
    extern(C) void function(const PipelineDesc *, Pipeline, void*) make_pipeline = null;
    extern(C) void function(const AttachmentsDesc *, Attachments, void*) make_attachments = null;
    extern(C) void function(Buffer, void*) destroy_buffer = null;
    extern(C) void function(Image, void*) destroy_image = null;
    extern(C) void function(Sampler, void*) destroy_sampler = null;
    extern(C) void function(Shader, void*) destroy_shader = null;
    extern(C) void function(Pipeline, void*) destroy_pipeline = null;
    extern(C) void function(Attachments, void*) destroy_attachments = null;
    extern(C) void function(Buffer, const Range *, void*) update_buffer = null;
    extern(C) void function(Image, const ImageData *, void*) update_image = null;
    extern(C) void function(Buffer, const Range *, int, void*) append_buffer = null;
    extern(C) void function(const Pass *, void*) begin_pass = null;
    extern(C) void function(int, int, int, int, bool, void*) apply_viewport = null;
    extern(C) void function(int, int, int, int, bool, void*) apply_scissor_rect = null;
    extern(C) void function(Pipeline, void*) apply_pipeline = null;
    extern(C) void function(const Bindings *, void*) apply_bindings = null;
    extern(C) void function(ShaderStage, int, const Range *, void*) apply_uniforms = null;
    extern(C) void function(int, int, int, void*) draw = null;
    extern(C) void function(void*) end_pass = null;
    extern(C) void function(void*) commit = null;
    extern(C) void function(Buffer, void*) alloc_buffer = null;
    extern(C) void function(Image, void*) alloc_image = null;
    extern(C) void function(Sampler, void*) alloc_sampler = null;
    extern(C) void function(Shader, void*) alloc_shader = null;
    extern(C) void function(Pipeline, void*) alloc_pipeline = null;
    extern(C) void function(Attachments, void*) alloc_attachments = null;
    extern(C) void function(Buffer, void*) dealloc_buffer = null;
    extern(C) void function(Image, void*) dealloc_image = null;
    extern(C) void function(Sampler, void*) dealloc_sampler = null;
    extern(C) void function(Shader, void*) dealloc_shader = null;
    extern(C) void function(Pipeline, void*) dealloc_pipeline = null;
    extern(C) void function(Attachments, void*) dealloc_attachments = null;
    extern(C) void function(Buffer, const BufferDesc *, void*) init_buffer = null;
    extern(C) void function(Image, const ImageDesc *, void*) init_image = null;
    extern(C) void function(Sampler, const SamplerDesc *, void*) init_sampler = null;
    extern(C) void function(Shader, const ShaderDesc *, void*) init_shader = null;
    extern(C) void function(Pipeline, const PipelineDesc *, void*) init_pipeline = null;
    extern(C) void function(Attachments, const AttachmentsDesc *, void*) init_attachments = null;
    extern(C) void function(Buffer, void*) uninit_buffer = null;
    extern(C) void function(Image, void*) uninit_image = null;
    extern(C) void function(Sampler, void*) uninit_sampler = null;
    extern(C) void function(Shader, void*) uninit_shader = null;
    extern(C) void function(Pipeline, void*) uninit_pipeline = null;
    extern(C) void function(Attachments, void*) uninit_attachments = null;
    extern(C) void function(Buffer, void*) fail_buffer = null;
    extern(C) void function(Image, void*) fail_image = null;
    extern(C) void function(Sampler, void*) fail_sampler = null;
    extern(C) void function(Shader, void*) fail_shader = null;
    extern(C) void function(Pipeline, void*) fail_pipeline = null;
    extern(C) void function(Attachments, void*) fail_attachments = null;
    extern(C) void function(const(char)*, void*) push_debug_group = null;
    extern(C) void function(void*) pop_debug_group = null;
}
extern(C)
struct SlotInfo {
    ResourceState state;
    uint res_id = 0;
}
extern(C)
struct BufferInfo {
    SlotInfo slot;
    uint update_frame_index = 0;
    uint append_frame_index = 0;
    int append_pos = 0;
    bool append_overflow = false;
    int num_slots = 0;
    int active_slot = 0;
}
extern(C)
struct ImageInfo {
    SlotInfo slot;
    uint upd_frame_index = 0;
    int num_slots = 0;
    int active_slot = 0;
}
extern(C)
struct SamplerInfo {
    SlotInfo slot;
}
extern(C)
struct ShaderInfo {
    SlotInfo slot;
}
extern(C)
struct PipelineInfo {
    SlotInfo slot;
}
extern(C)
struct AttachmentsInfo {
    SlotInfo slot;
}
extern(C)
struct FrameStatsGl {
    uint num_bind_buffer = 0;
    uint num_active_texture = 0;
    uint num_bind_texture = 0;
    uint num_bind_sampler = 0;
    uint num_use_program = 0;
    uint num_render_state = 0;
    uint num_vertex_attrib_pointer = 0;
    uint num_vertex_attrib_divisor = 0;
    uint num_enable_vertex_attrib_array = 0;
    uint num_disable_vertex_attrib_array = 0;
    uint num_uniform = 0;
}
extern(C)
struct FrameStatsD3d11Pass {
    uint num_om_set_render_targets = 0;
    uint num_clear_render_target_view = 0;
    uint num_clear_depth_stencil_view = 0;
    uint num_resolve_subresource = 0;
}
extern(C)
struct FrameStatsD3d11Pipeline {
    uint num_rs_set_state = 0;
    uint num_om_set_depth_stencil_state = 0;
    uint num_om_set_blend_state = 0;
    uint num_ia_set_primitive_topology = 0;
    uint num_ia_set_input_layout = 0;
    uint num_vs_set_shader = 0;
    uint num_vs_set_constant_buffers = 0;
    uint num_ps_set_shader = 0;
    uint num_ps_set_constant_buffers = 0;
}
extern(C)
struct FrameStatsD3d11Bindings {
    uint num_ia_set_vertex_buffers = 0;
    uint num_ia_set_index_buffer = 0;
    uint num_vs_set_shader_resources = 0;
    uint num_ps_set_shader_resources = 0;
    uint num_vs_set_samplers = 0;
    uint num_ps_set_samplers = 0;
}
extern(C)
struct FrameStatsD3d11Uniforms {
    uint num_update_subresource = 0;
}
extern(C)
struct FrameStatsD3d11Draw {
    uint num_draw_indexed_instanced = 0;
    uint num_draw_indexed = 0;
    uint num_draw_instanced = 0;
    uint num_draw = 0;
}
extern(C)
struct FrameStatsD3d11 {
    FrameStatsD3d11Pass pass;
    FrameStatsD3d11Pipeline pipeline;
    FrameStatsD3d11Bindings bindings;
    FrameStatsD3d11Uniforms uniforms;
    FrameStatsD3d11Draw draw;
    uint num_map = 0;
    uint num_unmap = 0;
}
extern(C)
struct FrameStatsMetalIdpool {
    uint num_added = 0;
    uint num_released = 0;
    uint num_garbage_collected = 0;
}
extern(C)
struct FrameStatsMetalPipeline {
    uint num_set_blend_color = 0;
    uint num_set_cull_mode = 0;
    uint num_set_front_facing_winding = 0;
    uint num_set_stencil_reference_value = 0;
    uint num_set_depth_bias = 0;
    uint num_set_render_pipeline_state = 0;
    uint num_set_depth_stencil_state = 0;
}
extern(C)
struct FrameStatsMetalBindings {
    uint num_set_vertex_buffer = 0;
    uint num_set_vertex_texture = 0;
    uint num_set_vertex_sampler_state = 0;
    uint num_set_fragment_buffer = 0;
    uint num_set_fragment_texture = 0;
    uint num_set_fragment_sampler_state = 0;
}
extern(C)
struct FrameStatsMetalUniforms {
    uint num_set_vertex_buffer_offset = 0;
    uint num_set_fragment_buffer_offset = 0;
}
extern(C)
struct FrameStatsMetal {
    FrameStatsMetalIdpool idpool;
    FrameStatsMetalPipeline pipeline;
    FrameStatsMetalBindings bindings;
    FrameStatsMetalUniforms uniforms;
}
extern(C)
struct FrameStatsWgpuUniforms {
    uint num_set_bindgroup = 0;
    uint size_write_buffer = 0;
}
extern(C)
struct FrameStatsWgpuBindings {
    uint num_set_vertex_buffer = 0;
    uint num_skip_redundant_vertex_buffer = 0;
    uint num_set_index_buffer = 0;
    uint num_skip_redundant_index_buffer = 0;
    uint num_create_bindgroup = 0;
    uint num_discard_bindgroup = 0;
    uint num_set_bindgroup = 0;
    uint num_skip_redundant_bindgroup = 0;
    uint num_bindgroup_cache_hits = 0;
    uint num_bindgroup_cache_misses = 0;
    uint num_bindgroup_cache_collisions = 0;
    uint num_bindgroup_cache_hash_vs_key_mismatch = 0;
}
extern(C)
struct FrameStatsWgpu {
    FrameStatsWgpuUniforms uniforms;
    FrameStatsWgpuBindings bindings;
}
extern(C)
struct FrameStats {
    uint frame_index = 0;
    uint num_passes = 0;
    uint num_apply_viewport = 0;
    uint num_apply_scissor_rect = 0;
    uint num_apply_pipeline = 0;
    uint num_apply_bindings = 0;
    uint num_apply_uniforms = 0;
    uint num_draw = 0;
    uint num_update_buffer = 0;
    uint num_append_buffer = 0;
    uint num_update_image = 0;
    uint size_apply_uniforms = 0;
    uint size_update_buffer = 0;
    uint size_append_buffer = 0;
    uint size_update_image = 0;
    FrameStatsGl gl;
    FrameStatsD3d11 d3d11;
    FrameStatsMetal metal;
    FrameStatsWgpu wgpu;
}
enum LogItem {
    Ok,
    Malloc_failed,
    Gl_texture_format_not_supported,
    Gl_3d_textures_not_supported,
    Gl_array_textures_not_supported,
    Gl_shader_compilation_failed,
    Gl_shader_linking_failed,
    Gl_vertex_attribute_not_found_in_shader,
    Gl_texture_name_not_found_in_shader,
    Gl_framebuffer_status_undefined,
    Gl_framebuffer_status_incomplete_attachment,
    Gl_framebuffer_status_incomplete_missing_attachment,
    Gl_framebuffer_status_unsupported,
    Gl_framebuffer_status_incomplete_multisample,
    Gl_framebuffer_status_unknown,
    D3d11_create_buffer_failed,
    D3d11_create_buffer_srv_failed,
    D3d11_create_depth_texture_unsupported_pixel_format,
    D3d11_create_depth_texture_failed,
    D3d11_create_2d_texture_unsupported_pixel_format,
    D3d11_create_2d_texture_failed,
    D3d11_create_2d_srv_failed,
    D3d11_create_3d_texture_unsupported_pixel_format,
    D3d11_create_3d_texture_failed,
    D3d11_create_3d_srv_failed,
    D3d11_create_msaa_texture_failed,
    D3d11_create_sampler_state_failed,
    D3d11_load_d3dcompiler_47_dll_failed,
    D3d11_shader_compilation_failed,
    D3d11_shader_compilation_output,
    D3d11_create_constant_buffer_failed,
    D3d11_create_input_layout_failed,
    D3d11_create_rasterizer_state_failed,
    D3d11_create_depth_stencil_state_failed,
    D3d11_create_blend_state_failed,
    D3d11_create_rtv_failed,
    D3d11_create_dsv_failed,
    D3d11_map_for_update_buffer_failed,
    D3d11_map_for_append_buffer_failed,
    D3d11_map_for_update_image_failed,
    Metal_create_buffer_failed,
    Metal_texture_format_not_supported,
    Metal_create_texture_failed,
    Metal_create_sampler_failed,
    Metal_shader_compilation_failed,
    Metal_shader_creation_failed,
    Metal_shader_compilation_output,
    Metal_vertex_shader_entry_not_found,
    Metal_fragment_shader_entry_not_found,
    Metal_create_rps_failed,
    Metal_create_rps_output,
    Metal_create_dss_failed,
    Wgpu_bindgroups_pool_exhausted,
    Wgpu_bindgroupscache_size_greater_one,
    Wgpu_bindgroupscache_size_pow2,
    Wgpu_createbindgroup_failed,
    Wgpu_create_buffer_failed,
    Wgpu_create_texture_failed,
    Wgpu_create_texture_view_failed,
    Wgpu_create_sampler_failed,
    Wgpu_create_shader_module_failed,
    Wgpu_shader_too_many_images,
    Wgpu_shader_too_many_samplers,
    Wgpu_shader_too_many_storagebuffers,
    Wgpu_shader_create_bindgroup_layout_failed,
    Wgpu_create_pipeline_layout_failed,
    Wgpu_create_render_pipeline_failed,
    Wgpu_attachments_create_texture_view_failed,
    Identical_commit_listener,
    Commit_listener_array_full,
    Trace_hooks_not_enabled,
    Dealloc_buffer_invalid_state,
    Dealloc_image_invalid_state,
    Dealloc_sampler_invalid_state,
    Dealloc_shader_invalid_state,
    Dealloc_pipeline_invalid_state,
    Dealloc_attachments_invalid_state,
    Init_buffer_invalid_state,
    Init_image_invalid_state,
    Init_sampler_invalid_state,
    Init_shader_invalid_state,
    Init_pipeline_invalid_state,
    Init_attachments_invalid_state,
    Uninit_buffer_invalid_state,
    Uninit_image_invalid_state,
    Uninit_sampler_invalid_state,
    Uninit_shader_invalid_state,
    Uninit_pipeline_invalid_state,
    Uninit_attachments_invalid_state,
    Fail_buffer_invalid_state,
    Fail_image_invalid_state,
    Fail_sampler_invalid_state,
    Fail_shader_invalid_state,
    Fail_pipeline_invalid_state,
    Fail_attachments_invalid_state,
    Buffer_pool_exhausted,
    Image_pool_exhausted,
    Sampler_pool_exhausted,
    Shader_pool_exhausted,
    Pipeline_pool_exhausted,
    Pass_pool_exhausted,
    Beginpass_attachment_invalid,
    Draw_without_bindings,
    Validate_bufferdesc_canary,
    Validate_bufferdesc_size,
    Validate_bufferdesc_data,
    Validate_bufferdesc_data_size,
    Validate_bufferdesc_no_data,
    Validate_bufferdesc_storagebuffer_supported,
    Validate_bufferdesc_storagebuffer_size_multiple_4,
    Validate_imagedata_nodata,
    Validate_imagedata_data_size,
    Validate_imagedesc_canary,
    Validate_imagedesc_width,
    Validate_imagedesc_height,
    Validate_imagedesc_rt_pixelformat,
    Validate_imagedesc_nonrt_pixelformat,
    Validate_imagedesc_msaa_but_no_rt,
    Validate_imagedesc_no_msaa_rt_support,
    Validate_imagedesc_msaa_num_mipmaps,
    Validate_imagedesc_msaa_3d_image,
    Validate_imagedesc_depth_3d_image,
    Validate_imagedesc_rt_immutable,
    Validate_imagedesc_rt_no_data,
    Validate_imagedesc_injected_no_data,
    Validate_imagedesc_dynamic_no_data,
    Validate_imagedesc_compressed_immutable,
    Validate_samplerdesc_canary,
    Validate_samplerdesc_minfilter_none,
    Validate_samplerdesc_magfilter_none,
    Validate_samplerdesc_anistropic_requires_linear_filtering,
    Validate_shaderdesc_canary,
    Validate_shaderdesc_source,
    Validate_shaderdesc_bytecode,
    Validate_shaderdesc_source_or_bytecode,
    Validate_shaderdesc_no_bytecode_size,
    Validate_shaderdesc_no_cont_ubs,
    Validate_shaderdesc_no_cont_ub_members,
    Validate_shaderdesc_no_ub_members,
    Validate_shaderdesc_ub_member_name,
    Validate_shaderdesc_ub_size_mismatch,
    Validate_shaderdesc_ub_array_count,
    Validate_shaderdesc_ub_std140_array_type,
    Validate_shaderdesc_no_cont_storagebuffers,
    Validate_shaderdesc_storagebuffer_readonly,
    Validate_shaderdesc_no_cont_images,
    Validate_shaderdesc_no_cont_samplers,
    Validate_shaderdesc_image_sampler_pair_image_slot_out_of_range,
    Validate_shaderdesc_image_sampler_pair_sampler_slot_out_of_range,
    Validate_shaderdesc_image_sampler_pair_name_required_for_gl,
    Validate_shaderdesc_image_sampler_pair_has_name_but_not_used,
    Validate_shaderdesc_image_sampler_pair_has_image_but_not_used,
    Validate_shaderdesc_image_sampler_pair_has_sampler_but_not_used,
    Validate_shaderdesc_nonfiltering_sampler_required,
    Validate_shaderdesc_comparison_sampler_required,
    Validate_shaderdesc_image_not_referenced_by_image_sampler_pairs,
    Validate_shaderdesc_sampler_not_referenced_by_image_sampler_pairs,
    Validate_shaderdesc_no_cont_image_sampler_pairs,
    Validate_shaderdesc_attr_string_too_long,
    Validate_pipelinedesc_canary,
    Validate_pipelinedesc_shader,
    Validate_pipelinedesc_no_cont_attrs,
    Validate_pipelinedesc_layout_stride4,
    Validate_pipelinedesc_attr_semantics,
    Validate_attachmentsdesc_canary,
    Validate_attachmentsdesc_no_attachments,
    Validate_attachmentsdesc_no_cont_color_atts,
    Validate_attachmentsdesc_image,
    Validate_attachmentsdesc_miplevel,
    Validate_attachmentsdesc_face,
    Validate_attachmentsdesc_layer,
    Validate_attachmentsdesc_slice,
    Validate_attachmentsdesc_image_no_rt,
    Validate_attachmentsdesc_color_inv_pixelformat,
    Validate_attachmentsdesc_depth_inv_pixelformat,
    Validate_attachmentsdesc_image_sizes,
    Validate_attachmentsdesc_image_sample_counts,
    Validate_attachmentsdesc_resolve_color_image_msaa,
    Validate_attachmentsdesc_resolve_image,
    Validate_attachmentsdesc_resolve_sample_count,
    Validate_attachmentsdesc_resolve_miplevel,
    Validate_attachmentsdesc_resolve_face,
    Validate_attachmentsdesc_resolve_layer,
    Validate_attachmentsdesc_resolve_slice,
    Validate_attachmentsdesc_resolve_image_no_rt,
    Validate_attachmentsdesc_resolve_image_sizes,
    Validate_attachmentsdesc_resolve_image_format,
    Validate_attachmentsdesc_depth_image,
    Validate_attachmentsdesc_depth_miplevel,
    Validate_attachmentsdesc_depth_face,
    Validate_attachmentsdesc_depth_layer,
    Validate_attachmentsdesc_depth_slice,
    Validate_attachmentsdesc_depth_image_no_rt,
    Validate_attachmentsdesc_depth_image_sizes,
    Validate_attachmentsdesc_depth_image_sample_count,
    Validate_beginpass_canary,
    Validate_beginpass_attachments_exists,
    Validate_beginpass_attachments_valid,
    Validate_beginpass_color_attachment_image,
    Validate_beginpass_resolve_attachment_image,
    Validate_beginpass_depthstencil_attachment_image,
    Validate_beginpass_swapchain_expect_width,
    Validate_beginpass_swapchain_expect_width_notset,
    Validate_beginpass_swapchain_expect_height,
    Validate_beginpass_swapchain_expect_height_notset,
    Validate_beginpass_swapchain_expect_samplecount,
    Validate_beginpass_swapchain_expect_samplecount_notset,
    Validate_beginpass_swapchain_expect_colorformat,
    Validate_beginpass_swapchain_expect_colorformat_notset,
    Validate_beginpass_swapchain_expect_depthformat_notset,
    Validate_beginpass_swapchain_metal_expect_currentdrawable,
    Validate_beginpass_swapchain_metal_expect_currentdrawable_notset,
    Validate_beginpass_swapchain_metal_expect_depthstenciltexture,
    Validate_beginpass_swapchain_metal_expect_depthstenciltexture_notset,
    Validate_beginpass_swapchain_metal_expect_msaacolortexture,
    Validate_beginpass_swapchain_metal_expect_msaacolortexture_notset,
    Validate_beginpass_swapchain_d3d11_expect_renderview,
    Validate_beginpass_swapchain_d3d11_expect_renderview_notset,
    Validate_beginpass_swapchain_d3d11_expect_resolveview,
    Validate_beginpass_swapchain_d3d11_expect_resolveview_notset,
    Validate_beginpass_swapchain_d3d11_expect_depthstencilview,
    Validate_beginpass_swapchain_d3d11_expect_depthstencilview_notset,
    Validate_beginpass_swapchain_wgpu_expect_renderview,
    Validate_beginpass_swapchain_wgpu_expect_renderview_notset,
    Validate_beginpass_swapchain_wgpu_expect_resolveview,
    Validate_beginpass_swapchain_wgpu_expect_resolveview_notset,
    Validate_beginpass_swapchain_wgpu_expect_depthstencilview,
    Validate_beginpass_swapchain_wgpu_expect_depthstencilview_notset,
    Validate_beginpass_swapchain_gl_expect_framebuffer_notset,
    Validate_apip_pipeline_valid_id,
    Validate_apip_pipeline_exists,
    Validate_apip_pipeline_valid,
    Validate_apip_shader_exists,
    Validate_apip_shader_valid,
    Validate_apip_curpass_attachments_exists,
    Validate_apip_curpass_attachments_valid,
    Validate_apip_att_count,
    Validate_apip_color_format,
    Validate_apip_depth_format,
    Validate_apip_sample_count,
    Validate_abnd_pipeline,
    Validate_abnd_pipeline_exists,
    Validate_abnd_pipeline_valid,
    Validate_abnd_vbs,
    Validate_abnd_vb_exists,
    Validate_abnd_vb_type,
    Validate_abnd_vb_overflow,
    Validate_abnd_no_ib,
    Validate_abnd_ib,
    Validate_abnd_ib_exists,
    Validate_abnd_ib_type,
    Validate_abnd_ib_overflow,
    Validate_abnd_vs_expected_image_binding,
    Validate_abnd_vs_img_exists,
    Validate_abnd_vs_image_type_mismatch,
    Validate_abnd_vs_image_msaa,
    Validate_abnd_vs_expected_filterable_image,
    Validate_abnd_vs_expected_depth_image,
    Validate_abnd_vs_unexpected_image_binding,
    Validate_abnd_vs_expected_sampler_binding,
    Validate_abnd_vs_unexpected_sampler_compare_never,
    Validate_abnd_vs_expected_sampler_compare_never,
    Validate_abnd_vs_expected_nonfiltering_sampler,
    Validate_abnd_vs_unexpected_sampler_binding,
    Validate_abnd_vs_smp_exists,
    Validate_abnd_vs_expected_storagebuffer_binding,
    Validate_abnd_vs_storagebuffer_exists,
    Validate_abnd_vs_storagebuffer_binding_buffertype,
    Validate_abnd_vs_unexpected_storagebuffer_binding,
    Validate_abnd_fs_expected_image_binding,
    Validate_abnd_fs_img_exists,
    Validate_abnd_fs_image_type_mismatch,
    Validate_abnd_fs_image_msaa,
    Validate_abnd_fs_expected_filterable_image,
    Validate_abnd_fs_expected_depth_image,
    Validate_abnd_fs_unexpected_image_binding,
    Validate_abnd_fs_expected_sampler_binding,
    Validate_abnd_fs_unexpected_sampler_compare_never,
    Validate_abnd_fs_expected_sampler_compare_never,
    Validate_abnd_fs_expected_nonfiltering_sampler,
    Validate_abnd_fs_unexpected_sampler_binding,
    Validate_abnd_fs_smp_exists,
    Validate_abnd_fs_expected_storagebuffer_binding,
    Validate_abnd_fs_storagebuffer_exists,
    Validate_abnd_fs_storagebuffer_binding_buffertype,
    Validate_abnd_fs_unexpected_storagebuffer_binding,
    Validate_aub_no_pipeline,
    Validate_aub_no_ub_at_slot,
    Validate_aub_size,
    Validate_updatebuf_usage,
    Validate_updatebuf_size,
    Validate_updatebuf_once,
    Validate_updatebuf_append,
    Validate_appendbuf_usage,
    Validate_appendbuf_size,
    Validate_appendbuf_update,
    Validate_updimg_usage,
    Validate_updimg_once,
    Validation_failed,
}
extern(C)
struct EnvironmentDefaults {
    PixelFormat color_format;
    PixelFormat depth_format;
    int sample_count = 0;
}
extern(C)
struct MetalEnvironment {
    const(void)* device = null;
}
extern(C)
struct D3d11Environment {
    const(void)* device = null;
    const(void)* device_context = null;
}
extern(C)
struct WgpuEnvironment {
    const(void)* device = null;
}
extern(C)
struct Environment {
    EnvironmentDefaults defaults;
    MetalEnvironment metal;
    D3d11Environment d3d11;
    WgpuEnvironment wgpu;
}
extern(C)
struct CommitListener {
    extern(C) void function(void*) func = null;
    void* user_data = null;
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
    uint _start_canary = 0;
    int buffer_pool_size = 0;
    int image_pool_size = 0;
    int sampler_pool_size = 0;
    int shader_pool_size = 0;
    int pipeline_pool_size = 0;
    int attachments_pool_size = 0;
    int uniform_buffer_size = 0;
    int max_commit_listeners = 0;
    bool disable_validation = false;
    bool mtl_force_managed_storage_mode = false;
    bool mtl_use_command_buffer_with_retained_references = false;
    bool wgpu_disable_bindgroups_cache = false;
    int wgpu_bindgroups_cache_size = 0;
    Allocator allocator;
    Logger logger;
    Environment environment;
    uint _end_canary = 0;
}
extern(C) void sg_setup(const Desc *) @system @nogc nothrow;
void setup(scope ref Desc desc) @trusted @nogc nothrow {
    sg_setup(&desc);
}
extern(C) void sg_shutdown() @system @nogc nothrow;
void shutdown() @trusted @nogc nothrow {
    sg_shutdown();
}
extern(C) bool sg_isvalid() @system @nogc nothrow;
bool isvalid() @trusted @nogc nothrow {
    return sg_isvalid();
}
extern(C) void sg_reset_state_cache() @system @nogc nothrow;
void resetStateCache() @trusted @nogc nothrow {
    sg_reset_state_cache();
}
extern(C) TraceHooks sg_install_trace_hooks(const TraceHooks *) @system @nogc nothrow;
TraceHooks installTraceHooks(scope ref TraceHooks trace_hooks) @trusted @nogc nothrow {
    return sg_install_trace_hooks(&trace_hooks);
}
extern(C) void sg_push_debug_group(const(char)*) @system @nogc nothrow;
void pushDebugGroup(scope const(char)* name) @trusted @nogc nothrow {
    sg_push_debug_group(name);
}
extern(C) void sg_pop_debug_group() @system @nogc nothrow;
void popDebugGroup() @trusted @nogc nothrow {
    sg_pop_debug_group();
}
extern(C) bool sg_add_commit_listener(CommitListener) @system @nogc nothrow;
bool addCommitListener(CommitListener listener) @trusted @nogc nothrow {
    return sg_add_commit_listener(listener);
}
extern(C) bool sg_remove_commit_listener(CommitListener) @system @nogc nothrow;
bool removeCommitListener(CommitListener listener) @trusted @nogc nothrow {
    return sg_remove_commit_listener(listener);
}
extern(C) Buffer sg_make_buffer(const BufferDesc *) @system @nogc nothrow;
Buffer makeBuffer(scope ref BufferDesc desc) @trusted @nogc nothrow {
    return sg_make_buffer(&desc);
}
extern(C) Image sg_make_image(const ImageDesc *) @system @nogc nothrow;
Image makeImage(scope ref ImageDesc desc) @trusted @nogc nothrow {
    return sg_make_image(&desc);
}
extern(C) Sampler sg_make_sampler(const SamplerDesc *) @system @nogc nothrow;
Sampler makeSampler(scope ref SamplerDesc desc) @trusted @nogc nothrow {
    return sg_make_sampler(&desc);
}
extern(C) Shader sg_make_shader(const ShaderDesc *) @system @nogc nothrow;
Shader makeShader(scope ref ShaderDesc desc) @trusted @nogc nothrow {
    return sg_make_shader(&desc);
}
extern(C) Pipeline sg_make_pipeline(const PipelineDesc *) @system @nogc nothrow;
Pipeline makePipeline(scope ref PipelineDesc desc) @trusted @nogc nothrow {
    return sg_make_pipeline(&desc);
}
extern(C) Attachments sg_make_attachments(const AttachmentsDesc *) @system @nogc nothrow;
Attachments makeAttachments(scope ref AttachmentsDesc desc) @trusted @nogc nothrow {
    return sg_make_attachments(&desc);
}
extern(C) void sg_destroy_buffer(Buffer) @system @nogc nothrow;
void destroyBuffer(Buffer buf) @trusted @nogc nothrow {
    sg_destroy_buffer(buf);
}
extern(C) void sg_destroy_image(Image) @system @nogc nothrow;
void destroyImage(Image img) @trusted @nogc nothrow {
    sg_destroy_image(img);
}
extern(C) void sg_destroy_sampler(Sampler) @system @nogc nothrow;
void destroySampler(Sampler smp) @trusted @nogc nothrow {
    sg_destroy_sampler(smp);
}
extern(C) void sg_destroy_shader(Shader) @system @nogc nothrow;
void destroyShader(Shader shd) @trusted @nogc nothrow {
    sg_destroy_shader(shd);
}
extern(C) void sg_destroy_pipeline(Pipeline) @system @nogc nothrow;
void destroyPipeline(Pipeline pip) @trusted @nogc nothrow {
    sg_destroy_pipeline(pip);
}
extern(C) void sg_destroy_attachments(Attachments) @system @nogc nothrow;
void destroyAttachments(Attachments atts) @trusted @nogc nothrow {
    sg_destroy_attachments(atts);
}
extern(C) void sg_update_buffer(Buffer, const Range *) @system @nogc nothrow;
void updateBuffer(Buffer buf, scope ref Range data) @trusted @nogc nothrow {
    sg_update_buffer(buf, &data);
}
extern(C) void sg_update_image(Image, const ImageData *) @system @nogc nothrow;
void updateImage(Image img, scope ref ImageData data) @trusted @nogc nothrow {
    sg_update_image(img, &data);
}
extern(C) int sg_append_buffer(Buffer, const Range *) @system @nogc nothrow;
int appendBuffer(Buffer buf, scope ref Range data) @trusted @nogc nothrow {
    return sg_append_buffer(buf, &data);
}
extern(C) bool sg_query_buffer_overflow(Buffer) @system @nogc nothrow;
bool queryBufferOverflow(Buffer buf) @trusted @nogc nothrow {
    return sg_query_buffer_overflow(buf);
}
extern(C) bool sg_query_buffer_will_overflow(Buffer, size_t) @system @nogc nothrow;
bool queryBufferWillOverflow(Buffer buf, size_t size) @trusted @nogc nothrow {
    return sg_query_buffer_will_overflow(buf, size);
}
extern(C) void sg_begin_pass(const Pass *) @system @nogc nothrow;
void beginPass(scope ref Pass pass) @trusted @nogc nothrow {
    sg_begin_pass(&pass);
}
extern(C) void sg_apply_viewport(int, int, int, int, bool) @system @nogc nothrow;
void applyViewport(int x, int y, int width, int height, bool origin_top_left) @trusted @nogc nothrow {
    sg_apply_viewport(x, y, width, height, origin_top_left);
}
extern(C) void sg_apply_viewportf(float, float, float, float, bool) @system @nogc nothrow;
void applyViewportf(float x, float y, float width, float height, bool origin_top_left) @trusted @nogc nothrow {
    sg_apply_viewportf(x, y, width, height, origin_top_left);
}
extern(C) void sg_apply_scissor_rect(int, int, int, int, bool) @system @nogc nothrow;
void applyScissorRect(int x, int y, int width, int height, bool origin_top_left) @trusted @nogc nothrow {
    sg_apply_scissor_rect(x, y, width, height, origin_top_left);
}
extern(C) void sg_apply_scissor_rectf(float, float, float, float, bool) @system @nogc nothrow;
void applyScissorRectf(float x, float y, float width, float height, bool origin_top_left) @trusted @nogc nothrow {
    sg_apply_scissor_rectf(x, y, width, height, origin_top_left);
}
extern(C) void sg_apply_pipeline(Pipeline) @system @nogc nothrow;
void applyPipeline(Pipeline pip) @trusted @nogc nothrow {
    sg_apply_pipeline(pip);
}
extern(C) void sg_apply_bindings(const Bindings *) @system @nogc nothrow;
void applyBindings(scope ref Bindings bindings) @trusted @nogc nothrow {
    sg_apply_bindings(&bindings);
}
extern(C) void sg_apply_uniforms(ShaderStage, uint, const Range *) @system @nogc nothrow;
void applyUniforms(ShaderStage stage, uint ub_index, scope ref Range data) @trusted @nogc nothrow {
    sg_apply_uniforms(stage, ub_index, &data);
}
extern(C) void sg_draw(uint, uint, uint) @system @nogc nothrow;
void draw(uint base_element, uint num_elements, uint num_instances) @trusted @nogc nothrow {
    sg_draw(base_element, num_elements, num_instances);
}
extern(C) void sg_end_pass() @system @nogc nothrow;
void endPass() @trusted @nogc nothrow {
    sg_end_pass();
}
extern(C) void sg_commit() @system @nogc nothrow;
void commit() @trusted @nogc nothrow {
    sg_commit();
}
extern(C) Desc sg_query_desc() @system @nogc nothrow;
Desc queryDesc() @trusted @nogc nothrow {
    return sg_query_desc();
}
extern(C) Backend sg_query_backend() @system @nogc nothrow;
Backend queryBackend() @trusted @nogc nothrow {
    return sg_query_backend();
}
extern(C) Features sg_query_features() @system @nogc nothrow;
Features queryFeatures() @trusted @nogc nothrow {
    return sg_query_features();
}
extern(C) Limits sg_query_limits() @system @nogc nothrow;
Limits queryLimits() @trusted @nogc nothrow {
    return sg_query_limits();
}
extern(C) PixelformatInfo sg_query_pixelformat(PixelFormat) @system @nogc nothrow;
PixelformatInfo queryPixelformat(PixelFormat fmt) @trusted @nogc nothrow {
    return sg_query_pixelformat(fmt);
}
extern(C) int sg_query_row_pitch(PixelFormat, int, int) @system @nogc nothrow;
int queryRowPitch(PixelFormat fmt, int width, int row_align_bytes) @trusted @nogc nothrow {
    return sg_query_row_pitch(fmt, width, row_align_bytes);
}
extern(C) int sg_query_surface_pitch(PixelFormat, int, int, int) @system @nogc nothrow;
int querySurfacePitch(PixelFormat fmt, int width, int height, int row_align_bytes) @trusted @nogc nothrow {
    return sg_query_surface_pitch(fmt, width, height, row_align_bytes);
}
extern(C) ResourceState sg_query_buffer_state(Buffer) @system @nogc nothrow;
ResourceState queryBufferState(Buffer buf) @trusted @nogc nothrow {
    return sg_query_buffer_state(buf);
}
extern(C) ResourceState sg_query_image_state(Image) @system @nogc nothrow;
ResourceState queryImageState(Image img) @trusted @nogc nothrow {
    return sg_query_image_state(img);
}
extern(C) ResourceState sg_query_sampler_state(Sampler) @system @nogc nothrow;
ResourceState querySamplerState(Sampler smp) @trusted @nogc nothrow {
    return sg_query_sampler_state(smp);
}
extern(C) ResourceState sg_query_shader_state(Shader) @system @nogc nothrow;
ResourceState queryShaderState(Shader shd) @trusted @nogc nothrow {
    return sg_query_shader_state(shd);
}
extern(C) ResourceState sg_query_pipeline_state(Pipeline) @system @nogc nothrow;
ResourceState queryPipelineState(Pipeline pip) @trusted @nogc nothrow {
    return sg_query_pipeline_state(pip);
}
extern(C) ResourceState sg_query_attachments_state(Attachments) @system @nogc nothrow;
ResourceState queryAttachmentsState(Attachments atts) @trusted @nogc nothrow {
    return sg_query_attachments_state(atts);
}
extern(C) BufferInfo sg_query_buffer_info(Buffer) @system @nogc nothrow;
BufferInfo queryBufferInfo(Buffer buf) @trusted @nogc nothrow {
    return sg_query_buffer_info(buf);
}
extern(C) ImageInfo sg_query_image_info(Image) @system @nogc nothrow;
ImageInfo queryImageInfo(Image img) @trusted @nogc nothrow {
    return sg_query_image_info(img);
}
extern(C) SamplerInfo sg_query_sampler_info(Sampler) @system @nogc nothrow;
SamplerInfo querySamplerInfo(Sampler smp) @trusted @nogc nothrow {
    return sg_query_sampler_info(smp);
}
extern(C) ShaderInfo sg_query_shader_info(Shader) @system @nogc nothrow;
ShaderInfo queryShaderInfo(Shader shd) @trusted @nogc nothrow {
    return sg_query_shader_info(shd);
}
extern(C) PipelineInfo sg_query_pipeline_info(Pipeline) @system @nogc nothrow;
PipelineInfo queryPipelineInfo(Pipeline pip) @trusted @nogc nothrow {
    return sg_query_pipeline_info(pip);
}
extern(C) AttachmentsInfo sg_query_attachments_info(Attachments) @system @nogc nothrow;
AttachmentsInfo queryAttachmentsInfo(Attachments atts) @trusted @nogc nothrow {
    return sg_query_attachments_info(atts);
}
extern(C) BufferDesc sg_query_buffer_desc(Buffer) @system @nogc nothrow;
BufferDesc queryBufferDesc(Buffer buf) @trusted @nogc nothrow {
    return sg_query_buffer_desc(buf);
}
extern(C) ImageDesc sg_query_image_desc(Image) @system @nogc nothrow;
ImageDesc queryImageDesc(Image img) @trusted @nogc nothrow {
    return sg_query_image_desc(img);
}
extern(C) SamplerDesc sg_query_sampler_desc(Sampler) @system @nogc nothrow;
SamplerDesc querySamplerDesc(Sampler smp) @trusted @nogc nothrow {
    return sg_query_sampler_desc(smp);
}
extern(C) ShaderDesc sg_query_shader_desc(Shader) @system @nogc nothrow;
ShaderDesc queryShaderDesc(Shader shd) @trusted @nogc nothrow {
    return sg_query_shader_desc(shd);
}
extern(C) PipelineDesc sg_query_pipeline_desc(Pipeline) @system @nogc nothrow;
PipelineDesc queryPipelineDesc(Pipeline pip) @trusted @nogc nothrow {
    return sg_query_pipeline_desc(pip);
}
extern(C) AttachmentsDesc sg_query_attachments_desc(Attachments) @system @nogc nothrow;
AttachmentsDesc queryAttachmentsDesc(Attachments atts) @trusted @nogc nothrow {
    return sg_query_attachments_desc(atts);
}
extern(C) BufferDesc sg_query_buffer_defaults(const BufferDesc *) @system @nogc nothrow;
BufferDesc queryBufferDefaults(scope ref BufferDesc desc) @trusted @nogc nothrow {
    return sg_query_buffer_defaults(&desc);
}
extern(C) ImageDesc sg_query_image_defaults(const ImageDesc *) @system @nogc nothrow;
ImageDesc queryImageDefaults(scope ref ImageDesc desc) @trusted @nogc nothrow {
    return sg_query_image_defaults(&desc);
}
extern(C) SamplerDesc sg_query_sampler_defaults(const SamplerDesc *) @system @nogc nothrow;
SamplerDesc querySamplerDefaults(scope ref SamplerDesc desc) @trusted @nogc nothrow {
    return sg_query_sampler_defaults(&desc);
}
extern(C) ShaderDesc sg_query_shader_defaults(const ShaderDesc *) @system @nogc nothrow;
ShaderDesc queryShaderDefaults(scope ref ShaderDesc desc) @trusted @nogc nothrow {
    return sg_query_shader_defaults(&desc);
}
extern(C) PipelineDesc sg_query_pipeline_defaults(const PipelineDesc *) @system @nogc nothrow;
PipelineDesc queryPipelineDefaults(scope ref PipelineDesc desc) @trusted @nogc nothrow {
    return sg_query_pipeline_defaults(&desc);
}
extern(C) AttachmentsDesc sg_query_attachments_defaults(const AttachmentsDesc *) @system @nogc nothrow;
AttachmentsDesc queryAttachmentsDefaults(scope ref AttachmentsDesc desc) @trusted @nogc nothrow {
    return sg_query_attachments_defaults(&desc);
}
extern(C) Buffer sg_alloc_buffer() @system @nogc nothrow;
Buffer allocBuffer() @trusted @nogc nothrow {
    return sg_alloc_buffer();
}
extern(C) Image sg_alloc_image() @system @nogc nothrow;
Image allocImage() @trusted @nogc nothrow {
    return sg_alloc_image();
}
extern(C) Sampler sg_alloc_sampler() @system @nogc nothrow;
Sampler allocSampler() @trusted @nogc nothrow {
    return sg_alloc_sampler();
}
extern(C) Shader sg_alloc_shader() @system @nogc nothrow;
Shader allocShader() @trusted @nogc nothrow {
    return sg_alloc_shader();
}
extern(C) Pipeline sg_alloc_pipeline() @system @nogc nothrow;
Pipeline allocPipeline() @trusted @nogc nothrow {
    return sg_alloc_pipeline();
}
extern(C) Attachments sg_alloc_attachments() @system @nogc nothrow;
Attachments allocAttachments() @trusted @nogc nothrow {
    return sg_alloc_attachments();
}
extern(C) void sg_dealloc_buffer(Buffer) @system @nogc nothrow;
void deallocBuffer(Buffer buf) @trusted @nogc nothrow {
    sg_dealloc_buffer(buf);
}
extern(C) void sg_dealloc_image(Image) @system @nogc nothrow;
void deallocImage(Image img) @trusted @nogc nothrow {
    sg_dealloc_image(img);
}
extern(C) void sg_dealloc_sampler(Sampler) @system @nogc nothrow;
void deallocSampler(Sampler smp) @trusted @nogc nothrow {
    sg_dealloc_sampler(smp);
}
extern(C) void sg_dealloc_shader(Shader) @system @nogc nothrow;
void deallocShader(Shader shd) @trusted @nogc nothrow {
    sg_dealloc_shader(shd);
}
extern(C) void sg_dealloc_pipeline(Pipeline) @system @nogc nothrow;
void deallocPipeline(Pipeline pip) @trusted @nogc nothrow {
    sg_dealloc_pipeline(pip);
}
extern(C) void sg_dealloc_attachments(Attachments) @system @nogc nothrow;
void deallocAttachments(Attachments attachments) @trusted @nogc nothrow {
    sg_dealloc_attachments(attachments);
}
extern(C) void sg_init_buffer(Buffer, const BufferDesc *) @system @nogc nothrow;
void initBuffer(Buffer buf, scope ref BufferDesc desc) @trusted @nogc nothrow {
    sg_init_buffer(buf, &desc);
}
extern(C) void sg_init_image(Image, const ImageDesc *) @system @nogc nothrow;
void initImage(Image img, scope ref ImageDesc desc) @trusted @nogc nothrow {
    sg_init_image(img, &desc);
}
extern(C) void sg_init_sampler(Sampler, const SamplerDesc *) @system @nogc nothrow;
void initSampler(Sampler smg, scope ref SamplerDesc desc) @trusted @nogc nothrow {
    sg_init_sampler(smg, &desc);
}
extern(C) void sg_init_shader(Shader, const ShaderDesc *) @system @nogc nothrow;
void initShader(Shader shd, scope ref ShaderDesc desc) @trusted @nogc nothrow {
    sg_init_shader(shd, &desc);
}
extern(C) void sg_init_pipeline(Pipeline, const PipelineDesc *) @system @nogc nothrow;
void initPipeline(Pipeline pip, scope ref PipelineDesc desc) @trusted @nogc nothrow {
    sg_init_pipeline(pip, &desc);
}
extern(C) void sg_init_attachments(Attachments, const AttachmentsDesc *) @system @nogc nothrow;
void initAttachments(Attachments attachments, scope ref AttachmentsDesc desc) @trusted @nogc nothrow {
    sg_init_attachments(attachments, &desc);
}
extern(C) void sg_uninit_buffer(Buffer) @system @nogc nothrow;
void uninitBuffer(Buffer buf) @trusted @nogc nothrow {
    sg_uninit_buffer(buf);
}
extern(C) void sg_uninit_image(Image) @system @nogc nothrow;
void uninitImage(Image img) @trusted @nogc nothrow {
    sg_uninit_image(img);
}
extern(C) void sg_uninit_sampler(Sampler) @system @nogc nothrow;
void uninitSampler(Sampler smp) @trusted @nogc nothrow {
    sg_uninit_sampler(smp);
}
extern(C) void sg_uninit_shader(Shader) @system @nogc nothrow;
void uninitShader(Shader shd) @trusted @nogc nothrow {
    sg_uninit_shader(shd);
}
extern(C) void sg_uninit_pipeline(Pipeline) @system @nogc nothrow;
void uninitPipeline(Pipeline pip) @trusted @nogc nothrow {
    sg_uninit_pipeline(pip);
}
extern(C) void sg_uninit_attachments(Attachments) @system @nogc nothrow;
void uninitAttachments(Attachments atts) @trusted @nogc nothrow {
    sg_uninit_attachments(atts);
}
extern(C) void sg_fail_buffer(Buffer) @system @nogc nothrow;
void failBuffer(Buffer buf) @trusted @nogc nothrow {
    sg_fail_buffer(buf);
}
extern(C) void sg_fail_image(Image) @system @nogc nothrow;
void failImage(Image img) @trusted @nogc nothrow {
    sg_fail_image(img);
}
extern(C) void sg_fail_sampler(Sampler) @system @nogc nothrow;
void failSampler(Sampler smp) @trusted @nogc nothrow {
    sg_fail_sampler(smp);
}
extern(C) void sg_fail_shader(Shader) @system @nogc nothrow;
void failShader(Shader shd) @trusted @nogc nothrow {
    sg_fail_shader(shd);
}
extern(C) void sg_fail_pipeline(Pipeline) @system @nogc nothrow;
void failPipeline(Pipeline pip) @trusted @nogc nothrow {
    sg_fail_pipeline(pip);
}
extern(C) void sg_fail_attachments(Attachments) @system @nogc nothrow;
void failAttachments(Attachments atts) @trusted @nogc nothrow {
    sg_fail_attachments(atts);
}
extern(C) void sg_enable_frame_stats() @system @nogc nothrow;
void enableFrameStats() @trusted @nogc nothrow {
    sg_enable_frame_stats();
}
extern(C) void sg_disable_frame_stats() @system @nogc nothrow;
void disableFrameStats() @trusted @nogc nothrow {
    sg_disable_frame_stats();
}
extern(C) bool sg_frame_stats_enabled() @system @nogc nothrow;
bool frameStatsEnabled() @trusted @nogc nothrow {
    return sg_frame_stats_enabled();
}
extern(C) FrameStats sg_query_frame_stats() @system @nogc nothrow;
FrameStats queryFrameStats() @trusted @nogc nothrow {
    return sg_query_frame_stats();
}
extern(C)
struct D3d11BufferInfo {
    const(void)* buf = null;
}
extern(C)
struct D3d11ImageInfo {
    const(void)* tex2d = null;
    const(void)* tex3d = null;
    const(void)* res = null;
    const(void)* srv = null;
}
extern(C)
struct D3d11SamplerInfo {
    const(void)* smp = null;
}
extern(C)
struct D3d11ShaderInfo {
    const(void)*[4] vs_cbufs = null;
    const(void)*[4] fs_cbufs = null;
    const(void)* vs = null;
    const(void)* fs = null;
}
extern(C)
struct D3d11PipelineInfo {
    const(void)* il = null;
    const(void)* rs = null;
    const(void)* dss = null;
    const(void)* bs = null;
}
extern(C)
struct D3d11AttachmentsInfo {
    const(void)*[4] color_rtv = null;
    const(void)*[4] resolve_rtv = null;
    const(void)* dsv = null;
}
extern(C)
struct MtlBufferInfo {
    const(void)*[2] buf = null;
    int active_slot = 0;
}
extern(C)
struct MtlImageInfo {
    const(void)*[2] tex = null;
    int active_slot = 0;
}
extern(C)
struct MtlSamplerInfo {
    const(void)* smp = null;
}
extern(C)
struct MtlShaderInfo {
    const(void)* vs_lib = null;
    const(void)* fs_lib = null;
    const(void)* vs_func = null;
    const(void)* fs_func = null;
}
extern(C)
struct MtlPipelineInfo {
    const(void)* rps = null;
    const(void)* dss = null;
}
extern(C)
struct WgpuBufferInfo {
    const(void)* buf = null;
}
extern(C)
struct WgpuImageInfo {
    const(void)* tex = null;
    const(void)* view = null;
}
extern(C)
struct WgpuSamplerInfo {
    const(void)* smp = null;
}
extern(C)
struct WgpuShaderInfo {
    const(void)* vs_mod = null;
    const(void)* fs_mod = null;
    const(void)* bgl = null;
}
extern(C)
struct WgpuPipelineInfo {
    const(void)* pip = null;
}
extern(C)
struct WgpuAttachmentsInfo {
    const(void)*[4] color_view = null;
    const(void)*[4] resolve_view = null;
    const(void)* ds_view = null;
}
extern(C)
struct GlBufferInfo {
    uint[2] buf = 0;
    int active_slot = 0;
}
extern(C)
struct GlImageInfo {
    uint[2] tex = 0;
    uint tex_target = 0;
    uint msaa_render_buffer = 0;
    int active_slot = 0;
}
extern(C)
struct GlSamplerInfo {
    uint smp = 0;
}
extern(C)
struct GlShaderInfo {
    uint prog = 0;
}
extern(C)
struct GlAttachmentsInfo {
    uint framebuffer = 0;
    uint[4] msaa_resolve_framebuffer = 0;
}
extern(C) const(void)* sg_d3d11_device() @system @nogc nothrow;
scope const(void)* d3d11Device() @trusted @nogc nothrow {
    return sg_d3d11_device();
}
extern(C) const(void)* sg_d3d11_device_context() @system @nogc nothrow;
scope const(void)* d3d11DeviceContext() @trusted @nogc nothrow {
    return sg_d3d11_device_context();
}
extern(C) D3d11BufferInfo sg_d3d11_query_buffer_info(Buffer) @system @nogc nothrow;
D3d11BufferInfo d3d11QueryBufferInfo(Buffer buf) @trusted @nogc nothrow {
    return sg_d3d11_query_buffer_info(buf);
}
extern(C) D3d11ImageInfo sg_d3d11_query_image_info(Image) @system @nogc nothrow;
D3d11ImageInfo d3d11QueryImageInfo(Image img) @trusted @nogc nothrow {
    return sg_d3d11_query_image_info(img);
}
extern(C) D3d11SamplerInfo sg_d3d11_query_sampler_info(Sampler) @system @nogc nothrow;
D3d11SamplerInfo d3d11QuerySamplerInfo(Sampler smp) @trusted @nogc nothrow {
    return sg_d3d11_query_sampler_info(smp);
}
extern(C) D3d11ShaderInfo sg_d3d11_query_shader_info(Shader) @system @nogc nothrow;
D3d11ShaderInfo d3d11QueryShaderInfo(Shader shd) @trusted @nogc nothrow {
    return sg_d3d11_query_shader_info(shd);
}
extern(C) D3d11PipelineInfo sg_d3d11_query_pipeline_info(Pipeline) @system @nogc nothrow;
D3d11PipelineInfo d3d11QueryPipelineInfo(Pipeline pip) @trusted @nogc nothrow {
    return sg_d3d11_query_pipeline_info(pip);
}
extern(C) D3d11AttachmentsInfo sg_d3d11_query_attachments_info(Attachments) @system @nogc nothrow;
D3d11AttachmentsInfo d3d11QueryAttachmentsInfo(Attachments atts) @trusted @nogc nothrow {
    return sg_d3d11_query_attachments_info(atts);
}
extern(C) const(void)* sg_mtl_device() @system @nogc nothrow;
scope const(void)* mtlDevice() @trusted @nogc nothrow {
    return sg_mtl_device();
}
extern(C) const(void)* sg_mtl_render_command_encoder() @system @nogc nothrow;
scope const(void)* mtlRenderCommandEncoder() @trusted @nogc nothrow {
    return sg_mtl_render_command_encoder();
}
extern(C) MtlBufferInfo sg_mtl_query_buffer_info(Buffer) @system @nogc nothrow;
MtlBufferInfo mtlQueryBufferInfo(Buffer buf) @trusted @nogc nothrow {
    return sg_mtl_query_buffer_info(buf);
}
extern(C) MtlImageInfo sg_mtl_query_image_info(Image) @system @nogc nothrow;
MtlImageInfo mtlQueryImageInfo(Image img) @trusted @nogc nothrow {
    return sg_mtl_query_image_info(img);
}
extern(C) MtlSamplerInfo sg_mtl_query_sampler_info(Sampler) @system @nogc nothrow;
MtlSamplerInfo mtlQuerySamplerInfo(Sampler smp) @trusted @nogc nothrow {
    return sg_mtl_query_sampler_info(smp);
}
extern(C) MtlShaderInfo sg_mtl_query_shader_info(Shader) @system @nogc nothrow;
MtlShaderInfo mtlQueryShaderInfo(Shader shd) @trusted @nogc nothrow {
    return sg_mtl_query_shader_info(shd);
}
extern(C) MtlPipelineInfo sg_mtl_query_pipeline_info(Pipeline) @system @nogc nothrow;
MtlPipelineInfo mtlQueryPipelineInfo(Pipeline pip) @trusted @nogc nothrow {
    return sg_mtl_query_pipeline_info(pip);
}
extern(C) const(void)* sg_wgpu_device() @system @nogc nothrow;
scope const(void)* wgpuDevice() @trusted @nogc nothrow {
    return sg_wgpu_device();
}
extern(C) const(void)* sg_wgpu_queue() @system @nogc nothrow;
scope const(void)* wgpuQueue() @trusted @nogc nothrow {
    return sg_wgpu_queue();
}
extern(C) const(void)* sg_wgpu_command_encoder() @system @nogc nothrow;
scope const(void)* wgpuCommandEncoder() @trusted @nogc nothrow {
    return sg_wgpu_command_encoder();
}
extern(C) const(void)* sg_wgpu_render_pass_encoder() @system @nogc nothrow;
scope const(void)* wgpuRenderPassEncoder() @trusted @nogc nothrow {
    return sg_wgpu_render_pass_encoder();
}
extern(C) WgpuBufferInfo sg_wgpu_query_buffer_info(Buffer) @system @nogc nothrow;
WgpuBufferInfo wgpuQueryBufferInfo(Buffer buf) @trusted @nogc nothrow {
    return sg_wgpu_query_buffer_info(buf);
}
extern(C) WgpuImageInfo sg_wgpu_query_image_info(Image) @system @nogc nothrow;
WgpuImageInfo wgpuQueryImageInfo(Image img) @trusted @nogc nothrow {
    return sg_wgpu_query_image_info(img);
}
extern(C) WgpuSamplerInfo sg_wgpu_query_sampler_info(Sampler) @system @nogc nothrow;
WgpuSamplerInfo wgpuQuerySamplerInfo(Sampler smp) @trusted @nogc nothrow {
    return sg_wgpu_query_sampler_info(smp);
}
extern(C) WgpuShaderInfo sg_wgpu_query_shader_info(Shader) @system @nogc nothrow;
WgpuShaderInfo wgpuQueryShaderInfo(Shader shd) @trusted @nogc nothrow {
    return sg_wgpu_query_shader_info(shd);
}
extern(C) WgpuPipelineInfo sg_wgpu_query_pipeline_info(Pipeline) @system @nogc nothrow;
WgpuPipelineInfo wgpuQueryPipelineInfo(Pipeline pip) @trusted @nogc nothrow {
    return sg_wgpu_query_pipeline_info(pip);
}
extern(C) WgpuAttachmentsInfo sg_wgpu_query_attachments_info(Attachments) @system @nogc nothrow;
WgpuAttachmentsInfo wgpuQueryAttachmentsInfo(Attachments atts) @trusted @nogc nothrow {
    return sg_wgpu_query_attachments_info(atts);
}
extern(C) GlBufferInfo sg_gl_query_buffer_info(Buffer) @system @nogc nothrow;
GlBufferInfo glQueryBufferInfo(Buffer buf) @trusted @nogc nothrow {
    return sg_gl_query_buffer_info(buf);
}
extern(C) GlImageInfo sg_gl_query_image_info(Image) @system @nogc nothrow;
GlImageInfo glQueryImageInfo(Image img) @trusted @nogc nothrow {
    return sg_gl_query_image_info(img);
}
extern(C) GlSamplerInfo sg_gl_query_sampler_info(Sampler) @system @nogc nothrow;
GlSamplerInfo glQuerySamplerInfo(Sampler smp) @trusted @nogc nothrow {
    return sg_gl_query_sampler_info(smp);
}
extern(C) GlShaderInfo sg_gl_query_shader_info(Shader) @system @nogc nothrow;
GlShaderInfo glQueryShaderInfo(Shader shd) @trusted @nogc nothrow {
    return sg_gl_query_shader_info(shd);
}
extern(C) GlAttachmentsInfo sg_gl_query_attachments_info(Attachments) @system @nogc nothrow;
GlAttachmentsInfo glQueryAttachmentsInfo(Attachments atts) @trusted @nogc nothrow {
    return sg_gl_query_attachments_info(atts);
}
