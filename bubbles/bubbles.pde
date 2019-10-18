PVector points[] = new PVector[4];
PFont f;
color c = color(192, 68, 101);
PGraphics pg;
void setup() {
  size(1000, 1000);

  //pg = createGraphics(width - (height/18 * 2), height  - (height/18 * 2));
    pg = createGraphics(width, height);
  f = createFont("GT-Walsheim-Pro-Trial-Regular.otf", 32, true); // Arial, 16 point, anti-aliasing on


  for (int i = 0; i < points.length; i++) {
    points[i] = new PVector(random(width), random(height));
  }
  //background(dist(0,0, mouseX,mouseY));
  //loadPixels();  
  // Loop through every pixel column
  //for (int x = 0; x < width; x++) {
  //  // Loop through every pixel row
  //  for (int y = 0; y < height; y++) {
  //    // Use the formula to find the 1D location
  //    int loc = x + y * width;

  //    float min = MAX_FLOAT;

  //    for (int i = 0; i < points.length; i++) {

  //      float dist = minkowski(points[i], new PVector(x, y), 1);//map(x, 0, width, 1., 2.0));
  //      min = (dist < min) ? dist : min;
  //    }
  //    //pixels[loc] = color(noise(x,y,minkowski(new PVector(width/2,height/2),new PVector(x,y), map(random(x),0, width, 1., 2.0))) * 255);
  //    //pixels[loc] = color(noise(x,y,min) * 255);
  //    pixels[loc] = color(min, 120-min, noise(x, y, min)* 255);

  //println(min);
  //  }
  //}
  //updatePixels();
  pg.beginDraw();
  pg.loadPixels();  

  // Loop through every pixel column
  for (int x = 0; x < pg.width; x++) {
    // Loop through every pixel row
    for (int y = 0; y < pg.height; y++) {
      // Use the formula to find the 1D location
      int loc = x + y * pg.width;

      float min = MAX_FLOAT;

      for (int i = 0; i < points.length; i++) {

        float dist = minkowski(points[i], new PVector(x, y), map(noise(x), 0, 1, 1., 1.4));
        min = (dist < min) ? dist : min;
      }
      c = color(192, 68, 101);
      //pg.pixels[loc] = color(red(c) * noise(min),green(c)* noise(min),blue(c) * noise(min));
      //pg.pixels[loc] = color(noise(x,y,min) * 255);
      pg.pixels[loc] = color( map(loc, 0, pg.width*pg.height, 0, min/2), 120-min, 255-noise(x, y, min)* 255);


      //println( map(loc, 0, width*height,0,255));
    }
  }
  pg.updatePixels();
  pg.endDraw();
}

void draw() {
  //for (int i = 0; i < points.length; i++){
  //  points[i].x *= sin(millis()*0.1 * i)*width;
  //    //points[i].y+= cos(millis()*0.1 * i)*height;
  //  }

  //background(minkowski(new PVector(0,0),new PVector(mouseX,mouseY), 1.));
  c = color(255-192, 255-68, 255-101);
  background(0 );
   //image(pg, height/18, height/18);
   image(pg,0,0);
  //c =  color(255, 255,0);
  fill(255);
  //fill(c);
  //textAlign(CENTER);
  //textFont(f, height/18);
  //text("G\nO\n \nT\nO\n\nT\nH\nE\n \nP\nA\nR\nT\nY", 24, height/18);
  //text("O", height/16 * 2 + 24, height/18);
  //text(" ", height/16 * 3 + 24, height/18);
  //text("T", height/16 * 4 + 24, height/18);
  //text("O", height/16 * 5 + 24, height/18);
  //text(" ", height/16 * 6 + 24, height/18);
  //text("T", height/16 * 7 + 24, height/18);
  //text("H", height/16 * 8 + 24, height/18);
  //text("E", height/16 * 9 + 24, height/18);
  //text(" ", height/16 * 10 + 24, height/18);
  //text("P", height/16 *11 + 24, height/18);
  //text("A", height/16 * 12 + 24, height/18);
  //text("R", height/16 * 13 + 24, height/18);
  //text("T", height/16 * 14 + 24, height/18);
  //text("Y", height/16 * 15 + 24, height/18);

  //println( "x : " + mouseX + " y :" +mouseY + "  noise :" + noise(mouseX * mouseY) *255);
}

float minkowski(PVector a, PVector b, float p) {


  float sum = 0;

  sum += pow(abs(a.x - b.x), p);
  sum += pow(abs(a.y - b.y), p);
  sum += pow(abs(a.z - b.z), p);

  float result = pow(sum, 1/p);
  return result;
}

void keyPressed() {

  save("goToTheParty" + millis() + ".jpg");
}
