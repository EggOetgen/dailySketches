/**
 * ASCII Video
 * by Ben Fry. 
 *
 * 
 * Text characters have been used to represent images since the earliest computers.
 * This sketch is a simple homage that re-interprets live video as ASCII text.
 * See the keyPressed function for more options, like changing the font size.
 */

import processing.video.*;

Capture video;
boolean cheatScreen = false;
node nodey;
node[] nodes = new node[1000];
// All ASCII characters, sorted according to their visual density
String letterOrder =
  " .`-_':,;^=+/\"|)\\<>)iv%xclrs{*}I?!][1taeo7zjLu" +
  "nT#JCwfy325Fp6mqSghVd4EgXPGZbYkOA&8U$@KHDBWNMR0Q";
char[] letters;

float[] bright;
char[] chars;

PFont font;
float fontSize = 1.5;


void setup() {
  size(640, 480);

  // This the default video input, see the GettingStartedCapture 
  // example if it creates an error
  video = new Capture(this, 640, 480);

  // Start capturing the images from the camera
  video.start();  

  int count = video.width * video.height;

  // current brightness for each point

  stroke(0, 200, 250);
  
  for(int i = 0; i < nodes.length; i++){
  nodes[i] = new node(new PVector(random(width), random(height)));
  }
  strokeWeight(2);
    background(0);

}


void captureEvent(Capture c) {
  c.read();
}


void draw() {
  //background(0);
    //if (video.available()) { 
if(cheatScreen){
  video.loadPixels();
  //for (int x = 0; x < video.width; x++) {
  //  for (int y = 0; y < video.height; y++) {
  //    int loc = x + y * video.width;
  //    int pixelColor = video.pixels[loc];
  //    // Faster method of calculating r, g, b than red(), green(), blue() 
  //    int r = (pixelColor >> 16) & 0xff;
  //    int g = (pixelColor >> 8) & 0xff;
  //    int b = pixelColor & 0xff;

  //    float luminance = 0.3*r + 0.59*g + 0.11*b;
  //      stroke(luminance);

  //    println(luminance);
  //    int newX = floor(map(x, 0, video.width, 0, width));
  //    int newY = floor(map(y, 0, video.height, 0, height));
  //    pushMatrix();
  //    translate(newX, newY);
  //    rotate(radians(luminance * 3.6));
  //    line(0, 0, 10, 0);
  //    popMatrix();
  //  }
  //}
  
    for(int i = 0; i < nodes.length; i++){

  int x =floor(nodes[i].pos.x);// floor(map(nodey.pos.x, 0, width, 0, video.width));
   // x= constrain(x,  0, video.width);

  int y =floor(nodes[i].pos.y);// floor(map(nodey.pos.y, 0, height, 0, video.height));
     //y= constrain(y,  0, video.height);

  int loc = x + y * video.width;
  //println("x : " + x + "  y :" + y + "   loc:" + loc + " : " + video.pixels.length); 
  loc = constrain(loc, 0, video.pixels.length-1);
  int pixelColor = video.pixels[abs(loc)];
  // Faster method of calculating r, g, b than red(), green(), blue() 
  int r = (pixelColor >> 16) & 0xff;
  int g = (pixelColor >> 8) & 0xff;
  int b = pixelColor & 0xff;

  float luminance = 0.3*r + 0.59*g + 0.11*b + ((noise(millis()*r, millis() * g, millis() * b) -0.5)* 10);
  float angle = luminance * 3.6;
  stroke(pixelColor); 
    fill(pixelColor, luminance); 

      nodes[i].applyForce(PVector.fromAngle(angle));

    nodes[i].draw();
    }
}
    //}
  //noLoop();
}


/**
 * Handle key presses:
 * 'c' toggles the cheat screen that shows the original image in the corner
 * 'g' grabs an image and saves the frame to a tiff image
 * 'f' and 'F' increase and decrease the font size
 */
void keyPressed() {

cheatScreen = !cheatScreen;
    //for (int i = 0; i <  nodes.length; i ++) {
    //  //nodes[i].pos.x = random(width);
    //  //      nodes[i].pos.y = random(height);
    //  nodes[i].applyForce(PVector.fromAngle(random(TWO_PI)));
  
      
    //}
  
}

//void mouseDragged(){
//      for (int i = 0; i <  nodes.length; i ++) {

//    nodes[i].isWithin(mouseX, mouseY);
//      }
//}
