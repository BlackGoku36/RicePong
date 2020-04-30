// painter_colored_frag_main

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct painter_colored_frag_main_in
{
    float4 fragmentColor [[user(locn0)]];
};

struct painter_colored_frag_main_out
{
    float4 FragColor [[color(0)]];
};

fragment painter_colored_frag_main_out painter_colored_frag_main(painter_colored_frag_main_in in [[stage_in]])
{
    painter_colored_frag_main_out out = {};
    out.FragColor = in.fragmentColor;
    return out;
}

