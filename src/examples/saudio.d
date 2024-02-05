//------------------------------------------------------------------------------
//  saudio.d
//  Test sokol-audio D bindings
//------------------------------------------------------------------------------
module examples.saudio;

import sg = sokol.gfx;
import app = sokol.app;
import log = sokol.log;
import sgapp = sokol.glue;
import saudio = sokol.audio;

extern (C):
@safe:

enum NUM_SAMPLES = 32;

struct State
{
    sg.PassAction pass_action = {
        colors: [
            {
                load_action: sg.LoadAction.Clear,
                clear_value: {r: 1.0, g: 0.5, b: 0.0, a: 1.0},
            }
        ]
    };
    int even_odd;
    size_t sample_pos;
    float[NUM_SAMPLES] samples;
}

static State state;

void init()
{
    sg.Desc gfx = {context: sgapp.context(),
    logger: {func: &log.slog_func}};
    sg.setup(gfx);
    saudio.Desc audio = {logger: {func: &log.slog_func}};
    saudio.setup(audio);
}

void frame()
{
    immutable num_frames = saudio.expect();

    foreach (_; 0 .. num_frames)
    {
        state.even_odd += 1;
        state.sample_pos += 1;

        if (state.sample_pos == NUM_SAMPLES)
        {
            state.sample_pos = 0;
            saudio.push(&state.samples[0], NUM_SAMPLES);
        }

        state.samples[state.sample_pos] = (0 != (state.even_odd & 0x20)) ? 0.1 : -0.1;
    }

    sg.beginDefaultPass(state.pass_action, app.width(), app.height());
    sg.endPass();
    sg.commit();
}

void cleanup()
{
    saudio.shutdown();
    sg.shutdown();
}

void main()
{
    app.Desc runner = {
        window_title: "saudio.d",
        init_cb: &init,
        frame_cb: &frame,
        cleanup_cb: &cleanup,
        width: 640,
        height: 480,
        icon: {sokol_default: true},
        logger: {func: &log.func}
    };
    app.run(runner);
}
