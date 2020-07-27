

#version 150

precision highp float;
out vec4 outputColor;
uniform vec2 u_resolution;

uniform vec2 u_mouse;
uniform vec2 u_mouse2;
uniform vec2 u_mouse3;
uniform vec3 col1;
uniform vec3 col2;
uniform float u_time;

uniform float radius;

uniform float centres[10];
float centresScale[10];

vec3 blue = vec3(0.035, 0.251, 0.455);
vec3 pink = vec3(0.788,0.482, 0.518);

float isWithin( vec2 st, vec2 c ){
    
    float f = 0.;
////
//    for (int i = 0; i < 10; i +=2){
//
        float numer =  radius * radius;
        f = numer;
//        float denom = ((st.x - centres[i]) * (st.x - centres[i])) + ((st.y - centres[i+1]) * (st.y - centres[i+1]));
    float denom = ((st.x - c.x) * (st.x - c.x)) + ((st.y - c.y) * (st.y - c.y));

        f += (numer / denom);
//    f = c.x;
//    }
//    if(f> 2.)
//        f = 2.;
//    else if(f < 0.0)
//        f = 0.0;
    return f;
//    return f > 1.0 ?  true : false;
}

float random (vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
                 43758.5453123);
}

void main() {
    blue = col1;
    pink = col2;
//    radius =((sin(u_time* 0.01 * cos(u_time *0.352)) + 0.5) )*0.5;
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec2 m = u_mouse.xy/u_resolution.xy;
    
    st.x = sin(st.x) ;
     st.y = cos(st.y) ;
    st.y += random(st ) * 0.05;
    st.x += random(st) * 0.05;
//    m.y = 0.9;
    vec2 m2 = m;//u_mouse2.xy/u_resolution.xy;
    vec2 m3 = m;//u_mouse3.xy/u_resolution.xy;
//    m3.y = 1.0-m3.y;
    
    for (int i = 0; i < 10; i +=2){
        centresScale[i] =  centres[i]/u_resolution.x;
        centresScale[i+1] =  centres[i+1]/u_resolution.y;
        
    }
//    st.x *= u_resolution.x/u_resolution.y;
    vec3 color = vec3(1.0)-vec3(pink);
//    if(st.x >= m.x)
//        color = vec3(0.,0.,0.);
//    else
//          color = vec3(1.0);
    if(st.y >isWithin(st, m) && isWithin(st, vec2(isWithin(vec2(isWithin(st, sin(m2))), m))) > 0.2)
        color = vec3( isWithin(st, vec2(isWithin(vec2(isWithin(st, sin(m2))), m))) * blue);
    
    else if(isWithin(st, m3)  > 0.2)
        color = vec3(isWithin(st, m3) * pink );
    

//    color -= vec3(st.x,st.y,abs(sin(u_time)));
    outputColor = vec4(color,1.0);
    
}
