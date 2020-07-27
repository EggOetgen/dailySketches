drop drip;
drop drips[] = new drop[10];
void setup() {

  drip = new drop(new PVector(width, width), 100);
  for( int i = 0; i < drips.length; i++){
    drips[i] = new drop(new PVector(random(width), random(height)), random(100));
  }
  size(900, 900);
}


void draw() {
  translate(width/2, height/2);
  background(0);
  loadPixels();

  for (int x = 0; x < width; x+=2) {
    for (int y = 0; y < height; y+=10) {
       for( int i = 0; i < drips.length; i++){
      int loc = x +y * width;
      //pixels[loc] = color(0);
      PVector pos = new PVector(x, y);
    
      
      if (drips[i].isWithin(x, y))
        pixels[loc] = color(255);
      else {
        PVector newPos = radialDisplacement(pos, drips[i].pos, drips[i].r);
        color oldc = get(x, y);
        
        int nX = floor(newPos.x);
        int nY = floor(newPos.y);
        //println(newPos.y);
        if (newPos.x > 0 && newPos. x < width && newPos.y>0 && newPos.y < height){
        loc = int(nX + nY * width);
        pixels[loc] = oldc;
        }
      }
    drips[i].r+= random(-0.1,0.1); ;

  }
    }
  }
  updatePixels();
  //drip.rSq+=10;
  //println(drip.rSq);
  //drip.rSq = drip.rSq % (width*height);
}

float sqrDist(PVector p1, PVector p2) {

  float sd = ((p2.x - p1.x) * (p2.x - p1.x)) + ((p2.y - p1.y) * (p2.y - p1.y));

  return sd;
}

PVector radialDisplacement( PVector P, PVector C, float r) {

  PVector newP;
  newP = C.add( P.sub(C))  .mult( sqrt( 1 + ( (r*r) / abs( P.sub(C).dot(P.sub(C)) ))) ) ;
  return newP;
}

void keyPressed(){ 
for( int i = 0; i < drips.length; i+=5){
drips[i].r+= random(-1,1); 
}
}
