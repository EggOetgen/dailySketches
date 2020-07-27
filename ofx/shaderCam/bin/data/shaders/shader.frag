// fragment shader
#version 150
precision highp float;
// this is how we receive the texture
uniform sampler2DRect tex0;
in vec2 origtexcoord;
in vec2 varyingtexcoord;
out vec4 outputColor;
uniform float mouseX;
uniform float mouseY;
uniform vec2 u_resolution;
uniform float u_time;

uniform int multiplicationFactor = 10;
uniform float threshold = 0.01;
#define TWO_PI 6.28318530718

float rand(vec2 co)
{
//    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
    return pow(co.x, co.y);
}
void main()
{
    vec2 st = varyingtexcoord / u_resolution;
    vec4 col = texture(tex0, varyingtexcoord);
    vec4 colB = texture(tex0, varyingtexcoord);
    vec2 dispTexCo = origtexcoord;
     vec2 dispTexCoV = varyingtexcoord;
    
    float mx = mouseX/u_resolution.x;
    float my = mouseY/u_resolution.y;
    mx -= 0.5;
    my -= 0.5;
    mx*=st.x;
    my*=st.y;
//    dispTexCoV.x += rand(st)*u_resolution.x * 0.05;
//    dispTexCoV.y+= rand(st)*u_resolution.y * 0.05;
//
//    dispTexCo.x += rand(st)*u_resolution.x * 0.05;
//    dispTexCo.y+= rand(st)*u_resolution.y * 0.05;
//
//    dispTexCoV.x += rand(st)*u_resolution.x * mx;
//    dispTexCoV.y+= rand(st)*u_resolution.y *my ;
//    dispTexCo.x += rand(st)*u_resolution.x * mx;
//    dispTexCo.y+= rand(st)*u_resolution.y * my;
    
        dispTexCoV.x += u_resolution.x * mx;
        dispTexCoV.y+= u_resolution.y *my ;
        dispTexCo.x += rand(st)*u_resolution.x * mx;
        dispTexCo.y+= rand(st)*u_resolution.y * my;

    
    col = texture(tex0, dispTexCoV);
    colB = texture(tex0, dispTexCo);
//      float mx = mouseX/u_resolution.x;
//    float my = mouseY/u_resolution.y;
    mx*=2.0;
    my*=2.0;
    
     colB.g = texture(tex0, vec2(dispTexCo.x - my, dispTexCo.y + mx)).g;
     colB.b = texture(tex0, vec2(dispTexCo.x - mx, dispTexCo.y + my)).g;
    col.r *= 0.2126;

    col.g *= 0.7252;
    col.b *= 0.722;

    float g = col.r + col.g + col.b;
    if ( g <= 0.0031308)
        g = 12.92 * g;
    else
        g = pow(1.055 * g, 1/2.4) - 0.055;
    
//
//    if(g > 0.8)
//        col = vec4(vec3(0.6392,0.0,0.0823), 1.0);
//    else
//        col = vec4(vec3(0.2352, 0.08235,0.2313), 1.0);
//
//     g = colB.r + colB.g + colB.b;
//    if ( g <= 0.0031308)
//        g = 12.92 * g;
//    else
//        g = pow(1.055 * g, 1/2.4) - 0.055;
//
//
//    if(g > 0.9)
//        colB = vec4(vec3(0.236,0.0 ,1.0-(0.4 * g)), 1.0);
//    else
//        colB  = vec4(vec3(0.236, 0.0,0.04), 1.0);
//
//

//
    if(g > 0.8)
        col = vec4(vec3(0.0823), 1.0);
    else
        col = vec4(vec3(0.2352), 1.0);

    g = colB.r + colB.g + colB.b;
    if ( g <= 0.0031308)
        g = 12.92 * g;
    else
        g = pow(1.055 * g, 1/2.4) - 0.055;

    if(g > 0.8)
        col = vec4(vec3(1.0), 1.0);
    else
        col = vec4(vec3(0.0), 1.0);
//
//    g = colB.r + colB.g + colB.b;
//    if ( g <= 0.0031308)
//        g = 12.92 * g;
//    else
//        g = pow(1.055 * g, 1/2.4) - 0.055;
//
//    if(g > 0.9)
//        colB = vec4(vec3(1.0-(0.4 * g)), 1.0);
//    else
//        colB  = vec4(vec3(0.04), 1.0);
//

    
//    if(g > 0.8)
//        col = vec4(vec3(0.0823 *vec3(0.6392,0.0,0.0823)), 1.0);
//    else
//        col = vec4(vec3(0.2352 * vec3(0.236,0.0 ,1.0-(0.4 * g))), 1.0);
//
//    g = colB.r + colB.g + colB.b;
//    if ( g <= 0.0031308)
//        g = 12.92 * g;
//    else
//        g = pow(1.055 * g, 1/2.4) - 0.055;
    
//    
//    if(g > 0.9)
//        colB = vec4(vec3(0.6392,0.0,0.0823) * g, 1.0);
//    else
//        colB  = vec4(vec3(0.04), 1.0);
    
    
//    col.r = 0.7;
//    col.g = 0.5*col.g;
//    col.b = 0.5*col.b;
//    if(col.x >0)
//        col.x=200;
//        col.y=200;
//    float mx = mouseX/u_resolution.x;
//    float my = mouseY/u_resolution.y;
  
//  vec2 st  gl_FragCoord.xy/u_resolution.xy;
////    if(((st.y) <=((cos(u_time * TWO_PI ))* 0.3*st.y) + 0.5 + (sin(st.y * TWO_PI * u_time) * 0.2))){
////
//     if(((st.x) <(((cos(u_time ))* 0.2*st.x)  + (sin(st.y * TWO_PI +u_time ) * 0.2))+ 0.8 ) &&  ( (st.x) >(((sin(u_time ))* 0.17*st.x)  + (sin(st.y *1.2 * TWO_PI +u_time ) * 0.2))+ 0.4 )){
////    if(((st.x) >(((cos(u_time ))* 0.2*st.x)  + (sin(st.y * TWO_PI +u_time ) * 0.2))+ 0.8 ) ){
////    if( ( (st.x) <(((sin(u_time ))* 0.17*st.x)  + (sin(st.y *1.2 * TWO_PI +u_time ) * 0.2))+ 0.4 )){
//
//    float spoint = abs((((cos(u_time)) *0.2) +0.5) -(((sin(u_time *0.8))*0.3) +0.5 )) ;
//    
////         col = col/2.0;
//         if(col == vec4(1.0)){
//            col = vec4(0.2,0.0,0.6, 1.0) ;
//         }else
//              col = vec4(0.8,1.0,0.6, 1.0) ;
//    }
    float spoint =((((sin(u_time ))* 0.17*st.x)  + (sin(st.y *1.2 * TWO_PI +u_time ) * 0.2))+ 0.4 )*u_resolution.x;

//     col = vec4(col.r, col.g, col.b,mix(spoint+(sin(st.x * u_time * 3  ) * 5 ),varyingtexcoord.x, mx));
//    if(mix(spoint+(sin(st.x * u_time * 3  ) * 5 ),varyingtexcoord.x, mx) > u_resolution.x ||mix(spoint+(sin(st.x * u_time * 3  ) * 5 ),varyingtexcoord.x, mx) <= 0.0 ){
        //black and white
//        col = vec4(vec3(mix(spoint+(sin(st.x * u_time * 3  ) * 5 ),varyingtexcoord.x, mx))*0.001, 1.0);
        
//           col = vec4(vec3(abs( 1.0 - mix(spoint+(sin(st.x * u_time * 3  ) * 5 ),varyingtexcoord.x, mx))), 1.0);
//        col = colB;
//        col.r = 0.7;
//        col.g = 0.5*col.g;
//        col.b = 0.5*col.b;

//        col.a = 0.0;
//        col.y += rand(st) - 0.5;
//        col.x += rand(st.yx) - 0.5;
////           col.x = rand(st.yx);
//        col.z += rand(col.yx) - 0.5;
//        col = vec4(0.4, 0.0, 0.1, 1.0);
//        vec2 dispTexCo = origtexcoord;
//        dispTexCo.x += rand(st)*u_resolution.x * 0.05;
//        dispTexCo.y+= rand(st)*u_resolution.y * 0.05;
//         col = texture(tex0, dispTexCo);

//    }
//    if((sin(st.y) <=((cos(u_time))* 0.25) +0.4&& sin(st.y) >=((sin(u_time ))*0.3) +0.5 )||(sin(st.y) >=((cos(u_time))* 0.25) +0.5&& sin(st.y) <=((sin(u_time ))*0.3) +0.5 ) &&((st.x) <=((cos(u_time))* 0.3) +0.6&& st.x >=((sin(u_time ))*0.3) +0.5 )||((st.x) >=((cos(u_time))* 0.3) +0.6&& st.x <=((sin(u_time ))*0.3) +0.5 ) ){
//
//        col = vec4(1.0, 1.0,1.0, 1.0);// - (col/2);
//
//    }
//
    outputColor = col;

}


