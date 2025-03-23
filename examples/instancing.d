//------------------------------------------------------------------------------
//  instancing.d
//
//  Demonstrate simple hardware-instancing using a static geometry buffer
//  and a dynamic instance-data buffer.
//------------------------------------------------------------------------------
module examples.instancing;

private:

import sg = sokol.gfx;
import app = sokol.app;
import log = sokol.log;
import handmade.math : Mat4, Vec3;
import sglue = sokol.glue;
import shd = examples.shaders.instancing;

extern (C):
@safe nothrow @nogc:

enum max_particles = 512 * 1024;
enum num_particles_emitted_per_frame = 10;

struct State
{
    float ry = 0;
    Vec3[max_particles] pos;
    Vec3[max_particles] vel;
    int cur_num_particles = 0;
    sg.Pipeline pip = {};
    sg.Bindings bind = {};
    // dfmt off
    sg.PassAction passAction = {
        colors: [
            {
                load_action: sg.LoadAction.Clear,
                clear_value: {r: 0.0, g: 0.0, b: 0.0, a: 1.0}
            }
        ]
    };
    // dfmt on

    Mat4 view() @nogc nothrow const
    {
        return Mat4.lookAt(Vec3(0.0, 1.5, 12.0), Vec3.zero(), Vec3.up());
    }
}

static State state;

void init()
{
    sg.Desc gfxd = {environment: sglue.environment,
    logger: {func: &log.func}};
    sg.setup(gfxd);

    immutable float r = 0.05;
    float[42] vertices = [
        0.0, -r, 0.0, 1.0, 0.0, 0.0, 1.0,
        r, 0.0, r, 0.0, 1.0, 0.0, 1.0,
        r, 0.0, -r, 0.0, 0.0, 1.0, 1.0,
        -r, 0.0, -r, 1.0, 1.0, 0.0, 1.0,
        -r, 0.0, r, 0.0, 1.0, 1.0, 1.0,
        0.0, r, 0.0, 1.0, 0.0, 1.0, 1.0,
    ];
    sg.BufferDesc vbufd0 = {data: {ptr: vertices.ptr, size: vertices.sizeof},};
    state.bind.vertex_buffers[0] = sg.makeBuffer(vbufd0);

    ushort[24] indices = [
        2, 1, 0, 3, 2, 0,
        4, 3, 0, 1, 4, 0,
        5, 1, 2, 5, 2, 3,
        5, 3, 4, 5, 4, 1,
    ];
    sg.BufferDesc ibufd = {
        type: sg.BufferType.Indexbuffer,
        data: {ptr: indices.ptr, size: indices.sizeof},};
        state.bind.index_buffer = sg.makeBuffer(ibufd);

        sg.BufferDesc vbufd1 = {
            type: sg.BufferType.Vertexbuffer,
            usage: sg.Usage.Stream,
            size: max_particles * Vec3.sizeof,};
            state.bind.vertex_buffers[1] = sg.makeBuffer(vbufd1);

            sg.PipelineDesc pld = {
                layout: {
                    attrs: [
                        shd.ATTR_INSTANCING_POS: {
                            format: sg.VertexFormat.Float3, buffer_index: 0
    },
    shd.ATTR_INSTANCING_COLOR0 : {
        format: sg.VertexFormat.Float4, buffer_index: 0
        },
        shd.ATTR_INSTANCING_INST_POS : {
            format: sg.VertexFormat.Float3, buffer_index: 1
                        }],
    },
    shader: sg.makeShader(shd.instancingShaderDesc(sg.queryBackend())),
    index_type: sg.IndexType.Uint16,
    cull_mode: sg.CullMode.Back,
    depth: {write_enabled: true,
    compare: sg.CompareFunc.Less_equal
        },
                };
    pld.layout.buffers[1].step_func = sg.VertexStep.Per_instance;
    state.pip = sg.makePipeline(pld);
}

void frame()
{
    immutable float frame_time = cast(float) app.frameDuration();

    // emit new particles
    foreach (i; 0 .. num_particles_emitted_per_frame)
    {
        if (state.cur_num_particles < max_particles)
        {
            state.pos[state.cur_num_particles] = Vec3.zero();
            state.vel[state.cur_num_particles] = Vec3(
                rand(-0.5, 0.5),
                rand(2.0, 2.5),
                rand(-0.5, 0.5)
            );
            state.cur_num_particles++;
        }
        else
        {
            break;
        }
    }

    // update particle positions
    foreach (i; 0 .. max_particles)
    {
        Vec3* vel = &state.vel[i];
        Vec3* pos = &state.pos[i];
        vel.y -= 1.0 * frame_time;
        *pos = Vec3.add(*pos, Vec3.mul(*vel, frame_time));
        if (pos.y < -2.0)
        {
            pos.y = -1.8;
            vel.y = -vel.y;
            *vel = Vec3.mul(*vel, 0.8);
        }
    }

    sg.Range ub = {ptr: &state.pos, size: state.pos.sizeof};
    sg.updateBuffer(state.bind.vertex_buffers[1], ub);
    state.ry += 1.0 * frame_time;

    shd.VsParams vsParams = computeMvp(1.0, state.ry);

    sg.Pass pass = {action: state.passAction, swapchain: sglue.swapchain()
            };
    sg.beginPass(pass);
    sg.applyPipeline(state.pip);
    sg.applyBindings(state.bind);
    sg.Range r_vsparams = {ptr: &vsParams, size: vsParams.sizeof};
    sg.applyUniforms(shd.UB_VS_PARAMS, r_vsparams);
    sg.draw(0, 24, state.cur_num_particles);
    sg.endPass();
    sg.commit();
}

void cleanup()
{
    sg.shutdown();
}

shd.VsParams computeMvp(float rx, float ry) @nogc nothrow
{
    immutable proj = Mat4.perspective(60.0, app.widthf() / app.heightf(), 0.01, 50.0);
    immutable rxm = Mat4.rotate(rx, Vec3(1.0, 0.0, 0.0));
    immutable rym = Mat4.rotate(ry, Vec3(0.0, 1.0, 0.0));
    immutable model = Mat4.mul(rxm, rym);
    immutable view_proj = Mat4.mul(proj, state.view());
    // dfmt off
    shd.VsParams mvp = { mvp: Mat4.mul(view_proj, model) };
    // dfmt on
    return mvp;
}

void main()
{
    // dfmt off
    app.Desc runner = {
        window_title: "instancing.d",
        init_cb: &init,
        frame_cb: &frame,
        cleanup_cb: &cleanup,
        width: 800,
        height: 600,
        sample_count: 4,
        icon: {sokol_default: true},
        logger: {func: &log.func}
    };
    // dfmt on
    app.run(runner);
}

uint xorshift32()
{
    static uint X = 0x12345678;

    uint x = X;
    x ^= x << 13;
    x ^= x >> 17;
    x ^= x << 5;
    X = x;
    return x;
}

float rand(inout(float) min, inout(float) max)
{
    return (cast(float)(xorshift32 & 0xFFFF) / 0x10000) * (max - min) + min;
}
