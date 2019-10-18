#version 150

float TWO_PI = 6.28318530718;

out vec4 outputColor;
uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform vec2 sphere2;

uniform vec3 a;
uniform vec3 b;
uniform vec3 c;
uniform vec3 d;
////pink and green
vec3 colA =vec3(0.792, 0.082, 0.318);
vec3 colB =vec3(0.059, 1.0, 0.584);





float rand(vec2 co)
{
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

//--------------------------------------------------------------
vec3 pal( in float t, in vec3 a, in vec3 b, in vec3 c, in vec3 d )
{
    return a + b*cos( 6.28318*(c*t+d) );
}


//--------------------------------------------------------------
void main()
{
    
   
        vec2 st = gl_FragCoord.xy/u_resolution.xy;
        st *=2.0;
        st -=0.5;
        st.x *= u_resolution.x/u_resolution.y;
    
        st.y += rand(st) * 0.5;
        st.x += rand(st) * 0.5;
    
        vec3 col = vec3(0.3)*st.y * 0.5+ 0.5;
        outputColor = vec4(col  , 1.0);
}

