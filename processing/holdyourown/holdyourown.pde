float viewSize = 600;
float viewHeight = 600;

PFont f;

void setup() {
  background(0);
  //background(67, 72,144);
  noStroke();
  //stroke(255);
  size(620, 879);
  //size(2480, 3508);
  viewSize = width *0.9;
  viewHeight = height * 0.75;

  f = createFont("GT-Walsheim-Pro-Trial-Regular.otf",16,true); // Arial, 16 point, anti-aliasing on
  


}

void draw() {
  //background(201, 150, 130);
background(162,173,197);
  noStroke();
  //background(0);
 //viewSize = mouseX;
  //viewSize = floor(x);

  pushMatrix();
  translate((width - viewSize)/2, (width - viewSize)/2);

  fill(29, 59, 143);
  rect(0, 0, viewSize, height -( (width - viewSize)) );
  noStroke();
  //  fill(237, 189 ,66);
  //ellipse(0,0,150,150);
  int numStep = floor(viewSize);
  for (int i = 0; i < numStep; i ++) {
    fill(237, 189, 66, map(i, 0, numStep, 10, 0));
    ellipse(0, 0, viewSize/9+i, viewSize/9+i);
    //inc +=0.5;
  }
  //wall(400, 100, -50, -50, 100, 100, 10);
  //wall(mouseX, mouseY, -50, -50, 100, 100, 10);
  wall(viewSize/2, viewSize/2, viewSize/9, -viewSize/4, viewSize/9, viewSize/9, viewSize/90);
  //stairs(width/2, height/2,4, 50,12, 10);
  popMatrix(); 
   pushMatrix();
  translate((width - viewSize)/2, (height -( (width - viewSize)))/3);
//fill(201, 150, 130, mouseX);
fill(162,173,197, 80);
    textFont(f,(height -( (width - viewSize)))/3);
  text("Hold",0,0);
   text("Your",0,(height -( (width - viewSize)))/3);
    text("Own",0,2*(height -( (width - viewSize)))/3);
  popMatrix();
}

void wall(float x, float y, float xDis, float yDis, float w, float h, float thick) {

  noFill();
  //noStroke();
  beginShape();

  //fill(120);
  stroke(219, 142, 68);
  fill(219, 142, 68);
  vertex(x, y);
  vertex(x+w + xDis, y + yDis);
  vertex(x +xDis+ w, y + h + yDis);
  vertex(x, y + h);
  vertex(x, y);
  endShape();

  fill(150);
  fill(80, 140, 150);
  stroke(80, 140, 150);
  beginShape();
  vertex(x - thick, y - thick );
  vertex(x, y);
  vertex(x, y + h);
  vertex(x - thick, y + h - thick);
  vertex(x - thick, y - thick);
  endShape();

  fill(220);
  fill(205, 109, 132);
  stroke(205, 109, 132);
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

  fill(10, 100);
  stroke(10, 100);
  beginShape();
  vertex(x, y + h );
  vertex(x  +xDis+ w, y + h + yDis);
  vertex(x  +xDis+ w +w, y +h + yDis+h);
  vertex(x +w, y + h + h);
  vertex(x, y + h);
  endShape();
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

void keyPressed(){

  save("holdYourOwn.jpg");
}

//void stairs() {
//}
