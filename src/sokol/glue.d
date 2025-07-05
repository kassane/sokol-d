/++
+ Machine generated D bindings for Sokol library.
+ 
+     Generated on: 2025-06-30 14:41:18
+ 
+     Source header: sokol_glue.h
+     Module: sokol.glue
+ 
+     Do not edit manually; regenerate using gen_d.py.
+/
module sokol.glue;
import sg = sokol.gfx;

extern(C) sg.Environment sglue_environment() @system @nogc nothrow pure;
sg.Environment environment() @trusted @nogc nothrow pure {
    return sglue_environment();
}
extern(C) sg.Swapchain sglue_swapchain() @system @nogc nothrow pure;
sg.Swapchain swapchain() @trusted @nogc nothrow pure {
    return sglue_swapchain();
}
