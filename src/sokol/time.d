// machine generated, do not edit

module sokol.time;

extern(C) void stm_setup() @system @nogc nothrow;
void setup() @trusted @nogc nothrow {
    stm_setup();
}
extern(C) ulong stm_now() @system @nogc nothrow;
ulong now() @trusted @nogc nothrow {
    return stm_now();
}
extern(C) ulong stm_diff(ulong, ulong) @system @nogc nothrow;
ulong diff(ulong new_ticks, ulong old_ticks) @trusted @nogc nothrow {
    return stm_diff(new_ticks, old_ticks);
}
extern(C) ulong stm_since(ulong) @system @nogc nothrow;
ulong since(ulong start_ticks) @trusted @nogc nothrow {
    return stm_since(start_ticks);
}
extern(C) ulong stm_laptime(ulong *) @system @nogc nothrow;
ulong laptime(scope ulong * last_time) @trusted @nogc nothrow {
    return stm_laptime(last_time);
}
extern(C) ulong stm_round_to_common_refresh_rate(ulong) @system @nogc nothrow;
ulong roundToCommonRefreshRate(ulong frame_ticks) @trusted @nogc nothrow {
    return stm_round_to_common_refresh_rate(frame_ticks);
}
extern(C) double stm_sec(ulong) @system @nogc nothrow;
double sec(ulong ticks) @trusted @nogc nothrow {
    return stm_sec(ticks);
}
extern(C) double stm_ms(ulong) @system @nogc nothrow;
double ms(ulong ticks) @trusted @nogc nothrow {
    return stm_ms(ticks);
}
extern(C) double stm_us(ulong) @system @nogc nothrow;
double us(ulong ticks) @trusted @nogc nothrow {
    return stm_us(ticks);
}
extern(C) double stm_ns(ulong) @system @nogc nothrow;
double ns(ulong ticks) @trusted @nogc nothrow {
    return stm_ns(ticks);
}
