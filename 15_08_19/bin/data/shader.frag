

#version 150

//precision highp float;
out vec4 outputColor;
uniform vec2 u_resolution;

uniform vec2 u_mouse;
 int numPoints = 7;
uniform float u_time;

float radius = 0.5;

uniform vec2 points[100];
uniform vec3 colors[100];
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
    vec3 color = vec3(0.0);
    
    float minDist = dist(vec2(0.,0.), vec2(1.0,1.0));
    int closestPoint = 0;
     int closestPointP = 0;
    float minP = minDist;

    for (int i = 0; i < numPoints; i ++){
        
        float d = dist(st, points[i] );
        
        color = mix(color, colors[i], 1.0-d );
//        float dP = dist(points[closestPoint], points[closestPointP]);
//        float pct = minDist / dP;
//        co
////        minDist = (d < minDist) ? d : minDist;
//            if (d < minP){
//
//                if (d < minDist){
//
////                    closestPointP = closestPoint;
//
//                    minDist = d;
//                    closestPoint = i;
//                }else{
//                    minP = d;
//                    closestPointP = i;
//                }
//            }
        
//        if(d<0.1)
//        if(i!= 0))
//            color += colors[i] * (1-d);
        
//        if(isWithin(st,points[i])<=minDist)
//            color = vec3(colors[i]*(1.0-minDist));

    }
    
//    float dP = dist(points[closestPoint], points[closestPointP]);
//    float pct = minDist / dP;
//    color = mix(colors[closestPoint], colors[closestPointP], m.x);
//   x color = vec3(pct);
//    color = vec3(minDist);
//    color = colors[closestPoint] * vec3(1.0 - minDist);
//    color = colors[closestPoint];
    outputColor = vec4(color,1.0);
    
}

//--------------------------------------------------------------
