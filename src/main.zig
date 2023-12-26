const std = @import("std");

const c = @cImport({
    @cInclude("stdbool.h");
    @cInclude("EDSDK.h");
});

pub fn main() void {
    if (c.EdsInitializeSDK() != c.EDS_ERR_OK) {
        std.debug.print("Error initializing the library\n", .{});
    }

    std.debug.print("Hello World\n", .{});

    if (c.EdsTerminateSDK() != c.EDS_ERR_OK) {
        std.debug.print("Error terminating the library\n", .{});
    }
}
