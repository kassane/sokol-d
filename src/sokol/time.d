/++
+ Machine generated D bindings for Sokol library.
+ 
+     Generated on: 2025-08-15 15:48:52
+ 
+     Source header: sokol_time.h
+     Module: sokol.time
+ 
+     Do not edit manually; regenerate using gen_d.py.
+/
module sokol.time;

extern(C) void stm_setup() @system @nogc nothrow pure;
void setup() @trusted @nogc nothrow pure {
    stm_setup();
}
extern(C) ulong stm_now() @system @nogc nothrow pure;
ulong now() @trusted @nogc nothrow pure {
    return stm_now();
}
extern(C) ulong stm_diff(ulong new_ticks, ulong old_ticks) @system @nogc nothrow pure;
ulong diff(ulong new_ticks, ulong old_ticks) @trusted @nogc nothrow pure {
    return stm_diff(new_ticks, old_ticks);
}
extern(C) ulong stm_since(ulong start_ticks) @system @nogc nothrow pure;
ulong since(ulong start_ticks) @trusted @nogc nothrow pure {
    return stm_since(start_ticks);
}
extern(C) ulong stm_laptime(ulong* last_time) @system @nogc nothrow pure;
ulong laptime(ulong* last_time) @trusted @nogc nothrow pure {
    return stm_laptime(last_time);
}
extern(C) ulong stm_round_to_common_refresh_rate(ulong frame_ticks) @system @nogc nothrow pure;
ulong roundToCommonRefreshRate(ulong frame_ticks) @trusted @nogc nothrow pure {
    return stm_round_to_common_refresh_rate(frame_ticks);
}
extern(C) double stm_sec(ulong ticks) @system @nogc nothrow pure;
double sec(ulong ticks) @trusted @nogc nothrow pure {
    return stm_sec(ticks);
}
extern(C) double stm_ms(ulong ticks) @system @nogc nothrow pure;
double ms(ulong ticks) @trusted @nogc nothrow pure {
    return stm_ms(ticks);
}
extern(C) double stm_us(ulong ticks) @system @nogc nothrow pure;
double us(ulong ticks) @trusted @nogc nothrow pure {
    return stm_us(ticks);
}
extern(C) double stm_ns(ulong ticks) @system @nogc nothrow pure;
double ns(ulong ticks) @trusted @nogc nothrow pure {
    return stm_ns(ticks);
}
