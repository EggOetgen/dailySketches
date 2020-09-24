int scale = 2;
int t = 0;
PImage letter;
PImage letter2;
int picker = 0;
PImage img ;//= createImage(66, 66, ARGB);

void setup() {

  size(800, 800, P2D);
  letter = loadImage("A.png");
  letter2 = loadImage("B.png");

  letter.filter(BLUR, 20);
  letter2.filter(BLUR, 20);
  //img = createImage(400, 00, ARGB);
  //pixelDensity(2);
  colorMode(HSB, 360, 100, 100, 255);
}

void draw() {
  background(255);
  stroke(255, 150);
  //strokeWeight(4);
  //float t = millis() * 0.01;
  //dial(100,100, 20, mouseX);
  //image(letter,0,0);
  //letter.loadPixels();
  //for(int i = 0; i < letter.pixels.length; i ++){
  //color c = letter.pixels[i];
  //println(" c + " + alpha(c));
  //color newColor = (c & 0xffffff) | (0 << 24); 
  //  println(" newc + " + alpha(newColor));

  //letter.pixels[i] = newColor;
  //}  
  //letter.filter(BLUR, 5);
  //  letter2.filter(BLUR, 5);
  float m = map(mouseX, 0, width, 0, 255);
  tint(255, m);

  image(letter2, 0, 0);
  tint(255, 255-m);
  image(letter, 0, 0);
  //println(red(get(100,100)));

  //letter.updatePixels();
  loadPixels();
  background(255);
  tint(255, m);

  image(letter2, 0, 0, width,height);
  tint(255, 255-m);
  image(letter, 0, 0, width, height);
  //int rows = 400 / scale; 
  //int cols = 400 / scale; 
  translate(100, 100);
  //strokeWeight(2);
  fill(10);
  stroke(255);
  strokeWeight(5);

  rect(10, 10, 580, 580);
  strokeWeight(1);

  color c = color(255);
  for (int x = 0; x < 400; x+=scale) {
    for (int y = 0; y  <400; y+=scale) {
      //int curX = x * scale;
      //int curY = y * scale;
      c = pixels[x + y *width];
      //   if(picker ==0)
      //dial(curX, curY, scale * 2, red(letter2.get((curX + t) % width, curY)));
      //else
      //  dial(curX, curY, scale * 2, red(get((curX + t) % width, curY)));
      dial(x * 1.5, y * 1.5, scale*10, red(c));


      //img.pixels[loc] = get(curX, curY);
    }
  }

  //rotate(radians(red(c)));
  //line(650, 650, 670,670);
  //filter(BLUR, 10);

  //t+=5;
  //letter.blend(letter2,0,0,400, 400, 0,0,400, 400,BLEND);

  //noLoop();
  //println(mouseY);
  //filter(BLUR,2);
}


void dial(float x, float y, float l, float theta) {
  int numArms = 3;

  l = map(theta, 255, 0, l/2, l);
  //strokeWeight( map(theta, 0, 255, 0, 5));
  //l = noise(theta) * l;
  //float th = map(theta, 255, 0, 0, 360 ) * sin(millis() * x * y);//+ (millis() * 0.05 + l);
  float th = map(theta, 255, 0, 0, 360 )+  (millis() * 0.1 + l);
  //stroke(360,0, 100, 255-(the/ta % 125));

  //stroke(th%260,0, 100-th%100, 255-theta);
  stroke(180+((th%90) ), 100, 100, 30);//180-theta);
  //stroke(255,0, 100-th%50,255-theta);
  //      stroke(360,0, 100-(th%20), theta);


  //theta = millis()*theta;
  //theta/=0.0000001;
  if (theta <mouseY* 0.5) {
    pushMatrix();
    translate(x, y);
    for (int i = 0; i < numArms; i++) {
      rotate(radians(th));
      line(0, -l/2, 0, l/2);
      l*=2;
    }
    popMatrix();
  }
}

void keyPressed() {

  picker = (picker +1 ) % 2;
}
//void dial(int x, int y, float l, float theta){
//  int numArms = 10;
//    stroke(255, 255-theta);

//    l = map(theta, 255, 0, 0, l);
//  strokeWeight( map(theta, 0, 255, 0, 5));

//  theta = map(theta, 255, 0, 0, 360 )+ (millis() * 0.1 + l);
//  if(theta > 0){
//  pushMatrix();
//  beginShape();
//  translate(x,y);
//  for(int i = 0; i < numArms; i++){
//  rotate(radians(theta));
//  point(0, -l/2);//, 
//  point(0, l/2);
//  }
//  endShape(CLOSE);
//  popMatrix();
//  }
//}
