module sokol.glue;

import sg = sokol.gfx;
import sapp = sokol.app;

extern(C) sg.ContextDesc context() @trusted @nogc nothrow {
   sg.ContextDesc ctx = {
        color_format: sapp.colorFormat(),
        depth_format: sapp.depthFormat(),
        sample_count: sapp.sampleCount(),
        metal: {
            device: sapp.metalGetDevice(),
            renderpass_descriptor_cb: &sapp.sapp_metal_get_renderpass_descriptor,
            drawable_cb: &sapp.sapp_metal_get_drawable,
        },
        d3d11: {
            device: sapp.d3d11GetDevice(),
            device_context: sapp.d3d11GetDeviceContext(),
            render_target_view_cb: &sapp.sapp_d3d11_get_render_target_view,
            depth_stencil_view_cb: &sapp.sapp_d3d11_get_depth_stencil_view,
        },
        wgpu: {
            device: sapp.wgpuGetDevice(),
            render_view_cb: &sapp.sapp_wgpu_get_render_view,
            resolve_view_cb: &sapp.sapp_wgpu_get_resolve_view,
            depth_stencil_view_cb: &sapp.sapp_wgpu_get_depth_stencil_view,
        },
    };
    return ctx;
}
