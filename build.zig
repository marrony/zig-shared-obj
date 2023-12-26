const std = @import("std");

pub fn build(b: *std.Build) void {
    const default_target = std.zig.CrossTarget.parse(.{
        .arch_os_abi = "arm-linux-gnueabihf",
    }) catch @panic("unknown target");

    const target = b.standardTargetOptions(.{
        .default_target = default_target,
    });

    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "zig-shared-obj",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    exe.addLibraryPath(.{ .path = "lib" });
    exe.addIncludePath(.{ .path = "include" });
    exe.defineCMacro("TARGET_OS_LINUX", null);
    exe.linkLibC();

    exe.linkSystemLibrary(":libEDSDK.so");
    exe.addRPathSpecial("$ORIGIN");

    b.installArtifact(exe);
}
