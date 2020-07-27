#version 150

out vec4 outputColor;
uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform vec2 sphere2;

////pink and green
//vec3 colA =vec3(0.792, 0.082, 0.318);
//vec3 colB =vec3(0.059, 1.0, 0.584);

//yello and blue
vec3 colA =vec3(0.251, 0.471, 0.6);
vec3 colB =vec3(0.886, 0.753, 0.267);
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


vec3 opTwist(  in vec3 p )
{
    const float k = 10.0; // or some other amount
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
    return d1+d2;
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

vec2 opBlend(vec2 d1, vec2 d2)
{
    float k = 0.1;
    float d = smin(d1.x, d2.x, k);
    float m = mix(d1.y, d2.y, (d1.x-d));
    return vec2(d, m);
}


//--------------------------------------------------------------
vec2 sdf(vec3 st){
    
        vec2 m = u_mouse.xy/u_resolution.xy;
//        m *=2.0;
//        m -=0.5;
//        m.x *= u_resolution.x/u_resolution.y;
    
    vec3 q = st - vec3(0.0,0.0,5.0);
//    q.xz *= Rot(m.x);
    
//    float t = mix(opDisplace(sdSphere(q, vec3(0.0,0.0, 0.0), 2.5), vec3(st.x ,  sphere2.y , sphere2.x)),sdSphere(q, vec3(0.0,0.0, 0.0), 2.5), st.y) ;
    
      float t = mix(opDisplace(sdSphere(q, vec3(0.0,0.0, 0.0), 2.5), vec3(m.x ,  st.y , sphere2.x)),sdSphere(q, vec3(0.0,0.0, 0.0), 2.5), st.y) ;
//    float t2 =sdPlane(st, vec4(0.0,1.0,0.0, 3.0)) ;//sdSphere(st, vec3(sphere2.x + 0.5, sphere2.y - 0.5, 10.0), 3.);
//    float t3 = sdSphere(st, vec3(sphere2.x + 0.2, sphere2.y, 8.0 +cos(u_time)), 2.);
////    float t3 =sdBox(vec3(0., -0.3, -8), vec3(1.5));
//
//    float pct =0.99;// abs(sin(u_time));
//    return smin(t, smin(t2,t3,pct), pct);
     q = st - vec3(-0.4,0.7,2.555);
//    q = opTwist(q);
        q.yz *= Rot(1.4);
        q.xz *= Rot(-1.4);

 
    float t3 = sdTorus(q, vec2(0.2, 0.08));
    q = st - vec3(0.4,0.7,2.555);
  
    q.yz *= Rot(1.4);
    q.xz *= Rot(1.4);
    
    //    q.yz *= Rot(u_mouse.y);

    float t4= sdTorus(q, vec2(0.2, 0.08));
  
    q = st - vec3(0.4,0.7,2.5);
    //    q.xz *= Rot(m.x);
    float t5 = sdSphere(q, vec3(0.0,0.0, 0.0), 0.08);
    q = st - vec3(-0.4,0.7,2.5);
    //    q.xz *= Rot(m.x);
   
    float t6 = sdSphere(q, vec3(0.0,0.0, 0.0), 0.08);
//    vec3 q = st - vec3(0.0,0.0,5.0);
//    //    q.xz *= Rot(m.x);
//    float t = sdSphere(q, vec3(0.0,0.0, 0.0), 2.5);

    float d2 = sdRoundBox(q, vec3(0.6,0.2,0.7), 0.1 );
    
    return opBlend(vec2(t, 0.0), opBlend(vec2(t3,0.0), opBlend(vec2(t4,0.0), opBlend(vec2(t5,1000.0),vec2(t6,1000.0)))));
//    return opBlend(vec2(t, 0.0),vec2(t3, 1.0));
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
    
    int numSteps = 70;
    
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
vec3 render(vec3 origin, vec3 dir){

    vec2 t = rayMarch(origin, dir);
    vec3 col;
    vec3 L = vec3(0.3,0.5,-0.5);
    float drawDist = 10.0;
    if(t.x > drawDist)
        col = colB- (dir.y * 0.7);
    else if(t.x >= 0.0){
        
        vec3 pos = origin + dir * t.x;
        
        vec3 N = calcNormal(pos);
        
        float NoL = max(dot(N,L),0.0);
        vec3 LDirectional = vec3(1.80,1.27,0.99) * NoL;
//            if(t.x == 0.0)
//        vec3 objectSurfaceColour = vec3(0.792, 0.082, 0.318) * 1.0 -vec3(t.y);
        //pink
         vec3 objectSurfaceColour = mix(colA, vec3(1.0),vec3(t.y));
//            else
//         vec3 objectSurfaceColour = vec3(0.0);
        vec3 ambient =vec3(0.9);// vec3(0.9, 0.8, 0.02);
        col = (LDirectional+ambient) * objectSurfaceColour;
        
        float shadow = 0.0;
        vec3 shadowRayOrigin = pos + N * 0.01;
        vec3 shadowRayDir = L;
        float shadowRayIntersection = rayMarch(shadowRayOrigin, shadowRayDir).x;
        if (shadowRayIntersection != -1.0)
        {
            shadow = 1.0;
        }
        col = mix(col, col*0.2, shadow);
//        col = vec3(0.792-t*0.075,0.082-t*0.075,0.318-t*0.075);
        
//        col = N * vec3(0.5) + vec3(0.5);
    } else
        col = colB - (dir.y * 0.7);
    
    
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
//    st.x = sin(st.x) ;
//    st.y = cos(st.y) ;
    st.y += rand(st ) * 0.02;
    st.x += rand(st) * 0.02;
   
    vec3 col = vec3(0.0);

    vec3 camPos    = vec3(0.0, 0.0, -1.0);
    vec3 camTarget = vec3(0.0, 0.0,  0.0);
    
    vec3 rayDir = getCameraRayDir(st, camPos, camTarget);
    
    col = render(camPos, rayDir);
	
    
    outputColor = vec4(col, 1.0);
}

