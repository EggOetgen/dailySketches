

#version 150

//precision highp float;
out vec4 outputColor;
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
  bool simple;

float TWO_PI = 6.28318530718;
vec2 mouseNorm;
int numOctaves = 8;
const mat2 m = mat2( 0.80,  0.60, -0.60,  0.80 );
float hash(float n) { return fract(sin(n) * 1e4); }
float hash(vec2 p) { return fract(1e4 * sin(17.0 * p.x + p.y * 0.1) * (0.1 + abs(sin(p.y * 13.0 + p.x)))); }

//FUNCTIONS
//float noise( in vec2 p )
//{
//    return sin(p.x)*sin(p.y)*cos(p.y)*cos(p.x);
//}
float rand(vec2 n) {
    return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

vec2 hash2( float n )
{
    return fract(sin(vec2(n,n+1.0))*vec2(13.5453123,31.1459123));
}


float noise(vec2 p) {
    
    if(false){
        return sin(p.x)*sin(p.y)*cos(p.y)*cos(p.x);
    }else{
    vec2 i = floor(p);
    vec2 f = fract(p);
    
    // Four corners in 2D of a tile
    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));
    
    // Simple 2D lerp using smoothstep envelope between the values.
    // return vec3(mix(mix(a, b, smoothstep(0.0, 1.0, f.x)),
    //            mix(c, d, smoothstep(0.0, 1.0, f.x)),
    //            smoothstep(0.0, 1.0, f.y)));
    
    // Same code, with the clamps in smoothstep and common subexpressions
    // optimized away.
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
    }
}




float fbm( in vec2 x )
{
    //how noisy ( self similiartiy of curve)
    float H =1.2;
    //between 0.5 1.0
    float G = exp2(-H);

//    float f = 1.0;
//    float a =abs(sin((u_time * 0.021)* cos(u_time * 0.00354) * x.y)* 0.25) + 0.8 ;//1.1;1.0;
    float a =noise(vec2(u_time*0.5  , x.y)* 0.25) + 0.8 ;//1.1;1.0;

    float t;
    if(false)
    t = 1.0;
    else
        t = -1.0;
    float f =1;//  mouseNorm.x;

    for( int i=0; i<numOctaves; i++ )
    {
        t += a*noise(f*x);
        
        //the frequency shift of each subsequent octave
        f *=2.0 ;//+ mouseNorm.y;
        a *= G;
    }
    return t;
}

//float fbm( vec2 p )
//{
//    float f = 0.0;
//    f += 0.5000*noise( p ); p = m*p*2.02;
//    f += 0.2500*noise( p ); p = m*p*2.03;
//    f += 0.1250*noise( p ); p = m*p*2.01;
//    f += 0.0625*noise( p );
////    f += 0.5000*noise( p ); p = p*2.02;
////    f += 0.2500*noise( p ); p = p*2.03;
////    f += 0.1250*noise( p ); p = p*2.01;
////    f += 0.0625*noise( p );
//    return f/0.9375;
//}

float pattern(in vec2 p)
{
    
    vec2 q = vec2(  fbm( p + vec2(0.0, 0.0) ),
                    fbm( p + vec2(5.2, 1.3) ) );
    
    vec2 r = vec2(  fbm( p + 4.0*q + vec2(1.7, 9.2) ),
                  fbm( p + 4.0*q + vec2(8.3,2.8)  )   );
    
    return fbm(p + 4.0 * r);
    
}
//MAIN
//--------------------------------------------------------------

void main() {
   
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    mouseNorm = u_mouse.xy/u_resolution.xy;
    if ( st.x > 0.5 )
        simple = true;
    else
        simple = false;
     if((st.x > 0.1 && st.x < 0.9)  ){
//  st =   hash2( float(u_time) + st.x + st.y );
         st*=2.0;// + abs(cos(u_time* 0.1));
  
    st+=rand(st ) * 0.001;
    if(!simple)
    st.y+= u_time*0.02;
    else
        st.y-= u_time*0.02;

    st.x+= abs(cos(u_time * 0.0214)) * 0.6;
    st.y+= abs(sin(u_time*0.00924)) * 0.12;
    
    vec3 color = vec3(pattern(st));
//    st.x*=st.y * u_time;
    
    if(simple){
        color = vec3(1.0) - color;
        color *=0.5;
    }else{
        color+= 0.1;
    }
//    if(color.x < mouseNorm.x){
//        if(!simple)
//        color = vec3(0.0,0.0,0.2 );
//    } else if(color.x > mouseNorm.x && simple){
//            color = vec3(0.2 ,0.0,0.1);
//
//    }//    else
//        color = vec3(1.0 * color.x,0.0,0.0);

//    if (st.x > 0.25 && st.x < 1.5 &&st.y > 0.25 && st.y < 1.5 ){
    outputColor = vec4(color,1.0);
    }else
        outputColor = vec4(vec3(0.1),1.0);

    
    
}

//--------------------------------------------------------------
