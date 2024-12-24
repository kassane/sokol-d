//------------------------------------------------------------------------------
//  texcube.d - Example Sokol Texcube
//
//  Texture creation, rendering with texture, packed vertex components.
//------------------------------------------------------------------------------
module examples.texcube;

import sg = sokol.gfx;
import app = sokol.app;
import log = sokol.log;
import handmade.math : Mat4, Vec3;
import sglue = sokol.glue;
import shd = examples.shaders.texcube;

extern (C):
@safe:

struct State
{
    float rx = 0;
    float ry = 0;

    sg.Pipeline pip;
    sg.Bindings bind;
    sg.PassAction passAction = {};

    Mat4 view()
    {
        return Mat4.lookAt(Vec3(0.0, 1.5, 6.0), Vec3.zero(), Vec3.up());
    }
}

struct Vertex
{
    float x = 0.0, y = 0.0, z = 0.0;
    int color = 0;
    short u = 0, v = 0;
}

static State state;

void init()
{
    sg.Desc gfxd = {environment: sglue.environment,
    logger: {func: &log.func}};
    sg.setup(gfxd);

    Vertex[24] vertices = [
        Vertex(-1.0, -1.0, -1.0, 0xFF0000FF, 0, 0),
        Vertex(1.0, -1.0, -1.0, 0xFF0000FF, 32_767, 0),
        Vertex(1.0, 1.0, -1.0, 0xFF0000FF, 32_767, 32_767),
        Vertex(-1.0, 1.0, -1.0, 0xFF0000FF, 0, 32_767),

        Vertex(-1.0, -1.0, 1.0, 0xFF00FF00, 0, 0),
        Vertex(1.0, -1.0, 1.0, 0xFF00FF00, 32_767, 0),
        Vertex(1.0, 1.0, 1.0, 0xFF00FF00, 32_767, 32_767),
        Vertex(-1.0, 1.0, 1.0, 0xFF00FF00, 0, 32_767),

        Vertex(-1.0, -1.0, -1.0, 0xFFFF0000, 0, 0),
        Vertex(-1.0, 1.0, -1.0, 0xFFFF0000, 32_767, 0),
        Vertex(-1.0, 1.0, 1.0, 0xFFFF0000, 32_767, 32_767),
        Vertex(-1.0, -1.0, 1.0, 0xFFFF0000, 0, 32_767),

        Vertex(1.0, -1.0, -1.0, 0xFFFF007F, 0, 0),
        Vertex(1.0, 1.0, -1.0, 0xFFFF007F, 32_767, 0),
        Vertex(1.0, 1.0, 1.0, 0xFFFF007F, 32_767, 32_767),
        Vertex(1.0, -1.0, 1.0, 0xFFFF007F, 0, 32_767),

        Vertex(-1.0, -1.0, -1.0, 0xFFFF7F00, 0, 0),
        Vertex(-1.0, -1.0, 1.0, 0xFFFF7F00, 32_767, 0),
        Vertex(1.0, -1.0, 1.0, 0xFFFF7F00, 32_767, 32_767),
        Vertex(1.0, -1.0, -1.0, 0xFFFF7F00, 0, 32_767),

        Vertex(-1.0, 1.0, -1.0, 0xFF007FFF, 0, 0),
        Vertex(-1.0, 1.0, 1.0, 0xFF007FFF, 32_767, 0),
        Vertex(1.0, 1.0, 1.0, 0xFF007FFF, 32_767, 32_767),
        Vertex(1.0, 1.0, -1.0, 0xFF007FFF, 0, 32_767),
    ];

    sg.BufferDesc vbufd = {data: {ptr: vertices.ptr, size: vertices.sizeof},};
    state.bind.vertex_buffers[0] = sg.makeBuffer(vbufd);

    ushort[36] indices = [
        0, 1, 2, 0, 2, 3,
        6, 5, 4, 7, 6, 4,
        8, 9, 10, 8, 10, 11,
        14, 13, 12, 15, 14, 12,
        16, 17, 18, 16, 18, 19,
        22, 21, 20, 23, 22, 20,
    ];

    int[4][4] colors = [
        [0xFFFFFFFF, 0xFF000000, 0xFFFFFFFF, 0xFF000000],
        [0xFF000000, 0xFFFFFFFF, 0xFF000000, 0xFFFFFFFF],
        [0xFFFFFFFF, 0xFF000000, 0xFFFFFFFF, 0xFF000000],
        [0xFF000000, 0xFFFFFFFF, 0xFF000000, 0xFFFFFFFF]
    ];
    // dfmt off
    sg.BufferDesc ibufd = {
        type: sg.BufferType.Indexbuffer,
        data: {ptr: indices.ptr, size: indices.sizeof},
    };
    state.bind.index_buffer = sg.makeBuffer(ibufd);

    sg.PipelineDesc pld = {
        layout: {
            attrs: [
                shd.ATTR_TEXCUBE_POS: {format: sg.VertexFormat.Float3},
                shd.ATTR_TEXCUBE_COLOR0: {format: sg.VertexFormat.Ubyte4n},
                shd.ATTR_TEXCUBE_TEXCOORD0: {format: sg.VertexFormat.Short2n},
            ],
        },
        shader: sg.makeShader(shd.texcubeShaderDesc(sg.queryBackend())),
        index_type: sg.IndexType.Uint16,
        cull_mode: sg.CullMode.Back,
        depth: {
            write_enabled: true,
            compare: sg.CompareFunc.Less_equal
        },
    };
    sg.ImageData img_data = {
        subimage: [[{
            ptr: cast(ubyte*)colors.ptr,
            size: colors.sizeof,
        }]]
    };
    // create a small checker-board texture
    sg.ImageDesc img_desc = {
        width: 4,
        height: 4,
        data: img_data,
    };
    // dfmt on
    state.bind.images[shd.IMG_TEX] = sg.makeImage(img_desc);

    sg.SamplerDesc smpld = {};
    state.bind.samplers[shd.SMP_SMP] = sg.makeSampler(smpld);

    state.pip = sg.makePipeline(pld);
}

void frame()
{
    immutable float t = cast(float)(app.frameDuration() * 60.0);

    state.rx += 1.0 * t;
    state.ry += 2.0 * t;

    shd.VsParams vsParams = {mvp: computeMvp(state.rx, state.ry)};

    sg.Pass pass = {action: state.passAction, swapchain: sglue.swapchain()};
    sg.beginPass(pass);
    sg.applyPipeline(state.pip);
    sg.applyBindings(state.bind);
    sg.Range r = {ptr: &vsParams, size: vsParams.sizeof};
    sg.applyUniforms(shd.UB_VS_PARAMS, r);
    sg.draw(0, 36, 1);
    sg.endPass();
    sg.commit();
}

void cleanup()
{
    sg.shutdown();
}

Mat4 computeMvp(float rx, float ry)
{
    immutable proj = Mat4.perspective(60.0, app.widthf() / app.heightf(), 0.01, 10.0);
    immutable rxm = Mat4.rotate(rx, Vec3(1.0, 0.0, 0.0));
    immutable rym = Mat4.rotate(ry, Vec3(0.0, 1.0, 0.0));
    immutable model = Mat4.mul(rxm, rym);
    immutable view_proj = Mat4.mul(proj, state.view());
    return Mat4.mul(view_proj, model);
}

// dfmt off
void main()
{
    app.Desc runner = {
        window_title: "texcube.d",
        init_cb: &init,
        frame_cb: &frame,
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
