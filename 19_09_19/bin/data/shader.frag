#version 150

float TWO_PI = 6.28318530718;

out vec4 outputColor;
uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform vec2 sphere2;

uniform vec3 a;
uniform vec3 b;
uniform vec3 c;
uniform vec3 d;
////pink and green
vec4 colA =vec4(0.792, 0.082, 0.318, 1.0);
vec4 colB =vec4(0.059, 1.0, 0.584, 1.0);


//yello and blue
//vec3 colA =vec3(0.251, 0.471, 0.6);
//uniform vec3 colA;
//uniform vec3 colB;// =vec3(0.886, 0.753, 0.267);
//--------------------------------------------------------------
float sdSphere(vec3 st, vec3 pos, float r) {
    
    return length(st - pos) - r;
    
}
mat2 Rot(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, -s, s, c);
}
float sdPlane(vec3 p, vec4 n)
{
    return dot(p, n.xyz) + n.w;
}

float sdBox(vec3 st, vec3 b){
    
    vec3 d = abs(st) - b;
    
    return length(max(d,0.0))
    + min( max( d.x, max(d.y, d.z)), 0.0);
    
    //    //just rerutns inside
    //    return length(max(d,0));
    
}

float sdRectRound(vec2 st, vec2 b, float r){
    
    vec2 d = abs(st) - b;
    
    return length(max(d,0)) - r
    + min( max( d.x, d.y), 0.0);
    
    //    //just rerutns inside
    //    return length(max(d,0)) - r;
    
}
float sdRoundBox( vec3 p, vec3 b, float r )
{
    vec3 d = abs(p) - b;
    return min(max(d.x,max(d.y,d.z)),0.0) + length(max(d,0.0)) - r;
}


float sdTorus(vec3 st, vec2 t){
    
    vec2 q = vec2(length(st.xz)-t.x,st.y);
    return length(q)-t.y;
    
}
float sdEllipsoid( in vec3 st, in vec3 r )
{
    float k0 = length(st/r);
    float k1 = length(st/(r*r));
    return k0*(k0-1.0)/k1;
}

vec3 opTwistB(  in vec3 p, in float amtX, in float amtY )
{
     float kX = amtX; // or some other amount
    float kY = amtY;
    float c = cos(kX*p.y);
    float s = sin(kY*p.y);
    mat2  m = mat2(c,-s,s,c);
    vec3  q = vec3(m*p.xz,p.y);
    return q;
}

vec3 opTwist(  in vec3 p, in float amt )
{
    float k = amt;
    float c = cos(k*p.y);
    float s = sin(k*p.y);
    mat2  m = mat2(c,-s,s,c);
    vec3  q = vec3(m*p.xz,p.y);
    return q;
}

float opDisplace( float s, in vec3 p )
{
    float d1 = s;
    float d2 = sin(20*p.x)*sin(20*p.y)*sin(20*p.z);
    //    float d2 = sin(20*sphere2.x*p.x)*sin(35235*p.y)*sin(200*p.z);
    return d1+d2;
}

