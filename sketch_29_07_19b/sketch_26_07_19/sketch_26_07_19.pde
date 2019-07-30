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
}

void draw() {

  background(255);
  translate(width/2, height/2);

  color c = color(255);
  //pushMatrix();
  ////rotate(sin(millis()));
  //point.x = 100 * sin(radians(720*noise(millis()*0.001)));
  //point.y = 100 * cos(radians(720*noise(millis()*0.001)));
  //line(0, 0, point.x, point.y);
  //ellipse(point.x,point.y, 10, 10);
  //popMatrix();

  PVector prevPoint = new PVector(0, 0);
  PVector prevPoint2 = new PVector(0, 0);
  float rad =100; 
  for (int i = 0; i < points.length; i++) {

    float time = millis()*0.0003;
    //points[i].x = 100*i * sin(radians(720*noise(millis()*0.001+(1+i*32412))));
    //points[i].y = 100*i * cos(radians(720*noise(millis()*0.001+(1+i*32412))));
    points[i].x = prevPoint.x+rad * sin(radians(noise(time)*720*(i+1)));
    points[i].y = prevPoint.y+rad * cos(radians(noise(time)*720*(i+1)));
    points2[i] = new PVector(-points[i].x, -points[i].y);

    line(prevPoint.x, prevPoint.y, points[i].x, points[i].y);
    line(prevPoint2.x, prevPoint2.y, points2[i].x, points2[i].y);
    ellipse(points[i].x, points[i].y, 10, 10);
    ellipse(points2[i].x, points2[i].y, 10, 10);
    prevPoint = points[i];
    prevPoint2 = points2[i];
    rad*=0.9;
  }
  loadPixels();
  for (int x = -width/2; x < width/2; x++) {
    for (int y = -height/2; y < height/2; y++) {
      int closestPoint = -1;
      float smol = MAX_FLOAT;
      PVector curPoint = new PVector(x, y);  
      for (int i = 0; i < points.length; i++) {

        float curDist = curPoint.dist(points[i]);
        //println(curDist);
        if (curDist < smol) {
          smol = curDist;
          closestPoint = i;
        }
      }
      for (int i = 0; i < points2.length; i++) {

        float curDist = curPoint.dist(points2[i]);

        if (curDist < smol) {
          smol = curDist;
          closestPoint = i;
        }
      }
      //      //println(closestPoint);
      c = colors[closestPoint];
      if (x < -width/2.2 || x > width/2.2 || y < -height/2.2 || y > height/2.2 )
        c = color(56);
      int loc = (x + width/2) +((y + height/2) * width);
      pixels[loc] = c;
      fill(colors[7]);
    }
  }

  updatePixels();
  for(int i = 0; i < 1; i++){
  for (int x = -width/2+1; x < width/2-1; x++) {
    for (int y = -height/2+1; y < height/2-1; y++) {
      int loc = (x + width/2) +((y + height/2) * width);
      int lef = (x-1 + width/2) +((y + height/2) * width);
      int rig = (x+1 + width/2) +((y + height/2) * width);
      int up = (x + width/2) +((y+1 + height/2) * width);
      int dwn = (x + width/2) +((y-1 + height/2) * width);
      //int rig = (x+1 + width/2) +((y + height/2) * width);

      float r = (red(pixels[loc]) + red(pixels[lef]) +red(pixels[up])+ red(pixels[dwn]) +red(pixels[rig]))/5;
      float g = (green(pixels[loc]) + green(pixels[lef]) +green(pixels[rig])+ green(pixels[up]) +green(pixels[dwn]))/5;
      float b = (blue(pixels[loc]) + blue(pixels[lef]) +blue(pixels[rig])+ blue(pixels[up]) +blue(pixels[dwn]))/5;
      pixels[loc] = color(r,g,b);
    }
  }
  updatePixels();
  }
}
