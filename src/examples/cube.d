//------------------------------------------------------------------------------
//  cube.d - Example Sokol Cube
//
//  Shader with uniform data.
//------------------------------------------------------------------------------
module examples.cube;

import sg = sokol.gfx;
import app = sokol.app;
import log = sokol.log;
import handmade.math : Mat4, Vec3;
import sgapp = sokol.glue;

struct State
{
    float rx = 0.0f;
    float ry = 0.0f;

    sg.Pipeline pip;
    sg.Bindings bind;
    sg.PassAction passAction;

    static Mat4 view()
    {
        return Mat4.lookAt(Vec3(0.0f, 1.5f, 6.0f), Vec3.zero(), Vec3.up());
    }
}

State state;

// void init()
// {
//     sg.setup(&sg.Desc(
//         sgapp.context(),
//         &log.func
//     ));

//     float[][] vertices = [
//         [-1, -1, -1, 1, 0, 0, 1],
//         [1, -1, -1, 1, 0, 0, 1],
//         [1, 1, -1, 1, 0, 0, 1],
//         [-1, 1, -1, 1, 0, 0, 1],

//         [-1, -1, 1, 0, 1, 0, 1],
//         [1, -1, 1, 0, 1, 0, 1],
//         [1, 1, 1, 0, 1, 0, 1],
//         [-1, 1, 1, 0, 1, 0, 1],

//         [-1, -1, -1, 0, 0, 1, 1],
//         [-1, 1, -1, 0, 0, 1, 1],
//         [-1, 1, 1, 0, 0, 1, 1],
//         [-1, -1, 1, 0, 0, 1, 1],

//         [1, -1, -1, 1, 0.5, 0, 1],
//         [1, 1, -1, 1, 0.5, 0, 1],
//         [1, 1, 1, 1, 0.5, 0, 1],
//         [1, -1, 1, 1, 0.5, 0, 1],

//         [-1, -1, -1, 0, 0.5, 1, 1],
//         [-1, -1, 1, 0, 0.5, 1, 1],
//         [1, -1, 1, 0, 0.5, 1, 1],
//         [1, -1, -1, 0, 0.5, 1, 1],

//         [-1, 1, -1, 1, 0, 0.5, 1],
//         [-1, 1, 1, 1, 0, 0.5, 1],
//         [1, 1, 1, 1, 0, 0.5, 1],
//         [1, 1, -1, 1, 0, 0.5, 1]
//     ];

//     // Create vertex buffer
//     state.bind.vertexBuffers[0] = sg.makeBuffer(
//         vertices.length,
//         sg.BufferType.VERTEXBUFFER,
//         sg.Usage.IMMUTABLE,
//         vertices
//     );

// }

// void frame()
// {
//     float dt = cast(float) app.frameDuration() * 60;

//     state.rx += dt;
//     state.ry += dt;

//     // auto vsParams = computeVsParams(state.rx, state.ry);

//     sg.beginDefaultPass(state.passAction, app.width(), app.height());

//     sg.applyPipeline(state.pip);
//     sg.applyBindings(state.bind);
//     // sg.applyUniforms(.vs, cubeShader.slotVsParams, &vsParams);

//     sg.draw(0, 36, 1);

//     sg.endPass();
//     sg.commit();
// }

extern (C) void cleanup()
{
    sg.shutdown();
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
