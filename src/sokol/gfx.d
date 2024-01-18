// machine generated, do not edit

module sokol.gfx;

extern(C)
struct Buffer {
    uint id;
}
extern(C)
struct Image {
    uint id;
}
extern(C)
struct Sampler {
    uint id;
}
extern(C)
struct Shader {
    uint id;
}
extern(C)
struct Pipeline {
    uint id;
}
extern(C)
struct Pass {
    uint id;
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
enum invalid_id = 0;
enum num_shader_stages = 2;
enum num_inflight_frames = 2;
enum max_color_attachments = 4;
enum max_vertex_buffers = 8;
enum max_shaderstage_images = 12;
enum max_shaderstage_samplers = 8;
enum max_shaderstage_imagesamplerpairs = 12;
enum max_shaderstage_ubs = 4;
enum max_ub_members = 16;
enum max_vertex_attributes = 16;
enum max_mipmaps = 16;
enum max_texturearray_layers = 128;
extern(C)
struct Color {
    float r;
    float g;
    float b;
    float a;
}
enum Backend {
    Glcore33,
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
    Bc4_r,
    Bc4_rsn,
    Bc5_rg,
    Bc5_rgsn,
    Bc6h_rgbf,
    Bc6h_rgbuf,
    Bc7_rgba,
    Pvrtc_rgb_2bpp,
    Pvrtc_rgb_4bpp,
    Pvrtc_rgba_2bpp,
    Pvrtc_rgba_4bpp,
    Etc2_rgb8,
    Etc2_rgb8a1,
    Etc2_rgba8,
    Etc2_rg11,
    Etc2_rg11sn,
    Num,
}
extern(C)
struct PixelformatInfo {
    bool sample;
    bool filter;
    bool render;
    bool blend;
    bool msaa;
    bool depth;
    bool compressed;
    int bytes_per_pixel;
}
extern(C)
struct Features {
    bool origin_top_left;
    bool image_clamp_to_border;
    bool mrt_independent_blend_state;
    bool mrt_independent_write_mask;
}
extern(C)
struct Limits {
    int max_image_size_2d;
    int max_image_size_cube;
    int max_image_size_3d;
    int max_image_size_array;
    int max_image_array_layers;
    int max_vertex_attrs;
    int gl_max_vertex_uniform_vectors;
    int gl_max_combined_texture_image_units;
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
    float clear_value;
}
extern(C)
struct StencilAttachmentAction {
    LoadAction load_action;
    StoreAction store_action;
    ubyte clear_value;
}
extern(C)
struct PassAction {
    uint _start_canary;
    ColorAttachmentAction[4] colors;
    DepthAttachmentAction depth;
    StencilAttachmentAction stencil;
    uint _end_canary;
}
extern(C)
struct StageBindings {
    Image[12] images;
    Sampler[8] samplers;
}
extern(C)
struct Bindings {
    uint _start_canary;
    Buffer[8] vertex_buffers;
    int[8] vertex_buffer_offsets;
    Buffer index_buffer;
    int index_buffer_offset;
    StageBindings vs;
    StageBindings fs;
    uint _end_canary;
}
extern(C)
struct BufferDesc {
    uint _start_canary;
    size_t size;
    BufferType type;
    Usage usage;
    Range data;
    const(char)* label;
    uint[2] gl_buffers;
    const(void)*[2] mtl_buffers;
    const(void)* d3d11_buffer;
    const(void)* wgpu_buffer;
    uint _end_canary;
}
extern(C)
struct ImageData {
    Range[6][16] subimage;
}
extern(C)
struct ImageDesc {
    uint _start_canary;
    ImageType type;
    bool render_target;
    int width;
    int height;
    int num_slices;
    int num_mipmaps;
    Usage usage;
    PixelFormat pixel_format;
    int sample_count;
    ImageData data;
    const(char)* label;
    uint[2] gl_textures;
    uint gl_texture_target;
    const(void)*[2] mtl_textures;
    const(void)* d3d11_texture;
    const(void)* d3d11_shader_resource_view;
    const(void)* wgpu_texture;
    const(void)* wgpu_texture_view;
    uint _end_canary;
}
extern(C)
struct SamplerDesc {
    uint _start_canary;
    Filter min_filter;
    Filter mag_filter;
    Filter mipmap_filter;
    Wrap wrap_u;
    Wrap wrap_v;
    Wrap wrap_w;
    float min_lod;
    float max_lod;
    BorderColor border_color;
    CompareFunc compare;
    uint max_anisotropy;
    const(char)* label;
    uint gl_sampler;
    const(void)* mtl_sampler;
    const(void)* d3d11_sampler;
    const(void)* wgpu_sampler;
    uint _end_canary;
}
extern(C)
struct ShaderAttrDesc {
    const(char)* name;
    const(char)* sem_name;
    int sem_index;
}
extern(C)
struct ShaderUniformDesc {
    const(char)* name;
    UniformType type;
    int array_count;
}
extern(C)
struct ShaderUniformBlockDesc {
    size_t size;
    UniformLayout layout;
    ShaderUniformDesc[16] uniforms;
}
extern(C)
struct ShaderImageDesc {
    bool used;
    bool multisampled;
    ImageType image_type;
    ImageSampleType sample_type;
}
extern(C)
struct ShaderSamplerDesc {
    bool used;
    SamplerType sampler_type;
}
extern(C)
struct ShaderImageSamplerPairDesc {
    bool used;
    int image_slot;
    int sampler_slot;
    const(char)* glsl_name;
}
extern(C)
struct ShaderStageDesc {
    const(char)* source;
    Range bytecode;
    const(char)* entry;
    const(char)* d3d11_target;
    ShaderUniformBlockDesc[4] uniform_blocks;
    ShaderImageDesc[12] images;
    ShaderSamplerDesc[8] samplers;
    ShaderImageSamplerPairDesc[12] image_sampler_pairs;
}
extern(C)
struct ShaderDesc {
    uint _start_canary;
    ShaderAttrDesc[16] attrs;
    ShaderStageDesc vs;
    ShaderStageDesc fs;
    const(char)* label;
    uint _end_canary;
}
extern(C)
struct VertexBufferLayoutState {
    int stride;
    VertexStep step_func;
    int step_rate;
}
extern(C)
struct VertexAttrState {
    int buffer_index;
    int offset;
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
    bool enabled;
    StencilFaceState front;
    StencilFaceState back;
    ubyte read_mask;
    ubyte write_mask;
    ubyte _ref;
}
extern(C)
struct DepthState {
    PixelFormat pixel_format;
    CompareFunc compare;
    bool write_enabled;
    float bias;
    float bias_slope_scale;
    float bias_clamp;
}
extern(C)
struct BlendState {
    bool enabled;
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
    uint _start_canary;
    Shader shader;
    VertexLayoutState layout;
    DepthState depth;
    StencilState stencil;
    int color_count;
    ColorTargetState[4] colors;
    PrimitiveType primitive_type;
    IndexType index_type;
    CullMode cull_mode;
    FaceWinding face_winding;
    int sample_count;
    Color blend_color;
    bool alpha_to_coverage_enabled;
    const(char)* label;
    uint _end_canary;
}
extern(C)
struct PassAttachmentDesc {
    Image image;
    int mip_level;
    int slice;
}
extern(C)
struct PassDesc {
    uint _start_canary;
    PassAttachmentDesc[4] color_attachments;
    PassAttachmentDesc[4] resolve_attachments;
    PassAttachmentDesc depth_stencil_attachment;
    const(char)* label;
    uint _end_canary;
}
extern(C)
struct TraceHooks {
    void* user_data;
    extern(C) void function(void*) reset_state_cache;
    extern(C) void function(const BufferDesc *, Buffer, void*) make_buffer;
    extern(C) void function(const ImageDesc *, Image, void*) make_image;
    extern(C) void function(const SamplerDesc *, Sampler, void*) make_sampler;
    extern(C) void function(const ShaderDesc *, Shader, void*) make_shader;
    extern(C) void function(const PipelineDesc *, Pipeline, void*) make_pipeline;
    extern(C) void function(const PassDesc *, Pass, void*) make_pass;
    extern(C) void function(Buffer, void*) destroy_buffer;
    extern(C) void function(Image, void*) destroy_image;
    extern(C) void function(Sampler, void*) destroy_sampler;
    extern(C) void function(Shader, void*) destroy_shader;
    extern(C) void function(Pipeline, void*) destroy_pipeline;
    extern(C) void function(Pass, void*) destroy_pass;
    extern(C) void function(Buffer, const Range *, void*) update_buffer;
    extern(C) void function(Image, const ImageData *, void*) update_image;
    extern(C) void function(Buffer, const Range *, int, void*) append_buffer;
    extern(C) void function(const PassAction *, int, int, void*) begin_default_pass;
    extern(C) void function(Pass, const PassAction *, void*) begin_pass;
    extern(C) void function(int, int, int, int, bool, void*) apply_viewport;
    extern(C) void function(int, int, int, int, bool, void*) apply_scissor_rect;
    extern(C) void function(Pipeline, void*) apply_pipeline;
    extern(C) void function(const Bindings *, void*) apply_bindings;
    extern(C) void function(ShaderStage, int, const Range *, void*) apply_uniforms;
    extern(C) void function(int, int, int, void*) draw;
    extern(C) void function(void*) end_pass;
    extern(C) void function(void*) commit;
    extern(C) void function(Buffer, void*) alloc_buffer;
    extern(C) void function(Image, void*) alloc_image;
    extern(C) void function(Sampler, void*) alloc_sampler;
    extern(C) void function(Shader, void*) alloc_shader;
    extern(C) void function(Pipeline, void*) alloc_pipeline;
    extern(C) void function(Pass, void*) alloc_pass;
    extern(C) void function(Buffer, void*) dealloc_buffer;
    extern(C) void function(Image, void*) dealloc_image;
    extern(C) void function(Sampler, void*) dealloc_sampler;
    extern(C) void function(Shader, void*) dealloc_shader;
    extern(C) void function(Pipeline, void*) dealloc_pipeline;
    extern(C) void function(Pass, void*) dealloc_pass;
    extern(C) void function(Buffer, const BufferDesc *, void*) init_buffer;
    extern(C) void function(Image, const ImageDesc *, void*) init_image;
    extern(C) void function(Sampler, const SamplerDesc *, void*) init_sampler;
    extern(C) void function(Shader, const ShaderDesc *, void*) init_shader;
    extern(C) void function(Pipeline, const PipelineDesc *, void*) init_pipeline;
    extern(C) void function(Pass, const PassDesc *, void*) init_pass;
    extern(C) void function(Buffer, void*) uninit_buffer;
    extern(C) void function(Image, void*) uninit_image;
    extern(C) void function(Sampler, void*) uninit_sampler;
    extern(C) void function(Shader, void*) uninit_shader;
    extern(C) void function(Pipeline, void*) uninit_pipeline;
    extern(C) void function(Pass, void*) uninit_pass;
    extern(C) void function(Buffer, void*) fail_buffer;
    extern(C) void function(Image, void*) fail_image;
    extern(C) void function(Sampler, void*) fail_sampler;
    extern(C) void function(Shader, void*) fail_shader;
    extern(C) void function(Pipeline, void*) fail_pipeline;
    extern(C) void function(Pass, void*) fail_pass;
    extern(C) void function(scope const(char)*, void*) push_debug_group;
    extern(C) void function(void*) pop_debug_group;
}
extern(C)
struct SlotInfo {
    ResourceState state;
    uint res_id;
    uint ctx_id;
}
extern(C)
struct BufferInfo {
    SlotInfo slot;
    uint update_frame_index;
    uint append_frame_index;
    int append_pos;
    bool append_overflow;
    int num_slots;
    int active_slot;
}
extern(C)
struct ImageInfo {
    SlotInfo slot;
    uint upd_frame_index;
    int num_slots;
    int active_slot;
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
struct PassInfo {
    SlotInfo slot;
}
extern(C)
struct FrameStatsGl {
    uint num_bind_buffer;
    uint num_active_texture;
    uint num_bind_texture;
    uint num_bind_sampler;
    uint num_use_program;
    uint num_render_state;
    uint num_vertex_attrib_pointer;
    uint num_vertex_attrib_divisor;
    uint num_enable_vertex_attrib_array;
    uint num_disable_vertex_attrib_array;
    uint num_uniform;
}
extern(C)
struct FrameStatsD3d11Pass {
    uint num_om_set_render_targets;
    uint num_clear_render_target_view;
    uint num_clear_depth_stencil_view;
    uint num_resolve_subresource;
}
extern(C)
struct FrameStatsD3d11Pipeline {
    uint num_rs_set_state;
    uint num_om_set_depth_stencil_state;
    uint num_om_set_blend_state;
    uint num_ia_set_primitive_topology;
    uint num_ia_set_input_layout;
    uint num_vs_set_shader;
    uint num_vs_set_constant_buffers;
    uint num_ps_set_shader;
    uint num_ps_set_constant_buffers;
}
extern(C)
struct FrameStatsD3d11Bindings {
    uint num_ia_set_vertex_buffers;
    uint num_ia_set_index_buffer;
    uint num_vs_set_shader_resources;
    uint num_ps_set_shader_resources;
    uint num_vs_set_samplers;
    uint num_ps_set_samplers;
}
extern(C)
struct FrameStatsD3d11Uniforms {
    uint num_update_subresource;
}
extern(C)
struct FrameStatsD3d11Draw {
    uint num_draw_indexed_instanced;
    uint num_draw_indexed;
    uint num_draw_instanced;
    uint num_draw;
}
extern(C)
struct FrameStatsD3d11 {
    FrameStatsD3d11Pass pass;
    FrameStatsD3d11Pipeline pipeline;
    FrameStatsD3d11Bindings bindings;
    FrameStatsD3d11Uniforms uniforms;
    FrameStatsD3d11Draw draw;
    uint num_map;
    uint num_unmap;
}
extern(C)
struct FrameStatsMetalIdpool {
    uint num_added;
    uint num_released;
    uint num_garbage_collected;
}
extern(C)
struct FrameStatsMetalPipeline {
    uint num_set_blend_color;
    uint num_set_cull_mode;
    uint num_set_front_facing_winding;
    uint num_set_stencil_reference_value;
    uint num_set_depth_bias;
    uint num_set_render_pipeline_state;
    uint num_set_depth_stencil_state;
}
extern(C)
struct FrameStatsMetalBindings {
    uint num_set_vertex_buffer;
    uint num_set_vertex_texture;
    uint num_set_vertex_sampler_state;
    uint num_set_fragment_texture;
    uint num_set_fragment_sampler_state;
}
extern(C)
struct FrameStatsMetalUniforms {
    uint num_set_vertex_buffer_offset;
    uint num_set_fragment_buffer_offset;
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
    uint num_set_bindgroup;
    uint size_write_buffer;
}
extern(C)
struct FrameStatsWgpuBindings {
    uint num_set_vertex_buffer;
    uint num_skip_redundant_vertex_buffer;
    uint num_set_index_buffer;
    uint num_skip_redundant_index_buffer;
    uint num_create_bindgroup;
    uint num_discard_bindgroup;
    uint num_set_bindgroup;
    uint num_skip_redundant_bindgroup;
    uint num_bindgroup_cache_hits;
    uint num_bindgroup_cache_misses;
    uint num_bindgroup_cache_collisions;
    uint num_bindgroup_cache_hash_vs_key_mismatch;
}
extern(C)
struct FrameStatsWgpu {
    FrameStatsWgpuUniforms uniforms;
    FrameStatsWgpuBindings bindings;
}
extern(C)
struct FrameStats {
    uint frame_index;
    uint num_passes;
    uint num_apply_viewport;
    uint num_apply_scissor_rect;
    uint num_apply_pipeline;
    uint num_apply_bindings;
    uint num_apply_uniforms;
    uint num_draw;
    uint num_update_buffer;
    uint num_append_buffer;
    uint num_update_image;
    uint size_apply_uniforms;
    uint size_update_buffer;
    uint size_append_buffer;
    uint size_update_image;
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
    Wgpu_shader_create_bindgroup_layout_failed,
    Wgpu_create_pipeline_layout_failed,
    Wgpu_create_render_pipeline_failed,
    Wgpu_pass_create_texture_view_failed,
    Uninit_buffer_active_context_mismatch,
    Uninit_image_active_context_mismatch,
    Uninit_sampler_active_context_mismatch,
    Uninit_shader_active_context_mismatch,
    Uninit_pipeline_active_context_mismatch,
    Uninit_pass_active_context_mismatch,
    Identical_commit_listener,
    Commit_listener_array_full,
    Trace_hooks_not_enabled,
    Dealloc_buffer_invalid_state,
    Dealloc_image_invalid_state,
    Dealloc_sampler_invalid_state,
    Dealloc_shader_invalid_state,
    Dealloc_pipeline_invalid_state,
    Dealloc_pass_invalid_state,
    Init_buffer_invalid_state,
    Init_image_invalid_state,
    Init_sampler_invalid_state,
    Init_shader_invalid_state,
    Init_pipeline_invalid_state,
    Init_pass_invalid_state,
    Uninit_buffer_invalid_state,
    Uninit_image_invalid_state,
    Uninit_sampler_invalid_state,
    Uninit_shader_invalid_state,
    Uninit_pipeline_invalid_state,
    Uninit_pass_invalid_state,
    Fail_buffer_invalid_state,
    Fail_image_invalid_state,
    Fail_sampler_invalid_state,
    Fail_shader_invalid_state,
    Fail_pipeline_invalid_state,
    Fail_pass_invalid_state,
    Buffer_pool_exhausted,
    Image_pool_exhausted,
    Sampler_pool_exhausted,
    Shader_pool_exhausted,
    Pipeline_pool_exhausted,
    Pass_pool_exhausted,
    Draw_without_bindings,
    Validate_bufferdesc_canary,
    Validate_bufferdesc_size,
    Validate_bufferdesc_data,
    Validate_bufferdesc_data_size,
    Validate_bufferdesc_no_data,
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
    Validate_shaderdesc_attr_semantics,
    Validate_shaderdesc_attr_string_too_long,
    Validate_pipelinedesc_canary,
    Validate_pipelinedesc_shader,
    Validate_pipelinedesc_no_attrs,
    Validate_pipelinedesc_layout_stride4,
    Validate_pipelinedesc_attr_semantics,
    Validate_passdesc_canary,
    Validate_passdesc_no_attachments,
    Validate_passdesc_no_cont_color_atts,
    Validate_passdesc_image,
    Validate_passdesc_miplevel,
    Validate_passdesc_face,
    Validate_passdesc_layer,
    Validate_passdesc_slice,
    Validate_passdesc_image_no_rt,
    Validate_passdesc_color_inv_pixelformat,
    Validate_passdesc_depth_inv_pixelformat,
    Validate_passdesc_image_sizes,
    Validate_passdesc_image_sample_counts,
    Validate_passdesc_resolve_color_image_msaa,
    Validate_passdesc_resolve_image,
    Validate_passdesc_resolve_sample_count,
    Validate_passdesc_resolve_miplevel,
    Validate_passdesc_resolve_face,
    Validate_passdesc_resolve_layer,
    Validate_passdesc_resolve_slice,
    Validate_passdesc_resolve_image_no_rt,
    Validate_passdesc_resolve_image_sizes,
    Validate_passdesc_resolve_image_format,
    Validate_passdesc_depth_image,
    Validate_passdesc_depth_miplevel,
    Validate_passdesc_depth_face,
    Validate_passdesc_depth_layer,
    Validate_passdesc_depth_slice,
    Validate_passdesc_depth_image_no_rt,
    Validate_passdesc_depth_image_sizes,
    Validate_passdesc_depth_image_sample_count,
    Validate_beginpass_pass,
    Validate_beginpass_color_attachment_image,
    Validate_beginpass_resolve_attachment_image,
    Validate_beginpass_depthstencil_attachment_image,
    Validate_apip_pipeline_valid_id,
    Validate_apip_pipeline_exists,
    Validate_apip_pipeline_valid,
    Validate_apip_shader_exists,
    Validate_apip_shader_valid,
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
struct MetalContextDesc {
    const(void)* device;
    extern(C) const(void)* function() renderpass_descriptor_cb;
    extern(C) const(void)* function(void*) renderpass_descriptor_userdata_cb;
    extern(C) const(void)* function() drawable_cb;
    extern(C) const(void)* function(void*) drawable_userdata_cb;
    void* user_data;
}
extern(C)
struct D3d11ContextDesc {
    const(void)* device;
    const(void)* device_context;
    extern(C) const(void)* function() render_target_view_cb;
    extern(C) const(void)* function(void*) render_target_view_userdata_cb;
    extern(C) const(void)* function() depth_stencil_view_cb;
    extern(C) const(void)* function(void*) depth_stencil_view_userdata_cb;
    void* user_data;
}
extern(C)
struct WgpuContextDesc {
    const(void)* device;
    extern(C) const(void)* function() render_view_cb;
    extern(C) const(void)* function(void*) render_view_userdata_cb;
    extern(C) const(void)* function() resolve_view_cb;
    extern(C) const(void)* function(void*) resolve_view_userdata_cb;
    extern(C) const(void)* function() depth_stencil_view_cb;
    extern(C) const(void)* function(void*) depth_stencil_view_userdata_cb;
    void* user_data;
}
extern(C)
struct GlContextDesc {
    extern(C) uint function() default_framebuffer_cb;
    extern(C) uint function(void*) default_framebuffer_userdata_cb;
    void* user_data;
}
extern(C)
struct ContextDesc {
    int color_format;
    int depth_format;
    int sample_count;
    MetalContextDesc metal;
    D3d11ContextDesc d3d11;
    WgpuContextDesc wgpu;
    GlContextDesc gl;
}
extern(C)
struct CommitListener {
    extern(C) void function(void*) func;
    void* user_data;
}
extern(C)
struct Allocator {
    extern(C) void* function(size_t, void*) alloc_fn;
    extern(C) void function(void*, void*) free_fn;
    void* user_data;
}
extern(C)
struct Logger {
    extern(C) void function(scope const(char)*, uint, uint, scope const(char)*, uint, scope const(char)*, void*) func;
    void* user_data;
}
extern(C)
struct Desc {
    uint _start_canary;
    int buffer_pool_size;
    int image_pool_size;
    int sampler_pool_size;
    int shader_pool_size;
    int pipeline_pool_size;
    int pass_pool_size;
    int context_pool_size;
    int uniform_buffer_size;
    int max_commit_listeners;
    bool disable_validation;
    bool mtl_force_managed_storage_mode;
    bool wgpu_disable_bindgroups_cache;
    int wgpu_bindgroups_cache_size;
    Allocator allocator;
    Logger logger;
    ContextDesc context;
    uint _end_canary;
}
extern(C) void sg_setup(const Desc *) @system @nogc nothrow;
void setup(ref Desc desc) @trusted nothrow @nogc {
    sg_setup(&desc);
}
extern(C) void sg_shutdown() @system @nogc nothrow;
void shutdown() @trusted nothrow @nogc {
    sg_shutdown();
}
extern(C) bool sg_isvalid() @system @nogc nothrow;
bool isvalid() @trusted nothrow @nogc {
    return sg_isvalid();
}
extern(C) void sg_reset_state_cache() @system @nogc nothrow;
void resetStateCache() @trusted nothrow @nogc {
    sg_reset_state_cache();
}
extern(C) TraceHooks sg_install_trace_hooks(const TraceHooks *) @system @nogc nothrow;
TraceHooks installTraceHooks(ref TraceHooks trace_hooks) @trusted nothrow @nogc {
    return sg_install_trace_hooks(&trace_hooks);
}
extern(C) void sg_push_debug_group(scope const(char)*) @system @nogc nothrow;
void pushDebugGroup(scope const(char)* name) @trusted nothrow @nogc {
    sg_push_debug_group(name);
}
extern(C) void sg_pop_debug_group() @system @nogc nothrow;
void popDebugGroup() @trusted nothrow @nogc {
    sg_pop_debug_group();
}
extern(C) bool sg_add_commit_listener(CommitListener) @system @nogc nothrow;
bool addCommitListener(CommitListener listener) @trusted nothrow @nogc {
    return sg_add_commit_listener(listener);
}
extern(C) bool sg_remove_commit_listener(CommitListener) @system @nogc nothrow;
bool removeCommitListener(CommitListener listener) @trusted nothrow @nogc {
    return sg_remove_commit_listener(listener);
}
extern(C) Buffer sg_make_buffer(const BufferDesc *) @system @nogc nothrow;
Buffer makeBuffer(ref BufferDesc desc) @trusted nothrow @nogc {
    return sg_make_buffer(&desc);
}
extern(C) Image sg_make_image(const ImageDesc *) @system @nogc nothrow;
Image makeImage(ref ImageDesc desc) @trusted nothrow @nogc {
    return sg_make_image(&desc);
}
extern(C) Sampler sg_make_sampler(const SamplerDesc *) @system @nogc nothrow;
Sampler makeSampler(ref SamplerDesc desc) @trusted nothrow @nogc {
    return sg_make_sampler(&desc);
}
extern(C) Shader sg_make_shader(const ShaderDesc *) @system @nogc nothrow;
Shader makeShader(ref ShaderDesc desc) @trusted nothrow @nogc {
    return sg_make_shader(&desc);
}
extern(C) Pipeline sg_make_pipeline(const PipelineDesc *) @system @nogc nothrow;
Pipeline makePipeline(ref PipelineDesc desc) @trusted nothrow @nogc {
    return sg_make_pipeline(&desc);
}
extern(C) Pass sg_make_pass(const PassDesc *) @system @nogc nothrow;
Pass makePass(ref PassDesc desc) @trusted nothrow @nogc {
    return sg_make_pass(&desc);
}
extern(C) void sg_destroy_buffer(Buffer) @system @nogc nothrow;
void destroyBuffer(Buffer buf) @trusted nothrow @nogc {
    sg_destroy_buffer(buf);
}
extern(C) void sg_destroy_image(Image) @system @nogc nothrow;
void destroyImage(Image img) @trusted nothrow @nogc {
    sg_destroy_image(img);
}
extern(C) void sg_destroy_sampler(Sampler) @system @nogc nothrow;
void destroySampler(Sampler smp) @trusted nothrow @nogc {
    sg_destroy_sampler(smp);
}
extern(C) void sg_destroy_shader(Shader) @system @nogc nothrow;
void destroyShader(Shader shd) @trusted nothrow @nogc {
    sg_destroy_shader(shd);
}
extern(C) void sg_destroy_pipeline(Pipeline) @system @nogc nothrow;
void destroyPipeline(Pipeline pip) @trusted nothrow @nogc {
    sg_destroy_pipeline(pip);
}
extern(C) void sg_destroy_pass(Pass) @system @nogc nothrow;
void destroyPass(Pass pass) @trusted nothrow @nogc {
    sg_destroy_pass(pass);
}
extern(C) void sg_update_buffer(Buffer, const Range *) @system @nogc nothrow;
void updateBuffer(Buffer buf, ref Range data) @trusted nothrow @nogc {
    sg_update_buffer(buf, &data);
}
extern(C) void sg_update_image(Image, const ImageData *) @system @nogc nothrow;
void updateImage(Image img, ref ImageData data) @trusted nothrow @nogc {
    sg_update_image(img, &data);
}
extern(C) int sg_append_buffer(Buffer, const Range *) @system @nogc nothrow;
int appendBuffer(Buffer buf, ref Range data) @trusted nothrow @nogc {
    return sg_append_buffer(buf, &data);
}
extern(C) bool sg_query_buffer_overflow(Buffer) @system @nogc nothrow;
bool queryBufferOverflow(Buffer buf) @trusted nothrow @nogc {
    return sg_query_buffer_overflow(buf);
}
extern(C) bool sg_query_buffer_will_overflow(Buffer, size_t) @system @nogc nothrow;
bool queryBufferWillOverflow(Buffer buf, size_t size) @trusted nothrow @nogc {
    return sg_query_buffer_will_overflow(buf, size);
}
extern(C) void sg_begin_default_pass(const PassAction *, int, int) @system @nogc nothrow;
void beginDefaultPass(ref PassAction pass_action, int width, int height) @trusted nothrow @nogc {
    sg_begin_default_pass(&pass_action, width, height);
}
extern(C) void sg_begin_default_passf(const PassAction *, float, float) @system @nogc nothrow;
void beginDefaultPassf(ref PassAction pass_action, float width, float height) @trusted nothrow @nogc {
    sg_begin_default_passf(&pass_action, width, height);
}
extern(C) void sg_begin_pass(Pass, const PassAction *) @system @nogc nothrow;
void beginPass(Pass pass, ref PassAction pass_action) @trusted nothrow @nogc {
    sg_begin_pass(pass, &pass_action);
}
extern(C) void sg_apply_viewport(int, int, int, int, bool) @system @nogc nothrow;
void applyViewport(int x, int y, int width, int height, bool origin_top_left) @trusted nothrow @nogc {
    sg_apply_viewport(x, y, width, height, origin_top_left);
}
extern(C) void sg_apply_viewportf(float, float, float, float, bool) @system @nogc nothrow;
void applyViewportf(float x, float y, float width, float height, bool origin_top_left) @trusted nothrow @nogc {
    sg_apply_viewportf(x, y, width, height, origin_top_left);
}
extern(C) void sg_apply_scissor_rect(int, int, int, int, bool) @system @nogc nothrow;
void applyScissorRect(int x, int y, int width, int height, bool origin_top_left) @trusted nothrow @nogc {
    sg_apply_scissor_rect(x, y, width, height, origin_top_left);
}
extern(C) void sg_apply_scissor_rectf(float, float, float, float, bool) @system @nogc nothrow;
void applyScissorRectf(float x, float y, float width, float height, bool origin_top_left) @trusted nothrow @nogc {
    sg_apply_scissor_rectf(x, y, width, height, origin_top_left);
}
extern(C) void sg_apply_pipeline(Pipeline) @system @nogc nothrow;
void applyPipeline(Pipeline pip) @trusted nothrow @nogc {
    sg_apply_pipeline(pip);
}
extern(C) void sg_apply_bindings(const Bindings *) @system @nogc nothrow;
void applyBindings(ref Bindings bindings) @trusted nothrow @nogc {
    sg_apply_bindings(&bindings);
}
extern(C) void sg_apply_uniforms(ShaderStage, uint, const Range *) @system @nogc nothrow;
void applyUniforms(ShaderStage stage, uint ub_index, ref Range data) @trusted nothrow @nogc {
    sg_apply_uniforms(stage, ub_index, &data);
}
extern(C) void sg_draw(uint, uint, uint) @system @nogc nothrow;
void draw(uint base_element, uint num_elements, uint num_instances) @trusted nothrow @nogc {
    sg_draw(base_element, num_elements, num_instances);
}
extern(C) void sg_end_pass() @system @nogc nothrow;
void endPass() @trusted nothrow @nogc {
    sg_end_pass();
}
extern(C) void sg_commit() @system @nogc nothrow;
void commit() @trusted nothrow @nogc {
    sg_commit();
}
extern(C) Desc sg_query_desc() @system @nogc nothrow;
Desc queryDesc() @trusted nothrow @nogc {
    return sg_query_desc();
}
extern(C) Backend sg_query_backend() @system @nogc nothrow;
Backend queryBackend() @trusted nothrow @nogc {
    return sg_query_backend();
}
extern(C) Features sg_query_features() @system @nogc nothrow;
Features queryFeatures() @trusted nothrow @nogc {
    return sg_query_features();
}
extern(C) Limits sg_query_limits() @system @nogc nothrow;
Limits queryLimits() @trusted nothrow @nogc {
    return sg_query_limits();
}
extern(C) PixelformatInfo sg_query_pixelformat(PixelFormat) @system @nogc nothrow;
PixelformatInfo queryPixelformat(PixelFormat fmt) @trusted nothrow @nogc {
    return sg_query_pixelformat(fmt);
}
extern(C) int sg_query_row_pitch(PixelFormat, int, int) @system @nogc nothrow;
int queryRowPitch(PixelFormat fmt, int width, int row_align_bytes) @trusted nothrow @nogc {
    return sg_query_row_pitch(fmt, width, row_align_bytes);
}
extern(C) int sg_query_surface_pitch(PixelFormat, int, int, int) @system @nogc nothrow;
int querySurfacePitch(PixelFormat fmt, int width, int height, int row_align_bytes) @trusted nothrow @nogc {
    return sg_query_surface_pitch(fmt, width, height, row_align_bytes);
}
extern(C) ResourceState sg_query_buffer_state(Buffer) @system @nogc nothrow;
ResourceState queryBufferState(Buffer buf) @trusted nothrow @nogc {
    return sg_query_buffer_state(buf);
}
extern(C) ResourceState sg_query_image_state(Image) @system @nogc nothrow;
ResourceState queryImageState(Image img) @trusted nothrow @nogc {
    return sg_query_image_state(img);
}
extern(C) ResourceState sg_query_sampler_state(Sampler) @system @nogc nothrow;
ResourceState querySamplerState(Sampler smp) @trusted nothrow @nogc {
    return sg_query_sampler_state(smp);
}
extern(C) ResourceState sg_query_shader_state(Shader) @system @nogc nothrow;
ResourceState queryShaderState(Shader shd) @trusted nothrow @nogc {
    return sg_query_shader_state(shd);
}
extern(C) ResourceState sg_query_pipeline_state(Pipeline) @system @nogc nothrow;
ResourceState queryPipelineState(Pipeline pip) @trusted nothrow @nogc {
    return sg_query_pipeline_state(pip);
}
extern(C) ResourceState sg_query_pass_state(Pass) @system @nogc nothrow;
ResourceState queryPassState(Pass pass) @trusted nothrow @nogc {
    return sg_query_pass_state(pass);
}
extern(C) BufferInfo sg_query_buffer_info(Buffer) @system @nogc nothrow;
BufferInfo queryBufferInfo(Buffer buf) @trusted nothrow @nogc {
    return sg_query_buffer_info(buf);
}
extern(C) ImageInfo sg_query_image_info(Image) @system @nogc nothrow;
ImageInfo queryImageInfo(Image img) @trusted nothrow @nogc {
    return sg_query_image_info(img);
}
extern(C) SamplerInfo sg_query_sampler_info(Sampler) @system @nogc nothrow;
SamplerInfo querySamplerInfo(Sampler smp) @trusted nothrow @nogc {
    return sg_query_sampler_info(smp);
}
extern(C) ShaderInfo sg_query_shader_info(Shader) @system @nogc nothrow;
ShaderInfo queryShaderInfo(Shader shd) @trusted nothrow @nogc {
    return sg_query_shader_info(shd);
}
extern(C) PipelineInfo sg_query_pipeline_info(Pipeline) @system @nogc nothrow;
PipelineInfo queryPipelineInfo(Pipeline pip) @trusted nothrow @nogc {
    return sg_query_pipeline_info(pip);
}
extern(C) PassInfo sg_query_pass_info(Pass) @system @nogc nothrow;
PassInfo queryPassInfo(Pass pass) @trusted nothrow @nogc {
    return sg_query_pass_info(pass);
}
extern(C) BufferDesc sg_query_buffer_desc(Buffer) @system @nogc nothrow;
BufferDesc queryBufferDesc(Buffer buf) @trusted nothrow @nogc {
    return sg_query_buffer_desc(buf);
}
extern(C) ImageDesc sg_query_image_desc(Image) @system @nogc nothrow;
ImageDesc queryImageDesc(Image img) @trusted nothrow @nogc {
    return sg_query_image_desc(img);
}
extern(C) SamplerDesc sg_query_sampler_desc(Sampler) @system @nogc nothrow;
SamplerDesc querySamplerDesc(Sampler smp) @trusted nothrow @nogc {
    return sg_query_sampler_desc(smp);
}
extern(C) ShaderDesc sg_query_shader_desc(Shader) @system @nogc nothrow;
ShaderDesc queryShaderDesc(Shader shd) @trusted nothrow @nogc {
    return sg_query_shader_desc(shd);
}
extern(C) PipelineDesc sg_query_pipeline_desc(Pipeline) @system @nogc nothrow;
PipelineDesc queryPipelineDesc(Pipeline pip) @trusted nothrow @nogc {
    return sg_query_pipeline_desc(pip);
}
extern(C) PassDesc sg_query_pass_desc(Pass) @system @nogc nothrow;
PassDesc queryPassDesc(Pass pass) @trusted nothrow @nogc {
    return sg_query_pass_desc(pass);
}
extern(C) BufferDesc sg_query_buffer_defaults(const BufferDesc *) @system @nogc nothrow;
BufferDesc queryBufferDefaults(ref BufferDesc desc) @trusted nothrow @nogc {
    return sg_query_buffer_defaults(&desc);
}
extern(C) ImageDesc sg_query_image_defaults(const ImageDesc *) @system @nogc nothrow;
ImageDesc queryImageDefaults(ref ImageDesc desc) @trusted nothrow @nogc {
    return sg_query_image_defaults(&desc);
}
extern(C) SamplerDesc sg_query_sampler_defaults(const SamplerDesc *) @system @nogc nothrow;
SamplerDesc querySamplerDefaults(ref SamplerDesc desc) @trusted nothrow @nogc {
    return sg_query_sampler_defaults(&desc);
}
extern(C) ShaderDesc sg_query_shader_defaults(const ShaderDesc *) @system @nogc nothrow;
ShaderDesc queryShaderDefaults(ref ShaderDesc desc) @trusted nothrow @nogc {
    return sg_query_shader_defaults(&desc);
}
extern(C) PipelineDesc sg_query_pipeline_defaults(const PipelineDesc *) @system @nogc nothrow;
PipelineDesc queryPipelineDefaults(ref PipelineDesc desc) @trusted nothrow @nogc {
    return sg_query_pipeline_defaults(&desc);
}
extern(C) PassDesc sg_query_pass_defaults(const PassDesc *) @system @nogc nothrow;
PassDesc queryPassDefaults(ref PassDesc desc) @trusted nothrow @nogc {
    return sg_query_pass_defaults(&desc);
}
extern(C) Buffer sg_alloc_buffer() @system @nogc nothrow;
Buffer allocBuffer() @trusted nothrow @nogc {
    return sg_alloc_buffer();
}
extern(C) Image sg_alloc_image() @system @nogc nothrow;
Image allocImage() @trusted nothrow @nogc {
    return sg_alloc_image();
}
extern(C) Sampler sg_alloc_sampler() @system @nogc nothrow;
Sampler allocSampler() @trusted nothrow @nogc {
    return sg_alloc_sampler();
}
extern(C) Shader sg_alloc_shader() @system @nogc nothrow;
Shader allocShader() @trusted nothrow @nogc {
    return sg_alloc_shader();
}
extern(C) Pipeline sg_alloc_pipeline() @system @nogc nothrow;
Pipeline allocPipeline() @trusted nothrow @nogc {
    return sg_alloc_pipeline();
}
extern(C) Pass sg_alloc_pass() @system @nogc nothrow;
Pass allocPass() @trusted nothrow @nogc {
    return sg_alloc_pass();
}
extern(C) void sg_dealloc_buffer(Buffer) @system @nogc nothrow;
void deallocBuffer(Buffer buf) @trusted nothrow @nogc {
    sg_dealloc_buffer(buf);
}
extern(C) void sg_dealloc_image(Image) @system @nogc nothrow;
void deallocImage(Image img) @trusted nothrow @nogc {
    sg_dealloc_image(img);
}
extern(C) void sg_dealloc_sampler(Sampler) @system @nogc nothrow;
void deallocSampler(Sampler smp) @trusted nothrow @nogc {
    sg_dealloc_sampler(smp);
}
extern(C) void sg_dealloc_shader(Shader) @system @nogc nothrow;
void deallocShader(Shader shd) @trusted nothrow @nogc {
    sg_dealloc_shader(shd);
}
extern(C) void sg_dealloc_pipeline(Pipeline) @system @nogc nothrow;
void deallocPipeline(Pipeline pip) @trusted nothrow @nogc {
    sg_dealloc_pipeline(pip);
}
extern(C) void sg_dealloc_pass(Pass) @system @nogc nothrow;
void deallocPass(Pass pass) @trusted nothrow @nogc {
    sg_dealloc_pass(pass);
}
extern(C) void sg_init_buffer(Buffer, const BufferDesc *) @system @nogc nothrow;
void initBuffer(Buffer buf, ref BufferDesc desc) @trusted nothrow @nogc {
    sg_init_buffer(buf, &desc);
}
extern(C) void sg_init_image(Image, const ImageDesc *) @system @nogc nothrow;
void initImage(Image img, ref ImageDesc desc) @trusted nothrow @nogc {
    sg_init_image(img, &desc);
}
extern(C) void sg_init_sampler(Sampler, const SamplerDesc *) @system @nogc nothrow;
void initSampler(Sampler smg, ref SamplerDesc desc) @trusted nothrow @nogc {
    sg_init_sampler(smg, &desc);
}
extern(C) void sg_init_shader(Shader, const ShaderDesc *) @system @nogc nothrow;
void initShader(Shader shd, ref ShaderDesc desc) @trusted nothrow @nogc {
    sg_init_shader(shd, &desc);
}
extern(C) void sg_init_pipeline(Pipeline, const PipelineDesc *) @system @nogc nothrow;
void initPipeline(Pipeline pip, ref PipelineDesc desc) @trusted nothrow @nogc {
    sg_init_pipeline(pip, &desc);
}
extern(C) void sg_init_pass(Pass, const PassDesc *) @system @nogc nothrow;
void initPass(Pass pass, ref PassDesc desc) @trusted nothrow @nogc {
    sg_init_pass(pass, &desc);
}
extern(C) void sg_uninit_buffer(Buffer) @system @nogc nothrow;
void uninitBuffer(Buffer buf) @trusted nothrow @nogc {
    sg_uninit_buffer(buf);
}
extern(C) void sg_uninit_image(Image) @system @nogc nothrow;
void uninitImage(Image img) @trusted nothrow @nogc {
    sg_uninit_image(img);
}
extern(C) void sg_uninit_sampler(Sampler) @system @nogc nothrow;
void uninitSampler(Sampler smp) @trusted nothrow @nogc {
    sg_uninit_sampler(smp);
}
extern(C) void sg_uninit_shader(Shader) @system @nogc nothrow;
void uninitShader(Shader shd) @trusted nothrow @nogc {
    sg_uninit_shader(shd);
}
extern(C) void sg_uninit_pipeline(Pipeline) @system @nogc nothrow;
void uninitPipeline(Pipeline pip) @trusted nothrow @nogc {
    sg_uninit_pipeline(pip);
}
extern(C) void sg_uninit_pass(Pass) @system @nogc nothrow;
void uninitPass(Pass pass) @trusted nothrow @nogc {
    sg_uninit_pass(pass);
}
extern(C) void sg_fail_buffer(Buffer) @system @nogc nothrow;
void failBuffer(Buffer buf) @trusted nothrow @nogc {
    sg_fail_buffer(buf);
}
extern(C) void sg_fail_image(Image) @system @nogc nothrow;
void failImage(Image img) @trusted nothrow @nogc {
    sg_fail_image(img);
}
extern(C) void sg_fail_sampler(Sampler) @system @nogc nothrow;
void failSampler(Sampler smp) @trusted nothrow @nogc {
    sg_fail_sampler(smp);
}
extern(C) void sg_fail_shader(Shader) @system @nogc nothrow;
void failShader(Shader shd) @trusted nothrow @nogc {
    sg_fail_shader(shd);
}
extern(C) void sg_fail_pipeline(Pipeline) @system @nogc nothrow;
void failPipeline(Pipeline pip) @trusted nothrow @nogc {
    sg_fail_pipeline(pip);
}
extern(C) void sg_fail_pass(Pass) @system @nogc nothrow;
void failPass(Pass pass) @trusted nothrow @nogc {
    sg_fail_pass(pass);
}
extern(C) void sg_enable_frame_stats() @system @nogc nothrow;
void enableFrameStats() @trusted nothrow @nogc {
    sg_enable_frame_stats();
}
extern(C) void sg_disable_frame_stats() @system @nogc nothrow;
void disableFrameStats() @trusted nothrow @nogc {
    sg_disable_frame_stats();
}
extern(C) bool sg_frame_stats_enabled() @system @nogc nothrow;
bool frameStatsEnabled() @trusted nothrow @nogc {
    return sg_frame_stats_enabled();
}
extern(C) FrameStats sg_query_frame_stats() @system @nogc nothrow;
FrameStats queryFrameStats() @trusted nothrow @nogc {
    return sg_query_frame_stats();
}
extern(C) Context sg_setup_context() @system @nogc nothrow;
Context setupContext() @trusted nothrow @nogc {
    return sg_setup_context();
}
extern(C) void sg_activate_context(Context) @system @nogc nothrow;
void activateContext(Context ctx_id) @trusted nothrow @nogc {
    sg_activate_context(ctx_id);
}
extern(C) void sg_discard_context(Context) @system @nogc nothrow;
void discardContext(Context ctx_id) @trusted nothrow @nogc {
    sg_discard_context(ctx_id);
}
extern(C)
struct D3d11BufferInfo {
    const(void)* buf;
}
extern(C)
struct D3d11ImageInfo {
    const(void)* tex2d;
    const(void)* tex3d;
    const(void)* res;
    const(void)* srv;
}
extern(C)
struct D3d11SamplerInfo {
    const(void)* smp;
}
extern(C)
struct D3d11ShaderInfo {
    const(void)*[4] vs_cbufs;
    const(void)*[4] fs_cbufs;
    const(void)* vs;
    const(void)* fs;
}
extern(C)
struct D3d11PipelineInfo {
    const(void)* il;
    const(void)* rs;
    const(void)* dss;
    const(void)* bs;
}
extern(C)
struct D3d11PassInfo {
    const(void)*[4] color_rtv;
    const(void)*[4] resolve_rtv;
    const(void)* dsv;
}
extern(C)
struct MtlBufferInfo {
    const(void)*[2] buf;
    int active_slot;
}
extern(C)
struct MtlImageInfo {
    const(void)*[2] tex;
    int active_slot;
}
extern(C)
struct MtlSamplerInfo {
    const(void)* smp;
}
extern(C)
struct MtlShaderInfo {
    const(void)* vs_lib;
    const(void)* fs_lib;
    const(void)* vs_func;
    const(void)* fs_func;
}
extern(C)
struct MtlPipelineInfo {
    const(void)* rps;
    const(void)* dss;
}
extern(C)
struct WgpuBufferInfo {
    const(void)* buf;
}
extern(C)
struct WgpuImageInfo {
    const(void)* tex;
    const(void)* view;
}
extern(C)
struct WgpuSamplerInfo {
    const(void)* smp;
}
extern(C)
struct WgpuShaderInfo {
    const(void)* vs_mod;
    const(void)* fs_mod;
    const(void)* bgl;
}
extern(C)
struct WgpuPipelineInfo {
    const(void)* pip;
}
extern(C)
struct WgpuPassInfo {
    const(void)*[4] color_view;
    const(void)*[4] resolve_view;
    const(void)* ds_view;
}
extern(C)
struct GlBufferInfo {
    uint[2] buf;
    int active_slot;
}
extern(C)
struct GlImageInfo {
    uint[2] tex;
    uint tex_target;
    uint msaa_render_buffer;
    int active_slot;
}
extern(C)
struct GlSamplerInfo {
    uint smp;
}
extern(C)
struct GlShaderInfo {
    uint prog;
}
extern(C)
struct GlPassInfo {
    uint frame_buffer;
    uint[4] msaa_resolve_framebuffer;
}
extern(C) scope const(void)* sg_d3d11_device() @system @nogc nothrow;
scope const(void)* d3d11Device() @trusted nothrow @nogc {
    return sg_d3d11_device();
}
extern(C) scope const(void)* sg_d3d11_device_context() @system @nogc nothrow;
scope const(void)* d3d11DeviceContext() @trusted nothrow @nogc {
    return sg_d3d11_device_context();
}
extern(C) D3d11BufferInfo sg_d3d11_query_buffer_info(Buffer) @system @nogc nothrow;
D3d11BufferInfo d3d11QueryBufferInfo(Buffer buf) @trusted nothrow @nogc {
    return sg_d3d11_query_buffer_info(buf);
}
extern(C) D3d11ImageInfo sg_d3d11_query_image_info(Image) @system @nogc nothrow;
D3d11ImageInfo d3d11QueryImageInfo(Image img) @trusted nothrow @nogc {
    return sg_d3d11_query_image_info(img);
}
extern(C) D3d11SamplerInfo sg_d3d11_query_sampler_info(Sampler) @system @nogc nothrow;
D3d11SamplerInfo d3d11QuerySamplerInfo(Sampler smp) @trusted nothrow @nogc {
    return sg_d3d11_query_sampler_info(smp);
}
extern(C) D3d11ShaderInfo sg_d3d11_query_shader_info(Shader) @system @nogc nothrow;
D3d11ShaderInfo d3d11QueryShaderInfo(Shader shd) @trusted nothrow @nogc {
    return sg_d3d11_query_shader_info(shd);
}
extern(C) D3d11PipelineInfo sg_d3d11_query_pipeline_info(Pipeline) @system @nogc nothrow;
D3d11PipelineInfo d3d11QueryPipelineInfo(Pipeline pip) @trusted nothrow @nogc {
    return sg_d3d11_query_pipeline_info(pip);
}
extern(C) D3d11PassInfo sg_d3d11_query_pass_info(Pass) @system @nogc nothrow;
D3d11PassInfo d3d11QueryPassInfo(Pass pass) @trusted nothrow @nogc {
    return sg_d3d11_query_pass_info(pass);
}
extern(C) scope const(void)* sg_mtl_device() @system @nogc nothrow;
scope const(void)* mtlDevice() @trusted nothrow @nogc {
    return sg_mtl_device();
}
extern(C) scope const(void)* sg_mtl_render_command_encoder() @system @nogc nothrow;
scope const(void)* mtlRenderCommandEncoder() @trusted nothrow @nogc {
    return sg_mtl_render_command_encoder();
}
extern(C) MtlBufferInfo sg_mtl_query_buffer_info(Buffer) @system @nogc nothrow;
MtlBufferInfo mtlQueryBufferInfo(Buffer buf) @trusted nothrow @nogc {
    return sg_mtl_query_buffer_info(buf);
}
extern(C) MtlImageInfo sg_mtl_query_image_info(Image) @system @nogc nothrow;
MtlImageInfo mtlQueryImageInfo(Image img) @trusted nothrow @nogc {
    return sg_mtl_query_image_info(img);
}
extern(C) MtlSamplerInfo sg_mtl_query_sampler_info(Sampler) @system @nogc nothrow;
MtlSamplerInfo mtlQuerySamplerInfo(Sampler smp) @trusted nothrow @nogc {
    return sg_mtl_query_sampler_info(smp);
}
extern(C) MtlShaderInfo sg_mtl_query_shader_info(Shader) @system @nogc nothrow;
MtlShaderInfo mtlQueryShaderInfo(Shader shd) @trusted nothrow @nogc {
    return sg_mtl_query_shader_info(shd);
}
extern(C) MtlPipelineInfo sg_mtl_query_pipeline_info(Pipeline) @system @nogc nothrow;
MtlPipelineInfo mtlQueryPipelineInfo(Pipeline pip) @trusted nothrow @nogc {
    return sg_mtl_query_pipeline_info(pip);
}
extern(C) scope const(void)* sg_wgpu_device() @system @nogc nothrow;
scope const(void)* wgpuDevice() @trusted nothrow @nogc {
    return sg_wgpu_device();
}
extern(C) scope const(void)* sg_wgpu_queue() @system @nogc nothrow;
scope const(void)* wgpuQueue() @trusted nothrow @nogc {
    return sg_wgpu_queue();
}
extern(C) scope const(void)* sg_wgpu_command_encoder() @system @nogc nothrow;
scope const(void)* wgpuCommandEncoder() @trusted nothrow @nogc {
    return sg_wgpu_command_encoder();
}
extern(C) scope const(void)* sg_wgpu_render_pass_encoder() @system @nogc nothrow;
scope const(void)* wgpuRenderPassEncoder() @trusted nothrow @nogc {
    return sg_wgpu_render_pass_encoder();
}
extern(C) WgpuBufferInfo sg_wgpu_query_buffer_info(Buffer) @system @nogc nothrow;
WgpuBufferInfo wgpuQueryBufferInfo(Buffer buf) @trusted nothrow @nogc {
    return sg_wgpu_query_buffer_info(buf);
}
extern(C) WgpuImageInfo sg_wgpu_query_image_info(Image) @system @nogc nothrow;
WgpuImageInfo wgpuQueryImageInfo(Image img) @trusted nothrow @nogc {
    return sg_wgpu_query_image_info(img);
}
extern(C) WgpuSamplerInfo sg_wgpu_query_sampler_info(Sampler) @system @nogc nothrow;
WgpuSamplerInfo wgpuQuerySamplerInfo(Sampler smp) @trusted nothrow @nogc {
    return sg_wgpu_query_sampler_info(smp);
}
extern(C) WgpuShaderInfo sg_wgpu_query_shader_info(Shader) @system @nogc nothrow;
WgpuShaderInfo wgpuQueryShaderInfo(Shader shd) @trusted nothrow @nogc {
    return sg_wgpu_query_shader_info(shd);
}
extern(C) WgpuPipelineInfo sg_wgpu_query_pipeline_info(Pipeline) @system @nogc nothrow;
WgpuPipelineInfo wgpuQueryPipelineInfo(Pipeline pip) @trusted nothrow @nogc {
    return sg_wgpu_query_pipeline_info(pip);
}
extern(C) WgpuPassInfo sg_wgpu_query_pass_info(Pass) @system @nogc nothrow;
WgpuPassInfo wgpuQueryPassInfo(Pass pass) @trusted nothrow @nogc {
    return sg_wgpu_query_pass_info(pass);
}
extern(C) GlBufferInfo sg_gl_query_buffer_info(Buffer) @system @nogc nothrow;
GlBufferInfo glQueryBufferInfo(Buffer buf) @trusted nothrow @nogc {
    return sg_gl_query_buffer_info(buf);
}
extern(C) GlImageInfo sg_gl_query_image_info(Image) @system @nogc nothrow;
GlImageInfo glQueryImageInfo(Image img) @trusted nothrow @nogc {
    return sg_gl_query_image_info(img);
}
extern(C) GlSamplerInfo sg_gl_query_sampler_info(Sampler) @system @nogc nothrow;
GlSamplerInfo glQuerySamplerInfo(Sampler smp) @trusted nothrow @nogc {
    return sg_gl_query_sampler_info(smp);
}
extern(C) GlShaderInfo sg_gl_query_shader_info(Shader) @system @nogc nothrow;
GlShaderInfo glQueryShaderInfo(Shader shd) @trusted nothrow @nogc {
    return sg_gl_query_shader_info(shd);
}
extern(C) GlPassInfo sg_gl_query_pass_info(Pass) @system @nogc nothrow;
GlPassInfo glQueryPassInfo(Pass pass) @trusted nothrow @nogc {
    return sg_gl_query_pass_info(pass);
}
