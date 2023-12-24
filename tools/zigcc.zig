//! zig-cc wrapper

const std = @import("std");

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

    try cmds.append("-lunwind");

    while (args.next()) |arg| {
        try cmds.append(arg);
    }
    var proc = std.ChildProcess.init(cmds.items, allocator);
    // proc.stdin_behavior = .Ignore;
    // proc.stderr_behavior = .Ignore;

    // See all flags
    for (cmds.items) |cmd|
        std.debug.print("{s}\n", .{cmd});

    _ = try proc.spawnAndWait();
}
