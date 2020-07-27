#version 150

// these are for the programmable pipeline system and are passed in
// by default from OpenFrameworks
uniform mat4 modelViewProjectionMatrix;

in vec4 position;
in vec2 texcoord;

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
    
//      texCoordVarying = vec2(texcoord.x , texcoord.y);
    // here we move the texture coordinates
    texCoordVarying = vec2(texcoord.x + offset +( 10.0 *mouseX *sin(texcoord.x )), texcoord.y+ ( 10.0 *mouseY *cos(texcoord.y )));
//     texCoordVarying = vec2(texcoord.x + ( mouseY *sin(mouseX *texcoord.x )), texcoord.y+ ( mouseY *cos(mouseX *texcoord.y )));
 
    // send the vertices to the fragment shader
    gl_Position = modelViewProjectionMatrix * position;
}
