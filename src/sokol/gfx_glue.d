module sokol.gfx_glue;

import sokol.gfx;
import sokol.app;

ContextDesc context()
{

    return ContextDesc(
        app.colorFormat(),
        app.depthFormat(),
        app.sampleCount(),

        MetalContextDesc(
            app.metal.device(),
            &app.metal.renderPassDesc,
            &app.metal.drawable
    ),

    D3D11ContextDesc(
        app.d3d11.device(),
        app.d3d11.deviceContext(),
        &app.d3d11.renderTargetView,
        &app.d3d11.depthStencilView
    ),

    WGPUContextDesc(
        app.wgpu.device(),
        &app.wgpu.renderView,
        &app.wgpu.resolveView,
        &app.wgpu.depthStencilView
    )
    );

}
