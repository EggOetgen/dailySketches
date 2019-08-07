PVector point;
int drawLength = 10000;
int numNodes = 300;
PVector points[] = new PVector[numNodes];
float scales[] = new float[numNodes];
float step = 0;
color[] colors = new color[100];
PVector prevPoint2 = new PVector(0,0);
boolean on = false;

ArrayList<PVector> drawPoints = new ArrayList<PVector>();
void setup() {

  size(900, 900, P3D);
  color(HSB, 255);
  point = new PVector(100, 100);
  for (int i = 0; i < points.length; i++) {
    points[i] = new PVector(random(-100, 100), random(-100, 100), 0);
    scales[i] = random(-100, 100);
  }
  float seed = random(1000);
  for (int i = 0; i < 100; i++) {
    colors[i] = color(noise(seed) *255, noise(seed*9333) *120, noise(seed*1435) *100);
    seed++;
  }
  //strokeWeight(3);
   drawPoints.add(points[numNodes-1]);
  ambientLight(51, 102, 126);
  background(0);
}

void draw() {
  background(0);
//fill(0,3);
//rect(0,0,width,height);
  translate(width/2, height/2);
if(on){
  color c = color(255);


  PVector prevPoint = new PVector(0, 0);
  
  float rad =150; 

  //println(step);
  //fill(255*noise(millis()*0.1), 255-255*noise((millis()*123123)*0.1), 255-255*noise(millis()*0.1));
  //stroke(255*noise(millis()*0.1), 255-255*noise((millis()*123123)*0.1), 255-255*noise(millis()*0.1));
  //lights();
  for (int i = 0; i < numNodes; i++) {

    float time = millis()*0.0001;
    //points[i].x = 100*i * sin(radians(720*noise(millis()*0.001+(1+i*32412))));
    //points[i].y = 100*i * cos(radians(720*noise(millis()*0.001+(1+i*32412))));
    //points[i].x = prevPoint.x+rad * sin(radians((time) * sin(((720 / 3)*(i+1) )* time)));
    //points[i].y = prevPoint.y+rad * cos(radians((time) * sin(((720 / 3)*(i+1) )* time)));

    points[i].x = prevPoint.x+rad * sin(( scales[i]  )  * 720);
    points[i].y = prevPoint.y+rad * cos(( scales[i]  )  * 720);

    line(prevPoint.x, prevPoint.y, points[i].x, points[i].y);

    ellipse(points[i].x, points[i].y, 10, 10);
 
    prevPoint = points[i];
    scales[i]+=signNoise(time * i) * 0.00005;
    rad*=0.9;
  }
  //println(drawPoints.size());
  if(drawPoints.size() < drawLength){
    PVector temp = new PVector(points[numNodes-1].x, points[numNodes-1].y, points[numNodes-1].z);
    drawPoints.add(temp);
  }else{
  drawPoints.remove(0);
  }
  for (int i = 0; i < drawPoints.size(); i++){
    float s = map(i, 0, drawPoints.size(), 0, 255);
    stroke(s, 255-s, 255-255*noise(s*0.1), s);
    fill(s, 255-s, 255-255*noise(s*0.1), 1);
    line(drawPoints.get(i).x, drawPoints.get(i).y, drawPoints.get(i).z, width, drawPoints.get(i).y , drawPoints.get(i).z ); 
  }
  //stroke(255);
  //pushMatrix();

  //translate(points[numNodes-1].x+width/2, points[numNodes-1].y , points[numNodes-1].z);
  //box(width,1,10);
  //popMatrix();
  line(points[numNodes-1].x, points[numNodes-1].y, points[numNodes-1].z, width, points[numNodes-1].y , points[numNodes-1].z ); 
 // beginShape();
 
 // vertex(points[numNodes-1].x, points[numNodes-1].y, points[numNodes-1].z ); 
 // vertex(width, points[numNodes-1].y, points[numNodes-1].z ); 

 // vertex(width, prevPoint2.y, prevPoint2.z );
 // vertex(prevPoint2.x, prevPoint2.y, prevPoint2.z ); 
 

  
 //// vertex(points[numNodes-2].x, points[numNodes-2].y, points[numNodes-2].z ); 
 ////vertex(width, points[numNodes-2].y, points[numNodes-2].z );
  
 //// vertex(points[numNodes-3].x, points[numNodes-3].y, points[numNodes-3].z ); 
 //// vertex(width, points[numNodes-3].y, points[numNodes-3].z );

 // endShape();
  
   if(frameCount % 100 == 0)
 prevPoint2 = points[numNodes-1];
  //ellipse(points[numNodes-1].x, points[numNodes-1].y, 5, 5);
}
}

float signNoise(float in) {

  float sN = noise(in);
  sN *= 2.;
  sN -= 1.0;

  return sN;
}

void keyPressed(){
on = true;
}
