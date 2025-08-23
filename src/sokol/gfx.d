/++
+ Machine generated D bindings for Sokol library.
+ 
+     Generated on: 2025-08-23 15:53:09
+ 
+     Source header: sokol_gfx.h
+     Module: sokol.gfx
+ 
+     Do not edit manually; regenerate using gen_d.py.
+/
module sokol.gfx;

/++
+ Resource id typedefs:
+ 
+     sg_buffer:      vertex- and index-buffers
+     sg_image:       images used as textures and render-pass attachments
+     sg_sampler      sampler objects describing how a texture is sampled in a shader
+     sg_shader:      vertex- and fragment-shaders and shader interface information
+     sg_pipeline:    associated shader and vertex-layouts, and render states
+     sg_view:        a resource view object used for bindings and render-pass attachments
+ 
+     Instead of pointers, resource creation functions return a 32-bit
+     handle which uniquely identifies the resource object.
+ 
+     The 32-bit resource id is split into a 16-bit pool index in the lower bits,
+     and a 16-bit 'generation counter' in the upper bits. The index allows fast
+     pool lookups, and combined with the generation-counter it allows to detect
+     'dangling accesses' (trying to use an object which no longer exists, and
+     its pool slot has been reused for a new object)
+ 
+     The resource ids are wrapped into a strongly-typed struct so that
+     trying to pass an incompatible resource id is a compile error.
+/
extern(C) struct Buffer {
    uint id = 0;
}
extern(C) struct Image {
    uint id = 0;
}
extern(C) struct Sampler {
    uint id = 0;
}
extern(C) struct Shader {
    uint id = 0;
}
extern(C) struct Pipeline {
    uint id = 0;
}
extern(C) struct View {
    uint id = 0;
}
/++
+ sg_range is a pointer-size-pair struct used to pass memory blobs into
+     sokol-gfx. When initialized from a value type (array or struct), you can
+     use the SG_RANGE() macro to build an sg_range struct. For functions which
+     take either a sg_range pointer, or a (C++) sg_range reference, use the
+     SG_RANGE_REF macro as a solution which compiles both in C and C++.
+/
extern(C) struct Range {
    const(void)* ptr = null;
    size_t size = 0;
}
/++
+ various compile-time constants in the public API
+/
enum invalid_id = 0;
enum num_inflight_frames = 2;
enum max_color_attachments = 4;
enum max_uniformblock_members = 16;
enum max_vertex_attributes = 16;
enum max_mipmaps = 16;
enum max_texturearray_layers = 128;
enum max_vertexbuffer_bindslots = 8;
enum max_uniformblock_bindslots = 8;
enum max_view_bindslots = 28;
enum max_sampler_bindslots = 16;
enum max_texture_sampler_pairs = 16;
/++
+ sg_color
+ 
+     An RGBA color value.
+/
extern(C) struct Color {
    float r = 0.0f;
    float g = 0.0f;
    float b = 0.0f;
    float a = 0.0f;
}
/++
+ sg_backend
+ 
+     The active 3D-API backend, use the function sg_query_backend()
+     to get the currently active backend.
+/
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
/++
+ sg_pixel_format
+ 
+     sokol_gfx.h basically uses the same pixel formats as WebGPU, since these
+     are supported on most newer GPUs.
+ 
+     A pixelformat name consist of three parts:
+ 
+         - components (R, RG, RGB or RGBA)
+         - bit width per component (8, 16 or 32)
+         - component data type:
+             - unsigned normalized (no postfix)
+             - signed normalized (SN postfix)
+             - unsigned integer (UI postfix)
+             - signed integer (SI postfix)
+             - float (F postfix)
+ 
+     Not all pixel formats can be used for everything, call sg_query_pixelformat()
+     to inspect the capabilities of a given pixelformat. The function returns
+     an sg_pixelformat_info struct with the following members:
+ 
+         - sample: the pixelformat can be sampled as texture at least with
+                   nearest filtering
+         - filter: the pixelformat can be sampled as texture with linear
+                   filtering
+         - render: the pixelformat can be used as render-pass attachment
+         - blend:  blending is supported when used as render-pass attachment
+         - msaa:   multisample-antialiasing is supported when used
+                   as render-pass attachment
+         - depth:  the pixelformat can be used for depth-stencil attachments
+         - compressed: this is a block-compressed format
+         - bytes_per_pixel: the numbers of bytes in a pixel (0 for compressed formats)
+ 
+     The default pixel format for texture images is SG_PIXELFORMAT_RGBA8.
+ 
+     The default pixel format for render target images is platform-dependent
+     and taken from the sg_environment struct passed into sg_setup(). Typically
+     the default formats are:
+ 
+         - for the Metal, D3D11 and WebGPU backends: SG_PIXELFORMAT_BGRA8
+         - for GL backends: SG_PIXELFORMAT_RGBA8
+/
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
/++
+ Runtime information about a pixel format, returned by sg_query_pixelformat().
+/
extern(C) struct PixelformatInfo {
    bool sample = false;
    bool filter = false;
    bool render = false;
    bool blend = false;
    bool msaa = false;
    bool depth = false;
    bool compressed = false;
    bool read = false;
    bool write = false;
    int bytes_per_pixel = 0;
}
/++
+ Runtime information about available optional features, returned by sg_query_features()
+/
extern(C) struct Features {
    bool origin_top_left = false;
    bool image_clamp_to_border = false;
    bool mrt_independent_blend_state = false;
    bool mrt_independent_write_mask = false;
    bool compute = false;
    bool msaa_texture_bindings = false;
    bool separate_buffer_types = false;
    bool gl_texture_views = false;
}
/++
+ Runtime information about resource limits, returned by sg_query_limit()
+/
extern(C) struct Limits {
    int max_image_size_2d = 0;
    int max_image_size_cube = 0;
    int max_image_size_3d = 0;
    int max_image_size_array = 0;
    int max_image_array_layers = 0;
    int max_vertex_attrs = 0;
    int gl_max_vertex_uniform_components = 0;
    int gl_max_combined_texture_image_units = 0;
}
/++
+ sg_resource_state
+ 
+     The current state of a resource in its resource pool.
+     Resources start in the INITIAL state, which means the
+     pool slot is unoccupied and can be allocated. When a resource is
+     created, first an id is allocated, and the resource pool slot
+     is set to state ALLOC. After allocation, the resource is
+     initialized, which may result in the VALID or FAILED state. The
+     reason why allocation and initialization are separate is because
+     some resource types (e.g. buffers and images) might be asynchronously
+     initialized by the user application. If a resource which is not
+     in the VALID state is attempted to be used for rendering, rendering
+     operations will silently be dropped.
+ 
+     The special INVALID state is returned in sg_query_xxx_state() if no
+     resource object exists for the provided resource id.
+/
enum ResourceState {
    Initial,
    Alloc,
    Valid,
    Failed,
    Invalid,
}
/++
+ sg_index_type
+ 
+     Indicates whether indexed rendering (fetching vertex-indices from an
+     index buffer) is used, and if yes, the index data type (16- or 32-bits).
+ 
+     This is used in the sg_pipeline_desc.index_type member when creating a
+     pipeline object.
+ 
+     The default index type is SG_INDEXTYPE_NONE.
+/
enum IndexType {
    Default,
    None,
    Uint16,
    Uint32,
    Num,
}
/++
+ sg_image_type
+ 
+     Indicates the basic type of an image object (2D-texture, cubemap,
+     3D-texture or 2D-array-texture). Used in the sg_image_desc.type member when
+     creating an image, and in sg_shader_image_desc to describe a sampled texture
+     in the shader (both must match and will be checked in the validation layer
+     when calling sg_apply_bindings).
+ 
+     The default image type when creating an image is SG_IMAGETYPE_2D.
+/
enum ImageType {
    Default,
    _2d,
    Cube,
    _3d,
    Array,
    Num,
}
/++
+ sg_image_sample_type
+ 
+     The basic data type of a texture sample as expected by a shader.
+     Must be provided in sg_shader_image and used by the validation
+     layer in sg_apply_bindings() to check if the provided image object
+     is compatible with what the shader expects. Apart from the sokol-gfx
+     validation layer, WebGPU is the only backend API which actually requires
+     matching texture and sampler type to be provided upfront for validation
+     (other 3D APIs treat texture/sampler type mismatches as undefined behaviour).
+ 
+     NOTE that the following texture pixel formats require the use
+     of SG_IMAGESAMPLETYPE_UNFILTERABLE_FLOAT, combined with a sampler
+     of type SG_SAMPLERTYPE_NONFILTERING:
+ 
+     - SG_PIXELFORMAT_R32F
+     - SG_PIXELFORMAT_RG32F
+     - SG_PIXELFORMAT_RGBA32F
+ 
+     (when using sokol-shdc, also check out the meta tags `@image_sample_type`
+     and `@sampler_type`)
+/
enum ImageSampleType {
    Default,
    Float,
    Depth,
    Sint,
    Uint,
    Unfilterable_float,
    Num,
}
/++
+ sg_sampler_type
+ 
+     The basic type of a texture sampler (sampling vs comparison) as
+     defined in a shader. Must be provided in sg_shader_sampler_desc.
+ 
+     sg_image_sample_type and sg_sampler_type for a texture/sampler
+     pair must be compatible with each other, specifically only
+     the following pairs are allowed:
+ 
+     - SG_IMAGESAMPLETYPE_FLOAT => (SG_SAMPLERTYPE_FILTERING or SG_SAMPLERTYPE_NONFILTERING)
+     - SG_IMAGESAMPLETYPE_UNFILTERABLE_FLOAT => SG_SAMPLERTYPE_NONFILTERING
+     - SG_IMAGESAMPLETYPE_SINT => SG_SAMPLERTYPE_NONFILTERING
+     - SG_IMAGESAMPLETYPE_UINT => SG_SAMPLERTYPE_NONFILTERING
+     - SG_IMAGESAMPLETYPE_DEPTH => SG_SAMPLERTYPE_COMPARISON
+/
enum SamplerType {
    Default,
    Filtering,
    Nonfiltering,
    Comparison,
    Num,
}
/++
+ sg_cube_face
+ 
+     The cubemap faces. Use these as indices in the sg_image_desc.content
+     array.
+/
enum CubeFace {
    Pos_x,
    Neg_x,
    Pos_y,
    Neg_y,
    Pos_z,
    Neg_z,
    Num,
}
/++
+ sg_primitive_type
+ 
+     This is the common subset of 3D primitive types supported across all 3D
+     APIs. This is used in the sg_pipeline_desc.primitive_type member when
+     creating a pipeline object.
+ 
+     The default primitive type is SG_PRIMITIVETYPE_TRIANGLES.
+/
enum PrimitiveType {
    Default,
    Points,
    Lines,
    Line_strip,
    Triangles,
    Triangle_strip,
    Num,
}
/++
+ sg_filter
+ 
+     The filtering mode when sampling a texture image. This is
+     used in the sg_sampler_desc.min_filter, sg_sampler_desc.mag_filter
+     and sg_sampler_desc.mipmap_filter members when creating a sampler object.
+ 
+     For the default is SG_FILTER_NEAREST.
+/
enum Filter {
    Default,
    Nearest,
    Linear,
    Num,
}
/++
+ sg_wrap
+ 
+     The texture coordinates wrapping mode when sampling a texture
+     image. This is used in the sg_image_desc.wrap_u, .wrap_v
+     and .wrap_w members when creating an image.
+ 
+     The default wrap mode is SG_WRAP_REPEAT.
+ 
+     NOTE: SG_WRAP_CLAMP_TO_BORDER is not supported on all backends
+     and platforms. To check for support, call sg_query_features()
+     and check the "clamp_to_border" boolean in the returned
+     sg_features struct.
+ 
+     Platforms which don't support SG_WRAP_CLAMP_TO_BORDER will silently fall back
+     to SG_WRAP_CLAMP_TO_EDGE without a validation error.
+/
enum Wrap {
    Default,
    Repeat,
    Clamp_to_edge,
    Clamp_to_border,
    Mirrored_repeat,
    Num,
}
/++
+ sg_border_color
+ 
+     The border color to use when sampling a texture, and the UV wrap
+     mode is SG_WRAP_CLAMP_TO_BORDER.
+ 
+     The default border color is SG_BORDERCOLOR_OPAQUE_BLACK
+/
enum BorderColor {
    Default,
    Transparent_black,
    Opaque_black,
    Opaque_white,
    Num,
}
/++
+ sg_vertex_format
+ 
+     The data type of a vertex component. This is used to describe
+     the layout of input vertex data when creating a pipeline object.
+ 
+     NOTE that specific mapping rules exist from the CPU-side vertex
+     formats to the vertex attribute base type in the vertex shader code
+     (see doc header section 'ON VERTEX FORMATS').
+/
enum VertexFormat {
    Invalid,
    Float,
    Float2,
    Float3,
    Float4,
    Int,
    Int2,
    Int3,
    Int4,
    Uint,
    Uint2,
    Uint3,
    Uint4,
    Byte4,
    Byte4n,
    Ubyte4,
    Ubyte4n,
    Short2,
    Short2n,
    Ushort2,
    Ushort2n,
    Short4,
    Short4n,
    Ushort4,
    Ushort4n,
    Uint10_n2,
    Half2,
    Half4,
    Num,
}
/++
+ sg_vertex_step
+ 
+     Defines whether the input pointer of a vertex input stream is advanced
+     'per vertex' or 'per instance'. The default step-func is
+     SG_VERTEXSTEP_PER_VERTEX. SG_VERTEXSTEP_PER_INSTANCE is used with
+     instanced-rendering.
+ 
+     The vertex-step is part of the vertex-layout definition
+     when creating pipeline objects.
+/
enum VertexStep {
    Default,
    Per_vertex,
    Per_instance,
    Num,
}
/++
+ sg_uniform_type
+ 
+     The data type of a uniform block member. This is used to
+     describe the internal layout of uniform blocks when creating
+     a shader object. This is only required for the GL backend, all
+     other backends will ignore the interior layout of uniform blocks.
+/
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
/++
+ sg_uniform_layout
+ 
+     A hint for the interior memory layout of uniform blocks. This is
+     only relevant for the GL backend where the internal layout
+     of uniform blocks must be known to sokol-gfx. For all other backends the
+     internal memory layout of uniform blocks doesn't matter, sokol-gfx
+     will just pass uniform data as an opaque memory blob to the
+     3D backend.
+ 
+     SG_UNIFORMLAYOUT_NATIVE (default)
+         Native layout means that a 'backend-native' memory layout
+         is used. For the GL backend this means that uniforms
+         are packed tightly in memory (e.g. there are no padding
+         bytes).
+ 
+     SG_UNIFORMLAYOUT_STD140
+         The memory layout is a subset of std140. Arrays are only
+         allowed for the FLOAT4, INT4 and MAT4. Alignment is as
+         is as follows:
+ 
+             FLOAT, INT:         4 byte alignment
+             FLOAT2, INT2:       8 byte alignment
+             FLOAT3, INT3:       16 byte alignment(!)
+             FLOAT4, INT4:       16 byte alignment
+             MAT4:               16 byte alignment
+             FLOAT4[], INT4[]:   16 byte alignment
+ 
+         The overall size of the uniform block must be a multiple
+         of 16.
+ 
+     For more information search for 'UNIFORM DATA LAYOUT' in the documentation block
+     at the start of the header.
+/
enum UniformLayout {
    Default,
    Native,
    Std140,
    Num,
}
/++
+ sg_cull_mode
+ 
+     The face-culling mode, this is used in the
+     sg_pipeline_desc.cull_mode member when creating a
+     pipeline object.
+ 
+     The default cull mode is SG_CULLMODE_NONE
+/
enum CullMode {
    Default,
    None,
    Front,
    Back,
    Num,
}
/++
+ sg_face_winding
+ 
+     The vertex-winding rule that determines a front-facing primitive. This
+     is used in the member sg_pipeline_desc.face_winding
+     when creating a pipeline object.
+ 
+     The default winding is SG_FACEWINDING_CW (clockwise)
+/
enum FaceWinding {
    Default,
    Ccw,
    Cw,
    Num,
}
/++
+ sg_compare_func
+ 
+     The compare-function for configuring depth- and stencil-ref tests
+     in pipeline objects, and for texture samplers which perform a comparison
+     instead of regular sampling operation.
+ 
+     Used in the following structs:
+ 
+     sg_pipeline_desc
+         .depth
+             .compare
+         .stencil
+             .front.compare
+             .back.compare
+ 
+     sg_sampler_desc
+         .compare
+ 
+     The default compare func for depth- and stencil-tests is
+     SG_COMPAREFUNC_ALWAYS.
+ 
+     The default compare func for samplers is SG_COMPAREFUNC_NEVER.
+/
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
/++
+ sg_stencil_op
+ 
+     The operation performed on a currently stored stencil-value when a
+     comparison test passes or fails. This is used when creating a pipeline
+     object in the following sg_pipeline_desc struct items:
+ 
+     sg_pipeline_desc
+         .stencil
+             .front
+                 .fail_op
+                 .depth_fail_op
+                 .pass_op
+             .back
+                 .fail_op
+                 .depth_fail_op
+                 .pass_op
+ 
+     The default value is SG_STENCILOP_KEEP.
+/
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
/++
+ sg_blend_factor
+ 
+     The source and destination factors in blending operations.
+     This is used in the following members when creating a pipeline object:
+ 
+     sg_pipeline_desc
+         .colors[i]
+             .blend
+                 .src_factor_rgb
+                 .dst_factor_rgb
+                 .src_factor_alpha
+                 .dst_factor_alpha
+ 
+     The default value is SG_BLENDFACTOR_ONE for source
+     factors, and for the destination SG_BLENDFACTOR_ZERO if the associated
+     blend-op is ADD, SUBTRACT or REVERSE_SUBTRACT or SG_BLENDFACTOR_ONE
+     if the associated blend-op is MIN or MAX.
+/
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
/++
+ sg_blend_op
+ 
+     Describes how the source and destination values are combined in the
+     fragment blending operation. It is used in the following struct items
+     when creating a pipeline object:
+ 
+     sg_pipeline_desc
+         .colors[i]
+             .blend
+                 .op_rgb
+                 .op_alpha
+ 
+     The default value is SG_BLENDOP_ADD.
+/
enum BlendOp {
    Default,
    Add,
    Subtract,
    Reverse_subtract,
    Min,
    Max,
    Num,
}
/++
+ sg_color_mask
+ 
+     Selects the active color channels when writing a fragment color to the
+     framebuffer. This is used in the members
+     sg_pipeline_desc.colors[i].write_mask when creating a pipeline object.
+ 
+     The default colormask is SG_COLORMASK_RGBA (write all colors channels)
+ 
+     NOTE: since the color mask value 0 is reserved for the default value
+     (SG_COLORMASK_RGBA), use SG_COLORMASK_NONE if all color channels
+     should be disabled.
+/
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
/++
+ sg_load_action
+ 
+     Defines the load action that should be performed at the start of a render pass:
+ 
+     SG_LOADACTION_CLEAR:        clear the render target
+     SG_LOADACTION_LOAD:         load the previous content of the render target
+     SG_LOADACTION_DONTCARE:     leave the render target in an undefined state
+ 
+     This is used in the sg_pass_action structure.
+ 
+     The default load action for all pass attachments is SG_LOADACTION_CLEAR,
+     with the values rgba = { 0.5f, 0.5f, 0.5f, 1.0f }, depth=1.0f and stencil=0.
+ 
+     If you want to override the default behaviour, it is important to not
+     only set the clear color, but the 'action' field as well (as long as this
+     is _SG_LOADACTION_DEFAULT, the value fields will be ignored).
+/
enum LoadAction {
    Default,
    Clear,
    Load,
    Dontcare,
}
/++
+ sg_store_action
+ 
+     Defines the store action that should be performed at the end of a render pass:
+ 
+     SG_STOREACTION_STORE:       store the rendered content to the color attachment image
+     SG_STOREACTION_DONTCARE:    allows the GPU to discard the rendered content
+/
enum StoreAction {
    Default,
    Store,
    Dontcare,
}
/++
+ sg_pass_action
+ 
+     The sg_pass_action struct defines the actions to be performed
+     at the start and end of a render pass.
+ 
+     - at the start of the pass: whether the render attachments should be cleared,
+       loaded with their previous content, or start in an undefined state
+     - for clear operations: the clear value (color, depth, or stencil values)
+     - at the end of the pass: whether the rendering result should be
+       stored back into the render attachment or discarded
+/
extern(C) struct ColorAttachmentAction {
    LoadAction load_action = LoadAction.Default;
    StoreAction store_action = StoreAction.Default;
    Color clear_value = {};
}
extern(C) struct DepthAttachmentAction {
    LoadAction load_action = LoadAction.Default;
    StoreAction store_action = StoreAction.Default;
    float clear_value = 0.0f;
}
extern(C) struct StencilAttachmentAction {
    LoadAction load_action = LoadAction.Default;
    StoreAction store_action = StoreAction.Default;
    ubyte clear_value = 0;
}
extern(C) struct PassAction {
    ColorAttachmentAction[4] colors = [];
    DepthAttachmentAction depth = {};
    StencilAttachmentAction stencil = {};
}
/++
+ sg_swapchain
+ 
+     Used in sg_begin_pass() to provide details about an external swapchain
+     (pixel formats, sample count and backend-API specific render surface objects).
+ 
+     The following information must be provided:
+ 
+     - the width and height of the swapchain surfaces in number of pixels,
+     - the pixel format of the render- and optional msaa-resolve-surface
+     - the pixel format of the optional depth- or depth-stencil-surface
+     - the MSAA sample count for the render and depth-stencil surface
+ 
+     If the pixel formats and MSAA sample counts are left zero-initialized,
+     their defaults are taken from the sg_environment struct provided in the
+     sg_setup() call.
+ 
+     The width and height *must* be > 0.
+ 
+     Additionally the following backend API specific objects must be passed in
+     as 'type erased' void pointers:
+ 
+     GL:
+         - on all GL backends, a GL framebuffer object must be provided. This
+           can be zero for the default framebuffer.
+ 
+     D3D11:
+         - an ID3D11RenderTargetView for the rendering surface, without
+           MSAA rendering this surface will also be displayed
+         - an optional ID3D11DepthStencilView for the depth- or depth/stencil
+           buffer surface
+         - when MSAA rendering is used, another ID3D11RenderTargetView
+           which serves as MSAA resolve target and will be displayed
+ 
+     WebGPU (same as D3D11, except different types)
+         - a WGPUTextureView for the rendering surface, without
+           MSAA rendering this surface will also be displayed
+         - an optional WGPUTextureView for the depth- or depth/stencil
+           buffer surface
+         - when MSAA rendering is used, another WGPUTextureView
+           which serves as MSAA resolve target and will be displayed
+ 
+     Metal (NOTE that the roles of provided surfaces is slightly different
+     than on D3D11 or WebGPU in case of MSAA vs non-MSAA rendering):
+ 
+         - A current CAMetalDrawable (NOT an MTLDrawable!) which will be presented.
+           This will either be rendered to directly (if no MSAA is used), or serve
+           as MSAA-resolve target.
+         - an optional MTLTexture for the depth- or depth-stencil buffer
+         - an optional multisampled MTLTexture which serves as intermediate
+           rendering surface which will then be resolved into the
+           CAMetalDrawable.
+ 
+     NOTE that for Metal you must use an ObjC __bridge cast to
+     properly tunnel the ObjC object id through a C void*, e.g.:
+ 
+         swapchain.metal.current_drawable = (__bridge const void*) [mtkView currentDrawable];
+ 
+     On all other backends you shouldn't need to mess with the reference count.
+ 
+     It's a good practice to write a helper function which returns an initialized
+     sg_swapchain structs, which can then be plugged directly into
+     sg_pass.swapchain. Look at the function sglue_swapchain() in the sokol_glue.h
+     as an example.
+/
extern(C) struct MetalSwapchain {
    const(void)* current_drawable = null;
    const(void)* depth_stencil_texture = null;
    const(void)* msaa_color_texture = null;
}
extern(C) struct D3d11Swapchain {
    const(void)* render_view = null;
    const(void)* resolve_view = null;
    const(void)* depth_stencil_view = null;
}
extern(C) struct WgpuSwapchain {
    const(void)* render_view = null;
    const(void)* resolve_view = null;
    const(void)* depth_stencil_view = null;
}
extern(C) struct GlSwapchain {
    uint framebuffer = 0;
}
extern(C) struct Swapchain {
    int width = 0;
    int height = 0;
    int sample_count = 0;
    PixelFormat color_format = PixelFormat.Default;
    PixelFormat depth_format = PixelFormat.Default;
    MetalSwapchain metal = {};
    D3d11Swapchain d3d11 = {};
    WgpuSwapchain wgpu = {};
    GlSwapchain gl = {};
}
/++
+ sg_attachments
+ 
+     Used in sg_pass to provide render pass attachment views. Each
+     type of pass attachment has it corresponding view type:
+ 
+     sg_attachments.colors[]:
+         populate with color-attachment views, e.g.:
+ 
+         sg_make_view(&(sg_view_desc){
+             .color_attachment = { ... },
+         });
+ 
+     sg_attachments.resolves[]:
+         populate with resolve-attachment views, e.g.:
+ 
+         sg_make_view(&(sg_view_desc){
+             .resolve_attachment = { ... },
+         });
+ 
+     sg_attachments.depth_stencil:
+         populate with depth-stencil-attachment views, e.g.:
+ 
+         sg_make_view(&(sg_view_desc){
+             .depth_stencil_attachment = { ... },
+         });
+/
extern(C) struct Attachments {
    View[4] colors = [];
    View[4] resolves = [];
    View depth_stencil = {};
}
/++
+ sg_pass
+ 
+     The sg_pass structure is passed as argument into the sg_begin_pass()
+     function.
+ 
+     For a swapchain render pass, provide an sg_pass_action and sg_swapchain
+     struct (for instance via the sglue_swapchain() helper function from
+     sokol_glue.h):
+ 
+         sg_begin_pass(&(sg_pass){
+             .action = { ... },
+             .swapchain = sglue_swapchain(),
+         });
+ 
+     For an offscreen render pass, provide an sg_pass_action struct with
+     attachment view objects:
+ 
+         sg_begin_pass(&(sg_pass){
+             .action = { ... },
+             .attachments = {
+                 .colors = { ... },
+                 .resolves = { ... },
+                 .depth_stencil = ...,
+             },
+         });
+ 
+     You can also omit the .action object to get default pass action behaviour
+     (clear to color=grey, depth=1 and stencil=0).
+ 
+     For a compute pass, just set the sg_pass.compute boolean to true:
+ 
+         sg_begin_pass(&(sg_pass){ .compute = true });
+/
extern(C) struct Pass {
    uint _start_canary = 0;
    bool compute = false;
    PassAction action = {};
    Attachments attachments = {};
    Swapchain swapchain = {};
    const(char)* label = null;
    uint _end_canary = 0;
}
/++
+ sg_bindings
+ 
+ 
+     The sg_bindings structure defines the resource bindings for
+     the next draw call.
+ 
+     To update the resource bindings, call sg_apply_bindings() with
+     a pointer to a populated sg_bindings struct. Note that
+     sg_apply_bindings() must be called after sg_apply_pipeline()
+     and that bindings are not preserved across sg_apply_pipeline()
+     calls, even when the new pipeline uses the same 'bindings layout'.
+ 
+     A resource binding struct contains:
+ 
+     - 1..N vertex buffers
+     - 1..N vertex buffer offsets
+     - 0..1 index buffer
+     - 0..1 index buffer offset
+     - 0..N resource views (texture-, storage-image, storage-buffer-views)
+     - 0..N samplers
+ 
+     Where 'N' is defined in the following constants:
+ 
+     - SG_MAX_VERTEXBUFFER_BINDSLOTS
+     - SG_MAX_VIEW_BINDSLOTS
+     - SG_MAX_SAMPLER_BINDSLOTS
+ 
+     Note that inside compute passes vertex- and index-buffer-bindings are
+     disallowed.
+ 
+     When using sokol-shdc for shader authoring, the `layout(binding=N)`
+     for texture-, storage-image- and storage-buffer-bindings directly
+     maps to the views-array index, for instance the following vertex-
+     and fragment-shader interface for sokol-shdc:
+ 
+         @vs vs
+         layout(binding=0) uniform vs_params { ... };
+         layout(binding=0) readonly buffer ssbo { ... };
+         layout(binding=1) uniform texture2D vs_tex;
+         layout(binding=0) uniform sampler vs_smp;
+         ...
+         @end
+ 
+         @fs fs
+         layout(binding=1) uniform fs_params { ... };
+         layout(binding=2) uniform texture2D fs_tex;
+         layout(binding=1) uniform sampler fs_smp;
+         ...
+         @end
+ 
+     ...would map to the following sg_bindings struct:
+ 
+         const sg_bindings bnd = {
+             .vertex_buffers[0] = ...,
+             .views[0] = ssbo_view,
+             .views[1] = vs_tex_view,
+             .views[2] = fs_tex_view,
+             .samplers[0] = vs_smp,
+             .samplers[1] = fs_smp,
+         };
+ 
+     ...alternatively you can use code-generated slot indices:
+ 
+         const sg_bindings bnd = {
+             .vertex_buffers[0] = ...,
+             .views[VIEW_ssbo] = ssbo_view,
+             .views[VIEW_vs_tex] = vs_tex_view,
+             .views[VIEW_fs_tex] = fs_tex_view,
+             .samplers[SMP_vs_smp] = vs_smp,
+             .samplers[SMP_fs_smp] = fs_smp,
+         };
+ 
+     Resource bindslots for a specific shader/pipeline may have gaps, and an
+     sg_bindings struct may have populated bind slots which are not used by a
+     specific shader. This allows to use the same sg_bindings struct across
+     different shader variants.
+ 
+     When not using sokol-shdc, the bindslot indices in the sg_bindings
+     struct need to match the per-binding reflection info slot indices
+     in the sg_shader_desc struct (for details about that see the
+     sg_shader_desc struct documentation).
+ 
+     The optional buffer offsets can be used to put different unrelated
+     chunks of vertex- and/or index-data into the same buffer objects.
+/
extern(C) struct Bindings {
    uint _start_canary = 0;
    Buffer[8] vertex_buffers = [];
    int[8] vertex_buffer_offsets = [0, 0, 0, 0, 0, 0, 0, 0];
    Buffer index_buffer = {};
    int index_buffer_offset = 0;
    View[28] views = [];
    Sampler[16] samplers = [];
    uint _end_canary = 0;
}
/++
+ sg_buffer_usage
+ 
+     Describes how a buffer object is going to be used:
+ 
+     .vertex_buffer (default: true)
+         the buffer will bound as vertex buffer via sg_bindings.vertex_buffers[]
+     .index_buffer (default: false)
+         the buffer will bound as index buffer via sg_bindings.index_buffer
+     .storage_buffer (default: false)
+         the buffer will bound as storage buffer via storage-buffer-view
+         in sg_bindings.views[]
+     .immutable (default: true)
+         the buffer content will never be updated from the CPU side (but
+         may be written to by a compute shader)
+     .dynamic_update (default: false)
+         the buffer content will be infrequently updated from the CPU side
+     .stream_upate (default: false)
+         the buffer content will be updated each frame from the CPU side
+/
extern(C) struct BufferUsage {
    bool vertex_buffer = false;
    bool index_buffer = false;
    bool storage_buffer = false;
    bool _immutable = false;
    bool dynamic_update = false;
    bool stream_update = false;
}
/++
+ sg_buffer_desc
+ 
+     Creation parameters for sg_buffer objects, used in the sg_make_buffer() call.
+ 
+     The default configuration is:
+ 
+     .size:      0       (*must* be >0 for buffers without data)
+     .usage              .vertex_buffer = true, .immutable = true
+     .data.ptr   0       (*must* be valid for immutable buffers without storage buffer usage)
+     .data.size  0       (*must* be > 0 for immutable buffers without storage buffer usage)
+     .label      0       (optional string label)
+ 
+     For immutable buffers which are initialized with initial data,
+     keep the .size item zero-initialized, and set the size together with the
+     pointer to the initial data in the .data item.
+ 
+     For immutable or mutable buffers without initial data, keep the .data item
+     zero-initialized, and set the buffer size in the .size item instead.
+ 
+     You can also set both size values, but currently both size values must
+     be identical (this may change in the future when the dynamic resource
+     management may become more flexible).
+ 
+     NOTE: Immutable buffers without storage-buffer-usage *must* be created
+     with initial content, this restriction doesn't apply to storage buffer usage,
+     because storage buffers may also get their initial content by running
+     a compute shader on them.
+ 
+     NOTE: Buffers without initial data will have undefined content, e.g.
+     do *not* expect the buffer to be zero-initialized!
+ 
+     ADVANCED TOPIC: Injecting native 3D-API buffers:
+ 
+     The following struct members allow to inject your own GL, Metal
+     or D3D11 buffers into sokol_gfx:
+ 
+     .gl_buffers[SG_NUM_INFLIGHT_FRAMES]
+     .mtl_buffers[SG_NUM_INFLIGHT_FRAMES]
+     .d3d11_buffer
+ 
+     You must still provide all other struct items except the .data item, and
+     these must match the creation parameters of the native buffers you provide.
+     For sg_buffer_desc.usage.immutable buffers, only provide a single native
+     3D-API buffer, otherwise you need to provide SG_NUM_INFLIGHT_FRAMES buffers
+     (only for GL and Metal, not D3D11). Providing multiple buffers for GL and
+     Metal is necessary because sokol_gfx will rotate through them when calling
+     sg_update_buffer() to prevent lock-stalls.
+ 
+     Note that it is expected that immutable injected buffer have already been
+     initialized with content, and the .content member must be 0!
+ 
+     Also you need to call sg_reset_state_cache() after calling native 3D-API
+     functions, and before calling any sokol_gfx function.
+/
extern(C) struct BufferDesc {
    uint _start_canary = 0;
    size_t size = 0;
    BufferUsage usage = {};
    Range data = {};
    const(char)* label = null;
    uint[2] gl_buffers = [0, 0];
    const(void)*[2] mtl_buffers = null;
    const(void)* d3d11_buffer = null;
    const(void)* wgpu_buffer = null;
    uint _end_canary = 0;
}
/++
+ sg_image_usage
+ 
+     Describes the intended usage of an image object:
+ 
+     .storage_image (default: false)
+         the image can be used as parent resource of a storage-image-view,
+         which allows compute shaders to write to the image in a compute
+         pass (for read-only access in compute shaders bind the image
+         via a texture view instead
+     .color_attachment (default: false)
+         the image can be used as parent resource of a color-attachment-view,
+         which is then passed into sg_begin_pass via sg_pass.attachments.colors[]
+         so that fragment shaders can render into the image
+     .resolve_attachment (default: false)
+         the image can be used as parent resource of a resolve-attachment-view,
+         which is then passed into sg_begin_pass via sg_pass.attachments.resolves[]
+         as target for an MSAA-resolve operation in sg_end_pass()
+     .depth_stencil_attachment (default: false)
+         the image can be used as parent resource of a depth-stencil-attachmnet-view
+         which is then passes into sg_begin_pass via sg_pass.attachments.depth_stencil
+         as depth-stencil-buffer
+     .immutable (default: true)
+         the image content cannot be updated from the CPU side
+         (but may be updated by the GPU in a render- or compute-pass)
+     .dynamic_update (default: false)
+         the image content is updated infrequently by the CPU
+     .stream_update (default: false)
+         the image content is updated each frame by the CPU via
+ 
+     Note that creating a texture view from the image to be used for
+     texture-sampling in vertex-, fragment- or compute-shaders
+     is always implicitly allowed.
+/
extern(C) struct ImageUsage {
    bool storage_image = false;
    bool color_attachment = false;
    bool resolve_attachment = false;
    bool depth_stencil_attachment = false;
    bool _immutable = false;
    bool dynamic_update = false;
    bool stream_update = false;
}
/++
+ sg_view_type
+ 
+     Allows to query the type of a view object via the function sg_query_view_type()
+/
enum ViewType {
    Invalid,
    Storagebuffer,
    Storageimage,
    Texture,
    Colorattachment,
    Resolveattachment,
    Depthstencilattachment,
}
/++
+ sg_image_data
+ 
+     Defines the content of an image through a 2D array of sg_range structs.
+     The first array dimension is the cubemap face, and the second array
+     dimension the mipmap level.
+/
extern(C) struct ImageData {
    Range[6][16] subimage = [];
}
/++
+ sg_image_desc
+ 
+     Creation parameters for sg_image objects, used in the sg_make_image() call.
+ 
+     The default configuration is:
+ 
+     .type               SG_IMAGETYPE_2D
+     .usage              .immutable = true
+     .width              0 (must be set to >0)
+     .height             0 (must be set to >0)
+     .num_slices         1 (3D textures: depth; array textures: number of layers)
+     .num_mipmaps        1
+     .pixel_format       SG_PIXELFORMAT_RGBA8 for textures, or sg_desc.environment.defaults.color_format for render targets
+     .sample_count       1 for textures, or sg_desc.environment.defaults.sample_count for render targets
+     .data               an sg_image_data struct to define the initial content
+     .label              0 (optional string label for trace hooks)
+ 
+     Q: Why is the default sample_count for render targets identical with the
+     "default sample count" from sg_desc.environment.defaults.sample_count?
+ 
+     A: So that it matches the default sample count in pipeline objects. Even
+     though it is a bit strange/confusing that offscreen render targets by default
+     get the same sample count as 'default swapchains', but it's better that
+     an offscreen render target created with default parameters matches
+     a pipeline object created with default parameters.
+ 
+     NOTE:
+ 
+     Regular images used as texture binding with usage.immutable must be fully
+     initialized by providing a valid .data member which points to initialization
+     data.
+ 
+     Images with usage.*_attachment or usage.storage_image must
+     *not* be created with initial content. Be aware that the initial
+     content of pass attachment and storage images is undefined
+     (not guaranteed to be zeroed).
+ 
+     ADVANCED TOPIC: Injecting native 3D-API textures:
+ 
+     The following struct members allow to inject your own GL, Metal or D3D11
+     textures into sokol_gfx:
+ 
+     .gl_textures[SG_NUM_INFLIGHT_FRAMES]
+     .mtl_textures[SG_NUM_INFLIGHT_FRAMES]
+     .d3d11_texture
+     .wgpu_texture
+ 
+     For GL, you can also specify the texture target or leave it empty to use
+     the default texture target for the image type (GL_TEXTURE_2D for
+     SG_IMAGETYPE_2D etc)
+ 
+     The same rules apply as for injecting native buffers (see sg_buffer_desc
+     documentation for more details).
+/
extern(C) struct ImageDesc {
    uint _start_canary = 0;
    ImageType type = ImageType.Default;
    ImageUsage usage = {};
    int width = 0;
    int height = 0;
    int num_slices = 0;
    int num_mipmaps = 0;
    PixelFormat pixel_format = PixelFormat.Default;
    int sample_count = 0;
    ImageData data = {};
    const(char)* label = null;
    uint[2] gl_textures = [0, 0];
    uint gl_texture_target = 0;
    const(void)*[2] mtl_textures = null;
    const(void)* d3d11_texture = null;
    const(void)* wgpu_texture = null;
    uint _end_canary = 0;
}
/++
+ sg_sampler_desc
+ 
+     Creation parameters for sg_sampler objects, used in the sg_make_sampler() call
+ 
+     .min_filter:        SG_FILTER_NEAREST
+     .mag_filter:        SG_FILTER_NEAREST
+     .mipmap_filter      SG_FILTER_NEAREST
+     .wrap_u:            SG_WRAP_REPEAT
+     .wrap_v:            SG_WRAP_REPEAT
+     .wrap_w:            SG_WRAP_REPEAT (only SG_IMAGETYPE_3D)
+     .min_lod            0.0f
+     .max_lod            FLT_MAX
+     .border_color       SG_BORDERCOLOR_OPAQUE_BLACK
+     .compare            SG_COMPAREFUNC_NEVER
+     .max_anisotropy     1 (must be 1..16)
+/
extern(C) struct SamplerDesc {
    uint _start_canary = 0;
    Filter min_filter = Filter.Default;
    Filter mag_filter = Filter.Default;
    Filter mipmap_filter = Filter.Default;
    Wrap wrap_u = Wrap.Default;
    Wrap wrap_v = Wrap.Default;
    Wrap wrap_w = Wrap.Default;
    float min_lod = 0.0f;
    float max_lod = 0.0f;
    BorderColor border_color = BorderColor.Default;
    CompareFunc compare = CompareFunc.Default;
    uint max_anisotropy = 0;
    const(char)* label = null;
    uint gl_sampler = 0;
    const(void)* mtl_sampler = null;
    const(void)* d3d11_sampler = null;
    const(void)* wgpu_sampler = null;
    uint _end_canary = 0;
}
/++
+ sg_shader_desc
+ 
+     Used as parameter of sg_make_shader() to create a shader object which
+     communicates shader source or bytecode and shader interface
+     reflection information to sokol-gfx.
+ 
+     If you use sokol-shdc you can ignore the following information since
+     the sg_shader_desc struct will be code-generated.
+ 
+     Otherwise you need to provide the following information to the
+     sg_make_shader() call:
+ 
+     - a vertex- and fragment-shader function:
+         - the shader source or bytecode
+         - an optional entry point name
+         - for D3D11: an optional compile target when source code is provided
+           (the defaults are "vs_4_0" and "ps_4_0")
+ 
+     - ...or alternatively, a compute function:
+         - the shader source or bytecode
+         - an optional entry point name
+         - for D3D11: an optional compile target when source code is provided
+           (the default is "cs_5_0")
+ 
+     - vertex attributes required by some backends (not for compute shaders):
+         - the vertex attribute base type (undefined, float, signed int, unsigned int),
+           this information is only used in the validation layer to check that the
+           pipeline object vertex formats are compatible with the input vertex attribute
+           type used in the vertex shader. NOTE that the default base type
+           'undefined' skips the validation layer check.
+         - for the GL backend: optional vertex attribute names used for name lookup
+         - for the D3D11 backend: semantic names and indices
+ 
+     - only for compute shaders on the Metal backend:
+         - the workgroup size aka 'threads per thread-group'
+ 
+           In other 3D APIs this is declared in the shader code:
+             - GLSL: `layout(local_size_x=x, local_size_y=y, local_size_y=z) in;`
+             - HLSL: `[numthreads(x, y, z)]`
+             - WGSL: `@workgroup_size(x, y, z)`
+           ...but in Metal the workgroup size is declared on the CPU side
+ 
+     - reflection information for each uniform block binding used by the shader:
+         - the shader stage the uniform block appears in (SG_SHADERSTAGE_*)
+         - the size in bytes of the uniform block
+         - backend-specific bindslots:
+             - HLSL: the constant buffer register `register(b0..7)`
+             - MSL: the buffer attribute `[[buffer(0..7)]]`
+             - WGSL: the binding in `@group(0) @binding(0..15)`
+         - GLSL only: a description of the uniform block interior
+             - the memory layout standard (SG_UNIFORMLAYOUT_*)
+             - for each member in the uniform block:
+                 - the member type (SG_UNIFORM_*)
+                 - if the member is an array, the array count
+                 - the member name
+ 
+     - reflection information for each texture-, storage-buffer and
+       storage-image bindings by the shader, each with an associated
+       view type:
+         - texture bindings => texture views
+         - storage-buffer bindings => storage-buffer views
+         - storage-image bindings => storage-image views
+ 
+     - texture bindings must provide the following information:
+         - the shader stage the texture binding appears in (SG_SHADERSTAGE_*)
+         - the image type (SG_IMAGETYPE_*)
+         - the image-sample type (SG_IMAGESAMPLETYPE_*)
+         - whether the texture is multisampled
+         - backend specific bindslots:
+             - HLSL: the texture register `register(t0..23)`
+             - MSL: the texture attribute `[[texture(0..19)]]`
+             - WGSL: the binding in `@group(1) @binding(0..127)`
+ 
+     - storage-buffer bindings must provide the following information:
+         - the shader stage the storage buffer appears in (SG_SHADERSTAGE_*)
+         - whether the storage buffer is readonly
+         - backend specific bindslots:
+             - HLSL:
+                 - for readonly storage buffer bindings: `register(t0..23)`
+                 - for read/write storage buffer bindings: `register(u0..11)`
+             - MSL: the buffer attribute `[[buffer(8..15)]]`
+             - WGSL: the binding in `@group(1) @binding(0..127)`
+             - GL: the binding in `layout(binding=0..7)`
+ 
+     - storage-image bindings must provide the following information:
+         - the shader stage (*must* be SG_SHADERSTAGE_COMPUTE)
+         - whether the storage image is writeonly or readwrite (for readonly
+           access use a regular texture binding instead)
+         - the image type expected by the shader (SG_IMAGETYPE_*)
+         - the access pixel format expected by the shader (SG_PIXELFORMAT_*),
+           note that only a subset of pixel formats is allowed for storage image
+           bindings
+         - backend specific bindslots:
+             - HLSL: the UAV register `register(u0..11)`
+             - MSL: the texture attribute `[[texture(0..19)]]`
+             - WGSL: the binding in `@group(1) @binding(0..127)`
+             - GLSL: the binding in `layout(binding=0..3, [access_format])`
+ 
+     - reflection information for each sampler used by the shader:
+         - the shader stage the sampler appears in (SG_SHADERSTAGE_*)
+         - the sampler type (SG_SAMPLERTYPE_*)
+         - backend specific bindslots:
+             - HLSL: the sampler register `register(s0..15)`
+             - MSL: the sampler attribute `[[sampler(0..15)]]`
+             - WGSL: the binding in `@group(0) @binding(0..127)`
+ 
+     - reflection information for each texture-sampler pair used by
+       the shader:
+         - the shader stage (SG_SHADERSTAGE_*)
+         - the texture's array index in the sg_shader_desc.views[] array
+         - the sampler's array index in the sg_shader_desc.samplers[] array
+         - GLSL only: the name of the combined image-sampler object
+ 
+     The number and order of items in the sg_shader_desc.attrs[]
+     array corresponds to the items in sg_pipeline_desc.layout.attrs.
+ 
+         - sg_shader_desc.attrs[N] => sg_pipeline_desc.layout.attrs[N]
+ 
+     NOTE that vertex attribute indices currently cannot have gaps.
+ 
+     The items index in the sg_shader_desc.uniform_blocks[] array corresponds
+     to the ub_slot arg in sg_apply_uniforms():
+ 
+         - sg_shader_desc.uniform_blocks[N] => sg_apply_uniforms(N, ...)
+ 
+     The items in the sg_shader_desc.views[] array directly map to
+     the views in the sg_bindings.views[] array!
+ 
+     For all GL backends, shader source-code must be provided. For D3D11 and Metal,
+     either shader source-code or byte-code can be provided.
+ 
+     NOTE that the uniform-block, view and sampler arrays may have gaps. This
+     allows to use the same sg_bindings struct for different but related
+     shader variations.
+ 
+     For D3D11, if source code is provided, the d3dcompiler_47.dll will be loaded
+     on demand. If this fails, shader creation will fail. When compiling HLSL
+     source code, you can provide an optional target string via
+     sg_shader_stage_desc.d3d11_target, the default target is "vs_4_0" for the
+     vertex shader stage and "ps_4_0" for the pixel shader stage.
+     You may optionally provide the file path to enable the default #include handler
+     behavior when compiling source code.
+/
enum ShaderStage {
    None,
    Vertex,
    Fragment,
    Compute,
}
extern(C) struct ShaderFunction {
    const(char)* source = null;
    Range bytecode = {};
    const(char)* entry = null;
    const(char)* d3d11_target = null;
    const(char)* d3d11_filepath = null;
}
enum ShaderAttrBaseType {
    Undefined,
    Float,
    Sint,
    Uint,
}
extern(C) struct ShaderVertexAttr {
    ShaderAttrBaseType base_type = ShaderAttrBaseType.Undefined;
    const(char)* glsl_name = null;
    const(char)* hlsl_sem_name = null;
    ubyte hlsl_sem_index = 0;
}
extern(C) struct GlslShaderUniform {
    UniformType type = UniformType.Invalid;
    ushort array_count = 0;
    const(char)* glsl_name = null;
}
extern(C) struct ShaderUniformBlock {
    ShaderStage stage = ShaderStage.None;
    uint size = 0;
    ubyte hlsl_register_b_n = 0;
    ubyte msl_buffer_n = 0;
    ubyte wgsl_group0_binding_n = 0;
    UniformLayout layout = UniformLayout.Default;
    GlslShaderUniform[16] glsl_uniforms = [];
}
extern(C) struct ShaderTextureView {
    ShaderStage stage = ShaderStage.None;
    ImageType image_type = ImageType.Default;
    ImageSampleType sample_type = ImageSampleType.Default;
    bool multisampled = false;
    ubyte hlsl_register_t_n = 0;
    ubyte msl_texture_n = 0;
    ubyte wgsl_group1_binding_n = 0;
}
extern(C) struct ShaderStorageBufferView {
    ShaderStage stage = ShaderStage.None;
    bool readonly = false;
    ubyte hlsl_register_t_n = 0;
    ubyte hlsl_register_u_n = 0;
    ubyte msl_buffer_n = 0;
    ubyte wgsl_group1_binding_n = 0;
    ubyte glsl_binding_n = 0;
}
extern(C) struct ShaderStorageImageView {
    ShaderStage stage = ShaderStage.None;
    ImageType image_type = ImageType.Default;
    PixelFormat access_format = PixelFormat.Default;
    bool writeonly = false;
    ubyte hlsl_register_u_n = 0;
    ubyte msl_texture_n = 0;
    ubyte wgsl_group1_binding_n = 0;
    ubyte glsl_binding_n = 0;
}
extern(C) struct ShaderView {
    ShaderTextureView texture = {};
    ShaderStorageBufferView storage_buffer = {};
    ShaderStorageImageView storage_image = {};
}
extern(C) struct ShaderSampler {
    ShaderStage stage = ShaderStage.None;
    SamplerType sampler_type = SamplerType.Default;
    ubyte hlsl_register_s_n = 0;
    ubyte msl_sampler_n = 0;
    ubyte wgsl_group1_binding_n = 0;
}
extern(C) struct ShaderTextureSamplerPair {
    ShaderStage stage = ShaderStage.None;
    ubyte view_slot = 0;
    ubyte sampler_slot = 0;
    const(char)* glsl_name = null;
}
extern(C) struct MtlShaderThreadsPerThreadgroup {
    int x = 0;
    int y = 0;
    int z = 0;
}
extern(C) struct ShaderDesc {
    uint _start_canary = 0;
    ShaderFunction vertex_func = {};
    ShaderFunction fragment_func = {};
    ShaderFunction compute_func = {};
    ShaderVertexAttr[16] attrs = [];
    ShaderUniformBlock[8] uniform_blocks = [];
    ShaderView[28] views = [];
    ShaderSampler[16] samplers = [];
    ShaderTextureSamplerPair[16] texture_sampler_pairs = [];
    MtlShaderThreadsPerThreadgroup mtl_threads_per_threadgroup = {};
    const(char)* label = null;
    uint _end_canary = 0;
}
/++
+ sg_pipeline_desc
+ 
+     The sg_pipeline_desc struct defines all creation parameters for an
+     sg_pipeline object, used as argument to the sg_make_pipeline() function:
+ 
+     Pipeline objects come in two flavours:
+ 
+     - render pipelines for use in render passes
+     - compute pipelines for use in compute passes
+ 
+     A compute pipeline only requires a compute shader object but no
+     'render state', while a render pipeline requires a vertex/fragment shader
+     object and additional render state declarations:
+ 
+     - the vertex layout for all input vertex buffers
+     - a shader object
+     - the 3D primitive type (points, lines, triangles, ...)
+     - the index type (none, 16- or 32-bit)
+     - all the fixed-function-pipeline state (depth-, stencil-, blend-state, etc...)
+ 
+     If the vertex data has no gaps between vertex components, you can omit
+     the .layout.buffers[].stride and layout.attrs[].offset items (leave them
+     default-initialized to 0), sokol-gfx will then compute the offsets and
+     strides from the vertex component formats (.layout.attrs[].format).
+     Please note that ALL vertex attribute offsets must be 0 in order for the
+     automatic offset computation to kick in.
+ 
+     Note that if you use vertex-pulling from storage buffers instead of
+     fixed-function vertex input you can simply omit the entire nested .layout
+     struct.
+ 
+     The default configuration is as follows:
+ 
+     .compute:               false (must be set to true for a compute pipeline)
+     .shader:                0 (must be initialized with a valid sg_shader id!)
+     .layout:
+         .buffers[]:         vertex buffer layouts
+             .stride:        0 (if no stride is given it will be computed)
+             .step_func      SG_VERTEXSTEP_PER_VERTEX
+             .step_rate      1
+         .attrs[]:           vertex attribute declarations
+             .buffer_index   0 the vertex buffer bind slot
+             .offset         0 (offsets can be omitted if the vertex layout has no gaps)
+             .format         SG_VERTEXFORMAT_INVALID (must be initialized!)
+     .depth:
+         .pixel_format:      sg_desc.context.depth_format
+         .compare:           SG_COMPAREFUNC_ALWAYS
+         .write_enabled:     false
+         .bias:              0.0f
+         .bias_slope_scale:  0.0f
+         .bias_clamp:        0.0f
+     .stencil:
+         .enabled:           false
+         .front/back:
+             .compare:       SG_COMPAREFUNC_ALWAYS
+             .fail_op:       SG_STENCILOP_KEEP
+             .depth_fail_op: SG_STENCILOP_KEEP
+             .pass_op:       SG_STENCILOP_KEEP
+         .read_mask:         0
+         .write_mask:        0
+         .ref:               0
+     .color_count            1
+     .colors[0..color_count]
+         .pixel_format       sg_desc.context.color_format
+         .write_mask:        SG_COLORMASK_RGBA
+         .blend:
+             .enabled:           false
+             .src_factor_rgb:    SG_BLENDFACTOR_ONE
+             .dst_factor_rgb:    SG_BLENDFACTOR_ZERO
+             .op_rgb:            SG_BLENDOP_ADD
+             .src_factor_alpha:  SG_BLENDFACTOR_ONE
+             .dst_factor_alpha:  SG_BLENDFACTOR_ZERO
+             .op_alpha:          SG_BLENDOP_ADD
+     .primitive_type:            SG_PRIMITIVETYPE_TRIANGLES
+     .index_type:                SG_INDEXTYPE_NONE
+     .cull_mode:                 SG_CULLMODE_NONE
+     .face_winding:              SG_FACEWINDING_CW
+     .sample_count:              sg_desc.context.sample_count
+     .blend_color:               (sg_color) { 0.0f, 0.0f, 0.0f, 0.0f }
+     .alpha_to_coverage_enabled: false
+     .label  0       (optional string label for trace hooks)
+/
extern(C) struct VertexBufferLayoutState {
    int stride = 0;
    VertexStep step_func = VertexStep.Default;
    int step_rate = 0;
}
extern(C) struct VertexAttrState {
    int buffer_index = 0;
    int offset = 0;
    VertexFormat format = VertexFormat.Invalid;
}
extern(C) struct VertexLayoutState {
    VertexBufferLayoutState[8] buffers = [];
    VertexAttrState[16] attrs = [];
}
extern(C) struct StencilFaceState {
    CompareFunc compare = CompareFunc.Default;
    StencilOp fail_op = StencilOp.Default;
    StencilOp depth_fail_op = StencilOp.Default;
    StencilOp pass_op = StencilOp.Default;
}
extern(C) struct StencilState {
    bool enabled = false;
    StencilFaceState front = {};
    StencilFaceState back = {};
    ubyte read_mask = 0;
    ubyte write_mask = 0;
    ubyte _ref = 0;
}
extern(C) struct DepthState {
    PixelFormat pixel_format = PixelFormat.Default;
    CompareFunc compare = CompareFunc.Default;
    bool write_enabled = false;
    float bias = 0.0f;
    float bias_slope_scale = 0.0f;
    float bias_clamp = 0.0f;
}
extern(C) struct BlendState {
    bool enabled = false;
    BlendFactor src_factor_rgb = BlendFactor.Default;
    BlendFactor dst_factor_rgb = BlendFactor.Default;
    BlendOp op_rgb = BlendOp.Default;
    BlendFactor src_factor_alpha = BlendFactor.Default;
    BlendFactor dst_factor_alpha = BlendFactor.Default;
    BlendOp op_alpha = BlendOp.Default;
}
extern(C) struct ColorTargetState {
    PixelFormat pixel_format = PixelFormat.Default;
    ColorMask write_mask = ColorMask.Default;
    BlendState blend = {};
}
extern(C) struct PipelineDesc {
    uint _start_canary = 0;
    bool compute = false;
    Shader shader = {};
    VertexLayoutState layout = {};
    DepthState depth = {};
    StencilState stencil = {};
    int color_count = 0;
    ColorTargetState[4] colors = [];
    PrimitiveType primitive_type = PrimitiveType.Default;
    IndexType index_type = IndexType.Default;
    CullMode cull_mode = CullMode.Default;
    FaceWinding face_winding = FaceWinding.Default;
    int sample_count = 0;
    Color blend_color = {};
    bool alpha_to_coverage_enabled = false;
    const(char)* label = null;
    uint _end_canary = 0;
}
/++
+ sg_view_desc
+ 
+     Creation params for sg_view objects, passed into sg_make_view() calls.
+ 
+     View objects are passed into sg_apply_bindings() (for texture-, storage-buffer-
+     and storage-image views), and sg_begin_pass() (for color-, resolve-
+     and depth-stencil-attachment views).
+ 
+     The view type is determined by initializing one of the sub-structs of
+     sg_view_desc:
+ 
+     .texture            a texture-view object will be created
+         .image          the sg_image parent resource
+         .mip_levels     optional mip-level range, keep zero-initialized for the
+                         entire mipmap chain
+             .base       the first mip level
+             .count      number of mip levels, keeping this zero-initialized means
+                         'all remaining mip levels'
+         .slices         optional slice range, keep zero-initialized to include
+                         all slices
+             .base       the first slice
+             .count      number of slices, keeping this zero-initializied means 'all remaining slices'
+ 
+     .storage_buffer     a storage-buffer-view object will be created
+         .buffer         the sg_buffer parent resource, must have been created
+                         with `sg_buffer_desc.usage.storage_buffer = true`
+         .offset         optional 256-byte aligned byte-offset into the buffer
+ 
+     .storage_image      a storage-image-view object will be created
+         .image          the sg_image parent resource, must have been created
+                         with `sg_image_desc.usage.storage_image = true`
+         .mip_level      selects the mip-level for the compute shader to write
+         .slice          selects the slice for the compute shader to write
+ 
+     .color_attachment   a color-attachment-view object will be created
+         .image          the sg_image parent resource, must have been created
+                         with `sg_image_desc.usage.color_attachment = true`
+         .mip_level      selects the mip-level to render into
+         .slice          selects the slice to render into
+ 
+     .resolve_attachment a resolve-attachment-view object will be created
+         .image          the sg_image parent resource, must have been created
+                         with `sg_image_desc.usage.resolve_attachment = true`
+         .mip_level      selects the mip-level to msaa-resolve into
+         .slice          selects the slice to msaa-resolve into
+ 
+     .depth_stencil_attachment   a depth-stencil-attachment-view object will be created
+         .image          the sg_image parent resource, must have been created
+                         with `sg_image_desc.usage.depth_stencil_attachment = true`
+         .mip_level      selects the mip-level to render into
+         .slice          selects the slice to render into
+/
extern(C) struct BufferViewDesc {
    Buffer buffer = {};
    int offset = 0;
}
extern(C) struct ImageViewDesc {
    Image image = {};
    int mip_level = 0;
    int slice = 0;
}
extern(C) struct TextureViewRange {
    int base = 0;
    int count = 0;
}
extern(C) struct TextureViewDesc {
    Image image = {};
    TextureViewRange mip_levels = {};
    TextureViewRange slices = {};
}
extern(C) struct ViewDesc {
    uint _start_canary = 0;
    TextureViewDesc texture = {};
    BufferViewDesc storage_buffer = {};
    ImageViewDesc storage_image = {};
    ImageViewDesc color_attachment = {};
    ImageViewDesc resolve_attachment = {};
    ImageViewDesc depth_stencil_attachment = {};
    const(char)* label = null;
    uint _end_canary = 0;
}
/++
+ sg_trace_hooks
+ 
+     Installable callback functions to keep track of the sokol-gfx calls,
+     this is useful for debugging, or keeping track of resource creation
+     and destruction.
+ 
+     Trace hooks are installed with sg_install_trace_hooks(), this returns
+     another sg_trace_hooks struct with the previous set of
+     trace hook function pointers. These should be invoked by the
+     new trace hooks to form a proper call chain.
+/
extern(C) struct TraceHooks {
    void* user_data = null;
    extern(C) void function(void*) reset_state_cache = null;
    extern(C) void function(const BufferDesc*, Buffer, void*) make_buffer = null;
    extern(C) void function(const ImageDesc*, Image, void*) make_image = null;
    extern(C) void function(const SamplerDesc*, Sampler, void*) make_sampler = null;
    extern(C) void function(const ShaderDesc*, Shader, void*) make_shader = null;
    extern(C) void function(const PipelineDesc*, Pipeline, void*) make_pipeline = null;
    extern(C) void function(const ViewDesc*, View, void*) make_view = null;
    extern(C) void function(Buffer, void*) destroy_buffer = null;
    extern(C) void function(Image, void*) destroy_image = null;
    extern(C) void function(Sampler, void*) destroy_sampler = null;
    extern(C) void function(Shader, void*) destroy_shader = null;
    extern(C) void function(Pipeline, void*) destroy_pipeline = null;
    extern(C) void function(View, void*) destroy_view = null;
    extern(C) void function(Buffer, const Range*, void*) update_buffer = null;
    extern(C) void function(Image, const ImageData*, void*) update_image = null;
    extern(C) void function(Buffer, const Range*, int, void*) append_buffer = null;
    extern(C) void function(const Pass*, void*) begin_pass = null;
    extern(C) void function(int, int, int, int, bool, void*) apply_viewport = null;
    extern(C) void function(int, int, int, int, bool, void*) apply_scissor_rect = null;
    extern(C) void function(Pipeline, void*) apply_pipeline = null;
    extern(C) void function(const Bindings*, void*) apply_bindings = null;
    extern(C) void function(int, const Range*, void*) apply_uniforms = null;
    extern(C) void function(int, int, int, void*) draw = null;
    extern(C) void function(int, int, int, void*) dispatch = null;
    extern(C) void function(void*) end_pass = null;
    extern(C) void function(void*) commit = null;
    extern(C) void function(Buffer, void*) alloc_buffer = null;
    extern(C) void function(Image, void*) alloc_image = null;
    extern(C) void function(Sampler, void*) alloc_sampler = null;
    extern(C) void function(Shader, void*) alloc_shader = null;
    extern(C) void function(Pipeline, void*) alloc_pipeline = null;
    extern(C) void function(View, void*) alloc_view = null;
    extern(C) void function(Buffer, void*) dealloc_buffer = null;
    extern(C) void function(Image, void*) dealloc_image = null;
    extern(C) void function(Sampler, void*) dealloc_sampler = null;
    extern(C) void function(Shader, void*) dealloc_shader = null;
    extern(C) void function(Pipeline, void*) dealloc_pipeline = null;
    extern(C) void function(View, void*) dealloc_view = null;
    extern(C) void function(Buffer, const BufferDesc*, void*) init_buffer = null;
    extern(C) void function(Image, const ImageDesc*, void*) init_image = null;
    extern(C) void function(Sampler, const SamplerDesc*, void*) init_sampler = null;
    extern(C) void function(Shader, const ShaderDesc*, void*) init_shader = null;
    extern(C) void function(Pipeline, const PipelineDesc*, void*) init_pipeline = null;
    extern(C) void function(View, const ViewDesc*, void*) init_view = null;
    extern(C) void function(Buffer, void*) uninit_buffer = null;
    extern(C) void function(Image, void*) uninit_image = null;
    extern(C) void function(Sampler, void*) uninit_sampler = null;
    extern(C) void function(Shader, void*) uninit_shader = null;
    extern(C) void function(Pipeline, void*) uninit_pipeline = null;
    extern(C) void function(View, void*) uninit_view = null;
    extern(C) void function(Buffer, void*) fail_buffer = null;
    extern(C) void function(Image, void*) fail_image = null;
    extern(C) void function(Sampler, void*) fail_sampler = null;
    extern(C) void function(Shader, void*) fail_shader = null;
    extern(C) void function(Pipeline, void*) fail_pipeline = null;
    extern(C) void function(View, void*) fail_view = null;
    extern(C) void function(const(char)*, void*) push_debug_group = null;
    extern(C) void function(void*) pop_debug_group = null;
}
/++
+ sg_buffer_info
+     sg_image_info
+     sg_sampler_info
+     sg_shader_info
+     sg_pipeline_info
+     sg_view_info
+ 
+     These structs contain various internal resource attributes which
+     might be useful for debug-inspection. Please don't rely on the
+     actual content of those structs too much, as they are quite closely
+     tied to sokol_gfx.h internals and may change more frequently than
+     the other public API elements.
+ 
+     The *_info structs are used as the return values of the following functions:
+ 
+     sg_query_buffer_info()
+     sg_query_image_info()
+     sg_query_sampler_info()
+     sg_query_shader_info()
+     sg_query_pipeline_info()
+     sg_query_view_info()
+/
extern(C) struct SlotInfo {
    ResourceState state = ResourceState.Initial;
    uint res_id = 0;
    uint uninit_count = 0;
}
extern(C) struct BufferInfo {
    SlotInfo slot = {};
    uint update_frame_index = 0;
    uint append_frame_index = 0;
    int append_pos = 0;
    bool append_overflow = false;
    int num_slots = 0;
    int active_slot = 0;
}
extern(C) struct ImageInfo {
    SlotInfo slot = {};
    uint upd_frame_index = 0;
    int num_slots = 0;
    int active_slot = 0;
}
extern(C) struct SamplerInfo {
    SlotInfo slot = {};
}
extern(C) struct ShaderInfo {
    SlotInfo slot = {};
}
extern(C) struct PipelineInfo {
    SlotInfo slot = {};
}
extern(C) struct ViewInfo {
    SlotInfo slot = {};
}
/++
+ sg_frame_stats
+ 
+     Allows to track generic and backend-specific stats about a
+     render frame. Obtained by calling sg_query_frame_stats(). The returned
+     struct contains information about the *previous* frame.
+/
extern(C) struct FrameStatsGl {
    uint num_bind_buffer = 0;
    uint num_active_texture = 0;
    uint num_bind_texture = 0;
    uint num_bind_sampler = 0;
    uint num_bind_image_texture = 0;
    uint num_use_program = 0;
    uint num_render_state = 0;
    uint num_vertex_attrib_pointer = 0;
    uint num_vertex_attrib_divisor = 0;
    uint num_enable_vertex_attrib_array = 0;
    uint num_disable_vertex_attrib_array = 0;
    uint num_uniform = 0;
    uint num_memory_barriers = 0;
}
extern(C) struct FrameStatsD3d11Pass {
    uint num_om_set_render_targets = 0;
    uint num_clear_render_target_view = 0;
    uint num_clear_depth_stencil_view = 0;
    uint num_resolve_subresource = 0;
}
extern(C) struct FrameStatsD3d11Pipeline {
    uint num_rs_set_state = 0;
    uint num_om_set_depth_stencil_state = 0;
    uint num_om_set_blend_state = 0;
    uint num_ia_set_primitive_topology = 0;
    uint num_ia_set_input_layout = 0;
    uint num_vs_set_shader = 0;
    uint num_vs_set_constant_buffers = 0;
    uint num_ps_set_shader = 0;
    uint num_ps_set_constant_buffers = 0;
    uint num_cs_set_shader = 0;
    uint num_cs_set_constant_buffers = 0;
}
extern(C) struct FrameStatsD3d11Bindings {
    uint num_ia_set_vertex_buffers = 0;
    uint num_ia_set_index_buffer = 0;
    uint num_vs_set_shader_resources = 0;
    uint num_vs_set_samplers = 0;
    uint num_ps_set_shader_resources = 0;
    uint num_ps_set_samplers = 0;
    uint num_cs_set_shader_resources = 0;
    uint num_cs_set_samplers = 0;
    uint num_cs_set_unordered_access_views = 0;
}
extern(C) struct FrameStatsD3d11Uniforms {
    uint num_update_subresource = 0;
}
extern(C) struct FrameStatsD3d11Draw {
    uint num_draw_indexed_instanced = 0;
    uint num_draw_indexed = 0;
    uint num_draw_instanced = 0;
    uint num_draw = 0;
}
extern(C) struct FrameStatsD3d11 {
    FrameStatsD3d11Pass pass = {};
    FrameStatsD3d11Pipeline pipeline = {};
    FrameStatsD3d11Bindings bindings = {};
    FrameStatsD3d11Uniforms uniforms = {};
    FrameStatsD3d11Draw draw = {};
    uint num_map = 0;
    uint num_unmap = 0;
}
extern(C) struct FrameStatsMetalIdpool {
    uint num_added = 0;
    uint num_released = 0;
    uint num_garbage_collected = 0;
}
extern(C) struct FrameStatsMetalPipeline {
    uint num_set_blend_color = 0;
    uint num_set_cull_mode = 0;
    uint num_set_front_facing_winding = 0;
    uint num_set_stencil_reference_value = 0;
    uint num_set_depth_bias = 0;
    uint num_set_render_pipeline_state = 0;
    uint num_set_depth_stencil_state = 0;
}
extern(C) struct FrameStatsMetalBindings {
    uint num_set_vertex_buffer = 0;
    uint num_set_vertex_buffer_offset = 0;
    uint num_skip_redundant_vertex_buffer = 0;
    uint num_set_vertex_texture = 0;
    uint num_skip_redundant_vertex_texture = 0;
    uint num_set_vertex_sampler_state = 0;
    uint num_skip_redundant_vertex_sampler_state = 0;
    uint num_set_fragment_buffer = 0;
    uint num_set_fragment_buffer_offset = 0;
    uint num_skip_redundant_fragment_buffer = 0;
    uint num_set_fragment_texture = 0;
    uint num_skip_redundant_fragment_texture = 0;
    uint num_set_fragment_sampler_state = 0;
    uint num_skip_redundant_fragment_sampler_state = 0;
    uint num_set_compute_buffer = 0;
    uint num_set_compute_buffer_offset = 0;
    uint num_skip_redundant_compute_buffer = 0;
    uint num_set_compute_texture = 0;
    uint num_skip_redundant_compute_texture = 0;
    uint num_set_compute_sampler_state = 0;
    uint num_skip_redundant_compute_sampler_state = 0;
}
extern(C) struct FrameStatsMetalUniforms {
    uint num_set_vertex_buffer_offset = 0;
    uint num_set_fragment_buffer_offset = 0;
    uint num_set_compute_buffer_offset = 0;
}
extern(C) struct FrameStatsMetal {
    FrameStatsMetalIdpool idpool = {};
    FrameStatsMetalPipeline pipeline = {};
    FrameStatsMetalBindings bindings = {};
    FrameStatsMetalUniforms uniforms = {};
}
extern(C) struct FrameStatsWgpuUniforms {
    uint num_set_bindgroup = 0;
    uint size_write_buffer = 0;
}
extern(C) struct FrameStatsWgpuBindings {
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
    uint num_bindgroup_cache_invalidates = 0;
    uint num_bindgroup_cache_hash_vs_key_mismatch = 0;
}
extern(C) struct FrameStatsWgpu {
    FrameStatsWgpuUniforms uniforms = {};
    FrameStatsWgpuBindings bindings = {};
}
extern(C) struct FrameStats {
    uint frame_index = 0;
    uint num_passes = 0;
    uint num_apply_viewport = 0;
    uint num_apply_scissor_rect = 0;
    uint num_apply_pipeline = 0;
    uint num_apply_bindings = 0;
    uint num_apply_uniforms = 0;
    uint num_draw = 0;
    uint num_dispatch = 0;
    uint num_update_buffer = 0;
    uint num_append_buffer = 0;
    uint num_update_image = 0;
    uint size_apply_uniforms = 0;
    uint size_update_buffer = 0;
    uint size_append_buffer = 0;
    uint size_update_image = 0;
    FrameStatsGl gl = {};
    FrameStatsD3d11 d3d11 = {};
    FrameStatsMetal metal = {};
    FrameStatsWgpu wgpu = {};
}
enum LogItem {
    Ok,
    Malloc_failed,
    Gl_texture_format_not_supported,
    Gl_3d_textures_not_supported,
    Gl_array_textures_not_supported,
    Gl_storagebuffer_glsl_binding_out_of_range,
    Gl_storageimage_glsl_binding_out_of_range,
    Gl_shader_compilation_failed,
    Gl_shader_linking_failed,
    Gl_vertex_attribute_not_found_in_shader,
    Gl_uniformblock_name_not_found_in_shader,
    Gl_image_sampler_name_not_found_in_shader,
    Gl_framebuffer_status_undefined,
    Gl_framebuffer_status_incomplete_attachment,
    Gl_framebuffer_status_incomplete_missing_attachment,
    Gl_framebuffer_status_unsupported,
    Gl_framebuffer_status_incomplete_multisample,
    Gl_framebuffer_status_unknown,
    D3d11_create_buffer_failed,
    D3d11_create_buffer_srv_failed,
    D3d11_create_buffer_uav_failed,
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
    D3d11_uniformblock_hlsl_register_b_out_of_range,
    D3d11_storagebuffer_hlsl_register_t_out_of_range,
    D3d11_storagebuffer_hlsl_register_u_out_of_range,
    D3d11_image_hlsl_register_t_out_of_range,
    D3d11_storageimage_hlsl_register_u_out_of_range,
    D3d11_sampler_hlsl_register_s_out_of_range,
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
    D3d11_create_uav_failed,
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
    Metal_shader_entry_not_found,
    Metal_uniformblock_msl_buffer_slot_out_of_range,
    Metal_storagebuffer_msl_buffer_slot_out_of_range,
    Metal_storageimage_msl_texture_slot_out_of_range,
    Metal_image_msl_texture_slot_out_of_range,
    Metal_sampler_msl_sampler_slot_out_of_range,
    Metal_create_cps_failed,
    Metal_create_cps_output,
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
    Wgpu_shader_create_bindgroup_layout_failed,
    Wgpu_uniformblock_wgsl_group0_binding_out_of_range,
    Wgpu_texture_wgsl_group1_binding_out_of_range,
    Wgpu_storagebuffer_wgsl_group1_binding_out_of_range,
    Wgpu_storageimage_wgsl_group1_binding_out_of_range,
    Wgpu_sampler_wgsl_group1_binding_out_of_range,
    Wgpu_create_pipeline_layout_failed,
    Wgpu_create_render_pipeline_failed,
    Wgpu_create_compute_pipeline_failed,
    Identical_commit_listener,
    Commit_listener_array_full,
    Trace_hooks_not_enabled,
    Dealloc_buffer_invalid_state,
    Dealloc_image_invalid_state,
    Dealloc_sampler_invalid_state,
    Dealloc_shader_invalid_state,
    Dealloc_pipeline_invalid_state,
    Dealloc_view_invalid_state,
    Init_buffer_invalid_state,
    Init_image_invalid_state,
    Init_sampler_invalid_state,
    Init_shader_invalid_state,
    Init_pipeline_invalid_state,
    Init_view_invalid_state,
    Uninit_buffer_invalid_state,
    Uninit_image_invalid_state,
    Uninit_sampler_invalid_state,
    Uninit_shader_invalid_state,
    Uninit_pipeline_invalid_state,
    Uninit_view_invalid_state,
    Fail_buffer_invalid_state,
    Fail_image_invalid_state,
    Fail_sampler_invalid_state,
    Fail_shader_invalid_state,
    Fail_pipeline_invalid_state,
    Fail_view_invalid_state,
    Buffer_pool_exhausted,
    Image_pool_exhausted,
    Sampler_pool_exhausted,
    Shader_pool_exhausted,
    Pipeline_pool_exhausted,
    View_pool_exhausted,
    Beginpass_attachments_alive,
    Draw_without_bindings,
    Validate_bufferdesc_canary,
    Validate_bufferdesc_immutable_dynamic_stream,
    Validate_bufferdesc_separate_buffer_types,
    Validate_bufferdesc_expect_nonzero_size,
    Validate_bufferdesc_expect_matching_data_size,
    Validate_bufferdesc_expect_zero_data_size,
    Validate_bufferdesc_expect_no_data,
    Validate_bufferdesc_expect_data,
    Validate_bufferdesc_storagebuffer_supported,
    Validate_bufferdesc_storagebuffer_size_multiple_4,
    Validate_imagedata_nodata,
    Validate_imagedata_data_size,
    Validate_imagedesc_canary,
    Validate_imagedesc_immutable_dynamic_stream,
    Validate_imagedesc_width,
    Validate_imagedesc_height,
    Validate_imagedesc_nonrt_pixelformat,
    Validate_imagedesc_msaa_but_no_attachment,
    Validate_imagedesc_depth_3d_image,
    Validate_imagedesc_attachment_expect_immutable,
    Validate_imagedesc_attachment_expect_no_data,
    Validate_imagedesc_attachment_pixelformat,
    Validate_imagedesc_attachment_resolve_expect_no_msaa,
    Validate_imagedesc_attachment_no_msaa_support,
    Validate_imagedesc_attachment_msaa_num_mipmaps,
    Validate_imagedesc_attachment_msaa_3d_image,
    Validate_imagedesc_attachment_msaa_cube_image,
    Validate_imagedesc_attachment_msaa_array_image,
    Validate_imagedesc_storageimage_pixelformat,
    Validate_imagedesc_storageimage_expect_no_msaa,
    Validate_imagedesc_injected_no_data,
    Validate_imagedesc_dynamic_no_data,
    Validate_imagedesc_compressed_immutable,
    Validate_samplerdesc_canary,
    Validate_samplerdesc_anistropic_requires_linear_filtering,
    Validate_shaderdesc_canary,
    Validate_shaderdesc_vertex_source,
    Validate_shaderdesc_fragment_source,
    Validate_shaderdesc_compute_source,
    Validate_shaderdesc_vertex_source_or_bytecode,
    Validate_shaderdesc_fragment_source_or_bytecode,
    Validate_shaderdesc_compute_source_or_bytecode,
    Validate_shaderdesc_invalid_shader_combo,
    Validate_shaderdesc_no_bytecode_size,
    Validate_shaderdesc_metal_threads_per_threadgroup_initialized,
    Validate_shaderdesc_metal_threads_per_threadgroup_multiple_32,
    Validate_shaderdesc_uniformblock_no_cont_members,
    Validate_shaderdesc_uniformblock_size_is_zero,
    Validate_shaderdesc_uniformblock_metal_buffer_slot_out_of_range,
    Validate_shaderdesc_uniformblock_metal_buffer_slot_collision,
    Validate_shaderdesc_uniformblock_hlsl_register_b_out_of_range,
    Validate_shaderdesc_uniformblock_hlsl_register_b_collision,
    Validate_shaderdesc_uniformblock_wgsl_group0_binding_out_of_range,
    Validate_shaderdesc_uniformblock_wgsl_group0_binding_collision,
    Validate_shaderdesc_uniformblock_no_members,
    Validate_shaderdesc_uniformblock_uniform_glsl_name,
    Validate_shaderdesc_uniformblock_size_mismatch,
    Validate_shaderdesc_uniformblock_array_count,
    Validate_shaderdesc_uniformblock_std140_array_type,
    Validate_shaderdesc_view_storagebuffer_metal_buffer_slot_out_of_range,
    Validate_shaderdesc_view_storagebuffer_metal_buffer_slot_collision,
    Validate_shaderdesc_view_storagebuffer_hlsl_register_t_out_of_range,
    Validate_shaderdesc_view_storagebuffer_hlsl_register_t_collision,
    Validate_shaderdesc_view_storagebuffer_hlsl_register_u_out_of_range,
    Validate_shaderdesc_view_storagebuffer_hlsl_register_u_collision,
    Validate_shaderdesc_view_storagebuffer_glsl_binding_out_of_range,
    Validate_shaderdesc_view_storagebuffer_glsl_binding_collision,
    Validate_shaderdesc_view_storagebuffer_wgsl_group1_binding_out_of_range,
    Validate_shaderdesc_view_storagebuffer_wgsl_group1_binding_collision,
    Validate_shaderdesc_view_storageimage_expect_compute_stage,
    Validate_shaderdesc_view_storageimage_metal_texture_slot_out_of_range,
    Validate_shaderdesc_view_storageimage_metal_texture_slot_collision,
    Validate_shaderdesc_view_storageimage_hlsl_register_u_out_of_range,
    Validate_shaderdesc_view_storageimage_hlsl_register_u_collision,
    Validate_shaderdesc_view_storageimage_glsl_binding_out_of_range,
    Validate_shaderdesc_view_storageimage_glsl_binding_collision,
    Validate_shaderdesc_view_storageimage_wgsl_group1_binding_out_of_range,
    Validate_shaderdesc_view_storageimage_wgsl_group1_binding_collision,
    Validate_shaderdesc_view_texture_metal_texture_slot_out_of_range,
    Validate_shaderdesc_view_texture_metal_texture_slot_collision,
    Validate_shaderdesc_view_texture_hlsl_register_t_out_of_range,
    Validate_shaderdesc_view_texture_hlsl_register_t_collision,
    Validate_shaderdesc_view_texture_wgsl_group1_binding_out_of_range,
    Validate_shaderdesc_view_texture_wgsl_group1_binding_collision,
    Validate_shaderdesc_sampler_metal_sampler_slot_out_of_range,
    Validate_shaderdesc_sampler_metal_sampler_slot_collision,
    Validate_shaderdesc_sampler_hlsl_register_s_out_of_range,
    Validate_shaderdesc_sampler_hlsl_register_s_collision,
    Validate_shaderdesc_sampler_wgsl_group1_binding_out_of_range,
    Validate_shaderdesc_sampler_wgsl_group1_binding_collision,
    Validate_shaderdesc_texture_sampler_pair_view_slot_out_of_range,
    Validate_shaderdesc_texture_sampler_pair_sampler_slot_out_of_range,
    Validate_shaderdesc_texture_sampler_pair_texture_stage_mismatch,
    Validate_shaderdesc_texture_sampler_pair_expect_texture_view,
    Validate_shaderdesc_texture_sampler_pair_sampler_stage_mismatch,
    Validate_shaderdesc_texture_sampler_pair_glsl_name,
    Validate_shaderdesc_nonfiltering_sampler_required,
    Validate_shaderdesc_comparison_sampler_required,
    Validate_shaderdesc_texview_not_referenced_by_texture_sampler_pairs,
    Validate_shaderdesc_sampler_not_referenced_by_texture_sampler_pairs,
    Validate_shaderdesc_attr_string_too_long,
    Validate_pipelinedesc_canary,
    Validate_pipelinedesc_shader,
    Validate_pipelinedesc_compute_shader_expected,
    Validate_pipelinedesc_no_compute_shader_expected,
    Validate_pipelinedesc_no_cont_attrs,
    Validate_pipelinedesc_attr_basetype_mismatch,
    Validate_pipelinedesc_layout_stride4,
    Validate_pipelinedesc_attr_semantics,
    Validate_pipelinedesc_shader_readonly_storagebuffers,
    Validate_pipelinedesc_blendop_minmax_requires_blendfactor_one,
    Validate_viewdesc_canary,
    Validate_viewdesc_unique_viewtype,
    Validate_viewdesc_any_viewtype,
    Validate_viewdesc_resource_alive,
    Validate_viewdesc_resource_failed,
    Validate_viewdesc_storagebuffer_offset_vs_buffer_size,
    Validate_viewdesc_storagebuffer_offset_multiple_256,
    Validate_viewdesc_storagebuffer_usage,
    Validate_viewdesc_storageimage_usage,
    Validate_viewdesc_colorattachment_usage,
    Validate_viewdesc_resolveattachment_usage,
    Validate_viewdesc_depthstencilattachment_usage,
    Validate_viewdesc_image_miplevel,
    Validate_viewdesc_image_2d_slice,
    Validate_viewdesc_image_cubemap_slice,
    Validate_viewdesc_image_array_slice,
    Validate_viewdesc_image_3d_slice,
    Validate_viewdesc_texture_expect_no_msaa,
    Validate_viewdesc_texture_miplevels,
    Validate_viewdesc_texture_2d_slices,
    Validate_viewdesc_texture_cubemap_slices,
    Validate_viewdesc_texture_array_slices,
    Validate_viewdesc_texture_3d_slices,
    Validate_viewdesc_storageimage_pixelformat,
    Validate_viewdesc_colorattachment_pixelformat,
    Validate_viewdesc_depthstencilattachment_pixelformat,
    Validate_viewdesc_resolveattachment_samplecount,
    Validate_beginpass_canary,
    Validate_beginpass_computepass_expect_no_attachments,
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
    Validate_beginpass_colorattachmentviews_continuous,
    Validate_beginpass_colorattachmentview_alive,
    Validate_beginpass_colorattachmentview_valid,
    Validate_beginpass_colorattachmentview_type,
    Validate_beginpass_colorattachmentview_image_alive,
    Validate_beginpass_colorattachmentview_image_valid,
    Validate_beginpass_colorattachmentview_sizes,
    Validate_beginpass_colorattachmentview_samplecounts,
    Validate_beginpass_resolveattachmentview_no_colorattachmentview,
    Validate_beginpass_resolveattachmentview_alive,
    Validate_beginpass_resolveattachmentview_valid,
    Validate_beginpass_resolveattachmentview_type,
    Validate_beginpass_resolveattachmentview_image_alive,
    Validate_beginpass_resolveattachmentview_image_valid,
    Validate_beginpass_resolveattachmentview_sizes,
    Validate_beginpass_depthstencilattachmentviews_continuous,
    Validate_beginpass_depthstencilattachmentview_alive,
    Validate_beginpass_depthstencilattachmentview_valid,
    Validate_beginpass_depthstencilattachmentview_type,
    Validate_beginpass_depthstencilattachmentview_image_alive,
    Validate_beginpass_depthstencilattachmentview_image_valid,
    Validate_beginpass_depthstencilattachmentview_sizes,
    Validate_beginpass_depthstencilattachmentview_samplecount,
    Validate_beginpass_attachments_expected,
    Validate_avp_renderpass_expected,
    Validate_asr_renderpass_expected,
    Validate_apip_pipeline_valid_id,
    Validate_apip_pipeline_exists,
    Validate_apip_pipeline_valid,
    Validate_apip_pass_expected,
    Validate_apip_pipeline_shader_alive,
    Validate_apip_pipeline_shader_valid,
    Validate_apip_computepass_expected,
    Validate_apip_renderpass_expected,
    Validate_apip_swapchain_color_count,
    Validate_apip_swapchain_color_format,
    Validate_apip_swapchain_depth_format,
    Validate_apip_swapchain_sample_count,
    Validate_apip_attachments_alive,
    Validate_apip_colorattachments_count,
    Validate_apip_colorattachments_view_valid,
    Validate_apip_colorattachments_image_valid,
    Validate_apip_colorattachments_format,
    Validate_apip_depthstencilattachment_view_valid,
    Validate_apip_depthstencilattachment_image_valid,
    Validate_apip_depthstencilattachment_format,
    Validate_apip_attachment_sample_count,
    Validate_abnd_pass_expected,
    Validate_abnd_empty_bindings,
    Validate_abnd_no_pipeline,
    Validate_abnd_pipeline_alive,
    Validate_abnd_pipeline_valid,
    Validate_abnd_pipeline_shader_alive,
    Validate_abnd_pipeline_shader_valid,
    Validate_abnd_compute_expected_no_vbufs,
    Validate_abnd_compute_expected_no_ibuf,
    Validate_abnd_expected_vbuf,
    Validate_abnd_vbuf_alive,
    Validate_abnd_vbuf_usage,
    Validate_abnd_vbuf_overflow,
    Validate_abnd_expected_no_ibuf,
    Validate_abnd_expected_ibuf,
    Validate_abnd_ibuf_alive,
    Validate_abnd_ibuf_usage,
    Validate_abnd_ibuf_overflow,
    Validate_abnd_expected_view_binding,
    Validate_abnd_view_alive,
    Validate_abnd_expect_texview,
    Validate_abnd_expect_sbview,
    Validate_abnd_expect_simgview,
    Validate_abnd_texview_imagetype_mismatch,
    Validate_abnd_texview_expected_multisampled_image,
    Validate_abnd_texview_expected_non_multisampled_image,
    Validate_abnd_texview_expected_filterable_image,
    Validate_abnd_texview_expected_depth_image,
    Validate_abnd_sbview_readwrite_immutable,
    Validate_abnd_simgview_compute_pass_expected,
    Validate_abnd_simgview_imagetype_mismatch,
    Validate_abnd_simgview_accessformat,
    Validate_abnd_expected_sampler_binding,
    Validate_abnd_unexpected_sampler_compare_never,
    Validate_abnd_expected_sampler_compare_never,
    Validate_abnd_expected_nonfiltering_sampler,
    Validate_abnd_sampler_alive,
    Validate_abnd_sampler_valid,
    Validate_abnd_texture_binding_vs_depthstencil_attachment,
    Validate_abnd_texture_binding_vs_color_attachment,
    Validate_abnd_texture_binding_vs_resolve_attachment,
    Validate_abnd_texture_vs_storageimage_binding,
    Validate_au_pass_expected,
    Validate_au_no_pipeline,
    Validate_au_pipeline_alive,
    Validate_au_pipeline_valid,
    Validate_au_pipeline_shader_alive,
    Validate_au_pipeline_shader_valid,
    Validate_au_no_uniformblock_at_slot,
    Validate_au_size,
    Validate_draw_renderpass_expected,
    Validate_draw_baseelement,
    Validate_draw_numelements,
    Validate_draw_numinstances,
    Validate_draw_required_bindings_or_uniforms_missing,
    Validate_dispatch_computepass_expected,
    Validate_dispatch_numgroupsx,
    Validate_dispatch_numgroupsy,
    Validate_dispatch_numgroupsz,
    Validate_dispatch_required_bindings_or_uniforms_missing,
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
/++
+ sg_desc
+ 
+     The sg_desc struct contains configuration values for sokol_gfx,
+     it is used as parameter to the sg_setup() call.
+ 
+     The default configuration is:
+ 
+     .buffer_pool_size               128
+     .image_pool_size                128
+     .sampler_pool_size              64
+     .shader_pool_size               32
+     .pipeline_pool_size             64
+     .view_pool_size                 256
+     .uniform_buffer_size            4 MB (4*1024*1024)
+     .max_commit_listeners           1024
+     .disable_validation             false
+     .mtl_force_managed_storage_mode false
+     .wgpu_disable_bindgroups_cache  false
+     .wgpu_bindgroups_cache_size     1024
+ 
+     .allocator.alloc_fn     0 (in this case, malloc() will be called)
+     .allocator.free_fn      0 (in this case, free() will be called)
+     .allocator.user_data    0
+ 
+     .environment.defaults.color_format: default value depends on selected backend:
+         all GL backends:    SG_PIXELFORMAT_RGBA8
+         Metal and D3D11:    SG_PIXELFORMAT_BGRA8
+         WebGPU:             *no default* (must be queried from WebGPU swapchain object)
+     .environment.defaults.depth_format: SG_PIXELFORMAT_DEPTH_STENCIL
+     .environment.defaults.sample_count: 1
+ 
+     Metal specific:
+         (NOTE: All Objective-C object references are transferred through
+         a bridged cast (__bridge const void*) to sokol_gfx, which will use an
+         unretained bridged cast (__bridge id<xxx>) to retrieve the Objective-C
+         references back. Since the bridge cast is unretained, the caller
+         must hold a strong reference to the Objective-C object until sg_setup()
+         returns.
+ 
+         .mtl_force_managed_storage_mode
+             when enabled, Metal buffers and texture resources are created in managed storage
+             mode, otherwise sokol-gfx will decide whether to create buffers and
+             textures in managed or shared storage mode (this is mainly a debugging option)
+         .mtl_use_command_buffer_with_retained_references
+             when true, the sokol-gfx Metal backend will use Metal command buffers which
+             bump the reference count of resource objects as long as they are inflight,
+             this is slower than the default command-buffer-with-unretained-references
+             method, this may be a workaround when confronted with lifetime validation
+             errors from the Metal validation layer until a proper fix has been implemented
+         .environment.metal.device
+             a pointer to the MTLDevice object
+ 
+     D3D11 specific:
+         .environment.d3d11.device
+             a pointer to the ID3D11Device object, this must have been created
+             before sg_setup() is called
+         .environment.d3d11.device_context
+             a pointer to the ID3D11DeviceContext object
+         .d3d11_shader_debugging
+             set this to true to compile shaders which are provided as HLSL source
+             code with debug information and without optimization, this allows
+             shader debugging in tools like RenderDoc, to output source code
+             instead of byte code from sokol-shdc, omit the `--binary` cmdline
+             option
+ 
+     WebGPU specific:
+         .wgpu_disable_bindgroups_cache
+             When this is true, the WebGPU backend will create and immediately
+             release a BindGroup object in the sg_apply_bindings() call, only
+             use this for debugging purposes.
+         .wgpu_bindgroups_cache_size
+             The size of the bindgroups cache for re-using BindGroup objects
+             between sg_apply_bindings() calls. The smaller the cache size,
+             the more likely are cache slot collisions which will cause
+             a BindGroups object to be destroyed and a new one created.
+             Use the information returned by sg_query_stats() to check
+             if this is a frequent occurrence, and increase the cache size as
+             needed (the default is 1024).
+             NOTE: wgpu_bindgroups_cache_size must be a power-of-2 number!
+         .environment.wgpu.device
+             a WGPUDevice handle
+ 
+     When using sokol_gfx.h and sokol_app.h together, consider using the
+     helper function sglue_environment() in the sokol_glue.h header to
+     initialize the sg_desc.environment nested struct. sglue_environment() returns
+     a completely initialized sg_environment struct with information
+     provided by sokol_app.h.
+/
extern(C) struct EnvironmentDefaults {
    PixelFormat color_format = PixelFormat.Default;
    PixelFormat depth_format = PixelFormat.Default;
    int sample_count = 0;
}
extern(C) struct MetalEnvironment {
    const(void)* device = null;
}
extern(C) struct D3d11Environment {
    const(void)* device = null;
    const(void)* device_context = null;
}
extern(C) struct WgpuEnvironment {
    const(void)* device = null;
}
extern(C) struct Environment {
    EnvironmentDefaults defaults = {};
    MetalEnvironment metal = {};
    D3d11Environment d3d11 = {};
    WgpuEnvironment wgpu = {};
}
/++
+ sg_commit_listener
+ 
+     Used with function sg_add_commit_listener() to add a callback
+     which will be called in sg_commit(). This is useful for libraries
+     building on top of sokol-gfx to be notified about when a frame
+     ends (instead of having to guess, or add a manual 'new-frame'
+     function.
+/
extern(C) struct CommitListener {
    extern(C) void function(void*) func = null;
    void* user_data = null;
}
/++
+ sg_allocator
+ 
+     Used in sg_desc to provide custom memory-alloc and -free functions
+     to sokol_gfx.h. If memory management should be overridden, both the
+     alloc_fn and free_fn function must be provided (e.g. it's not valid to
+     override one function but not the other).
+/
extern(C) struct Allocator {
    extern(C) void* function(size_t, void*) alloc_fn = null;
    extern(C) void function(void*, void*) free_fn = null;
    void* user_data = null;
}
/++
+ sg_logger
+ 
+     Used in sg_desc to provide a logging function. Please be aware
+     that without logging function, sokol-gfx will be completely
+     silent, e.g. it will not report errors, warnings and
+     validation layer messages. For maximum error verbosity,
+     compile in debug mode (e.g. NDEBUG *not* defined) and provide a
+     compatible logger function in the sg_setup() call
+     (for instance the standard logging function from sokol_log.h).
+/
extern(C) struct Logger {
    extern(C) void function(const(char)*, uint, uint, const(char)*, uint, const(char)*, void*) func = null;
    void* user_data = null;
}
extern(C) struct Desc {
    uint _start_canary = 0;
    int buffer_pool_size = 0;
    int image_pool_size = 0;
    int sampler_pool_size = 0;
    int shader_pool_size = 0;
    int pipeline_pool_size = 0;
    int view_pool_size = 0;
    int uniform_buffer_size = 0;
    int max_commit_listeners = 0;
    bool disable_validation = false;
    bool d3d11_shader_debugging = false;
    bool mtl_force_managed_storage_mode = false;
    bool mtl_use_command_buffer_with_retained_references = false;
    bool wgpu_disable_bindgroups_cache = false;
    int wgpu_bindgroups_cache_size = 0;
    Allocator allocator = {};
    Logger logger = {};
    Environment environment = {};
    uint _end_canary = 0;
}
/++
+ setup and misc functions
+/
extern(C) void sg_setup(const Desc* desc) @system @nogc nothrow pure;
void setup(scope ref Desc desc) @trusted @nogc nothrow pure {
    sg_setup(&desc);
}
extern(C) void sg_shutdown() @system @nogc nothrow pure;
void shutdown() @trusted @nogc nothrow pure {
    sg_shutdown();
}
extern(C) bool sg_isvalid() @system @nogc nothrow pure;
bool isvalid() @trusted @nogc nothrow pure {
    return sg_isvalid();
}
extern(C) void sg_reset_state_cache() @system @nogc nothrow pure;
void resetStateCache() @trusted @nogc nothrow pure {
    sg_reset_state_cache();
}
extern(C) TraceHooks sg_install_trace_hooks(const TraceHooks* trace_hooks) @system @nogc nothrow pure;
TraceHooks installTraceHooks(scope ref TraceHooks trace_hooks) @trusted @nogc nothrow pure {
    return sg_install_trace_hooks(&trace_hooks);
}
extern(C) void sg_push_debug_group(const(char)* name) @system @nogc nothrow pure;
void pushDebugGroup(const(char)* name) @trusted @nogc nothrow pure {
    sg_push_debug_group(name);
}
extern(C) void sg_pop_debug_group() @system @nogc nothrow pure;
void popDebugGroup() @trusted @nogc nothrow pure {
    sg_pop_debug_group();
}
extern(C) bool sg_add_commit_listener(CommitListener listener) @system @nogc nothrow pure;
bool addCommitListener(CommitListener listener) @trusted @nogc nothrow pure {
    return sg_add_commit_listener(listener);
}
extern(C) bool sg_remove_commit_listener(CommitListener listener) @system @nogc nothrow pure;
bool removeCommitListener(CommitListener listener) @trusted @nogc nothrow pure {
    return sg_remove_commit_listener(listener);
}
/++
+ resource creation, destruction and updating
+/
extern(C) Buffer sg_make_buffer(const BufferDesc* desc) @system @nogc nothrow pure;
Buffer makeBuffer(scope ref BufferDesc desc) @trusted @nogc nothrow pure {
    return sg_make_buffer(&desc);
}
extern(C) Image sg_make_image(const ImageDesc* desc) @system @nogc nothrow pure;
Image makeImage(scope ref ImageDesc desc) @trusted @nogc nothrow pure {
    return sg_make_image(&desc);
}
extern(C) Sampler sg_make_sampler(const SamplerDesc* desc) @system @nogc nothrow pure;
Sampler makeSampler(scope ref SamplerDesc desc) @trusted @nogc nothrow pure {
    return sg_make_sampler(&desc);
}
extern(C) Shader sg_make_shader(const ShaderDesc* desc) @system @nogc nothrow pure;
Shader makeShader(scope ref ShaderDesc desc) @trusted @nogc nothrow pure {
    return sg_make_shader(&desc);
}
extern(C) Pipeline sg_make_pipeline(const PipelineDesc* desc) @system @nogc nothrow pure;
Pipeline makePipeline(scope ref PipelineDesc desc) @trusted @nogc nothrow pure {
    return sg_make_pipeline(&desc);
}
extern(C) View sg_make_view(const ViewDesc* desc) @system @nogc nothrow pure;
View makeView(scope ref ViewDesc desc) @trusted @nogc nothrow pure {
    return sg_make_view(&desc);
}
extern(C) void sg_destroy_buffer(Buffer buf) @system @nogc nothrow pure;
void destroyBuffer(Buffer buf) @trusted @nogc nothrow pure {
    sg_destroy_buffer(buf);
}
extern(C) void sg_destroy_image(Image img) @system @nogc nothrow pure;
void destroyImage(Image img) @trusted @nogc nothrow pure {
    sg_destroy_image(img);
}
extern(C) void sg_destroy_sampler(Sampler smp) @system @nogc nothrow pure;
void destroySampler(Sampler smp) @trusted @nogc nothrow pure {
    sg_destroy_sampler(smp);
}
extern(C) void sg_destroy_shader(Shader shd) @system @nogc nothrow pure;
void destroyShader(Shader shd) @trusted @nogc nothrow pure {
    sg_destroy_shader(shd);
}
extern(C) void sg_destroy_pipeline(Pipeline pip) @system @nogc nothrow pure;
void destroyPipeline(Pipeline pip) @trusted @nogc nothrow pure {
    sg_destroy_pipeline(pip);
}
extern(C) void sg_destroy_view(View view) @system @nogc nothrow pure;
void destroyView(View view) @trusted @nogc nothrow pure {
    sg_destroy_view(view);
}
extern(C) void sg_update_buffer(Buffer buf, const Range* data) @system @nogc nothrow pure;
void updateBuffer(Buffer buf, scope ref Range data) @trusted @nogc nothrow pure {
    sg_update_buffer(buf, &data);
}
extern(C) void sg_update_image(Image img, const ImageData* data) @system @nogc nothrow pure;
void updateImage(Image img, scope ref ImageData data) @trusted @nogc nothrow pure {
    sg_update_image(img, &data);
}
extern(C) int sg_append_buffer(Buffer buf, const Range* data) @system @nogc nothrow pure;
int appendBuffer(Buffer buf, scope ref Range data) @trusted @nogc nothrow pure {
    return sg_append_buffer(buf, &data);
}
extern(C) bool sg_query_buffer_overflow(Buffer buf) @system @nogc nothrow pure;
bool queryBufferOverflow(Buffer buf) @trusted @nogc nothrow pure {
    return sg_query_buffer_overflow(buf);
}
extern(C) bool sg_query_buffer_will_overflow(Buffer buf, size_t size) @system @nogc nothrow pure;
bool queryBufferWillOverflow(Buffer buf, size_t size) @trusted @nogc nothrow pure {
    return sg_query_buffer_will_overflow(buf, size);
}
/++
+ render and compute functions
+/
extern(C) void sg_begin_pass(const Pass* pass) @system @nogc nothrow pure;
void beginPass(scope ref Pass pass) @trusted @nogc nothrow pure {
    sg_begin_pass(&pass);
}
extern(C) void sg_apply_viewport(int x, int y, int width, int height, bool origin_top_left) @system @nogc nothrow pure;
void applyViewport(int x, int y, int width, int height, bool origin_top_left) @trusted @nogc nothrow pure {
    sg_apply_viewport(x, y, width, height, origin_top_left);
}
extern(C) void sg_apply_viewportf(float x, float y, float width, float height, bool origin_top_left) @system @nogc nothrow pure;
void applyViewportf(float x, float y, float width, float height, bool origin_top_left) @trusted @nogc nothrow pure {
    sg_apply_viewportf(x, y, width, height, origin_top_left);
}
extern(C) void sg_apply_scissor_rect(int x, int y, int width, int height, bool origin_top_left) @system @nogc nothrow pure;
void applyScissorRect(int x, int y, int width, int height, bool origin_top_left) @trusted @nogc nothrow pure {
    sg_apply_scissor_rect(x, y, width, height, origin_top_left);
}
extern(C) void sg_apply_scissor_rectf(float x, float y, float width, float height, bool origin_top_left) @system @nogc nothrow pure;
void applyScissorRectf(float x, float y, float width, float height, bool origin_top_left) @trusted @nogc nothrow pure {
    sg_apply_scissor_rectf(x, y, width, height, origin_top_left);
}
extern(C) void sg_apply_pipeline(Pipeline pip) @system @nogc nothrow pure;
void applyPipeline(Pipeline pip) @trusted @nogc nothrow pure {
    sg_apply_pipeline(pip);
}
extern(C) void sg_apply_bindings(const Bindings* bindings) @system @nogc nothrow pure;
void applyBindings(scope ref Bindings bindings) @trusted @nogc nothrow pure {
    sg_apply_bindings(&bindings);
}
extern(C) void sg_apply_uniforms(uint ub_slot, const Range* data) @system @nogc nothrow pure;
void applyUniforms(uint ub_slot, scope ref Range data) @trusted @nogc nothrow pure {
    sg_apply_uniforms(ub_slot, &data);
}
extern(C) void sg_draw(uint base_element, uint num_elements, uint num_instances) @system @nogc nothrow pure;
void draw(uint base_element, uint num_elements, uint num_instances) @trusted @nogc nothrow pure {
    sg_draw(base_element, num_elements, num_instances);
}
extern(C) void sg_dispatch(uint num_groups_x, uint num_groups_y, uint num_groups_z) @system @nogc nothrow pure;
void dispatch(uint num_groups_x, uint num_groups_y, uint num_groups_z) @trusted @nogc nothrow pure {
    sg_dispatch(num_groups_x, num_groups_y, num_groups_z);
}
extern(C) void sg_end_pass() @system @nogc nothrow pure;
void endPass() @trusted @nogc nothrow pure {
    sg_end_pass();
}
extern(C) void sg_commit() @system @nogc nothrow pure;
void commit() @trusted @nogc nothrow pure {
    sg_commit();
}
/++
+ getting information
+/
extern(C) Desc sg_query_desc() @system @nogc nothrow pure;
Desc queryDesc() @trusted @nogc nothrow pure {
    return sg_query_desc();
}
extern(C) Backend sg_query_backend() @system @nogc nothrow pure;
Backend queryBackend() @trusted @nogc nothrow pure {
    return sg_query_backend();
}
extern(C) Features sg_query_features() @system @nogc nothrow pure;
Features queryFeatures() @trusted @nogc nothrow pure {
    return sg_query_features();
}
extern(C) Limits sg_query_limits() @system @nogc nothrow pure;
Limits queryLimits() @trusted @nogc nothrow pure {
    return sg_query_limits();
}
extern(C) PixelformatInfo sg_query_pixelformat(PixelFormat fmt) @system @nogc nothrow pure;
PixelformatInfo queryPixelformat(PixelFormat fmt) @trusted @nogc nothrow pure {
    return sg_query_pixelformat(fmt);
}
extern(C) int sg_query_row_pitch(PixelFormat fmt, int width, int row_align_bytes) @system @nogc nothrow pure;
int queryRowPitch(PixelFormat fmt, int width, int row_align_bytes) @trusted @nogc nothrow pure {
    return sg_query_row_pitch(fmt, width, row_align_bytes);
}
extern(C) int sg_query_surface_pitch(PixelFormat fmt, int width, int height, int row_align_bytes) @system @nogc nothrow pure;
int querySurfacePitch(PixelFormat fmt, int width, int height, int row_align_bytes) @trusted @nogc nothrow pure {
    return sg_query_surface_pitch(fmt, width, height, row_align_bytes);
}
/++
+ get current state of a resource (INITIAL, ALLOC, VALID, FAILED, INVALID)
+/
extern(C) ResourceState sg_query_buffer_state(Buffer buf) @system @nogc nothrow pure;
ResourceState queryBufferState(Buffer buf) @trusted @nogc nothrow pure {
    return sg_query_buffer_state(buf);
}
extern(C) ResourceState sg_query_image_state(Image img) @system @nogc nothrow pure;
ResourceState queryImageState(Image img) @trusted @nogc nothrow pure {
    return sg_query_image_state(img);
}
extern(C) ResourceState sg_query_sampler_state(Sampler smp) @system @nogc nothrow pure;
ResourceState querySamplerState(Sampler smp) @trusted @nogc nothrow pure {
    return sg_query_sampler_state(smp);
}
extern(C) ResourceState sg_query_shader_state(Shader shd) @system @nogc nothrow pure;
ResourceState queryShaderState(Shader shd) @trusted @nogc nothrow pure {
    return sg_query_shader_state(shd);
}
extern(C) ResourceState sg_query_pipeline_state(Pipeline pip) @system @nogc nothrow pure;
ResourceState queryPipelineState(Pipeline pip) @trusted @nogc nothrow pure {
    return sg_query_pipeline_state(pip);
}
extern(C) ResourceState sg_query_view_state(View view) @system @nogc nothrow pure;
ResourceState queryViewState(View view) @trusted @nogc nothrow pure {
    return sg_query_view_state(view);
}
/++
+ get runtime information about a resource
+/
extern(C) BufferInfo sg_query_buffer_info(Buffer buf) @system @nogc nothrow pure;
BufferInfo queryBufferInfo(Buffer buf) @trusted @nogc nothrow pure {
    return sg_query_buffer_info(buf);
}
extern(C) ImageInfo sg_query_image_info(Image img) @system @nogc nothrow pure;
ImageInfo queryImageInfo(Image img) @trusted @nogc nothrow pure {
    return sg_query_image_info(img);
}
extern(C) SamplerInfo sg_query_sampler_info(Sampler smp) @system @nogc nothrow pure;
SamplerInfo querySamplerInfo(Sampler smp) @trusted @nogc nothrow pure {
    return sg_query_sampler_info(smp);
}
extern(C) ShaderInfo sg_query_shader_info(Shader shd) @system @nogc nothrow pure;
ShaderInfo queryShaderInfo(Shader shd) @trusted @nogc nothrow pure {
    return sg_query_shader_info(shd);
}
extern(C) PipelineInfo sg_query_pipeline_info(Pipeline pip) @system @nogc nothrow pure;
PipelineInfo queryPipelineInfo(Pipeline pip) @trusted @nogc nothrow pure {
    return sg_query_pipeline_info(pip);
}
extern(C) ViewInfo sg_query_view_info(View view) @system @nogc nothrow pure;
ViewInfo queryViewInfo(View view) @trusted @nogc nothrow pure {
    return sg_query_view_info(view);
}
/++
+ get desc structs matching a specific resource (NOTE that not all creation attributes may be provided)
+/
extern(C) BufferDesc sg_query_buffer_desc(Buffer buf) @system @nogc nothrow pure;
BufferDesc queryBufferDesc(Buffer buf) @trusted @nogc nothrow pure {
    return sg_query_buffer_desc(buf);
}
extern(C) ImageDesc sg_query_image_desc(Image img) @system @nogc nothrow pure;
ImageDesc queryImageDesc(Image img) @trusted @nogc nothrow pure {
    return sg_query_image_desc(img);
}
extern(C) SamplerDesc sg_query_sampler_desc(Sampler smp) @system @nogc nothrow pure;
SamplerDesc querySamplerDesc(Sampler smp) @trusted @nogc nothrow pure {
    return sg_query_sampler_desc(smp);
}
extern(C) ShaderDesc sg_query_shader_desc(Shader shd) @system @nogc nothrow pure;
ShaderDesc queryShaderDesc(Shader shd) @trusted @nogc nothrow pure {
    return sg_query_shader_desc(shd);
}
extern(C) PipelineDesc sg_query_pipeline_desc(Pipeline pip) @system @nogc nothrow pure;
PipelineDesc queryPipelineDesc(Pipeline pip) @trusted @nogc nothrow pure {
    return sg_query_pipeline_desc(pip);
}
extern(C) ViewDesc sg_query_view_desc(View view) @system @nogc nothrow pure;
ViewDesc queryViewDesc(View view) @trusted @nogc nothrow pure {
    return sg_query_view_desc(view);
}
/++
+ get resource creation desc struct with their default values replaced
+/
extern(C) BufferDesc sg_query_buffer_defaults(const BufferDesc* desc) @system @nogc nothrow pure;
BufferDesc queryBufferDefaults(scope ref BufferDesc desc) @trusted @nogc nothrow pure {
    return sg_query_buffer_defaults(&desc);
}
extern(C) ImageDesc sg_query_image_defaults(const ImageDesc* desc) @system @nogc nothrow pure;
ImageDesc queryImageDefaults(scope ref ImageDesc desc) @trusted @nogc nothrow pure {
    return sg_query_image_defaults(&desc);
}
extern(C) SamplerDesc sg_query_sampler_defaults(const SamplerDesc* desc) @system @nogc nothrow pure;
SamplerDesc querySamplerDefaults(scope ref SamplerDesc desc) @trusted @nogc nothrow pure {
    return sg_query_sampler_defaults(&desc);
}
extern(C) ShaderDesc sg_query_shader_defaults(const ShaderDesc* desc) @system @nogc nothrow pure;
ShaderDesc queryShaderDefaults(scope ref ShaderDesc desc) @trusted @nogc nothrow pure {
    return sg_query_shader_defaults(&desc);
}
extern(C) PipelineDesc sg_query_pipeline_defaults(const PipelineDesc* desc) @system @nogc nothrow pure;
PipelineDesc queryPipelineDefaults(scope ref PipelineDesc desc) @trusted @nogc nothrow pure {
    return sg_query_pipeline_defaults(&desc);
}
extern(C) ViewDesc sg_query_view_defaults(const ViewDesc* desc) @system @nogc nothrow pure;
ViewDesc queryViewDefaults(scope ref ViewDesc desc) @trusted @nogc nothrow pure {
    return sg_query_view_defaults(&desc);
}
/++
+ assorted query functions
+/
extern(C) size_t sg_query_buffer_size(Buffer buf) @system @nogc nothrow pure;
size_t queryBufferSize(Buffer buf) @trusted @nogc nothrow pure {
    return sg_query_buffer_size(buf);
}
extern(C) BufferUsage sg_query_buffer_usage(Buffer buf) @system @nogc nothrow pure;
BufferUsage queryBufferUsage(Buffer buf) @trusted @nogc nothrow pure {
    return sg_query_buffer_usage(buf);
}
extern(C) ImageType sg_query_image_type(Image img) @system @nogc nothrow pure;
ImageType queryImageType(Image img) @trusted @nogc nothrow pure {
    return sg_query_image_type(img);
}
extern(C) int sg_query_image_width(Image img) @system @nogc nothrow pure;
int queryImageWidth(Image img) @trusted @nogc nothrow pure {
    return sg_query_image_width(img);
}
extern(C) int sg_query_image_height(Image img) @system @nogc nothrow pure;
int queryImageHeight(Image img) @trusted @nogc nothrow pure {
    return sg_query_image_height(img);
}
extern(C) int sg_query_image_num_slices(Image img) @system @nogc nothrow pure;
int queryImageNumSlices(Image img) @trusted @nogc nothrow pure {
    return sg_query_image_num_slices(img);
}
extern(C) int sg_query_image_num_mipmaps(Image img) @system @nogc nothrow pure;
int queryImageNumMipmaps(Image img) @trusted @nogc nothrow pure {
    return sg_query_image_num_mipmaps(img);
}
extern(C) PixelFormat sg_query_image_pixelformat(Image img) @system @nogc nothrow pure;
PixelFormat queryImagePixelformat(Image img) @trusted @nogc nothrow pure {
    return sg_query_image_pixelformat(img);
}
extern(C) ImageUsage sg_query_image_usage(Image img) @system @nogc nothrow pure;
ImageUsage queryImageUsage(Image img) @trusted @nogc nothrow pure {
    return sg_query_image_usage(img);
}
extern(C) int sg_query_image_sample_count(Image img) @system @nogc nothrow pure;
int queryImageSampleCount(Image img) @trusted @nogc nothrow pure {
    return sg_query_image_sample_count(img);
}
extern(C) ViewType sg_query_view_type(View view) @system @nogc nothrow pure;
ViewType queryViewType(View view) @trusted @nogc nothrow pure {
    return sg_query_view_type(view);
}
extern(C) Image sg_query_view_image(View view) @system @nogc nothrow pure;
Image queryViewImage(View view) @trusted @nogc nothrow pure {
    return sg_query_view_image(view);
}
extern(C) Buffer sg_query_view_buffer(View view) @system @nogc nothrow pure;
Buffer queryViewBuffer(View view) @trusted @nogc nothrow pure {
    return sg_query_view_buffer(view);
}
/++
+ separate resource allocation and initialization (for async setup)
+/
extern(C) Buffer sg_alloc_buffer() @system @nogc nothrow pure;
Buffer allocBuffer() @trusted @nogc nothrow pure {
    return sg_alloc_buffer();
}
extern(C) Image sg_alloc_image() @system @nogc nothrow pure;
Image allocImage() @trusted @nogc nothrow pure {
    return sg_alloc_image();
}
extern(C) Sampler sg_alloc_sampler() @system @nogc nothrow pure;
Sampler allocSampler() @trusted @nogc nothrow pure {
    return sg_alloc_sampler();
}
extern(C) Shader sg_alloc_shader() @system @nogc nothrow pure;
Shader allocShader() @trusted @nogc nothrow pure {
    return sg_alloc_shader();
}
extern(C) Pipeline sg_alloc_pipeline() @system @nogc nothrow pure;
Pipeline allocPipeline() @trusted @nogc nothrow pure {
    return sg_alloc_pipeline();
}
extern(C) View sg_alloc_view() @system @nogc nothrow pure;
View allocView() @trusted @nogc nothrow pure {
    return sg_alloc_view();
}
extern(C) void sg_dealloc_buffer(Buffer buf) @system @nogc nothrow pure;
void deallocBuffer(Buffer buf) @trusted @nogc nothrow pure {
    sg_dealloc_buffer(buf);
}
extern(C) void sg_dealloc_image(Image img) @system @nogc nothrow pure;
void deallocImage(Image img) @trusted @nogc nothrow pure {
    sg_dealloc_image(img);
}
extern(C) void sg_dealloc_sampler(Sampler smp) @system @nogc nothrow pure;
void deallocSampler(Sampler smp) @trusted @nogc nothrow pure {
    sg_dealloc_sampler(smp);
}
extern(C) void sg_dealloc_shader(Shader shd) @system @nogc nothrow pure;
void deallocShader(Shader shd) @trusted @nogc nothrow pure {
    sg_dealloc_shader(shd);
}
extern(C) void sg_dealloc_pipeline(Pipeline pip) @system @nogc nothrow pure;
void deallocPipeline(Pipeline pip) @trusted @nogc nothrow pure {
    sg_dealloc_pipeline(pip);
}
extern(C) void sg_dealloc_view(View view) @system @nogc nothrow pure;
void deallocView(View view) @trusted @nogc nothrow pure {
    sg_dealloc_view(view);
}
extern(C) void sg_init_buffer(Buffer buf, const BufferDesc* desc) @system @nogc nothrow pure;
void initBuffer(Buffer buf, scope ref BufferDesc desc) @trusted @nogc nothrow pure {
    sg_init_buffer(buf, &desc);
}
extern(C) void sg_init_image(Image img, const ImageDesc* desc) @system @nogc nothrow pure;
void initImage(Image img, scope ref ImageDesc desc) @trusted @nogc nothrow pure {
    sg_init_image(img, &desc);
}
extern(C) void sg_init_sampler(Sampler smg, const SamplerDesc* desc) @system @nogc nothrow pure;
void initSampler(Sampler smg, scope ref SamplerDesc desc) @trusted @nogc nothrow pure {
    sg_init_sampler(smg, &desc);
}
extern(C) void sg_init_shader(Shader shd, const ShaderDesc* desc) @system @nogc nothrow pure;
void initShader(Shader shd, scope ref ShaderDesc desc) @trusted @nogc nothrow pure {
    sg_init_shader(shd, &desc);
}
extern(C) void sg_init_pipeline(Pipeline pip, const PipelineDesc* desc) @system @nogc nothrow pure;
void initPipeline(Pipeline pip, scope ref PipelineDesc desc) @trusted @nogc nothrow pure {
    sg_init_pipeline(pip, &desc);
}
extern(C) void sg_init_view(View view, const ViewDesc* desc) @system @nogc nothrow pure;
void initView(View view, scope ref ViewDesc desc) @trusted @nogc nothrow pure {
    sg_init_view(view, &desc);
}
extern(C) void sg_uninit_buffer(Buffer buf) @system @nogc nothrow pure;
void uninitBuffer(Buffer buf) @trusted @nogc nothrow pure {
    sg_uninit_buffer(buf);
}
extern(C) void sg_uninit_image(Image img) @system @nogc nothrow pure;
void uninitImage(Image img) @trusted @nogc nothrow pure {
    sg_uninit_image(img);
}
extern(C) void sg_uninit_sampler(Sampler smp) @system @nogc nothrow pure;
void uninitSampler(Sampler smp) @trusted @nogc nothrow pure {
    sg_uninit_sampler(smp);
}
extern(C) void sg_uninit_shader(Shader shd) @system @nogc nothrow pure;
void uninitShader(Shader shd) @trusted @nogc nothrow pure {
    sg_uninit_shader(shd);
}
extern(C) void sg_uninit_pipeline(Pipeline pip) @system @nogc nothrow pure;
void uninitPipeline(Pipeline pip) @trusted @nogc nothrow pure {
    sg_uninit_pipeline(pip);
}
extern(C) void sg_uninit_view(View view) @system @nogc nothrow pure;
void uninitView(View view) @trusted @nogc nothrow pure {
    sg_uninit_view(view);
}
extern(C) void sg_fail_buffer(Buffer buf) @system @nogc nothrow pure;
void failBuffer(Buffer buf) @trusted @nogc nothrow pure {
    sg_fail_buffer(buf);
}
extern(C) void sg_fail_image(Image img) @system @nogc nothrow pure;
void failImage(Image img) @trusted @nogc nothrow pure {
    sg_fail_image(img);
}
extern(C) void sg_fail_sampler(Sampler smp) @system @nogc nothrow pure;
void failSampler(Sampler smp) @trusted @nogc nothrow pure {
    sg_fail_sampler(smp);
}
extern(C) void sg_fail_shader(Shader shd) @system @nogc nothrow pure;
void failShader(Shader shd) @trusted @nogc nothrow pure {
    sg_fail_shader(shd);
}
extern(C) void sg_fail_pipeline(Pipeline pip) @system @nogc nothrow pure;
void failPipeline(Pipeline pip) @trusted @nogc nothrow pure {
    sg_fail_pipeline(pip);
}
extern(C) void sg_fail_view(View view) @system @nogc nothrow pure;
void failView(View view) @trusted @nogc nothrow pure {
    sg_fail_view(view);
}
/++
+ frame stats
+/
extern(C) void sg_enable_frame_stats() @system @nogc nothrow pure;
void enableFrameStats() @trusted @nogc nothrow pure {
    sg_enable_frame_stats();
}
extern(C) void sg_disable_frame_stats() @system @nogc nothrow pure;
void disableFrameStats() @trusted @nogc nothrow pure {
    sg_disable_frame_stats();
}
extern(C) bool sg_frame_stats_enabled() @system @nogc nothrow pure;
bool frameStatsEnabled() @trusted @nogc nothrow pure {
    return sg_frame_stats_enabled();
}
extern(C) FrameStats sg_query_frame_stats() @system @nogc nothrow pure;
FrameStats queryFrameStats() @trusted @nogc nothrow pure {
    return sg_query_frame_stats();
}
/++
+ Backend-specific structs and functions, these may come in handy for mixing
+    sokol-gfx rendering with 'native backend' rendering functions.
+ 
+    This group of functions will be expanded as needed.
+/
extern(C) struct D3d11BufferInfo {
    const(void)* buf = null;
}
extern(C) struct D3d11ImageInfo {
    const(void)* tex2d = null;
    const(void)* tex3d = null;
    const(void)* res = null;
}
extern(C) struct D3d11SamplerInfo {
    const(void)* smp = null;
}
extern(C) struct D3d11ShaderInfo {
    const(void)*[8] cbufs = null;
    const(void)* vs = null;
    const(void)* fs = null;
}
extern(C) struct D3d11PipelineInfo {
    const(void)* il = null;
    const(void)* rs = null;
    const(void)* dss = null;
    const(void)* bs = null;
}
extern(C) struct D3d11ViewInfo {
    const(void)* srv = null;
    const(void)* uav = null;
    const(void)* rtv = null;
    const(void)* dsv = null;
}
extern(C) struct MtlBufferInfo {
    const(void)*[2] buf = null;
    int active_slot = 0;
}
extern(C) struct MtlImageInfo {
    const(void)*[2] tex = null;
    int active_slot = 0;
}
extern(C) struct MtlSamplerInfo {
    const(void)* smp = null;
}
extern(C) struct MtlShaderInfo {
    const(void)* vertex_lib = null;
    const(void)* fragment_lib = null;
    const(void)* vertex_func = null;
    const(void)* fragment_func = null;
}
extern(C) struct MtlPipelineInfo {
    const(void)* rps = null;
    const(void)* dss = null;
}
extern(C) struct WgpuBufferInfo {
    const(void)* buf = null;
}
extern(C) struct WgpuImageInfo {
    const(void)* tex = null;
}
extern(C) struct WgpuSamplerInfo {
    const(void)* smp = null;
}
extern(C) struct WgpuShaderInfo {
    const(void)* vs_mod = null;
    const(void)* fs_mod = null;
    const(void)* bgl = null;
}
extern(C) struct WgpuPipelineInfo {
    const(void)* render_pipeline = null;
    const(void)* compute_pipeline = null;
}
extern(C) struct WgpuViewInfo {
    const(void)* view = null;
}
extern(C) struct GlBufferInfo {
    uint[2] buf = [0, 0];
    int active_slot = 0;
}
extern(C) struct GlImageInfo {
    uint[2] tex = [0, 0];
    uint tex_target = 0;
    int active_slot = 0;
}
extern(C) struct GlSamplerInfo {
    uint smp = 0;
}
extern(C) struct GlShaderInfo {
    uint prog = 0;
}
extern(C) struct GlViewInfo {
    uint[2] tex_view = [0, 0];
    uint msaa_render_buffer = 0;
    uint msaa_resolve_frame_buffer = 0;
}
/++
+ D3D11: return ID3D11Device
+/
extern(C) const(void)* sg_d3d11_device() @system @nogc nothrow pure;
const(void)* d3d11Device() @trusted @nogc nothrow pure {
    return sg_d3d11_device();
}
/++
+ D3D11: return ID3D11DeviceContext
+/
extern(C) const(void)* sg_d3d11_device_context() @system @nogc nothrow pure;
const(void)* d3d11DeviceContext() @trusted @nogc nothrow pure {
    return sg_d3d11_device_context();
}
/++
+ D3D11: get internal buffer resource objects
+/
extern(C) D3d11BufferInfo sg_d3d11_query_buffer_info(Buffer buf) @system @nogc nothrow pure;
D3d11BufferInfo d3d11QueryBufferInfo(Buffer buf) @trusted @nogc nothrow pure {
    return sg_d3d11_query_buffer_info(buf);
}
/++
+ D3D11: get internal image resource objects
+/
extern(C) D3d11ImageInfo sg_d3d11_query_image_info(Image img) @system @nogc nothrow pure;
D3d11ImageInfo d3d11QueryImageInfo(Image img) @trusted @nogc nothrow pure {
    return sg_d3d11_query_image_info(img);
}
/++
+ D3D11: get internal sampler resource objects
+/
extern(C) D3d11SamplerInfo sg_d3d11_query_sampler_info(Sampler smp) @system @nogc nothrow pure;
D3d11SamplerInfo d3d11QuerySamplerInfo(Sampler smp) @trusted @nogc nothrow pure {
    return sg_d3d11_query_sampler_info(smp);
}
/++
+ D3D11: get internal shader resource objects
+/
extern(C) D3d11ShaderInfo sg_d3d11_query_shader_info(Shader shd) @system @nogc nothrow pure;
D3d11ShaderInfo d3d11QueryShaderInfo(Shader shd) @trusted @nogc nothrow pure {
    return sg_d3d11_query_shader_info(shd);
}
/++
+ D3D11: get internal pipeline resource objects
+/
extern(C) D3d11PipelineInfo sg_d3d11_query_pipeline_info(Pipeline pip) @system @nogc nothrow pure;
D3d11PipelineInfo d3d11QueryPipelineInfo(Pipeline pip) @trusted @nogc nothrow pure {
    return sg_d3d11_query_pipeline_info(pip);
}
/++
+ D3D11: get internal view resource objects
+/
extern(C) D3d11ViewInfo sg_d3d11_query_view_info(View view) @system @nogc nothrow pure;
D3d11ViewInfo d3d11QueryViewInfo(View view) @trusted @nogc nothrow pure {
    return sg_d3d11_query_view_info(view);
}
/++
+ Metal: return __bridge-casted MTLDevice
+/
extern(C) const(void)* sg_mtl_device() @system @nogc nothrow pure;
const(void)* mtlDevice() @trusted @nogc nothrow pure {
    return sg_mtl_device();
}
/++
+ Metal: return __bridge-casted MTLRenderCommandEncoder when inside render pass (otherwise zero)
+/
extern(C) const(void)* sg_mtl_render_command_encoder() @system @nogc nothrow pure;
const(void)* mtlRenderCommandEncoder() @trusted @nogc nothrow pure {
    return sg_mtl_render_command_encoder();
}
/++
+ Metal: return __bridge-casted MTLComputeCommandEncoder when inside compute pass (otherwise zero)
+/
extern(C) const(void)* sg_mtl_compute_command_encoder() @system @nogc nothrow pure;
const(void)* mtlComputeCommandEncoder() @trusted @nogc nothrow pure {
    return sg_mtl_compute_command_encoder();
}
/++
+ Metal: get internal __bridge-casted buffer resource objects
+/
extern(C) MtlBufferInfo sg_mtl_query_buffer_info(Buffer buf) @system @nogc nothrow pure;
MtlBufferInfo mtlQueryBufferInfo(Buffer buf) @trusted @nogc nothrow pure {
    return sg_mtl_query_buffer_info(buf);
}
/++
+ Metal: get internal __bridge-casted image resource objects
+/
extern(C) MtlImageInfo sg_mtl_query_image_info(Image img) @system @nogc nothrow pure;
MtlImageInfo mtlQueryImageInfo(Image img) @trusted @nogc nothrow pure {
    return sg_mtl_query_image_info(img);
}
/++
+ Metal: get internal __bridge-casted sampler resource objects
+/
extern(C) MtlSamplerInfo sg_mtl_query_sampler_info(Sampler smp) @system @nogc nothrow pure;
MtlSamplerInfo mtlQuerySamplerInfo(Sampler smp) @trusted @nogc nothrow pure {
    return sg_mtl_query_sampler_info(smp);
}
/++
+ Metal: get internal __bridge-casted shader resource objects
+/
extern(C) MtlShaderInfo sg_mtl_query_shader_info(Shader shd) @system @nogc nothrow pure;
MtlShaderInfo mtlQueryShaderInfo(Shader shd) @trusted @nogc nothrow pure {
    return sg_mtl_query_shader_info(shd);
}
/++
+ Metal: get internal __bridge-casted pipeline resource objects
+/
extern(C) MtlPipelineInfo sg_mtl_query_pipeline_info(Pipeline pip) @system @nogc nothrow pure;
MtlPipelineInfo mtlQueryPipelineInfo(Pipeline pip) @trusted @nogc nothrow pure {
    return sg_mtl_query_pipeline_info(pip);
}
/++
+ WebGPU: return WGPUDevice object
+/
extern(C) const(void)* sg_wgpu_device() @system @nogc nothrow pure;
const(void)* wgpuDevice() @trusted @nogc nothrow pure {
    return sg_wgpu_device();
}
/++
+ WebGPU: return WGPUQueue object
+/
extern(C) const(void)* sg_wgpu_queue() @system @nogc nothrow pure;
const(void)* wgpuQueue() @trusted @nogc nothrow pure {
    return sg_wgpu_queue();
}
/++
+ WebGPU: return this frame's WGPUCommandEncoder
+/
extern(C) const(void)* sg_wgpu_command_encoder() @system @nogc nothrow pure;
const(void)* wgpuCommandEncoder() @trusted @nogc nothrow pure {
    return sg_wgpu_command_encoder();
}
/++
+ WebGPU: return WGPURenderPassEncoder of current pass (returns 0 when outside pass or in a compute pass)
+/
extern(C) const(void)* sg_wgpu_render_pass_encoder() @system @nogc nothrow pure;
const(void)* wgpuRenderPassEncoder() @trusted @nogc nothrow pure {
    return sg_wgpu_render_pass_encoder();
}
/++
+ WebGPU: return WGPUComputePassEncoder of current pass (returns 0 when outside pass or in a render pass)
+/
extern(C) const(void)* sg_wgpu_compute_pass_encoder() @system @nogc nothrow pure;
const(void)* wgpuComputePassEncoder() @trusted @nogc nothrow pure {
    return sg_wgpu_compute_pass_encoder();
}
/++
+ WebGPU: get internal buffer resource objects
+/
extern(C) WgpuBufferInfo sg_wgpu_query_buffer_info(Buffer buf) @system @nogc nothrow pure;
WgpuBufferInfo wgpuQueryBufferInfo(Buffer buf) @trusted @nogc nothrow pure {
    return sg_wgpu_query_buffer_info(buf);
}
/++
+ WebGPU: get internal image resource objects
+/
extern(C) WgpuImageInfo sg_wgpu_query_image_info(Image img) @system @nogc nothrow pure;
WgpuImageInfo wgpuQueryImageInfo(Image img) @trusted @nogc nothrow pure {
    return sg_wgpu_query_image_info(img);
}
/++
+ WebGPU: get internal sampler resource objects
+/
extern(C) WgpuSamplerInfo sg_wgpu_query_sampler_info(Sampler smp) @system @nogc nothrow pure;
WgpuSamplerInfo wgpuQuerySamplerInfo(Sampler smp) @trusted @nogc nothrow pure {
    return sg_wgpu_query_sampler_info(smp);
}
/++
+ WebGPU: get internal shader resource objects
+/
extern(C) WgpuShaderInfo sg_wgpu_query_shader_info(Shader shd) @system @nogc nothrow pure;
WgpuShaderInfo wgpuQueryShaderInfo(Shader shd) @trusted @nogc nothrow pure {
    return sg_wgpu_query_shader_info(shd);
}
/++
+ WebGPU: get internal pipeline resource objects
+/
extern(C) WgpuPipelineInfo sg_wgpu_query_pipeline_info(Pipeline pip) @system @nogc nothrow pure;
WgpuPipelineInfo wgpuQueryPipelineInfo(Pipeline pip) @trusted @nogc nothrow pure {
    return sg_wgpu_query_pipeline_info(pip);
}
/++
+ WebGPU: get internal view resource objects
+/
extern(C) WgpuViewInfo sg_wgpu_query_view_info(View view) @system @nogc nothrow pure;
WgpuViewInfo wgpuQueryViewInfo(View view) @trusted @nogc nothrow pure {
    return sg_wgpu_query_view_info(view);
}
/++
+ GL: get internal buffer resource objects
+/
extern(C) GlBufferInfo sg_gl_query_buffer_info(Buffer buf) @system @nogc nothrow pure;
GlBufferInfo glQueryBufferInfo(Buffer buf) @trusted @nogc nothrow pure {
    return sg_gl_query_buffer_info(buf);
}
/++
+ GL: get internal image resource objects
+/
extern(C) GlImageInfo sg_gl_query_image_info(Image img) @system @nogc nothrow pure;
GlImageInfo glQueryImageInfo(Image img) @trusted @nogc nothrow pure {
    return sg_gl_query_image_info(img);
}
/++
+ GL: get internal sampler resource objects
+/
extern(C) GlSamplerInfo sg_gl_query_sampler_info(Sampler smp) @system @nogc nothrow pure;
GlSamplerInfo glQuerySamplerInfo(Sampler smp) @trusted @nogc nothrow pure {
    return sg_gl_query_sampler_info(smp);
}
/++
+ GL: get internal shader resource objects
+/
extern(C) GlShaderInfo sg_gl_query_shader_info(Shader shd) @system @nogc nothrow pure;
GlShaderInfo glQueryShaderInfo(Shader shd) @trusted @nogc nothrow pure {
    return sg_gl_query_shader_info(shd);
}
/++
+ GL: get internal view resource objects
+/
extern(C) GlViewInfo sg_gl_query_view_info(View view) @system @nogc nothrow pure;
GlViewInfo glQueryViewInfo(View view) @trusted @nogc nothrow pure {
    return sg_gl_query_view_info(view);
}
