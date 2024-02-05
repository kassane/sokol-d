//------------------------------------------------------------------------------
//  triangle.d
//
//  Vertex buffer, shader, pipeline state object.
//------------------------------------------------------------------------------
module examples.triangle;

import sg = sokol.gfx;
import sapp = sokol.app;
import log = sokol.log;
import sgapp = sokol.glue;
import sgutil = sokol.utils;

extern (C):
@safe:

struct State
{
  static sg.Bindings bind;
  static sg.Pipeline pip;
}

void init() @trusted
{
  sg.Desc gfx = {context: sgapp.context(),
  logger: {func: &log.slog_func}};
  sg.setup(gfx);
  State state;

  // create vertex buffer with triangle vertices
  float[21] vertices = [
    // positions         colors
    0.0, 0.5, 0.5, 1.0, 0.0, 0.0, 1.0,
    0.5, -0.5, 0.5, 0.0, 1.0, 0.0, 1.0,
    -0.5, -0.5, 0.5, 0.0, 0.0, 1.0, 1.0,
  ];
  sg.BufferDesc buff = {data: sgutil.asRange(&vertices[0])};
  state.bind.vertex_buffers[0] = sg.makeBuffer(buff);

  // create a shader and pipeline object
  sg.ShaderDesc shader = shaderDesc();
  const shd = sg.makeShader(shader);
  sg.PipelineDesc pip_desc = {shader: shd};
  pip_desc.layout.attrs[0].format = sg.VertexFormat.Float3;
  pip_desc.layout.attrs[1].format = sg.VertexFormat.Float4;
  state.pip = sg.makePipeline(pip_desc);
}

void frame()
{
  State state;
  // default pass-action clears to grey
  sg.PassAction pass_action;
  sg.beginDefaultPass(pass_action, sapp.width(), sapp.height());
  sg.applyPipeline(state.pip);
  sg.applyBindings(state.bind);
  sg.draw(0, 3, 1);
  sg.endPass();
  sg.commit();
}

void cleanup()
{
  sg.shutdown();
}

void main()
{
  sapp.Desc runner = {
    window_title: "triangle.d",
    init_cb: &init,
    frame_cb: &frame,
    cleanup_cb: &cleanup,
    width: 800,
    height: 600,
    icon: {sokol_default: true},
    logger: {func: &log.func}
  };
  sapp.run(runner);
}

sg.ShaderDesc shaderDesc() @trusted nothrow @nogc
{
  sg.ShaderDesc desc;
  switch (sg.queryBackend)
  {
  case sg.Backend.Glcore33:
    desc.attrs[0].name = "position";
    desc.attrs[1].name = "color0";
    desc.vs.source = "
                #version 330
                in vec4 position;
                in vec4 color0;
                out vec4 color;
                void main() {
                  gl_Position = position;
                  color = color0;
                }";
    desc.fs.source = "
                #version 330
                in vec4 color;
                out vec4 frag_color;
                void main() {
                  frag_color = color;
                }";
    break;
  case sg.Backend.D3d11:
    desc.attrs[0].sem_name = "POS";
    desc.attrs[1].sem_name = "COLOR";
    desc.vs.source = "
                struct vs_in {
                  float4 pos: POS;
                  float4 color: COLOR;
                };
                struct vs_out {
                  float4 color: COLOR0;
                  float4 pos: SV_Position;
                };
                vs_out main(vs_in inp) {
                  vs_out outp;
                  outp.pos = inp.pos;
                  outp.color = inp.color;
                  return outp;
                }
            ";
    desc.fs.source = "
                float4 main(float4 color: COLOR0): SV_Target0 {
                  return color;
                }
            ";
    break;
  case sg.Backend.Metal_macos:
    desc.vs.source = "
                #include <metal_stdlib>
                using namespace metal;
                struct vs_in {
                  float4 position [[attribute(0)]];
                  float4 color [[attribute(1)]];
                };
                struct vs_out {
                  float4 position [[position]];
                  float4 color;
                };
                vertex vs_out _main(vs_in inp [[stage_in]]) {
                  vs_out outp;
                  outp.position = inp.position;
                  outp.color = inp.color;
                  return outp;
                }
            ";
    desc.fs.source = "
                #include <metal_stdlib>
                using namespace metal;
                fragment float4 _main(float4 color [[stage_in]]) {
                  return color;
                };
            ";
    break;
  default:
    break;
  }
  return desc;
}
