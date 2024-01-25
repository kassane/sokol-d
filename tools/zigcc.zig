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

    if (builtin.os.tag != .windows) {
        // not working on msvc target (nostdlib++)
        try cmds.append("-lunwind");
    }

    // LDC2 not setting triple targets on host build to cc/linker, except Apple (why?)
    var isNative = true;
    while (args.next()) |arg| {
        // MacOS M1/M2 target, replace aarch64 to arm64
        if (std.mem.eql(u8, arg, std.fmt.comptimePrint("{s}-apple-{s}", .{ if (builtin.cpu.arch.isAARCH64()) "arm64" else @tagName(builtin.cpu.arch), @tagName(builtin.os.tag) }))) {
            try cmds.append("native-native");
            try cmds.append("-fapple-link-rtlib");
        } else if (std.mem.eql(u8, arg, std.fmt.comptimePrint("{s}-unknown-unknown-{s}", .{ @tagName(builtin.cpu.arch), @tagName(builtin.os.tag) }))) {
            // wasm32 or wasm64
            try cmds.append(std.fmt.comptimePrint("{s}-emscripten", .{@tagName(builtin.cpu.arch)}));
        } else if (std.mem.eql(u8, arg, std.fmt.comptimePrint("{s}-unknown-{s}", .{ @tagName(builtin.cpu.arch), @tagName(builtin.os.tag) }))) {
            try cmds.append(std.fmt.comptimePrint("{s}-{s}", .{ @tagName(builtin.cpu.arch), @tagName(builtin.os.tag) }));
        } else if (std.mem.eql(u8, arg, "-target")) {
            isNative = false;
            try cmds.append(arg); // get "-target" flag
        } else {
            try cmds.append(arg);
        }
    }
    // Why native? See: https://github.com/kassane/sokol-d/issues/1
    if (isNative) {
        try cmds.append("-target");
        if (builtin.os.tag == .windows)
            try cmds.append("native-native-msvc")
        else {
            try cmds.append("native-native");
        }
    }

    var proc = std.ChildProcess.init(cmds.items, allocator);

    // See all flags
    // std.debug.print("debug flags: ", .{});
    // for (cmds.items) |cmd|
    //     std.debug.print("{s} ", .{cmd});

    _ = try proc.spawnAndWait();
}
