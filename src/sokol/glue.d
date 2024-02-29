// machine generated, do not edit

module sokol.glue;
import sg = sokol.gfx;

extern(C) sg.Environment sglue_environment() @system @nogc nothrow;
sg.Environment environment() @trusted @nogc nothrow {
    return sglue_environment();
}
extern(C) sg.Swapchain sglue_swapchain() @system @nogc nothrow;
sg.Swapchain swapchain() @trusted @nogc nothrow {
    return sglue_swapchain();
}
