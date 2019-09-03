#version 150

out vec4 outputColor;
uniform float u_time;
float TWO_PI = 6.28318530718;
uniform vec2 u_resolution;
//void main()
//{
//    // gl_FragCoord contains the window relative coordinate for the fragment.
//    // we use gl_FragCoord.x position to control the red color value.
//    // we use gl_FragCoord.y position to control the green color value.
//    // please note that all r, g, b, a values are between 0 and 1.
//
//    float windowWidth = 1024.0;
//    float windowHeight = 768.0;
//
//    float r = gl_FragCoord.x / windowWidth;
//    float g = gl_FragCoord.y / windowHeight;
//    float b = 1.0;
//    float a = 1.0;
//    outputColor = vec4(r, g, b, a);
//}

//--------------------------------------------------------------
float rand(vec2 co)
{
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}
vec3 pal( in float t, in vec3 a, in vec3 b, in vec3 c, in vec3 d )
{
    return a + b*cos( 6.28318*(c*t+d) );
}

void main()
{
    vec2 p =  gl_FragCoord.xy/u_resolution.xy;
    float tx = u_time * 0.5;
    
    p.y += rand(p ) * 0.0001;
    p.x += rand(p) * 0.0001;
    p *=2.;
    p -=vec2(0.00,1.500);
    // animate
    // p.x += 0.01*u_time;
    p.x = sin(p.x);
    p.y = cos(p.y);
    // compute colors
    vec3                col =pal( (sin(p.x * TWO_PI) * 0.012) - 2.968, vec3(0.5),vec3((p.x * TWO_PI) ),vec3(mix(1.0,(p.y *p.y), cos(sin(tx * 0.5) * p.x*1.2 * p.y*10.3)))* 0.5,vec3(0.0,0.15,0.2) );
    
    // band
    
    outputColor = vec4( col, 1.0 );
}
