//------------------------------------------------------------------------------
//  cube.d - Example Sokol Cube
//
//  Shader with uniform data.
//------------------------------------------------------------------------------
module examples.cube;

private:

import sg = sokol.gfx;
import app = sokol.app;
import log = sokol.log;
import handmade.math : Mat4, Vec3;
import sglue = sokol.glue;
import shd = examples.shaders.cube;

extern (C):
@safe:

interface ICubeRenderer
{
    void init();
    void frame();
    void cleanup();
}

class CubeRenderer : ICubeRenderer
{
    private struct State
    {
        float rx = 0;
        float ry = 0;
        sg.Pipeline pip;
        sg.Bindings bind;
        sg.PassAction passAction = {
            colors: [
                {
                    load_action: sg.LoadAction.Clear,
                    clear_value: {r: 0.25, g: 0.5, b: 0.75, a: 1.0}
                }
            ]
        };
    }

    private State state;

    private Mat4 view()
    {
        return Mat4.lookAt(Vec3(0.0, 1.5, 6.0), Vec3.zero(), Vec3.up());
    }

    private Mat4 computeMvp(float rx, float ry)
    {
        immutable proj = Mat4.perspective(60.0, app.widthf() / app.heightf(), 0.01, 10.0);
        immutable rxm = Mat4.rotate(rx, Vec3(1.0, 0.0, 0.0));
        immutable rym = Mat4.rotate(ry, Vec3(0.0, 1.0, 0.0));
        immutable model = Mat4.mul(rxm, rym);
        immutable view_proj = Mat4.mul(proj, view());
        return Mat4.mul(view_proj, model);
    }

    void init()
    {
        sg.Desc gfxd = {
            environment: sglue.environment,
            logger: {func: &log.func}
        };
        sg.setup(gfxd);

        float[168] vertices = [
            -1.0, -1.0, -1.0, 1.0, 0.0, 0.0, 1.0,
            1.0, -1.0, -1.0, 1.0, 0.0, 0.0, 1.0,
            1.0, 1.0, -1.0, 1.0, 0.0, 0.0, 1.0,
            -1.0, 1.0, -1.0, 1.0, 0.0, 0.0, 1.0,

            -1.0, -1.0, 1.0, 0.0, 1.0, 0.0, 1.0,
            1.0, -1.0, 1.0, 0.0, 1.0, 0.0, 1.0,
            1.0, 1.0, 1.0, 0.0, 1.0, 0.0, 1.0,
            -1.0, 1.0, 1.0, 0.0, 1.0, 0.0, 1.0,

            -1.0, -1.0, -1.0, 0.0, 0.0, 1.0, 1.0,
            -1.0, 1.0, -1.0, 0.0, 0.0, 1.0, 1.0,
            -1.0, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0,
            -1.0, -1.0, 1.0, 0.0, 0.0, 1.0, 1.0,

            1.0, -1.0, -1.0, 1.0, 0.5, 0.0, 1.0,
            1.0, 1.0, -1.0, 1.0, 0.5, 0.0, 1.0,
            1.0, 1.0, 1.0, 1.0, 0.5, 0.0, 1.0,
            1.0, -1.0, 1.0, 1.0, 0.5, 0.0, 1.0,

            -1.0, -1.0, -1.0, 0.0, 0.5, 1.0, 1.0,
            -1.0, -1.0, 1.0, 0.0, 0.5, 1.0, 1.0,
            1.0, -1.0, 1.0, 0.0, 0.5, 1.0, 1.0,
            1.0, -1.0, -1.0, 0.0, 0.5, 1.0, 1.0,

            -1.0, 1.0, -1.0, 1.0, 0.0, 0.5, 1.0,
            -1.0, 1.0, 1.0, 1.0, 0.0, 0.5, 1.0,
            1.0, 1.0, 1.0, 1.0, 0.0, 0.5, 1.0,
            1.0, 1.0, -1.0, 1.0, 0.0, 0.5, 1.0
        ];
        sg.BufferDesc vbufd = {
            data: {ptr: vertices.ptr, size: vertices.sizeof},
        };
        state.bind.vertex_buffers[0] = sg.makeBuffer(vbufd);

        ushort[36] indices = [
            0, 1, 2, 0, 2, 3,
            6, 5, 4, 7, 6, 4,
            8, 9, 10, 8, 10, 11,
            14, 13, 12, 15, 14, 12,
            16, 17, 18, 16, 18, 19,
            22, 21, 20, 23, 22, 20,
        ];
        sg.BufferDesc ibufd = {
            usage: {index_buffer: true},
            data: {ptr: indices.ptr, size: indices.sizeof},
        };
        state.bind.index_buffer = sg.makeBuffer(ibufd);

        sg.PipelineDesc pld = {
            layout: {
                attrs: [
                    shd.ATTR_CUBE_POSITION: {format: sg.VertexFormat.Float3},
                    shd.ATTR_CUBE_COLOR0: {format: sg.VertexFormat.Float4},
                ],
            },
            shader: sg.makeShader(shd.cubeShaderDesc(sg.queryBackend())),
            index_type: sg.IndexType.Uint16,
            cull_mode: sg.CullMode.Back,
            depth: {write_enabled: true,
            compare: sg.CompareFunc.Less_equal},
        };
        state.pip = sg.makePipeline(pld);
    }

    void frame() @trusted
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
}

private __gshared ICubeRenderer renderer;

void main() @system
{
    renderer = new CubeRenderer();

    app.Desc runner = {
        window_title: "cube.d",

        init_cb: &initWrapper,
        frame_cb: &frameWrapper,
        cleanup_cb: &cleanupWrapper,
        width: 800,
        height: 600,
        sample_count: 4,
        icon: {sokol_default: true},
        logger: {func: &log.func}
    };
    app.run(runner);
}

extern (C) private void initWrapper() @system
{
    renderer.init();
}

extern (C) private void frameWrapper() @system
{
    renderer.frame();
}

extern (C) private void cleanupWrapper() @system
{
    renderer.cleanup();
}
