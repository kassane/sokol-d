//! zig-cc wrapper for ldc2
//! Copyright (c) 2023 Matheus Catarino França <matheus-catarino@hotmail.com>
//! Zlib license

const std = @import("std");
const builtin = @import("builtin");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = std.debug.assert(gpa.deinit() == .ok); // ok or leak
    const allocator = gpa.allocator();

    var args = try std.process.argsWithAllocator(allocator);
    defer args.deinit();

    _ = args.skip(); // skip arg[0]

    var cmds = std.ArrayList([]const u8).init(allocator);
    defer cmds.deinit();

    try cmds.append("zig");
    try cmds.append("cc");

    // LDC2 not set triple targets to cc/linker, except Apple (Why?)
    switch (builtin.os.tag) {
        .windows => {
            try cmds.append("-target");
            try cmds.append("native-native-msvc"); // msvc only
        },
        .macos, .ios => {},
        else => {
            try cmds.append("-target");
            try cmds.append("native-native");
            try cmds.append("-lunwind");
        },
    }

    while (args.next()) |arg| {
        if (std.mem.eql(u8, arg, std.fmt.comptimePrint("{s}-apple-{s}", .{ @tagName(builtin.cpu.arch), @tagName(builtin.os.tag) }))) {
            try cmds.append("native-native");
            try cmds.append("-lunwind");
            try cmds.append("-fapple-link-rtlib");
        } else try cmds.append(arg);
    }
    var proc = std.ChildProcess.init(cmds.items, allocator);

    // See all flags
    // std.debug.print("debug flags: ", .{});
    // for (cmds.items) |cmd|
    //     std.debug.print("{s} ", .{cmd});

    _ = try proc.spawnAndWait();
}
