#version 150

// these are for the programmable pipeline system and are passed in
// by default from OpenFrameworks
uniform mat4 modelViewProjectionMatrix;

in vec4 position;
in vec2 texcoord;

// this is something we're creating for this shader
out vec2 texCoordVarying;

float mouseRange = 20.;
// this is coming from our C++ code
uniform float mouseX;
uniform float mouseY;
uniform vec2 u_mouse;
uniform float u_time;
uniform float offset;

float random (vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
                 43758.5453123);
}
void main()
{
    //     mouseRange =offset*100.;
    //      texCoordVarying = vec2(texcoord.x , texcoord.y);
    // here we move the texture coordinates
    //    offset = 0;
        texCoordVarying = vec2(texcoord.x + offset +( 10.0 *mouseX *sin(texcoord.x )), texcoord.y+ ( 10.0 *mouseY *cos(texcoord.y )));
    texCoordVarying.x+= u_time;
//    texCoordVarying = texcoord.xy;
//         texCoordVarying = vec2(texcoord.x + offset +( 10.0 *mouseX *sin(texcoord.x )),texcoord.y);
//         texCoordVarying = vec2(texcoord.x + ( mouseY *sin(mouseX *texcoord.x )), texcoord.y+ ( mouseY *cos(mouseX *texcoord.y )));
    vec4 pos = position;
    //      for(int i = 0; i < 100; i ++){
    //
    //    vec2 pos2 =vec2(sin(random(pos.xy) * i *  36) * 100., cos(random(pos.yx) *  i * 36) * 100. );
    //
    //
    //    // direction vector from mouse position to vertex position.
    //    vec2 dir = pos.xy - pos2;
    //
    //    // distance between the mouse position and vertex position.
    //    float dist =  sqrt(dir.x * dir.x + dir.y * dir.y);
    //
    //    // check vertex is within mouse range.
    //    if(dist > 0.0 && dist < mouseRange) {
    //
    //        // normalise distance between 0 and 1.
    //        float distNorm = dist / mouseRange;
    //
    //        // flip it so the closer we are the greater the repulsion.
    //        distNorm = 1.0 - distNorm;
    //
    //        // make the direction vector magnitude fade out the further it gets from mouse position.
    //        dir *= distNorm;
    //
    //        // add the direction vector to the vertex position.
    //        pos.x += dir.x;
    //        pos.y += dir.y;
    ////        pos2 += vec2(10.0);
    //    }
    //    }
        pos.x += sin(u_time*pos.x * 0.01) * 20;
    pos.y += cos(200*pos.x * 0.0001) * 5;
    // send the vertices to the fragment shader
    gl_Position = modelViewProjectionMatrix * pos;
}
