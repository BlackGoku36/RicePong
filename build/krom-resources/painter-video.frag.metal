// painter_video_frag_main

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct painter_video_frag_main_in
{
    float4 color [[user(locn0)]];
    float2 texCoord [[user(locn1)]];
};

struct painter_video_frag_main_out
{
    float4 FragColor [[color(0)]];
};

fragment painter_video_frag_main_out painter_video_frag_main(painter_video_frag_main_in in [[stage_in]], texture2d<float> tex [[texture(0)]], sampler texSmplr [[sampler(0)]])
{
    painter_video_frag_main_out out = {};
    float4 texcolor = tex.sample(texSmplr, in.texCoord) * in.color;
    float3 _32 = texcolor.xyz * in.color.w;
    texcolor = float4(_32.x, _32.y, _32.z, texcolor.w);
    out.FragColor = texcolor;
    return out;
}

