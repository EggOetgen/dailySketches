#version 150

uniform mat4 modelViewProjectionMatrix;

in vec4 position;
in vec4 color;
in vec4 normal;
in vec2 texcoord;
// this is the end of the defau
out vec2 varyingtexcoord;
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
    
    float f = 1.0;
    float a = 1.0;
    float t = 0.0+  mouseNorm.x;
    
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

void main(){
    vec2 newPos = position.xy;
    mouseNorm = u_mouse.xy/u_resolution.xy;

//    float pat = pattern(newPos);
//    newPos.x =  sin(position.y)* u_mouse.x;
     varyingtexcoord = newPos;
	gl_Position = modelViewProjectionMatrix * position;
}