float sdCappedTorus(in vec3 p, in vec2 sc, in float ra, in float rb)
{
    p.x = abs(p.x);
    float k = (sc.y*p.x>sc.x*p.y) ? dot(p.xy,sc) : length(p.xy);
    return sqrt( dot(p,p) + ra*ra - 2.0*ra*k ) - rb;
}
//--------------------------------------------------------------
float rand(vec2 co)
{
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

float smin( float a, float b, float k )
{
    float h = clamp( 0.5+0.5*(b-a)/k, 0.0, 1.0 );
    return mix( b, a, h ) - k*h*(1.0-h);
}

vec2 opBlend(vec2 d1, vec2 d2, float k)
{
//    float k = 0.5;
    float d = smin(d1.x, d2.x, k);
    float m = mix(d1.y, d2.y, (d1.x-d));
    return vec2(d, m);
}

float opSmoothSubtraction( float d1, float d2, float k ) {
    float h = clamp( 0.5 - 0.5*(d2+d1)/k, 0.0, 1.0 );
    return mix( d2, -d1, h ) + k*h*(1.0-h); }


vec3 opRep( in vec3 p, in vec3 c)
{
    vec3 q = mod(p,c)-0.5*c;
    return ( q );
}
//--------------------------------------------------------------
vec2 sdf(vec3 st){
    
    vec2 m = u_mouse.xy/u_resolution.xy;

    m.x *= u_resolution.x/u_resolution.y;
 
    vec3 q = st - vec3(0.0,0.0,5.0);

//    q.xy *= Rot(u_time* 0.001);
//
////    q.xy *=m.x;
//     q.xy *= Rot(u_time);
//     float flr =sdPlane(q , vec4(0.0,m.y,-1.1, m.x)) ;
        q.xz *= Rot(TWO_PI/2.0);
      q.yz *= Rot(TWO_PI* 0.25);

        q = opTwist(  q, sin(u_time*0.38542 )*0.5);

//  vec3
//    q = opRep(q, (vec3(10.*sin(u_time*0.06354*sin(u_time*0.36845)), 10.*cos(u_time*0.006045*sin(u_time*0.8658)), 10.0 *sin(u_time*0.0098365*cos(u_time*0.98645)))));
//    q = opRep(q, vec3(10.0, 10.0, 10.0));
//    q = vec3(mix(q.x, q2.x, m.x),mix(q.y, q2.y, m.x),mix(q.z, q2.z, m.x));
//    q = opTwist(  q, sin(u_time  )*0.1);
//    q = opTwist(  q.yxz, cos(u_time)*5.*cos(u q = opRep(q, (vec3(10., 10., 10.0 * m.x)));_time*0.032414 * q.x));

    float t = sdSphere( q,vec3(0.0,0., 0.), 0.7 + 0.005*sin(u_time));
    
    
    float t2 =sdSphere(q,vec3(0.0,0.98 + ( 0.01 * sin(u_time*5.0)), -0.5), 0.3) ;
    float eyeL =sdSphere(q,vec3(-0.15,0.98 + ( 0.01 * sin(u_time*5.0)), -0.7), 0.05) ;
    float eyeR =sdSphere(q,vec3(0.15,0.98 + ( 0.01 * sin(u_time*5.0)), -0.7), 0.05) ;
    
    
    
    q.xy *= Rot(TWO_PI/2.);
    q +=vec3(0.0,0.88+ ( 0.01 * sin(u_time*5.0)), 0.61);
    float mouth = sdCappedTorus(q, vec2(0.5,0.1),0.1, 0.06);

    q.y -= 0.5;

//    vec2  ou = vec2( opBlend( vec2(t,0.0), vec2(t2,0.0) )    , 0.0);
//
//    vec2 ou = vec2(t2, 0.0);
    vec2 ou ;
    
    float T = smin( t, t2 ,0.5);
    T = opSmoothSubtraction(eyeL,T, 0.1);
    T = opSmoothSubtraction(eyeR,T, 0.1);
    T = opSmoothSubtraction(mouth,T, 0.1);
    
//    T = opDisplace(T, vec3(q.x * q.x * m.x, q.y*q.y*m.y, m.x * m.y * q.x * q.y));
//      T = opDisplace(T, vec3( m.x * m.y * q.x * q.y,q.x * q.x * m.x, q.y*q.y*m.y));
//    T = opRep(q,vec3(m.x, m.y, 1.0), T);
//    T = smin(T, flr, 0.5);
//    ou = opBlend( ou, vec2(eyeL,-100.0) , 0.01);
//     ou = vec2(opSmoothSubtraction(eyeL,ou.x, 0.1), 0.0);
//     ou = vec2(opSmoothSubtraction(eyeR,ou.x, 0.1), 0.0);
//    ou = vec2(opSmoothSubtraction(mouth,ou.x, 0.1), 0.0);
//    ou = opBlend(ou, vec2(mouth, 0.0), 0.5);
    ou = vec2(T,0.0);
//    ou = vec2(mouth, 0.0);
    return ou;
}






//--------------------------------------------------------------
vec3 pal( in float t, in vec3 a, in vec3 b, in vec3 c, in vec3 d )
{
    return a + b*cos( 6.28318*(c*t+d) );
}

vec3 calcNormal(vec3 pos)
{
    // Center sample
    float c = sdf(pos).x;
    // Use offset samples to compute gradient / normal
    vec2 eps_zero = vec2(0.001, 0.0);
    return normalize(vec3( sdf(pos + eps_zero.xyy).x, sdf(pos + eps_zero.yxy).x, sdf(pos + eps_zero.yyx).x ) - c);
}

//--------------------------------------------------------------
vec3 shade(float sd){
    
    float maxDist = 2.0;
    
    vec3 palCol = pal(0.5 - sd*0.4,
                      vec3(0.3,0.3,0.0),
                      vec3(0.8,0.8,0.1),
                      vec3(0.9,0.7,0.0),
                      vec3(0.3,0.9,0.8)
                      );
    
    vec3 col = palCol;
    
    // Darken around surface, closer to x darker new color is(expo incraeses towards inf
    col = mix(col, col*1.0-exp(-10.0*abs(sd)), 0.4);
    //repeating lines
    col *= 0.8 + 0.2*cos(150.0*sd);
    // White outline at surface
    col = mix(col, vec3(1.0), 1.0-smoothstep(0.0,0.01,abs(sd)));
    
    return col;
    
}


//--------------------------------------------------------------

vec3 getCameraRayDir(vec2 uv, vec3 camPos, vec3 camTarget){
    
    // Calculate camera's "orthonormal basis", i.e. its transform matrix components
    vec3 camForward = normalize(camTarget - camPos);
    vec3 camRight = normalize(cross(vec3(0.0, 1.0, 0.0), camForward));
    vec3 camUp = normalize(cross(camForward, camRight));
    
    float fPersp = 2.0;
    vec3 vDir = normalize(uv.x * camRight + uv.y * camUp + camForward * fPersp);
    
    return vDir;
}

vec2 rayMarch(vec3 origin, vec3 dir){
    
    int numSteps = 40;
    
    float dist = 0;
    for (int i = 0; i < numSteps; i++){
        
        vec2 sd = sdf(origin + dir * dist);
        
        if(sd.x < 0.00001*dist)
            return vec2(dist, sd.y);
        
        dist += sd.x;
    }
    return vec2(-1.0,0.0);
}

//--------------------------------------------------------------
vec4 render(vec3 origin, vec3 dir){
    
    vec2 m = u_mouse.xy/u_resolution.xy;
    vec2 t = rayMarch(origin, dir);
    vec4 col;
    vec3 L = vec3(-0.0,10.0,0.0);
    float drawDist = 100.0;
    if(t.x > drawDist){
//        col =  colB- (dir.y * 0.7);
    }else if(t.x >= 0.0){
        
        vec3 pos = origin + dir * t.x;
        
        vec3 N = calcNormal(pos);
        
        float NoL = max(dot(N,L),0.0);
        vec3 LDirectional = vec3(0.0,0.0,0.99) * NoL;
        //            if(t.x == 0.0)
        //        vec3 objectSurfaceColour = vec3(0.792, 0.082, 0.318) * 1.0 -vec3(t.y);
        //pink
        vec3 objectSurfaceColour = mix(colA.xyz, vec3(1.0),vec3(t.y));
        //            else
        //         vec3 objectSurfaceColour = vec3(0.0);
        vec3 ambient =vec3(0.9);// vec3(0.9, 0.8, 0.02);
        col = vec4((LDirectional+ambient) * objectSurfaceColour, 1.0);
        
        float shadow = 0.0;
        vec3 shadowRayOrigin = pos + N * 0.001;
        vec3 shadowRayDir = L;
        float shadowRayIntersection = rayMarch(shadowRayOrigin, shadowRayDir).x;
        if (shadowRayIntersection != -1.0)
        {
            shadow = 1.0;
        }
        col = mix(col, col*0.9, shadow);
        //        col = vec3(0.792-t*0.075,0.082-t*0.075,0.318-t*0.075);
        
        //        col = N * vec3(0.5) + vec3(0.5);
    } else
        col = colB;// - (dir.y * 0.7);
    
    
    return col;
    
    
}

vec2 normalizeScreenCoords(vec2 screenCoord)
{
    vec2 result = 2.0 * (screenCoord/u_resolution.xy - 0.5);
    result.x *= u_resolution.x/u_resolution.y; // Correct for aspect ratio
    return result;
}

//--------------------------------------------------------------
void main()
{
    
   
    //    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    //    st *=2.0;
    //    st -=0.5;
    //    st.x *= u_resolution.x/u_resolution.y;
    
    vec2 st = normalizeScreenCoords(gl_FragCoord.xy);
    vec2 m =    u_mouse.xy/u_resolution.xy;
//    colA = vec4(pal( (st.y* 0.1) - 1.0 + rand(st )* 0.08, a,b,c,d), 1.0);
       colA = vec4(pal( st.y *0.1, a,b,c,d), 1.0);
//    colB = pal( 01  , a,b,c,d);
//    colB = vec4(st.x,0.,0.,0.0);
//    st.x = sin(st.x * TWO_PI);
//        st.x = abs(sin(st.x * (TWO_PI / 4)));
//    st.x /=(st.x);
//    st.y /=(st.x);
//      st.x = (sin(st.x * (TWO_PI )));
//      st.y = (cos(st.y * (TWO_PI )));
    float xnorm =((st.y * 0.5)+0.5);
    float ynorm =((st.y * 0.5)+0.5);
//    st.x*= 1.0 + ((sin(u_time*0.000534684)) * 2.0);
//     st.y*= 1.0 + ((cos(u_time*0.0008753)) * 1.0);
//    st.y = (1.0 * ((st.x * 0.5)+0.5));
//    st.x = abs(st.x);
    
//    st.x = 1.0- sin(st.x * (TWO_PI/ 4.) );
//    st.y = cos(st.y * (TWO_PI/ 4.) );
    colB = vec4(0.,0.,0.,0.0);
    
//        st.y = st.x ;
//    st.x = sin(st.x) *squish;
//    st.y = cos(st.x) ;
//    st.y += rand(st ) * 0.005;
//    st.x += rand(st) * 0.005;
    
    vec4 col = vec4(0.0);
    
    vec3 camPos    = vec3(0.0, -0.00001, -0.001);
    vec3 camTarget = vec3(0.0, 0.0,  0.0);
    
    vec3 rayDir = getCameraRayDir(st, camPos, camTarget);
    
    col = render(camPos, rayDir);
    
    
    outputColor = vec4(col);
}

