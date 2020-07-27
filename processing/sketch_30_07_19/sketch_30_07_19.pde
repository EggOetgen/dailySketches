PVector cells[] = new PVector[300*300];
int size;

PVector drop;
void setup() {
background(0);
  size(600, 600,P3D);
  drop = new PVector(random(width), random(height));
  size = 2;
  int range = 300;
  int i =0;
  for (int x = 0; x < range; x++) {
    for (int y = 0; y < range; y++) {

      //println(x + " " + y + " " +i);
      cells[i] = new PVector(x * size , y * size, random(-10,10) );
      i++;
    }
  }
  noStroke();
}

void draw() {
  background(0);
  rotateX(radians(4));
  lights();
  for (int i = 0; i < cells.length; i++) {
   

    cells[i] = radialDisplacement(cells[i], new PVector(0,  0, random(-10,10)), 20);
    //cells[i] = radialDisplacement(cells[i],new PVector(width,0),5);
    //cells[i] = radialDisplacement(cells[i],drop,0.01); 
    //cells[i] = radialDisplacement( drop, cells[i], 0.1); 

    rect(cells[i].x, cells[i].y, size, size);
    //pushMatrix();
    //translate(cells[i].x, cells[i].y,cells[i].z);
    //    sphere(size);
    // popMatrix();
      fill(random(255), 100, 150);
  }
  //ellipse(0,0, 100, 100);
}

void keyPressed() {
  drop.x = random(width);
  drop.y = random(height);
  println(drop.x + " " + drop.y);
 
}

PVector radialDisplacement( PVector P, PVector C, float r) {

  //C.x = map(C.x, 0, width, 0, 1);
  //C.y = map(C.y, 0, height, 0, 1);
  //P.x = map(P.x, 0, width, 0, 1);
  //P.y = map(P.y, 0, height, 0, 1);

  PVector newP;
  newP = C.add( P.sub(C))  .mult( sqrt( 1 + ( (r*r) / abs( P.sub(C).dot(P.sub(C)) ))) ) ;
  return newP;
}
