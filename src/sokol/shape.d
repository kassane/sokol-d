// machine generated, do not edit

module sokol.shape;
import sg = sokol.gfx;

// helper functions
import sokol.utils: cStrTod;


// WIP: helper function to convert "anything" to a Range struct
Range asRange(T)(T val) @trusted {
    import std.traits;
    static if (isPointer!T) {
       return Range(val, T.sizeof);
    } else static if (is(T == float[]) || is(T == double[])) {
       auto arr = val.dup;
       return Range(&arr[0], arr.length * arr[0].sizeof);
    } else static if (is(T == struct)) {
       Range r = {ptr: cast(const(void)*)&val, size: T.sizeof};
       return r;
    } else {
       static assert(0, "Cannot convert to range");
    }
}

extern(C)
struct Range {
    const(void)* ptr;
    size_t size;
}
extern(C)
struct Mat4 {
    float[4][4] m;
}
extern(C)
struct Vertex {
    float x;
    float y;
    float z;
    uint normal;
    ushort u;
    ushort v;
    uint color;
}
extern(C)
struct ElementRange {
    uint base_element;
    uint num_elements;
}
extern(C)
struct SizesItem {
    uint num;
    uint size;
}
extern(C)
struct Sizes {
    SizesItem vertices;
    SizesItem indices;
}
extern(C)
struct BufferItem {
    Range buffer;
    size_t data_size;
    size_t shape_offset;
}
extern(C)
struct Buffer {
    bool valid;
    BufferItem vertices;
    BufferItem indices;
}
extern(C)
struct Plane {
    float width;
    float depth;
    ushort tiles;
    uint color;
    bool random_colors;
    bool merge;
    Mat4 transform;
}
extern(C)
struct Box {
    float width;
    float height;
    float depth;
    ushort tiles;
    uint color;
    bool random_colors;
    bool merge;
    Mat4 transform;
}
extern(C)
struct Sphere {
    float radius;
    ushort slices;
    ushort stacks;
    uint color;
    bool random_colors;
    bool merge;
    Mat4 transform;
}
extern(C)
struct Cylinder {
    float radius;
    float height;
    ushort slices;
    ushort stacks;
    uint color;
    bool random_colors;
    bool merge;
    Mat4 transform;
}
extern(C)
struct Torus {
    float radius;
    float ring_radius;
    ushort sides;
    ushort rings;
    uint color;
    bool random_colors;
    bool merge;
    Mat4 transform;
}
extern(C) Buffer sshape_build_plane(const Buffer *, const Plane *) @system @nogc nothrow;
Buffer buildPlane(ref Buffer buf, ref Plane params) @trusted nothrow {
    return sshape_build_plane(&buf, &params);
}
extern(C) Buffer sshape_build_box(const Buffer *, const Box *) @system @nogc nothrow;
Buffer buildBox(ref Buffer buf, ref Box params) @trusted nothrow {
    return sshape_build_box(&buf, &params);
}
extern(C) Buffer sshape_build_sphere(const Buffer *, const Sphere *) @system @nogc nothrow;
Buffer buildSphere(ref Buffer buf, ref Sphere params) @trusted nothrow {
    return sshape_build_sphere(&buf, &params);
}
extern(C) Buffer sshape_build_cylinder(const Buffer *, const Cylinder *) @system @nogc nothrow;
Buffer buildCylinder(ref Buffer buf, ref Cylinder params) @trusted nothrow {
    return sshape_build_cylinder(&buf, &params);
}
extern(C) Buffer sshape_build_torus(const Buffer *, const Torus *) @system @nogc nothrow;
Buffer buildTorus(ref Buffer buf, ref Torus params) @trusted nothrow {
    return sshape_build_torus(&buf, &params);
}
extern(C) Sizes sshape_plane_sizes(uint) @system @nogc nothrow;
Sizes planeSizes(uint tiles) @trusted nothrow {
    return sshape_plane_sizes(tiles);
}
extern(C) Sizes sshape_box_sizes(uint) @system @nogc nothrow;
Sizes boxSizes(uint tiles) @trusted nothrow {
    return sshape_box_sizes(tiles);
}
extern(C) Sizes sshape_sphere_sizes(uint, uint) @system @nogc nothrow;
Sizes sphereSizes(uint slices, uint stacks) @trusted nothrow {
    return sshape_sphere_sizes(slices, stacks);
}
extern(C) Sizes sshape_cylinder_sizes(uint, uint) @system @nogc nothrow;
Sizes cylinderSizes(uint slices, uint stacks) @trusted nothrow {
    return sshape_cylinder_sizes(slices, stacks);
}
extern(C) Sizes sshape_torus_sizes(uint, uint) @system @nogc nothrow;
Sizes torusSizes(uint sides, uint rings) @trusted nothrow {
    return sshape_torus_sizes(sides, rings);
}
extern(C) ElementRange sshape_element_range(const Buffer *) @system @nogc nothrow;
ElementRange elementRange(ref Buffer buf) @trusted nothrow {
    return sshape_element_range(&buf);
}
extern(C) sg.BufferDesc sshape_vertex_buffer_desc(const Buffer *) @system @nogc nothrow;
sg.BufferDesc vertexBufferDesc(ref Buffer buf) @trusted nothrow {
    return sshape_vertex_buffer_desc(&buf);
}
extern(C) sg.BufferDesc sshape_index_buffer_desc(const Buffer *) @system @nogc nothrow;
sg.BufferDesc indexBufferDesc(ref Buffer buf) @trusted nothrow {
    return sshape_index_buffer_desc(&buf);
}
extern(C) sg.VertexBufferLayoutState sshape_vertex_buffer_layout_state() @system @nogc nothrow;
sg.VertexBufferLayoutState vertexBufferLayoutState() @trusted nothrow {
    return sshape_vertex_buffer_layout_state();
}
extern(C) sg.VertexAttrState sshape_position_vertex_attr_state() @system @nogc nothrow;
sg.VertexAttrState positionVertexAttrState() @trusted nothrow {
    return sshape_position_vertex_attr_state();
}
extern(C) sg.VertexAttrState sshape_normal_vertex_attr_state() @system @nogc nothrow;
sg.VertexAttrState normalVertexAttrState() @trusted nothrow {
    return sshape_normal_vertex_attr_state();
}
extern(C) sg.VertexAttrState sshape_texcoord_vertex_attr_state() @system @nogc nothrow;
sg.VertexAttrState texcoordVertexAttrState() @trusted nothrow {
    return sshape_texcoord_vertex_attr_state();
}
extern(C) sg.VertexAttrState sshape_color_vertex_attr_state() @system @nogc nothrow;
sg.VertexAttrState colorVertexAttrState() @trusted nothrow {
    return sshape_color_vertex_attr_state();
}
extern(C) uint sshape_color_4f(float, float, float, float) @system @nogc nothrow;
uint color4f(float r, float g, float b, float a) @trusted nothrow {
    return sshape_color_4f(r, g, b, a);
}
extern(C) uint sshape_color_3f(float, float, float) @system @nogc nothrow;
uint color3f(float r, float g, float b) @trusted nothrow {
    return sshape_color_3f(r, g, b);
}
extern(C) uint sshape_color_4b(ubyte, ubyte, ubyte, ubyte) @system @nogc nothrow;
uint color4b(ubyte r, ubyte g, ubyte b, ubyte a) @trusted nothrow {
    return sshape_color_4b(r, g, b, a);
}
extern(C) uint sshape_color_3b(ubyte, ubyte, ubyte) @system @nogc nothrow;
uint color3b(ubyte r, ubyte g, ubyte b) @trusted nothrow {
    return sshape_color_3b(r, g, b);
}
extern(C) Mat4 sshape_mat4(const float *) @system @nogc nothrow;
Mat4 mat4(const float * m) @trusted nothrow {
    return sshape_mat4(m);
}
extern(C) Mat4 sshape_mat4_transpose(const float *) @system @nogc nothrow;
Mat4 mat4Transpose(const float * m) @trusted nothrow {
    return sshape_mat4_transpose(m);
}
