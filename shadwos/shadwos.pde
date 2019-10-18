float viewSize = 600;
float viewHeight = 600;
int numC = 500000;
PFont f;

float rot = 12.4;
color colours[] = {color(162, 173, 197), color(219, 142, 68), color(80, 140, 150), color(205, 109, 132), color(29, 59, 143), color(237, 189, 66)};
//color colours[] = {color(162, 173, 197),color(219, 142, 68),color(80, 140, 150), color(205, 109, 132),  color(237, 189, 66, 10)};
PShader blur;
void setup() {
  background(0);
  //background(67, 72,144);
  noStroke();
  //stroke(255);
  size(620, 879);
  //size(600,600);
  //size(2480, 3508);
  viewSize = width *0.9;
  viewHeight = height * 0.75;

  f = createFont("GT-Walsheim-Pro-Trial-Regular.otf", 16, true); // Arial, 16 point, anti-aliasing on

  scene();
}

void draw() {
}

void wall(float x, float y, float xDis, float yDis, float w, float h, float thick) {

  noFill();
  fill(10, 100);
  stroke(10, 100);
  rect(x-thick, y + h +yDis, w/2+thick, height);
  //noStroke();
  beginShape();

  //fill(120);
  stroke(colours[1]);
  fill(colours[1]);
  vertex(x, y);
  vertex(x+w + xDis, y + yDis);
  vertex(x +xDis+ w, y + h + yDis);
  vertex(x, y + h);
  vertex(x, y);
  endShape();

  fill(150);
  fill(colours[2]);
  stroke(colours[2]);
  beginShape();
  vertex(x - thick, y - thick );
  vertex(x, y);
  vertex(x, y + h);
  vertex(x - thick, y + h - thick);
  vertex(x - thick, y - thick);
  endShape();


  fill(colours[3]);
  stroke(colours[3]);
  beginShape();
  vertex(x - thick, y - thick);
  vertex(x  +xDis+ w - thick, y + yDis - thick);
  vertex(x  +xDis+ w, y + yDis);
  vertex(x, y);
  vertex(x - thick, y - thick);
  endShape();

  beginShape();

  //  //fill(120);
  //  stroke(255, 0, 0);
  //  fill(255, 0, 0);

  //  vertex(x+10 + xDis, y + yDis);
  //  vertex(x +xDis+ 10, y + h + yDis);
  //  vertex(x, y + h/2+ h);
  //  vertex(x, y+ h/2);
  //  endShape();


  //float rWidth = dist(x, y + h, x + w + xDis, y + h + yDis);

  //rect(x-thick, y + h +yDis, w/2+thick,h);
  //beginShape();

  //vertex(x +w, y + h +yDis);
  // vertex(x +w , y + h +yDis + 10);
  //vertex(x, y + h);
  //vertex(x +w, y + h +yDis);
  //endShape();
}

void stairs( float x, float y, int numStairs, float w, float h, float steep) {

  float stepH = h/numStairs;
  float stepW = w/numStairs;
  for (int i = numStairs; i >=0; i --) {
    //  stroke(255,0,0);
    //line(x+ steep*i + w - 50, y + 20 - 50,+ steep*i + w, y + 20);
    wall(x + stepW*i, y, -20, -20, stepW, stepH, 50);
  }
}

void keyPressed() {

  for (int i = 0; i < colours.length; i ++) {

    int r = floor(random(colours.length));
    color temp = colours[r];

    colours[r] = colours[i];
    colours[i] = temp;
    //colours[
  }
  scene();
  save("monolith" + str(millis()) + ".jpg");
}

//void stairs() {
//}

void scene() {
  //background(201, 150, 130);
  background(colours[0]);
  background(colours[0]);
  noStroke();
  //background(0);
  //viewSize = mouseX;
  //viewSize = floor(x);

  pushMatrix();
  translate((width - viewSize)/2, (width - viewSize)/2);

  fill(colours[4]);
  rect(0, 0, viewSize, height -( (width - viewSize)) );
  noStroke();
  //  fill(237, 189 ,66);
  //ellipse(0,0,150,150);
  int numStep = floor(viewSize);
  for (int i = 0; i < numStep; i ++) {
    color sun = color(red(colours[5]), green(colours[5]), blue(colours[5]), map(i, 0, numStep, 10, 0));
    //colours[5] = color(red(colours[5]), green(colours[5]),blue(colours[5]), map(i, 0, numStep, 10, 0));
    fill(sun);
    ellipse(viewSize/2, 0, viewSize/9+i, viewSize/9+i);
    //inc +=0.5;
  }

  wall(viewSize*0.25, viewSize/2*1.5, -50, -50, 100, viewSize*0.3, 10);

  pushMatrix();
  translate((width - viewSize)/2, (height -( (width - viewSize)))/3);
  //fill(201, 150, 130, mouseX);
  fill(colours[0]);
  textFont(f, (height -( (width - viewSize)))/3);
  //text("Hold", 0, 0);

  popMatrix();
  wall(viewSize/2, viewSize/2*1.2, -50, -50, 100, viewSize*0.6, 10);
  pushMatrix();
  translate((width - viewSize)/2, (height -( (width - viewSize)))/3);
  //fill(201, 150, 130, mouseX);
  fill(colours[0]);
  textFont(f, (height -( (width - viewSize)))/3);

  //text("Your", 0, (height -( (width - viewSize)))/9);

  popMatrix();

  pushMatrix();
  translate((width - viewSize)/2, (height -( (width - viewSize)))/3);
  //fill(201, 150, 130, mouseX);
  fill(colours[0]);
  textFont(f, (height -( (width - viewSize)))/3);

  //text("Own", 0, 2*(height -( (width - viewSize)))/9);
  popMatrix();
  //stairs(width/2, height/2,4, 50,12, 10);
  wall(viewSize*0.75, viewSize/2*0.8, -50, -50, 100, viewSize*0.9, 10);
  popMatrix();
  tex();
}
void tex() {

  for (int i = 0; i <  numC; i ++) {
    noStroke();
    fill(random( 100, 180), random(10));
    float r = random(3);
    ellipse(random(width), random(height), r, r);
  }
}
