#version 150

out vec4 outputColor;
uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform vec2 sphere2;

//--------------------------------------------------------------
float sdSphere(vec3 st, vec3 pos, float r) {
    
    return length(st - pos) - r;
    
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

//--------------------------------------------------------------
float sdf(vec3 st){
   
    float t = sdSphere(st, vec3(u_mouse.x, u_mouse.y, 10.0), 3.);
    float t2 =sdPlane(st, vec4(0.0,1.0,0.0, 3.0)) ;//sdSphere(st, vec3(sphere2.x + 0.5, sphere2.y - 0.5, 10.0), 3.);
    float t3 = sdSphere(st, vec3(sphere2.x + 0.2, sphere2.y, 8.0 +cos(u_time)), 2.);
//    float t3 =sdBox(vec3(0., -0.3, -8), vec3(1.5));
    
    float pct =0.99;// abs(sin(u_time));
    return smin(t, smin(t2,t3,pct), pct);
//    return t3;
}





float sdTorus2D(vec2 st, vec2 t){
    
    vec2 q = vec2(length(st.x)-t.x,st.y);
    return length(q)-t.y;
    
}

//--------------------------------------------------------------
vec3 pal( in float t, in vec3 a, in vec3 b, in vec3 c, in vec3 d )
{
    return a + b*cos( 6.28318*(c*t+d) );
}

vec3 calcNormal(vec3 pos)
{
    // Center sample
    float c = sdf(pos);
    // Use offset samples to compute gradient / normal
    vec2 eps_zero = vec2(0.001, 0.0);
    return normalize(vec3( sdf(pos + eps_zero.xyy), sdf(pos + eps_zero.yxy), sdf(pos + eps_zero.yyx) ) - c);
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

float rayMarch(vec3 origin, vec3 dir){
    
    int numSteps = 80;
    
    float dist = 0;
    for (int i = 0; i < numSteps; i++){
        
        float sd = sdf(origin + dir * dist);
        
        if(sd < 0.00001*dist)
            return dist;
       
        dist += sd;
    }
    return -1.0;
}

//--------------------------------------------------------------
vec3 render(vec3 origin, vec3 dir){

    float t = rayMarch(origin, dir);
    vec3 col;
    vec3 L = vec3(0.3,0.5,-0.5);
    if(t >= 0.0){
        
        vec3 pos = origin + dir * t;
        
        vec3 N = calcNormal(pos);
        
        float NoL = max(dot(N,L),0.0);
        vec3 LDirectional = vec3(1.80,1.27,0.99) * NoL;
        vec3 objectSurfaceColour = vec3(0.792, 0.082, 0.318);
        vec3 ambient =vec3(0.9);// vec3(0.9, 0.8, 0.02);
        col = (LDirectional+ambient) * objectSurfaceColour;
        
        float shadow = 0.0;
        vec3 shadowRayOrigin = pos + N * 0.01;
        vec3 shadowRayDir = L;
        float shadowRayIntersection = rayMarch(shadowRayOrigin, shadowRayDir);
        if (shadowRayIntersection != -1.0)
        {
            shadow = 1.0;
        }
        col = mix(col, col*0.2, shadow);
//        col = vec3(0.792-t*0.075,0.082-t*0.075,0.318-t*0.075);
        
//        col = N * vec3(0.5) + vec3(0.5);
    } else
        col = vec3(0.059, 1.0, 0.584) - (dir.y * 0.7);
    
    
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
    
   
    vec3 col = vec3(0.0);

    vec3 camPos    = vec3(0.0, 0.0, -1.0);
    vec3 camTarget = vec3(0.0, 0.0,  0.0);
    
    vec3 rayDir = getCameraRayDir(st, camPos, camTarget);
    
    col = render(camPos, rayDir);
	
    
    outputColor = vec4(col, 1.0);
}

