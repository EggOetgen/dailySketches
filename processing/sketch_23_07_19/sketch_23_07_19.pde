int numPoints = 50;
float rad = 100;

PVector[] points = new PVector[numPoints];
color[] colors = new color[numPoints];
void setup(){

  size(800,800);
  float seed = random(1000);
  for(int i = 0; i < numPoints; i++){
    float x = random(rad) * sin(random(360));
     float y = random(rad) * sin(random(360));
    //points[i] = new PVector(random(width), random(height));
      points[i] = new PVector(x + width/2, y + height/2);
    //colors[i] = color(noise(seed) *255, noise(seed*9333) *120, noise(seed*1435) *100);
     colors[i] = color(noise(seed) *255);
    seed ++;
  }
}

void draw(){
  background(0);
loadPixels();
color c = color(255);
for(int x = 0; x < width; x++){
  for(int y = 0; y < height; y++){
    int closestPoint = -1;
    float smol = MAX_FLOAT;
    PVector curPoint = new PVector(x,y);  
  

  for(int i = 0; i < numPoints; i++){
      
    float curDist = curPoint.dist(points[i]);
    
    if(curDist < smol){
      smol = curDist;
      closestPoint = i;
    }
  }
  //switch(closestPoint){
  //  case -1:
  //    break;
  //  case 0:
  //    c = color(255,0,0);
  //    break;
  //  case 1:
  //    c = color(0,255,0);
  //    break;
  //  case 2:
  //    c = color(0,0,255);
  //    break;
  //  case 3:
  //    c = color(255,0,255);
  //    break;
  //}
  c = colors[closestPoint];
   //c = color(255 -red(colors[closestPoint]),255 -green(colors[closestPoint]),255 -blue(colors[closestPoint]) );
  // c = color(255 -red(colors[closestPoint]),255 -red(colors[closestPoint]),255 -red(colors[closestPoint]) );
  //if(curPoint.dist(new PVector(width/2, height/2)) > 200){
     //if(false){
    //c = color(255 -red(colors[closestPoint]),255 -green(colors[closestPoint]),255 -blue(colors[closestPoint]) );
    c*= colors[ closestPoint];
     //}
     //if((curPoint.dist(new PVector(width/2, height/2)) > 250) &&(curPoint.dist(new PVector(width/2, height/2)) < 270))  {
     //  c*= colors[ closestPoint];
     //}
    int loc = x +(y * width);
    pixels[loc] = c;
  }
}
updatePixels();
for(int i = 0; i < numPoints; i++){
  
    
  //  ellipse(points[i].x,points[i].y, 10, 10);
    
    //while((points[i].x >width && points[i].x <0) && (points[i].y >height && points[i].y <0) ){ 
    points[i].x += random(-5,5);
    points[i].y += random(-5,5);
    //}
    
    if((points[i].x >width || points[i].x <0)){
    float x = random(rad) * sin(random(360));
    points[i].x = x + mouseX;
     
    }
     if((points[i].y >height || points[i].y <0) ){
    float y = random(rad) * sin(random(360));
    points[i].y = y + mouseY;
    }
  }
  
  
}
