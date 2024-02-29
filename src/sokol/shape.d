// machine generated, do not edit

module sokol.shape;
import sg = sokol.gfx;

extern(C)
struct Range {
    const(void)* ptr = null;
    size_t size = 0;
}
extern(C)
struct Mat4 {
    float[4][4] m = 0.0f;
}
extern(C)
struct Vertex {
    float x = 0.0f;
    float y = 0.0f;
    float z = 0.0f;
    uint normal = 0;
    ushort u = 0;
    ushort v = 0;
    uint color = 0;
}
extern(C)
struct ElementRange {
    uint base_element = 0;
    uint num_elements = 0;
}
extern(C)
struct SizesItem {
    uint num = 0;
    uint size = 0;
}
extern(C)
struct Sizes {
    SizesItem vertices;
    SizesItem indices;
}
extern(C)
struct BufferItem {
    Range buffer;
    size_t data_size = 0;
    size_t shape_offset = 0;
}
extern(C)
struct Buffer {
    bool valid = false;
    BufferItem vertices;
    BufferItem indices;
}
extern(C)
struct Plane {
    float width = 0.0f;
    float depth = 0.0f;
    ushort tiles = 0;
    uint color = 0;
    bool random_colors = false;
    bool merge = false;
    Mat4 transform;
}
extern(C)
struct Box {
    float width = 0.0f;
    float height = 0.0f;
    float depth = 0.0f;
    ushort tiles = 0;
    uint color = 0;
    bool random_colors = false;
    bool merge = false;
    Mat4 transform;
}
extern(C)
struct Sphere {
    float radius = 0.0f;
    ushort slices = 0;
    ushort stacks = 0;
    uint color = 0;
    bool random_colors = false;
    bool merge = false;
    Mat4 transform;
}
extern(C)
struct Cylinder {
    float radius = 0.0f;
    float height = 0.0f;
    ushort slices = 0;
    ushort stacks = 0;
    uint color = 0;
    bool random_colors = false;
    bool merge = false;
    Mat4 transform;
}
extern(C)
struct Torus {
    float radius = 0.0f;
    float ring_radius = 0.0f;
    ushort sides = 0;
    ushort rings = 0;
    uint color = 0;
    bool random_colors = false;
    bool merge = false;
    Mat4 transform;
}
extern(C) Buffer sshape_build_plane(const Buffer *, const Plane *) @system @nogc nothrow;
Buffer buildPlane(ref Buffer buf, ref Plane params) @trusted @nogc nothrow {
    return sshape_build_plane(&buf, &params);
}
extern(C) Buffer sshape_build_box(const Buffer *, const Box *) @system @nogc nothrow;
Buffer buildBox(ref Buffer buf, ref Box params) @trusted @nogc nothrow {
    return sshape_build_box(&buf, &params);
}
extern(C) Buffer sshape_build_sphere(const Buffer *, const Sphere *) @system @nogc nothrow;
Buffer buildSphere(ref Buffer buf, ref Sphere params) @trusted @nogc nothrow {
    return sshape_build_sphere(&buf, &params);
}
extern(C) Buffer sshape_build_cylinder(const Buffer *, const Cylinder *) @system @nogc nothrow;
Buffer buildCylinder(ref Buffer buf, ref Cylinder params) @trusted @nogc nothrow {
    return sshape_build_cylinder(&buf, &params);
}
extern(C) Buffer sshape_build_torus(const Buffer *, const Torus *) @system @nogc nothrow;
Buffer buildTorus(ref Buffer buf, ref Torus params) @trusted @nogc nothrow {
    return sshape_build_torus(&buf, &params);
}
extern(C) Sizes sshape_plane_sizes(uint) @system @nogc nothrow;
Sizes planeSizes(uint tiles) @trusted @nogc nothrow {
    return sshape_plane_sizes(tiles);
}
extern(C) Sizes sshape_box_sizes(uint) @system @nogc nothrow;
Sizes boxSizes(uint tiles) @trusted @nogc nothrow {
    return sshape_box_sizes(tiles);
}
extern(C) Sizes sshape_sphere_sizes(uint, uint) @system @nogc nothrow;
Sizes sphereSizes(uint slices, uint stacks) @trusted @nogc nothrow {
    return sshape_sphere_sizes(slices, stacks);
}
extern(C) Sizes sshape_cylinder_sizes(uint, uint) @system @nogc nothrow;
Sizes cylinderSizes(uint slices, uint stacks) @trusted @nogc nothrow {
    return sshape_cylinder_sizes(slices, stacks);
}
extern(C) Sizes sshape_torus_sizes(uint, uint) @system @nogc nothrow;
Sizes torusSizes(uint sides, uint rings) @trusted @nogc nothrow {
    return sshape_torus_sizes(sides, rings);
}
extern(C) ElementRange sshape_element_range(const Buffer *) @system @nogc nothrow;
ElementRange elementRange(ref Buffer buf) @trusted @nogc nothrow {
    return sshape_element_range(&buf);
}
extern(C) sg.BufferDesc sshape_vertex_buffer_desc(const Buffer *) @system @nogc nothrow;
sg.BufferDesc vertexBufferDesc(ref Buffer buf) @trusted @nogc nothrow {
    return sshape_vertex_buffer_desc(&buf);
}
extern(C) sg.BufferDesc sshape_index_buffer_desc(const Buffer *) @system @nogc nothrow;
sg.BufferDesc indexBufferDesc(ref Buffer buf) @trusted @nogc nothrow {
    return sshape_index_buffer_desc(&buf);
}
extern(C) sg.VertexBufferLayoutState sshape_vertex_buffer_layout_state() @system @nogc nothrow;
sg.VertexBufferLayoutState vertexBufferLayoutState() @trusted @nogc nothrow {
    return sshape_vertex_buffer_layout_state();
}
extern(C) sg.VertexAttrState sshape_position_vertex_attr_state() @system @nogc nothrow;
sg.VertexAttrState positionVertexAttrState() @trusted @nogc nothrow {
    return sshape_position_vertex_attr_state();
}
extern(C) sg.VertexAttrState sshape_normal_vertex_attr_state() @system @nogc nothrow;
sg.VertexAttrState normalVertexAttrState() @trusted @nogc nothrow {
    return sshape_normal_vertex_attr_state();
}
extern(C) sg.VertexAttrState sshape_texcoord_vertex_attr_state() @system @nogc nothrow;
sg.VertexAttrState texcoordVertexAttrState() @trusted @nogc nothrow {
    return sshape_texcoord_vertex_attr_state();
}
extern(C) sg.VertexAttrState sshape_color_vertex_attr_state() @system @nogc nothrow;
sg.VertexAttrState colorVertexAttrState() @trusted @nogc nothrow {
    return sshape_color_vertex_attr_state();
}
extern(C) uint sshape_color_4f(float, float, float, float) @system @nogc nothrow;
uint color4f(float r, float g, float b, float a) @trusted @nogc nothrow {
    return sshape_color_4f(r, g, b, a);
}
extern(C) uint sshape_color_3f(float, float, float) @system @nogc nothrow;
uint color3f(float r, float g, float b) @trusted @nogc nothrow {
    return sshape_color_3f(r, g, b);
}
extern(C) uint sshape_color_4b(ubyte, ubyte, ubyte, ubyte) @system @nogc nothrow;
uint color4b(ubyte r, ubyte g, ubyte b, ubyte a) @trusted @nogc nothrow {
    return sshape_color_4b(r, g, b, a);
}
extern(C) uint sshape_color_3b(ubyte, ubyte, ubyte) @system @nogc nothrow;
uint color3b(ubyte r, ubyte g, ubyte b) @trusted @nogc nothrow {
    return sshape_color_3b(r, g, b);
}
extern(C) Mat4 sshape_mat4(const float *) @system @nogc nothrow;
Mat4 mat4(const float * m) @trusted @nogc nothrow {
    return sshape_mat4(m);
}
extern(C) Mat4 sshape_mat4_transpose(const float *) @system @nogc nothrow;
Mat4 mat4Transpose(const float * m) @trusted @nogc nothrow {
    return sshape_mat4_transpose(m);
}
