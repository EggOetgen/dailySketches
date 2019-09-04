#version 150
uniform sampler2DRect tex0;

in vec2 texCoordVarying;
out vec4 outputColor;
uniform float u_time;
float TWO_PI = 6.28318530718;
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform vec3 a;
uniform vec3 b;
uniform vec3 c;
uniform vec3 d;
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
    
    p.y += rand(p ) * 0.05;
    p.x += rand(p) * 0.05;
    
//    p *= abs(sin(u_time)* 2)+ 0.1;
//    p /= (sin(u_time));
//    p -=vec2(0.00,1.500);
    // animate
    // p.x += 0.01*u_time;
//    p.x = sin(p.x);
//    p.y = cos(p.y);
    // compute colors
    float r = 0.2;
    float x = r * sin(p.x * TWO_PI);
    float y = r * sin(p.y);
    
    vec3  col = pal( mix(pow(p.x , p.y), p.x * p.y,sin(tx)*2) , a,b,c,d);

//    if(texture(tex0, texCoordVarying).w >= 0.5)
//          col =pal(-(u_mouse.x/u_resolution.x)+p.x , a,b,d,c);
        if(texture(tex0, texCoordVarying).w >= 0.5)
              col =pal(-1.0+p.x , a,b,d,c);

//    else
//         vec3  col =pal( mix(p.x, p.y,0.5 ) , b,a,c,d);
    // band
    
    outputColor =vec4( col, 1.0);
}

//void main()
//{
//    vec2 p =  gl_FragCoord.xy/u_resolution.xy;
//    float tx = u_time * 0.5;
//
//    p.y += rand(p ) * 0.0001;
//    p.x += rand(p) * 0.0001;
//    p *=2.;
//    p -=vec2(0.00,1.500);
//    // animate
//    // p.x += 0.01*u_time;
//    p.x = sin(p.x);
//    p.y = cos(p.y);
//    // compute colors
//    vec3                col =pal( (sin(p.x * TWO_PI) * 0.012) - 2.968, vec3(0.5),vec3((p.x * TWO_PI) ),vec3(mix(1.0,(p.y *p.y), cos(sin(tx * 0.5) * p.x*1.2 * p.y*10.3)))* 0.5,vec3(0.0,0.15,0.2) );
//
//    // band
//
//    outputColor = vec4( col, 1.0 );
//}
