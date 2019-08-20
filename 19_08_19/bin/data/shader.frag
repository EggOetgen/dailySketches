

#version 150

//precision highp float;
out vec4 outputColor;
uniform vec2 u_resolution;

uniform vec2 u_mouse;
 int numPoints = 10;
uniform float u_time;

float radius = 0.2;

uniform vec2 points[10];
uniform vec3 colors[10];
float centresScale[10];

//FUNCTIONS
//--------------------------------------------------------------
//float isWithin( vec2 st, vec2 c ){
//
//    float f = 0.;
//////
////    for (int i = 0; i < 10; i +=2){
////
//        float numer =  radius * radius;
//        f = numer;
////        float denom = ((st.x - centres[i]) * (st.x - centres[i])) + ((st.y - centres[i+1]) * (st.y - centres[i+1]));
//    float denom = ((st.x - c.x) * (st.x - c.x)) + ((st.y - c.y) * (st.y - c.y));
//
//        f += (numer / denom);
////    f = c.x;
////    }
//    return f;
////    return f > 1.0 ?  true : false;
//}


//--------------------------------------------------------------
float random (vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
                 43758.5453123);
}


//--------------------------------------------------------------
float dist(vec2 p1, vec2 p2){
    
    return sqrt( ((p2.x - p1.x)  * (p2.x - p1.x)) + ((p2.y - p1.y)  * (p2.y - p1.y)) ) ;
}

//--------------------------------------------------------------
float distSQR(vec2 p1, vec2 p2){
    
    return  abs(((p2.x - p1.x)  * (p2.x - p1.x)) + ((p2.y - p1.y)  * (p2.y - p1.y)))  ;
}

//MAIN
//--------------------------------------------------------------

void main() {
   
//    radius =((sin(u_time* 0.01 * cos(u_time *0.352)) + 0.5) )*0.5;
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec2 m = u_mouse.xy/u_resolution.xy;
//    m.y = 1.0-m.y;
//        m.x = 1.0-m.x;
//  radius = m.y*0.5;
    st.y = 1.0 - st.y;
    
    vec3 color = vec3(1.0);
    
    float minDist = dist(vec2(0.,0.), vec2(1.0,1.0));
    int closestPoint = 0;
     int closestPointP = 0;
    float minP = minDist;
    for (int i = 0; i < numPoints; i ++){
        vec2 p = points[i]/u_resolution.xy;
        float d = dist(st, p );
        

                        if (d < minDist){
        
     
        
                            minDist = d;
                            closestPoint = i;
                        }
                    }
        
    
    color = colors[closestPoint];
    outputColor = vec4(color,1.0);
    
}

//--------------------------------------------------------------
