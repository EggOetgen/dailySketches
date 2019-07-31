PVector point;

PVector points[] = new PVector[10];
PVector points2[] = new PVector[10];

color[] colors = new color[100];
void setup() {

  size(900, 900);
  point = new PVector(100, 100);
  for (int i = 0; i < points.length; i++) {
    points[i] = new PVector(random(-100, 100), random(-100, 100));
    points2[i] = new PVector(-points[i].x, -points[i].y);
  }
  float seed = random(1000);
  for (int i = 0; i < 100; i++) {
    colors[i] = color(noise(seed) *255, noise(seed*9333) *120, noise(seed*1435) *100);
    seed++;
  }
  //noStroke();
  stroke(255);
  background(0);
}

void draw() {

  //background(255);
  //fill(255,2);
  //rect(0,0,width,height);
  translate(width/2, height/2);

  color c = color(255);

  //PVector prevPoint = new PVector(0, 0);
  //PVector prevPoint2 = new PVector(0, 0);
  //float rad =100; 
  //for (int i = 0; i < points.length; i++) {

  //  float time = millis()*0.00003;
  //  //points[i].x = 100*i * sin(radians(720*noise(millis()*0.001+(1+i*32412))));
  //  //points[i].y = 100*i * cos(radians(720*noise(millis()*0.001+(1+i*32412))));
  //  //points[i].x = prevPoint.x+rad * sin(radians(noise(time)*720*(i+1)));
  //  //points[i].y = prevPoint.y+rad * cos(radians(noise(time)*720*(i+1)));
  //  points2[i] = new PVector(-points[i].x, -points[i].y);

  //  points[i].x = prevPoint.x+rad * sin(radians(time*163 * i));
  //  points[i].y = prevPoint.y+rad * cos(radians(time*720));
  //  time *= 0.1;
  //  points2[i].x = prevPoint.x+rad * sin(radians(time*720 * i));
  //  points2[i].y = prevPoint.y+rad * cos(radians(time*720));


  //  line(prevPoint.x, prevPoint.y, points[i].x, points[i].y);
  //  //line(prevPoint2.x, prevPoint2.y, points2[i].x, points2[i].y);
  //  ellipse(points[i].x, points[i].y, 2, 2);
  //  //ellipse(points2[i].x, points2[i].y, 2, 2);
  //  prevPoint = points[i];
  //  prevPoint2 = points2[i];
  //  rad*=0.9;
  //}
rune(millis(), 0.0006, 72, 72, 40);
  //      //println(closestPoint);

  fill(colors[7]);
}

void rune(float time, float speed, float xMod, float yMod, int nodes) {

  PVector point =  new PVector(0, 0);
  
  PVector prevPoint = new PVector(0, 0);

  float rad =100; 
  time *= speed;
  for (int i = 0; i < nodes; i++) {
    point.x = prevPoint.x+rad * sin(radians(time*xMod * i));
    point.y = prevPoint.y+rad * cos(radians(time*yMod));
     
     println("prev :" +prevPoint + " cur :" + point);
     stroke(map(i, 0, nodes, 125,255),120-map(i, 0, nodes, 0,120),0,50);
    line(prevPoint.x, prevPoint.y, point.x, point.y);
    fill(map(i, 0, nodes, 125,255),120-map(i, 0, nodes, 0,120),0);
    noStroke();
    ellipse(point.x, point.y, 2, 2);
    //ellipse(points2[i].x, points2[i].y, 2, 2);
    if(i > 0){
    prevPoint.add(point);
    }
 
    rad*=0.9;
  }
}
