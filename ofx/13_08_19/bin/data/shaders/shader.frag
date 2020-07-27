//#version 150
//
//precision highp float;
//out vec4 outputColor;
//
//in vec2 texCoordVarying;
//uniform vec2 u_resolution;
//
//uniform vec2 u_mouse;
//
//uniform float u_time;
//uniform sampler2DRect tex;
//
//
//vec3 blue = vec3(0.035, 0.251, 0.455);
//vec3 pink = vec3(0.788,0.482, 0.518);
//
//
//

//
//void main(){
//    vec2 st = gl_FragCoord.xy/u_resolution.xy;
//    vec3 color = vec3(1.0)-vec3(pink);
//
//    outputColor =   texture(tex,st);
////    outputColor =   vec4(color,1.0);
//
//}

#version 150



// this is how we receive the texture
uniform sampler2DRect tex0;

in vec2 texCoordVarying;

out vec4 outputColor;

float random (vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
                 43758.5453123);
}

void main()
{
    vec4 color =texture(tex0, texCoordVarying);
    color.y += random(texCoordVarying.xy )*0.4;
    color.x += random(texCoordVarying.xy)*0.4;
    color.z += random(texCoordVarying.xy)*0.4;
    outputColor = color;
}
