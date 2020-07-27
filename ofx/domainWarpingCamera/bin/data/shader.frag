

#version 150

//precision highp float;
out vec4 outputColor;
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
  bool simple = false;
uniform sampler2DRect tex0;
uniform sampler2DRect dif;
uniform sampler2DRect bg;


in vec2 varyingtexcoord;


float TWO_PI = 6.28318530718;
vec2 mouseNorm;
int numOctaves = 10;
const mat2 m = mat2( 0.80,  0.60, -0.60,  0.80 );
float hash(float n) { return fract(sin(n) * 1e4); }
float hash(vec2 p) { return fract(1e4 * sin(17.0 * p.x + p.y * 0.1) * (0.1 + abs(sin(p.y * 13.0 + p.x)))); }

//FUNCTIONS
//float noise( in vec2 p )
//{
//    return sin(p.x)*sin(p.y)*cos(p.y)*cos(p.x);
//}

float dist(vec2 p1, vec2 p2){
    
    return sqrt( ((p2.x - p1.x)  * (p2.x - p1.x)) + ((p2.y - p1.y)  * (p2.y - p1.y)) ) ;
}

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
    float a =(noise(vec2(x.x + 0.5 + (u_time*0.02), x.y  - (u_time*0.1247))));//abs(cos(u_time * TWO_PI * 0.05)) * 0.25 + 1.8;//noise(vec2(u_time*0.5  , x.y)* 0.25) + 0.8 ;//1.1;1.0;

    float t;
    if(false)
    t = 1.0;
    else
        t = -1;//abs(cos(u_time * TWO_PI * 0.05) ) * 0.6 ;;
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

vec4 vec4Mix( vec4 a, vec4 b, float pct){
    
    
    return vec4( mix(a.x , b.x, pct),
                 mix(a.y , b.y, pct),
                 mix(a.z , b.z, pct),
                 mix(a.w , b.w, pct)
                );
    
}
//MAIN
//--------------------------------------------------------------

void main() {
   
    vec2 st = varyingtexcoord / u_resolution;

//    vec2 st   = gl_FragCoord.xy/u_resolution.xy;
    mouseNorm = u_mouse.xy/u_resolution.xy;
    

         vec4 inputImg;
    vec4 thresholdImg;

    vec4 inputImgDist;
    float pat = pattern(st);
//    st.x-=0.25;
//
//    st.x*=mouseNorm.x * 2.0;;
//
//    if(st.x < 0.0)
//        st.x = 0.0;
//    st.x = smoothstep(0.0, 1.0, st.x);
//    vec3 color = vec3(pattern(st));
//         if(texture(tex,  varyingtexcoord).r >= 0.5 && texture(tex,  varyingtexcoord).g <= 0.8 &&texture(tex,  varyingtexcoord).b <= 0.8 ){
       inputImg = texture(tex0,  varyingtexcoord);
    thresholdImg = texture(dif,  varyingtexcoord);

        inputImgDist = texture(tex0,  varyingtexcoord * ((fract(pat)) * ((st.x + 0.5))  ));
//    inputImgDist = texture(tex,  varyingtexcoord + (pat * (dist(st, vec2(0.5)*mouseNorm.x ))*u_resolution));
//         }
//         else{
//             inputImg = texture(tex,  varyingtexcoord );
//
//         }
//    if(st.x < 0.25)
//        st.x = 0.0;
   
//    if(thresholdImg == vec4(vec3(1.0), 1.0)){
////    inputImg = vec4(vec3(0.4*pat * st.x, 0.3* pat * st.y, pat), 1.0);
//        inputImg =  inputImgDist;// vec4(vec3(pat , 0.1* pat , pat*0.1 ), 1.0);
////        inputImg =  vec4(vec3(st.y * 0.2 + 0.1 ), 1.0);
//
//    }
//    if(thresholdImg == vec4(vec3(0.0), 1.0)){
            if(thresholdImg == vec4(vec3(1.0), 1.0)){

        //    inputImg = vec4(vec3(0.4*pat * st.x, 0.3* pat * st.y, pat), 1.0);
        inputImg =  inputImgDist;// vec4(vec3(pat , 0.1* pat , pat*0.1 ), 1.0);
        //        inputImg =  vec4(vec3(st.y * 0.2 + 0.1 ), 1.0);
        
    }
//
    if(inputImg == vec4(vec3(mouseNorm.x), 1.0)){
        inputImgDist = vec4(1.0,0.0,0.0, 1.0);//vec4(vec3(pat), 1.0);// inputImg;//vec4(vec3(0.4*pat, 0.3* pat , pat * 0.7), 1.0);//inputImg;//vec4(vec3(pattern(st)), 1.0);
// inputImgDist =  vec4(vec3(st.y * 0.5), 1.0);
    }

    //    st.x*=st.y * u_time;

//    if(simple){
//        color = vec3(1.0) - color;
//        color *=0.5;
//    }else{
//        color+= 0.1;
//    }
//    if(color.x < mouseNorm.x){
//        if(!simple)
//        color = vec3(0.0,0.0,0.2 );
//    } else if(color.x > mouseNorm.x && simple){
//            color = vec3(0.2 ,0.0,0.1);
//
//    }//    else
//        color = vec3(1.0 * color.x,0.0,0.0);

//    if (st.x > 0.1 && st.x < 0.9 &&st.y > 0.1 && st.y < 0.9
//         ){
//    outputColor = vec4(color,1.0);
//         outputColor = vec4(vec3(inputImg.xyz * (1.0-color.x)), 1.0);;
//         outputColor =vec4Mix(inputImg, inputImgDist, mouseNorm.x);
//    if(st.x > 0.45 && st.x < 0.95   &&st.y > 0.3 && st.y < 0.9 ){
//    if(st.x > 0.446615 - (mouseNorm.y * 0.446615) && st.x < 0.61458  + (mouseNorm.y * (1.0 - 0.61458))  &&st.y > 0.183594- (mouseNorm.y * 0.183594) && st.y < 0.513021 + (mouseNorm.y * (1.0 - 0.513021))   ){
//    if(st.x > 0.446615  && st.x < 0.61458   && st.y > 0.183594 && st.y < 0.513021    ){
// if(st.x > 0.446615  && st.x < 0.61458   && st.y > 0.183594 && st.y < 0.513021    ){
//if(st.x > 0.3 && st.x < 0.7   && st.y > 0.1 && st.y < 0.9    ){
//    outputColor = inputImgDist;
//}else
    outputColor =inputImg;
//    } else{
//            outputColor = thresholdImg;
//
//        }
        
//    outputColor =thresholdImg;
}

//--------------------------------------------------------------
