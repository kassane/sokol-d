//------------------------------------------------------------------------------
//  sgl_points.d
//
//  Test sokol-gl point rendering.
//
//  (port of this C sample: https://floooh.github.io/sokol-html5/sgl-points-sapp.html)
//------------------------------------------------------------------------------

module examples.sgl_points;

import sg = sokol.gfx;
import sglue = sokol.glue;
import sapp = sokol.app;
import slog = sokol.log;
import sgl = sokol.gl;
import handmade.math : sin, cos, floor;

extern (C):
@safe:

struct RGB
{
    float r = 0.0, g = 0.0, b = 0.0;
}

struct State
{
    static sg.PassAction pass_action = {
        colors: [
            {
                load_action: sg.LoadAction.Clear,
                clear_value: {r: 0.0, g: 0.0, b: 0.0, a: 1.0},
            }
        ]
    };
}

immutable float[3][16] pallete = [
    [0.957, 0.263, 0.212],
    [0.914, 0.118, 0.388],
    [0.612, 0.153, 0.690],
    [0.404, 0.227, 0.718],
    [0.247, 0.318, 0.710],
    [0.129, 0.588, 0.953],
    [0.012, 0.663, 0.957],
    [0.000, 0.737, 0.831],
    [0.000, 0.588, 0.533],
    [0.298, 0.686, 0.314],
    [0.545, 0.765, 0.290],
    [0.804, 0.863, 0.224],
    [1.000, 0.922, 0.231],
    [1.000, 0.757, 0.027],
    [1.000, 0.596, 0.000],
    [1.000, 0.341, 0.133],
];

void init()
{
    sg.Desc gfxd = {environment: sglue.environment,
    logger: {func: &slog.func}};
    sg.setup(gfxd);

    sgl.Desc gld = {logger: {func: &slog.func}};
    sgl.setup(gld);
}

void frame()
{
    immutable float angle = sapp.frameCount() % 360.0;
    State state;

    sgl.defaults();
    sgl.beginPoints();
    float psize = 5.0;
    foreach (i; 0 .. 360)
    {
        auto a = sgl.asRadians(angle + i);
        auto color = computeColor(((sapp.frameCount() + i) % 300) / 300.0);
        auto r = sin(a * 4.0);
        auto s = sin(a);
        auto c = cos(a);
        auto x = s * r;
        auto y = c * r;
        sgl.c3f(color.r, color.g, color.b);
        sgl.pointSize(psize);
        sgl.v2f(x, y);
        psize *= 1.005;
    }
    sgl.end();

    sg.Pass pass = {action: state.pass_action, swapchain: sglue.swapchain};
    sg.beginPass(pass);
    sgl.draw();
    sg.endPass();
    sg.commit();
}

void cleanup()
{
    sgl.shutdown();
    sg.shutdown();
}

void main()
{
    sapp.Desc runner = {
        window_title: "sgl-points.d",
        init_cb: &init,
        frame_cb: &frame,
        cleanup_cb: &cleanup,
        width: 512,
        height: 512,
        logger: {func: &slog.func},
        icon: {sokol_default: true}
    };
    sapp.run(runner);
}

RGB computeColor(float t)
{
    const(size_t) idx0 = cast(size_t)(t * 16) % 16;
    const(size_t) idx1 = cast(size_t)(idx0 + 1) % 16;
    const l = (t * 16) - floor(t * 16);
    const c0 = pallete[idx0];
    const c1 = pallete[idx1];
    RGB rgb = {
        r: (c0[0] * (1 - l)) + (c1[0] * l),
        g: (c0[1] * (1 - l)) + (c1[1] * l),
        b: (c0[2] * (1 - l)) + (c1[2] * l),
    };
    return rgb;
}
