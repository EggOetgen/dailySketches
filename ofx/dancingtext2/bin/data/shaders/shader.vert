#version 150
#define TWO_PI 6.28318530718
precision highp float;
// these are for the programmable pipeline system and are passed in
// by default from OpenFrameworks
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 textureMatrix;
uniform mat4 modelViewProjectionMatrix;



in vec4 position;
in vec4 color;
in vec4 normal;
in vec2 texcoord;
// this is the end of the default functionality

// this is something we're creating for this shader
out vec2 varyingtexcoord;
out vec2 origtexcoord;
// this is coming from our C++ code
uniform float mouseX;
uniform float mouseY;
uniform vec2 u_resolution;

uniform vec2 u_mouse;
uniform float u_time;

float rand(vec2 co)
{
    //    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
    return (dot(sin(co.x * TWO_PI ), cos(TWO_PI * co.y )));
    //    return (dot(sin(co.x * TWO_PI), cos(TWO_PI * co.y))) + fract(sin(dot(co.xy ,vec2(12.9898,78.233))) );;
    
}

void main()
{
    
    vec2 st = texcoord / u_resolution;
    origtexcoord = texcoord;
//    st *= 2.0;
//    st -= 1.0;
    vec2 m = u_mouse/u_resolution;
    float mx = mouseX/u_resolution.x;
       float my = mouseY/u_resolution.y;
    mx*=2.0;
    my*=5.0;
    float scl =1.0-fract(sqrt(  (   (st.x - mx) * (st.x - mx) ) +
                                (   (st.y - my) * (st.y - my) )   ));
    
//        float spoint = abs((((cos(u_time)) *0.2) +0.5) -(((sin(u_time *0.8))*0.3) +0.5 )) * u_resolution.x;
//    float spoint = 1.0;//(((cos(u_time))* 0.1) +0.6)*u_resolution.y ;//(cos(u_time)* 0.3) +0.6;  float spoint
             float spoint =((((sin(20  ))* 0.17*st.x)  + (sin(st.y *1.2 * TWO_PI  ) * 0.2))+ 0.4 )*u_resolution.x;
//             float spoint = mouseX;
         varyingtexcoord = vec2(mix(spoint+(sin(st.x * 3  ) * 5 ),texcoord.x, mx) , mix(texcoord.y+(cos(st.y  * 3  ) * 5 ),texcoord.y, my) );
   
//    varyingtexcoord = vec2(spoint+(sin(st.x * u_time * 3  ) * 5 ),texcoord.y+(cos(st.y * u_time * 2  ) * 5 ) );
    vec4 pos = position;
//    pos.x =mix(spoint+(sin(st.x * u_time * 3  ) * 5 ),texcoord.x, mx);
//    pos.y = mix(texcoord.y+(cos(st.y * u_time * 2  ) * 5 ),texcoord.y, my) ;
//    pos.x += rand(st)*u_resolution.x * mx;
//    pos.y+= rand(st)*u_resolution.y *my ;
//    // send the vertices to the fragment shader
    gl_Position = modelViewProjectionMatrix * pos;
}
