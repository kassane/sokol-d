//------------------------------------------------------------------------------
//  cube.d - Example Sokol Cube
//
//  Shader with uniform data.
//------------------------------------------------------------------------------
module examples.cube;

import sokol.gfx;
import sokol.app;
import sokol.log;
import hmath: Mat4, Vec3;
import sokol.gfx_glue;

alias app = sokol.app;
alias sgapp = sokol.gfx_glue;
alias log = sokol.log;

struct State
{
    float rx = 0.0f;
    float ry = 0.0f;

    Pipeline pip;
    Bindings bind;
    PassAction passAction;

    static Mat4 view()
    {
        return Mat4.lookAt(
            Vec3(0.0f, 1.5f, 6.0f),
            Vec3.zero(),
            Vec3.up()
        );
    }
}

State state;

void init()
{
    sokol.gfx.setup(sokol.gfx.Desc(
            sgapp.context(),
            &log.func
    ));

    float[][] vertices = [
        [-1, -1, -1, 1, 0, 0, 1],
        [1, -1, -1, 1, 0, 0, 1],
        [1, 1, -1, 1, 0, 0, 1],
        [-1, 1, -1, 1, 0, 0, 1],

        [-1, -1, 1, 0, 1, 0, 1],
        [1, -1, 1, 0, 1, 0, 1],
        [1, 1, 1, 0, 1, 0, 1],
        [-1, 1, 1, 0, 1, 0, 1],

        [-1, -1, -1, 0, 0, 1, 1],
        [-1, 1, -1, 0, 0, 1, 1],
        [-1, 1, 1, 0, 0, 1, 1],
        [-1, -1, 1, 0, 0, 1, 1],

        [1, -1, -1, 1, 0.5, 0, 1],
        [1, 1, -1, 1, 0.5, 0, 1],
        [1, 1, 1, 1, 0.5, 0, 1],
        [1, -1, 1, 1, 0.5, 0, 1],

        [-1, -1, -1, 0, 0.5, 1, 1],
        [-1, -1, 1, 0, 0.5, 1, 1],
        [1, -1, 1, 0, 0.5, 1, 1],
        [1, -1, -1, 0, 0.5, 1, 1],

        [-1, 1, -1, 1, 0, 0.5, 1],
        [-1, 1, 1, 1, 0, 0.5, 1],
        [1, 1, 1, 1, 0, 0.5, 1],
        [1, 1, -1, 1, 0, 0.5, 1]
    ];

    // Create vertex buffer
    state.bind.vertexBuffers[0] = sokol.gfx.makeBuffer(
        vertices.length,
        sokol.gfx.BufferType.VERTEXBUFFER,
        sokol.gfx.Usage.IMMUTABLE,
        vertices
    );

}

void frame()
{
    float dt = cast(float) app.frameDuration() * 60;

    state.rx += dt;
    state.ry += dt;

    // auto vsParams = computeVsParams(state.rx, state.ry);

    sokol.gfx.beginDefaultPass(state.passAction, app.width(), app.height());

    sokol.gfx.applyPipeline(state.pip);
    sokol.gfx.applyBindings(state.bind);
    // sokol.gfx.applyUniforms(.vs, cubeShader.slotVsParams, &vsParams);

    sokol.gfx.draw(0, 36);

    sokol.gfx.endPass();
    sokol.gfx.commit();
}

void cleanup()
{
    sokol.gfx.shutdown();
}

void main()
{
    // TODO
}

// TODO: missing cube.glsl
// VsParams computeVsParams(float rx, float ry)
// {

//     auto rxm = Mat4.rotate(rx, Vec3(1, 0, 0));
//     auto rym = Mat4.rotate(ry, Vec3(0, 1, 0));
//     auto model = Mat4.mul(rxm, rym);

//     auto aspect = app.width() / app.height();
//     auto proj = Mat4.perspective(60, aspect, 0.01f, 10);

//     return VsParams(
//         Mat4.mul(Mat4.mul(proj, state.view), model)
//     );
// }
