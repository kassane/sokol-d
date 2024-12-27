//------------------------------------------------------------------------------
//  shapes.d
//
//  Simple sokol.shape demo.
//------------------------------------------------------------------------------
module examples.shapes;

private:

import sg = sokol.gfx;
import app = sokol.app;
import log = sokol.log;
import handmade.math : Mat4, Vec3;
import sglue = sokol.glue;
import sdtx = sokol.debugtext;
import sshape = sokol.shape;
import shd = examples.shaders.shapes;

extern (C):
@safe:

struct State
{
    float rx = 0;
    float ry = 0;

    sg.Pipeline pip;
    sg.Bindings bind;
    sg.PassAction passAction = {};
    shd.VsParams vsParams = {};
    Shape[5] shapes = [
        Shape(Vec3(-1, 1, 0)),
        Shape(Vec3(1, 1, 0)),
        Shape(Vec3(-2, -1, 0)),
        Shape(Vec3(2, -1, 0)),
        Shape(Vec3(0, -1, 0)),
    ];

    Mat4 view()
    {
        return Mat4.lookAt(Vec3(0.0, 1.5, 6.0), Vec3.zero(), Vec3.up());
    }
}

struct Shape
{
    Vec3 pos = Vec3.zero();
    sshape.ElementRange draw = {};
}

static State state;

void init()
{
    sg.Desc gfxd = {environment: sglue.environment,
    logger: {func: &log.func}};
    sg.setup(gfxd);

    sdtx.Desc desc = {fonts: [
        sdtx.fontOric()
    ],
    logger: {func: &log.func},};
    sdtx.setup(desc);

    sshape.Vertex[6 * 1024] vertices;
    ushort[16 * 1024] indices;

    state.passAction.colors[0].load_action = sg.LoadAction.Clear;
    state.passAction.colors[0].clear_value.r = 0.0;
    state.passAction.colors[0].clear_value.g = 0.0;
    state.passAction.colors[0].clear_value.b = 0.0;
    state.passAction.colors[0].clear_value.a = 1.0;

    // dfmt off
    sg.PipelineDesc pld = {
        layout: {
            buffers: [sshape.vertexBufferLayoutState()],
            attrs: [
                shd.ATTR_SHAPES_POSITION: sshape.positionVertexAttrState,
                shd.ATTR_SHAPES_NORMAL: sshape.normalVertexAttrState,
                shd.ATTR_SHAPES_COLOR0: sshape.colorVertexAttrState,
                shd.ATTR_SHAPES_TEXCOORD: sshape.texcoordVertexAttrState,
            ],
        },
        shader: sg.makeShader(shd.shapesShaderDesc(sg.queryBackend())),
        index_type: sg.IndexType.Uint16,
        cull_mode: sg.CullMode.None,
        depth: {
            write_enabled: true,
            compare: sg.CompareFunc.Less_equal
        },
    };
    // dfmt on
    state.pip = sg.makePipeline(pld);

    // dfmt off
    sshape.Buffer buf = {
        vertices: {buffer: {ptr: vertices.ptr, size: vertices.sizeof}},
        indices: {buffer: {ptr: indices.ptr, size: indices.sizeof}},
    };
    buf = sshape.buildBox(buf, sshape.Box(
            width: 1.0, height: 1.0, depth: 1.0,
            tiles: 10, random_colors: true,
        )
    );
    state.shapes[0].draw = sshape.elementRange(buf);
    buf = sshape.buildPlane(buf, sshape.Plane(
            width: 1.0, depth: 1.0,
            tiles: 10, random_colors: true,
        )
    );
    state.shapes[1].draw = sshape.elementRange(buf);
    buf = sshape.buildSphere(buf, sshape.Sphere(
            radius: 0.75, slices: 36,
            stacks: 20, random_colors: true,
        )
    );
    state.shapes[2].draw = sshape.elementRange(buf);
    buf = sshape.buildCylinder(buf, sshape.Cylinder(
            radius: 0.5, height: 1.5, slices: 36,
            stacks: 10, random_colors: true,
        )
    );
    state.shapes[3].draw = sshape.elementRange(buf);
    buf = sshape.buildTorus(buf, sshape.Torus(
            radius: 0.5, ring_radius: 0.3, rings: 36,
            sides: 18, random_colors: true,
        )
    );
    // dfmt on

    state.shapes[4].draw = sshape.elementRange(buf);
    assert(buf.valid);
    // one vertex- and index-buffer for all shapes
    state.bind.vertex_buffers[0] = sg.makeBuffer(sshape.vertexBufferDesc(buf));
    state.bind.index_buffer = sg.makeBuffer(sshape.indexBufferDesc(buf));
}

void frame()
{
    sdtx.canvas(app.widthf() * 0.5, app.heightf() * 0.5);
    sdtx.pos(0.5, 0.5);
    sdtx.puts("press key to switch draw mode:\n\n");
    sdtx.puts("  1: vertex normals\n");
    sdtx.puts("  2: texture coords\n");
    sdtx.puts("  3: vertex colors\n");

    // view-project matrix
    const proj = Mat4.perspective(60.0, app.widthf / app.heightf, 0.01, 10.0);
    const view_proj = Mat4.mul(proj, state.view);
    // model-rotation matrix
    immutable float dt = cast(float)(app.frameDuration * 60);
    state.rx += 1.0 * dt;
    state.ry += 1.0 * dt;
    const rxm = Mat4.rotate(state.rx, Vec3(1, 0, 0));
    const rym = Mat4.rotate(state.ry, Vec3(0, 1, 0));
    const rm = Mat4.mul(rxm, rym);

    sg.Pass pass = {action: state.passAction, swapchain: sglue.swapchain()};
    sg.beginPass(pass);
    sg.applyPipeline(state.pip);
    sg.applyBindings(state.bind);

    sg.Range rg = {ptr: &state.vsParams, size: state.vsParams.sizeof};
    // dfmt off
    foreach (shape;state.shapes) {
        // per-shape model-view-projection matrix
        const model = Mat4.mul(Mat4.translate(shape.pos), rm);
        state.vsParams.mvp = Mat4.mul(view_proj, model);
        sg.applyUniforms(shd.UB_VS_PARAMS, rg);
        sg.draw(shape.draw.base_element, shape.draw.num_elements, 1);
    }
    // dfmt on
    sdtx.draw;
    sg.endPass;
    sg.commit;
}

void input(const app.Event* event)
{
    const ev = *event;
    if (ev.type == app.EventType.Key_down)
    {
        switch (ev.key_code)
        {
        case app.Keycode._1:
            state.vsParams.draw_mode = 0.0f;
            break;
        case app.Keycode._2:
            state.vsParams.draw_mode = 1.0f;
            break;
        case app.Keycode._3:
            state.vsParams.draw_mode = 2.0f;
            break;
        default:
            break;
        }
    }
}

void cleanup()
{
    sdtx.shutdown();
    sg.shutdown();
}

// dfmt off
void main()
{
    app.Desc runner = {
        window_title: "shapes.d",
        init_cb: &init,
        frame_cb: &frame,
        event_cb: &input,
        cleanup_cb: &cleanup,
        width: 800,
        height: 600,
        sample_count: 4,
        icon: {sokol_default: true},
        logger: {func: &log.func}
    };
    app.run(runner);
}
// dfmt on
