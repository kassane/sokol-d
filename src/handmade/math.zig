//! replace "core.stdc.math" to "zig.std.math"
const std = @import("std");

export fn zig_sqrt(x: u64) callconv(.C) u64 {
    return std.math.sqrt(x);
}
export fn zig_sqrtf(x: f64) callconv(.C) f64 {
    return std.math.sqrt(x);
}
export fn zig_cos(x: f64) callconv(.C) f64 {
    return std.math.cos(x);
}
export fn zig_sin(x: f64) callconv(.C) f64 {
    return std.math.sin(x);
}
export fn zig_tan(x: f64) callconv(.C) f64 {
    return std.math.tan(x);
}
