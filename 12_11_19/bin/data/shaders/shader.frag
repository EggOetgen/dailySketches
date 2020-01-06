// fragment shader
#version 150
precision highp float;
// this is how we receive the texture
uniform sampler2DRect tex0;
in vec2 varyingtexcoord;
out vec4 outputColor;
uniform float mouseX;
uniform float mouseY;
uniform vec2 u_resolution;
uniform float u_time;

uniform int multiplicationFactor = 10;
uniform float threshold = 0.01;
#define TWO_PI 6.28318530718
void main()
{
    
    vec4 col = texture(tex0, varyingtexcoord);
//    if(col.x >0)
//        col.x=200;
//        col.y=200;

    vec2 st = varyingtexcoord / u_resolution;
//  vec2 st  gl_FragCoord.xy/u_resolution.xy;
//    if(((st.y) <=((cos(u_time * TWO_PI ))* 0.3*st.y) + 0.5 + (sin(st.y * TWO_PI * u_time) * 0.2))){
//
     if(((st.x) <(((cos(u_time ))* 0.2*st.x)  + (sin(st.y * TWO_PI +u_time ) * 0.2))+ 0.8 ) &&  ( (st.x) >(((sin(u_time ))* 0.17*st.x)  + (sin(st.y *1.2 * TWO_PI +u_time ) * 0.2))+ 0.4 )){
//    if(((st.x) >(((cos(u_time ))* 0.2*st.x)  + (sin(st.y * TWO_PI +u_time ) * 0.2))+ 0.8 ) ){
//    if( ( (st.x) <(((sin(u_time ))* 0.17*st.x)  + (sin(st.y *1.2 * TWO_PI +u_time ) * 0.2))+ 0.4 )){

    float spoint = abs((((cos(u_time)) *0.2) +0.5) -(((sin(u_time *0.8))*0.3) +0.5 )) ;
    
//         col = col/2.0;
         if(col == vec4(1.0)){
            col = vec4(0.2,0.0,0.6, 1.0) ;
         }else
              col = vec4(0.8,1.0,0.6, 1.0) ;
    }
//    if((sin(st.y) <=((cos(u_time))* 0.25) +0.4&& sin(st.y) >=((sin(u_time ))*0.3) +0.5 )||(sin(st.y) >=((cos(u_time))* 0.25) +0.5&& sin(st.y) <=((sin(u_time ))*0.3) +0.5 ) &&((st.x) <=((cos(u_time))* 0.3) +0.6&& st.x >=((sin(u_time ))*0.3) +0.5 )||((st.x) >=((cos(u_time))* 0.3) +0.6&& st.x <=((sin(u_time ))*0.3) +0.5 ) ){
//
//        col = vec4(1.0, 1.0,1.0, 1.0);// - (col/2);
//
//    }
//
    outputColor = col;

}


