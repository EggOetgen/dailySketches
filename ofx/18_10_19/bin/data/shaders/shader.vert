#version 150

// these are for the programmable pipeline system and are passed in
// by default from OpenFrameworks
uniform mat4 modelViewProjectionMatrix;

in vec4 position;
in vec2 texcoord;
uniform vec2 u_resolution;
// this is something we're creating for this shader
out vec2 texCoordVarying;

// this is coming from our C++ code
uniform float mouseX;
uniform float mouseY;

uniform float offset;

float random (vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
                 43758.5453123);
}
void main()
{
    
//    texCoordVarying = fract(texcoord);
//    if(texcoord.x < mouseX)
    vec2 st = texcoord.xy/u_resolution;
    st.x *=1000;
    st.y *=1000;
    
    if( (sin(st.x))< mouseX/u_resolution.x && (cos(st.y))< mouseY/u_resolution.y){
//        if( ((st.x))< mouseX/u_resolution.x){
//            if( ((st.y))> mouseY/u_resolution.y){

//    if( (sin(st.x))< mouseX/u_resolution.x ){
//    if( st.x < 0.5){

    texCoordVarying = vec2(st.x*u_resolution.x,st.y*u_resolution.y);
    } else{
        texCoordVarying = vec2((st.x)*texcoord.x, u_resolution.y * (st.y));
    }
//    st *= 2;
//      texCoordVarying = vec2(st.x*u_resolution.x,st.y*u_resolution.y);
//
  
    gl_Position = modelViewProjectionMatrix * position;
}
