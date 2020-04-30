// painter_colored_vert_main

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct painter_colored_vert_main_in
{
    float3 vertexPosition [[attribute(0)]];
    float4 vertexColor [[attribute(1)]];
};

struct painter_colored_vert_main_out
{
    float4 fragmentColor [[user(locn0)]];
    float4 gl_Position [[position]];
};

struct painter_colored_vert_main_uniforms
{
    float4x4 projectionMatrix;
};

vertex painter_colored_vert_main_out painter_colored_vert_main(painter_colored_vert_main_in in [[stage_in]], constant painter_colored_vert_main_uniforms& uniforms [[buffer(1)]], uint gl_VertexID [[vertex_id]], uint gl_InstanceID [[instance_id]])
{
    painter_colored_vert_main_out out = {};
    out.gl_Position = uniforms.projectionMatrix * float4(in.vertexPosition, 1.0);
    out.fragmentColor = in.vertexColor;
    out.gl_Position.z = (out.gl_Position.z + out.gl_Position.w) * 0.5;       // Adjust clip-space for Metal
    return out;
}

