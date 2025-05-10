//------------------------------------------------------------------------------
//  instancingcompute.d
//
//  Like instancing.d, but use a compute shader to update particles.
//------------------------------------------------------------------------------
module examples.instancingcompute;

private:

import sg = sokol.gfx;
import sapp = sokol.app;
import slog = sokol.log;
import handmade.math: Mat4, Vec3;
import sglue = sokol.glue;
import shd = examples.shaders.instancingcompute;

extern (C):
@safe nothrow @nogc:

enum max_particles = 512 * 1024;
enum num_particles_emitted_per_frame = 10;

struct ComputeState {
    sg.Pipeline pip = {};
    sg.Bindings bind = {};
}

struct DisplayState {
    sg.Pipeline pip = {};
    sg.Bindings bind = {};
    sg.PassAction pass_action = {
        colors: [
            {
                load_action: sg.LoadAction.Clear,
                clear_value: {r: 0.0, g: 0.1, b: 0.2, a: 1 },
            }
        ]
    };
}

struct State {
    int num_particles = 0;
    float ry = 0;
    ComputeState compute;
    DisplayState display;

    Mat4 view() @nogc nothrow const {
        return Mat4.lookAt(Vec3(0.0, 1.5, 12.0), Vec3.zero(), Vec3.up());
    }
}

static State state;

void init() {
    sg.Desc gfxd = {
        environment: sglue.environment,
        logger: { func: &slog.func },
    };
    sg.setup(gfxd);

    // if compute shaders not supported, clear to red color and early out
    if (!sg.queryFeatures().compute) {
        state.display.pass_action.colors[0].clear_value.r = 1.0;
        state.display.pass_action.colors[0].clear_value.g = 0.0;
        state.display.pass_action.colors[0].clear_value.b = 0.0;
        return;
    }

    // a zero-initialized storage buffer for the particle state
    sg.BufferDesc sbufd = {
        usage: { storage_buffer: true },
        size: shd.Particle.sizeof * max_particles,
        label: "particle-buffer",
    };
    sg.Buffer sbuf = sg.makeBuffer(sbufd);
    state.compute.bind.storage_buffers[shd.SBUF_CS_SSBO] = sbuf;
    state.display.bind.storage_buffers[shd.SBUF_VS_SSBO] = sbuf;

    // a compute shader and pipeline object for updating the particle state
    sg.PipelineDesc upipd = {
        compute: true,
        shader: sg.makeShader(shd.updateShaderDesc(sg.queryBackend())),
        label: "update-pipeline",
    };
    state.compute.pip = sg.makePipeline(upipd);

    // vertex and index buffer for the particle geometry
    immutable float r = 0.05;
    float[42] vertices = [
        0.0, -r, 0.0, 1.0, 0.0, 0.0, 1.0,
        r, 0.0, r, 0.0, 1.0, 0.0, 1.0,
        r, 0.0, -r, 0.0, 0.0, 1.0, 1.0,
        -r, 0.0, -r, 1.0, 1.0, 0.0, 1.0,
        -r, 0.0, r, 0.0, 1.0, 1.0, 1.0,
        0.0, r, 0.0, 1.0, 0.0, 1.0, 1.0,
    ];
    ushort[24] indices = [
        2, 1, 0, 3, 2, 0,
        4, 3, 0, 1, 4, 0,
        5, 1, 2, 5, 2, 3,
        5, 3, 4, 5, 4, 1,
    ];
    sg.BufferDesc vbufd = {
        data: { ptr: vertices.ptr, size: vertices.sizeof },
        label: "geometry-vbuf",
    };
    sg.BufferDesc ibufd = {
        usage: { index_buffer: true },
        data: { ptr: indices.ptr, size: indices.sizeof },
        label: "geometry-ibuf",
    };
    state.display.bind.vertex_buffers[0] = sg.makeBuffer(vbufd);
    state.display.bind.index_buffer = sg.makeBuffer(ibufd);

    // shader and pipeline for rendering the particles, this uses
    // the compute-updated storage buffer to provide the particle positions
    sg.PipelineDesc rpipd = {
        shader: sg.makeShader(shd.displayShaderDesc(sg.queryBackend())),
        layout: {
            attrs: [
                shd.ATTR_DISPLAY_POS: { format: sg.VertexFormat.Float3 },
                shd.ATTR_DISPLAY_COLOR0: { format: sg.VertexFormat.Float4 },
            ],
        },
        index_type: sg.IndexType.Uint16,
        cull_mode: sg.CullMode.Back,
        depth: {
            compare: sg.CompareFunc.Less_equal,
            write_enabled: true,
        },
        label: "render-pipeline",
    };
    state.display.pip = sg.makePipeline(rpipd);

    // one-time init of particle velocities via a compute shader
    sg.PipelineDesc ipipd = {
        compute: true,
        shader: sg.makeShader(shd.initShaderDesc(sg.queryBackend())),
    };
    sg.Pipeline ipip = sg.makePipeline(ipipd);
    sg.Pass pass = { compute: true };
    sg.beginPass(pass);
    sg.applyPipeline(ipip);
    sg.applyBindings(state.compute.bind);
    sg.dispatch(max_particles / 64, 1, 1);
    sg.endPass();
}

