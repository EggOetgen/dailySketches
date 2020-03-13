#version 150

uniform sampler2DRect tex0;
uniform float blurAmnt;
uniform float u_time;
uniform vec2 u_resolution;

uniform vec2 u_mouse;
in vec2 texCoordVarying;
out vec4 outputColor;



void main()
{

    vec4 color = vec4(0.0, 0.0, 0.0, 0.0);

    vec2 st = texCoordVarying/ u_resolution.x;
    color = texture(tex0, texCoordVarying + vec2(0.0, 0));
//    if(abs( color.x - color.y - color.z) > 0.01)
    color = texture(tex0, texCoordVarying + vec2(sin(( color.x - color.y - color.z )+u_time )  , cos( (color.x - color.y - color.z) + u_time * 1.1 ) ));
    //    else if(color.y > color.z)
    //        color = texture(tex0, texCoordVarying + vec2(abs(sin(color.y - color.z * 6.28318530718 ))  , abs(cos(color.y - color.z * 6.28318530718 ))));
    //

        outputColor =color;
}

//void main()
//{
//
//    vec4 color = vec4(0.0, 0.0, 0.0, 0.0);
//
//
//    color = texture(tex0, texCoordVarying + vec2(0.0, 0));
//    if(color.x > color.y)
//        color = texture(tex0, texCoordVarying + vec2(color.x - color.y   , color.x - color.y ));
//    //    else if(color.y > color.z)
//    //        color = texture(tex0, texCoordVarying + vec2(abs(sin(color.y - color.z * 6.28318530718 ))  , abs(cos(color.y - color.z * 6.28318530718 ))));
//    //
//
//
//
//    outputColor = color;
//}

//void main()
//{
//
//    vec4 color = vec4(0.0, 0.0, 0.0, 0.0);
//
//
//    color = texture(tex0, texCoordVarying + vec2(0.0, 0));
//    if(color.x > color.y)
//        color = texture(tex0, texCoordVarying + vec2((sin(color.x - color.y * 6.28318530718) )  , (cos(color.x - color.y * 6.28318530718 ))));
////    else if(color.y > color.z)
////        color = texture(tex0, texCoordVarying + vec2(abs(sin(color.y - color.z * 6.28318530718 ))  , abs(cos(color.y - color.z * 6.28318530718 ))));
////
//
//
//
//    outputColor = color;
//}

//void main()
//{
//
//    vec4 color = vec4(0.0, 0.0, 0.0, 0.0);
//
//
//    color = texture(tex0, texCoordVarying + vec2(0.0, 0));
//        if(color.x > color.y)
//    color = texture(tex0, texCoordVarying + vec2((sin(color.x - color.y * 6.28318530718 +u_time) )  , (cos(color.x - color.y * 6.28318530718 + u_time))));
//    //    else if(color.y > color.z)
//    //        color = texture(tex0, texCoordVarying + vec2(abs(sin(color.y - color.z * 6.28318530718 ))  , abs(cos(color.y - color.z * 6.28318530718 ))));
//    //
//
//
//
//    outputColor = color;
//}
