// machine generated, do not edit

module sokol.time;

// helper function to convert a C string to a D string
string cStrToDString(const(char*) c_str)
{
    import std.conv : to;

    return c_str.to!string;
}

extern (C) void stm_setup();
void setup()
{
    stm_setup();
}

extern (C) ulong stm_now();
ulong now()
{
    return stm_now();
}

extern (C) ulong stm_diff(ulong, ulong);
ulong diff(ulong new_ticks, ulong old_ticks)
{
    return stm_diff(new_ticks, old_ticks);
}

extern (C) ulong stm_since(ulong);
ulong since(ulong start_ticks)
{
    return stm_since(start_ticks);
}

extern (C) ulong stm_laptime(ulong*);
ulong laptime(ulong* last_time)
{
    return stm_laptime(last_time);
}

extern (C) ulong stm_round_to_common_refresh_rate(ulong);
ulong roundToCommonRefreshRate(ulong frame_ticks)
{
    return stm_round_to_common_refresh_rate(frame_ticks);
}

extern (C) double stm_sec(ulong);
double sec(ulong ticks)
{
    return stm_sec(ticks);
}

extern (C) double stm_ms(ulong);
double ms(ulong ticks)
{
    return stm_ms(ticks);
}

extern (C) double stm_us(ulong);
double us(ulong ticks)
{
    return stm_us(ticks);
}

extern (C) double stm_ns(ulong);
double ns(ulong ticks)
{
    return stm_ns(ticks);
}
