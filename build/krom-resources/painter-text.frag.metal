// painter_text_frag_main

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct painter_text_frag_main_in
{
    float4 fragmentColor [[user(locn0)]];
    float2 texCoord [[user(locn1)]];
};

struct painter_text_frag_main_out
{
    float4 FragColor [[color(0)]];
};

fragment painter_text_frag_main_out painter_text_frag_main(painter_text_frag_main_in in [[stage_in]], texture2d<float> tex [[texture(0)]], sampler texSmplr [[sampler(0)]])
{
    painter_text_frag_main_out out = {};
    out.FragColor = float4(in.fragmentColor.xyz, tex.sample(texSmplr, in.texCoord).x * in.fragmentColor.w);
    return out;
}

