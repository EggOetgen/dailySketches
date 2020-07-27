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
uniform float u_time;

void main()
{
    
    vec2 st = texcoord / u_resolution;
    origtexcoord = texcoord;
//    st *= 2.0;
//    st -= 1.0;
    float mx = mouseX/u_resolution.x;
       float my = mouseY/u_resolution.y;
    mx*=2.0;
    my*=5.0;
         varyingtexcoord = vec2(texcoord.x +(sin(st.x * u_time * 3  ) * 5 ) , texcoord.y +(cos(st.y * TWO_PI + u_time * 2   ) * 5 ) );
//         if(((st.x) <(((cos(u_time ))* 0.2*st.x)  + (sin(st.y * TWO_PI +u_time ) * 0.2))+ 0.8 ) &&  ( (st.x) >(((sin(u_time ))* 0.17*st.x)  + (sin(st.y *1.2 * TWO_PI +u_time ) * 0.2))+ 0.4 )){
//        float spoint = abs((((cos(u_time)) *0.2) +0.5) -(((sin(u_time *0.8))*0.3) +0.5 )) * u_resolution.x;
//        float spoint = (((cos(u_time))* 0.1) +0.6)*u_resolution.y ;//(cos(u_time)* 0.3) +0.6;  float spoint
             float spoint =((((sin(u_time ))* 0.17*st.x)  + (sin(st.y *1.2 * TWO_PI +u_time ) * 0.2))+ 0.4 )*u_resolution.x;
//             float spoint = mouseX;
         varyingtexcoord = vec2(mix(spoint+(sin(st.x * u_time * 3  ) * 5 ),texcoord.x, mx) , mix(texcoord.y+(cos(st.y * u_time * 2  ) * 5 ),texcoord.y, my) );
//         }
//      varyingtexcoord = vec2(mix(spoint+(sin(st.x * u_time * 3  ) * 5 ),texcoord.x, -2.0) , mix(texcoord.y+(cos(st.y * u_time * 2  ) * 5 ),texcoord.y, 2.0) );
//     if(mix(spoint+(sin(st.x * u_time * 3  ) * 5 ),varyingtexcoord.x, mx) > u_resolution.x ||mix(spoint+(sin(st.x * u_time * 3  ) * 5 ),varyingtexcoord.x, mx) <= 0.0 ){
//           varyingtexcoord = vec2(mix(spoint+(sin(st.y * u_time * 3  ) * 5 ),texcoord.y, -2.0) , mix(texcoord.x+(cos(st.x * u_time * 2  ) * 5 ),texcoord.x, 2.0) );
//     }
////         else   if(((st.x) <(((cos(u_time  ))* 0.3*st.x)  + (sin(st.y * TWO_PI +u_time ) * 0.2))+ 0.8 ) &&  ( (st.x) >(((sin(u_time ))* 0.25*st.x)  + (sin(st.y *1.5 * TWO_PI +u_time ) * 0.2))+ 0.4 )){
////             //        float spoint = abs((((cos(u_time)) *0.2) +0.5) -(((sin(u_time *0.8))*0.3) +0.5 )) * u_resolution.x;
////             //        float spoint = (((cos(u_time))* 0.1) +0.6)*u_resolution.y ;//(cos(u_time)* 0.3) +0.6;
////             float spoint =((((sin(u_time ))* 0.17*st.x)  + (sin(st.x *1.2 * TWO_PI +u_time ) * 0.2))+ 0.4 )*u_resolution.y;
////             varyingtexcoord = vec2(spoint+(sin(st.x * u_time * 3  ) * 5 ) , texcoord.y+(cos(st.y * u_time * 2  ) * 5 ) );
////         }
//else
   

//    }else
//        varyingtexcoord = vec2( texcoord.x, texcoord.y);
//    // send the vertices to the fragment shader
    gl_Position = modelViewProjectionMatrix * position;
}
