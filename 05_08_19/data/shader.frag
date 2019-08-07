

#version 150

//precision highp float;
out vec4 outputColor;
uniform vec2 u_resolution;

uniform vec2 u_mouse;
uniform vec2 u_mouse2;
uniform vec2 u_mouse3;

uniform float u_time;

float radius = 0.2;

uniform float centres[10];
float centresScale[10];

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
    return f;
//    return f > 1.0 ?  true : false;
}

void main() {
    
//    radius =((sin(u_time* 0.01 * cos(u_time *0.352)) + 0.5) )*0.5;
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec2 m = u_mouse.xy/u_resolution.xy;
   vec2 m2 = u_mouse2.xy/u_resolution.xy;
    vec2 m3 = u_mouse3.xy/u_resolution.xy;
    m3.y = 1.0-m3.y;
    
    for (int i = 0; i < 10; i +=2){
        centresScale[i] =  centres[i]/u_resolution.x;
        centresScale[i+1] =  centres[i+1]/u_resolution.y;
        
    }
//    st.x *= u_resolution.x/u_resolution.y;
    vec3 color = vec3(0.);
//    if(st.x >= m.x)
//        color = vec3(0.,0.,0.);
//    else
//          color = vec3(1.0);
    if(st.x > smoothstep(st.x,1.0, 0.2) && (st.y <0.4 || st.y > 0.2))
        color = vec3(isWithin(st, m) + isWithin(st, m2) +isWithin(st, m3) , isWithin(st, m2) + isWithin(st, m3),isWithin(st, m3));
    
    else
        color = vec3(1.0) - vec3(isWithin(st, m) + isWithin(st, m2) +isWithin(st, m3) , isWithin(st, m2) + isWithin(st, m3),isWithin(st, m3));
    

//    color = vec3(st.x,st.y,abs(sin(u_time)));
    outputColor = vec4(color,1.0);
    
}