void frame() {
    if (!sg.queryFeatures().compute) {
        drawFallback();
        return;
    }

    state.num_particles += num_particles_emitted_per_frame;
    if (state.num_particles > max_particles) {
        state.num_particles = max_particles;
    }
    float dt = sapp.frameDuration();

    // compute pass to update particle positions
    shd.CsParams cs_params = {
        dt: dt,
        num_particles: state.num_particles,
    };
    sg.Range cs_params_range = { ptr: &cs_params, size: cs_params.sizeof };
    sg.Pass cpass = { compute: true, label: "compute-pass" };
    sg.beginPass(cpass);
    sg.applyPipeline(state.compute.pip);
    sg.applyBindings(state.compute.bind);
    sg.applyUniforms(shd.UB_CS_PARAMS, cs_params_range);
    sg.dispatch((state.num_particles + 63) / 64, 1, 1);
    sg.endPass();

    // render pass to render the particles via instancing, with the
    // instance positions coming from the storage buffer
    state.ry += 60.0 * dt;
    shd.VsParams vs_params = computeVsParams(1.0, state.ry);
    sg.Range vs_params_range = { ptr: &vs_params, size: vs_params.sizeof };
    sg.Pass rpass = {
        action: state.display.pass_action,
        swapchain: sglue.swapchain(),
        label: "render-pass",
    };
    sg.beginPass(rpass);
    sg.applyPipeline(state.display.pip);
    sg.applyBindings(state.display.bind);
    sg.applyUniforms(shd.UB_VS_PARAMS, vs_params_range);
    sg.draw(0, 24, state.num_particles);
    sg.endPass();
    sg.commit();
}

void cleanup() {
    sg.shutdown();
}

void drawFallback() {
    sg.Pass rpass = {
        action: state.display.pass_action,
        swapchain: sglue.swapchain(),
        label: "render-pass",
    };
    sg.beginPass(rpass);
    sg.endPass();
    sg.commit();
}

shd.VsParams computeVsParams(float rx, float ry) @nogc nothrow
{
    immutable proj = Mat4.perspective(60.0, sapp.widthf() / sapp.heightf(), 0.01, 50.0);
    immutable rxm = Mat4.rotate(rx, Vec3(1.0, 0.0, 0.0));
    immutable rym = Mat4.rotate(ry, Vec3(0.0, 1.0, 0.0));
    immutable model = Mat4.mul(rxm, rym);
    immutable view_proj = Mat4.mul(proj, state.view());
    shd.VsParams mvp = { mvp: Mat4.mul(view_proj, model) };
    return mvp;
}

void main() {
    sapp.Desc adesc = {
        init_cb: &init,
        frame_cb: &frame,
        cleanup_cb: &cleanup,
        width: 800,
        height: 600,
        sample_count: 4,
        window_title: "instancingcompute.d",
        icon: { sokol_default: true },
        logger: { func: &slog.func },
    };
    sapp.run(adesc);
}
