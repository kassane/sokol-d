/++
+ Machine generated D bindings for Sokol library.
+ 
+     Source header: sokol_shape.h
+     Module: sokol.shape
+ 
+     Do not edit manually; regenerate using gen_d.py.
+/
module sokol.shape;
import sg = sokol.gfx;

/++
+ sshape_range is a pointer-size-pair struct used to pass memory
+     blobs into sokol-shape. When initialized from a value type
+     (array or struct), use the SSHAPE_RANGE() macro to build
+     an sshape_range struct.
+/
extern(C) struct Range {
    const(void)* ptr = null;
    size_t size = 0;
}
/++
+ a 4x4 matrix wrapper struct
+/
extern(C) struct Mat4 {
    float[4][4] m = [0.0f, 0.0f, 0.0f, 0.0f];
}
/++
+ vertex layout of the generated geometry
+/
extern(C) struct Vertex {
    float x = 0.0f;
    float y = 0.0f;
    float z = 0.0f;
    uint normal = 0;
    ushort u = 0;
    ushort v = 0;
    uint color = 0;
}
/++
+ a range of draw-elements (sg_draw(int base_element, int num_element, ...))
+/
extern(C) struct ElementRange {
    uint base_element = 0;
    uint num_elements = 0;
}
/++
+ number of elements and byte size of build actions
+/
extern(C) struct SizesItem {
    uint num = 0;
    uint size = 0;
}
extern(C) struct Sizes {
    SizesItem vertices = {};
    SizesItem indices = {};
}
/++
+ in/out struct to keep track of mesh-build state
+/
extern(C) struct BufferItem {
    Range buffer = {};
    size_t data_size = 0;
    size_t shape_offset = 0;
}
extern(C) struct Buffer {
    bool valid = false;
    BufferItem vertices = {};
    BufferItem indices = {};
}
/++
+ creation parameters for the different shape types
+/
extern(C) struct Plane {
    float width = 0.0f;
    float depth = 0.0f;
    ushort tiles = 0;
    uint color = 0;
    bool random_colors = false;
    bool merge = false;
    Mat4 transform = {};
}
extern(C) struct Box {
    float width = 0.0f;
    float height = 0.0f;
    float depth = 0.0f;
    ushort tiles = 0;
    uint color = 0;
    bool random_colors = false;
    bool merge = false;
    Mat4 transform = {};
}
extern(C) struct Sphere {
    float radius = 0.0f;
    ushort slices = 0;
    ushort stacks = 0;
    uint color = 0;
    bool random_colors = false;
    bool merge = false;
    Mat4 transform = {};
}
extern(C) struct Cylinder {
    float radius = 0.0f;
    float height = 0.0f;
    ushort slices = 0;
    ushort stacks = 0;
    uint color = 0;
    bool random_colors = false;
    bool merge = false;
    Mat4 transform = {};
}
extern(C) struct Torus {
    float radius = 0.0f;
    float ring_radius = 0.0f;
    ushort sides = 0;
    ushort rings = 0;
    uint color = 0;
    bool random_colors = false;
    bool merge = false;
    Mat4 transform = {};
}
/++
+ shape builder functions
+/
extern(C) Buffer sshape_build_plane(const Buffer* buf, const Plane* params) @system @nogc nothrow pure;
Buffer buildPlane(scope ref Buffer buf, scope ref Plane params) @trusted @nogc nothrow pure {
    return sshape_build_plane(&buf, &params);
}
extern(C) Buffer sshape_build_box(const Buffer* buf, const Box* params) @system @nogc nothrow pure;
Buffer buildBox(scope ref Buffer buf, scope ref Box params) @trusted @nogc nothrow pure {
    return sshape_build_box(&buf, &params);
}
extern(C) Buffer sshape_build_sphere(const Buffer* buf, const Sphere* params) @system @nogc nothrow pure;
Buffer buildSphere(scope ref Buffer buf, scope ref Sphere params) @trusted @nogc nothrow pure {
    return sshape_build_sphere(&buf, &params);
}
extern(C) Buffer sshape_build_cylinder(const Buffer* buf, const Cylinder* params) @system @nogc nothrow pure;
Buffer buildCylinder(scope ref Buffer buf, scope ref Cylinder params) @trusted @nogc nothrow pure {
    return sshape_build_cylinder(&buf, &params);
}
extern(C) Buffer sshape_build_torus(const Buffer* buf, const Torus* params) @system @nogc nothrow pure;
Buffer buildTorus(scope ref Buffer buf, scope ref Torus params) @trusted @nogc nothrow pure {
    return sshape_build_torus(&buf, &params);
}
/++
+ query required vertex- and index-buffer sizes in bytes
+/
extern(C) Sizes sshape_plane_sizes(uint tiles) @system @nogc nothrow pure;
Sizes planeSizes(uint tiles) @trusted @nogc nothrow pure {
    return sshape_plane_sizes(tiles);
}
extern(C) Sizes sshape_box_sizes(uint tiles) @system @nogc nothrow pure;
Sizes boxSizes(uint tiles) @trusted @nogc nothrow pure {
    return sshape_box_sizes(tiles);
}
extern(C) Sizes sshape_sphere_sizes(uint slices, uint stacks) @system @nogc nothrow pure;
Sizes sphereSizes(uint slices, uint stacks) @trusted @nogc nothrow pure {
    return sshape_sphere_sizes(slices, stacks);
}
extern(C) Sizes sshape_cylinder_sizes(uint slices, uint stacks) @system @nogc nothrow pure;
Sizes cylinderSizes(uint slices, uint stacks) @trusted @nogc nothrow pure {
    return sshape_cylinder_sizes(slices, stacks);
}
extern(C) Sizes sshape_torus_sizes(uint sides, uint rings) @system @nogc nothrow pure;
Sizes torusSizes(uint sides, uint rings) @trusted @nogc nothrow pure {
    return sshape_torus_sizes(sides, rings);
}
/++
+ extract sokol-gfx desc structs and primitive ranges from build state
+/
extern(C) ElementRange sshape_element_range(const Buffer* buf) @system @nogc nothrow pure;
ElementRange elementRange(scope ref Buffer buf) @trusted @nogc nothrow pure {
    return sshape_element_range(&buf);
}
extern(C) sg.BufferDesc sshape_vertex_buffer_desc(const Buffer* buf) @system @nogc nothrow pure;
sg.BufferDesc vertexBufferDesc(scope ref Buffer buf) @trusted @nogc nothrow pure {
    return sshape_vertex_buffer_desc(&buf);
}
extern(C) sg.BufferDesc sshape_index_buffer_desc(const Buffer* buf) @system @nogc nothrow pure;
sg.BufferDesc indexBufferDesc(scope ref Buffer buf) @trusted @nogc nothrow pure {
    return sshape_index_buffer_desc(&buf);
}
extern(C) sg.VertexBufferLayoutState sshape_vertex_buffer_layout_state() @system @nogc nothrow pure;
sg.VertexBufferLayoutState vertexBufferLayoutState() @trusted @nogc nothrow pure {
    return sshape_vertex_buffer_layout_state();
}
extern(C) sg.VertexAttrState sshape_position_vertex_attr_state() @system @nogc nothrow pure;
sg.VertexAttrState positionVertexAttrState() @trusted @nogc nothrow pure {
    return sshape_position_vertex_attr_state();
}
extern(C) sg.VertexAttrState sshape_normal_vertex_attr_state() @system @nogc nothrow pure;
sg.VertexAttrState normalVertexAttrState() @trusted @nogc nothrow pure {
    return sshape_normal_vertex_attr_state();
}
extern(C) sg.VertexAttrState sshape_texcoord_vertex_attr_state() @system @nogc nothrow pure;
sg.VertexAttrState texcoordVertexAttrState() @trusted @nogc nothrow pure {
    return sshape_texcoord_vertex_attr_state();
}
extern(C) sg.VertexAttrState sshape_color_vertex_attr_state() @system @nogc nothrow pure;
sg.VertexAttrState colorVertexAttrState() @trusted @nogc nothrow pure {
    return sshape_color_vertex_attr_state();
}
/++
+ helper functions to build packed color value from floats or bytes
+/
extern(C) uint sshape_color_4f(float r, float g, float b, float a) @system @nogc nothrow pure;
uint color4f(float r, float g, float b, float a) @trusted @nogc nothrow pure {
    return sshape_color_4f(r, g, b, a);
}
extern(C) uint sshape_color_3f(float r, float g, float b) @system @nogc nothrow pure;
uint color3f(float r, float g, float b) @trusted @nogc nothrow pure {
    return sshape_color_3f(r, g, b);
}
extern(C) uint sshape_color_4b(ubyte r, ubyte g, ubyte b, ubyte a) @system @nogc nothrow pure;
uint color4b(ubyte r, ubyte g, ubyte b, ubyte a) @trusted @nogc nothrow pure {
    return sshape_color_4b(r, g, b, a);
}
extern(C) uint sshape_color_3b(ubyte r, ubyte g, ubyte b) @system @nogc nothrow pure;
uint color3b(ubyte r, ubyte g, ubyte b) @trusted @nogc nothrow pure {
    return sshape_color_3b(r, g, b);
}
/++
+ adapter function for filling matrix struct from generic float[16] array
+/
extern(C) Mat4 sshape_mat4(const float* m) @system @nogc nothrow pure;
Mat4 mat4(const float* m) @trusted @nogc nothrow pure {
    return sshape_mat4(m);
}
extern(C) Mat4 sshape_mat4_transpose(const float* m) @system @nogc nothrow pure;
Mat4 mat4Transpose(const float* m) @trusted @nogc nothrow pure {
    return sshape_mat4_transpose(m);
}
