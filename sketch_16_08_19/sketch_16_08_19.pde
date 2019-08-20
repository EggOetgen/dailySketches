int rows = 5;
int cols = 10;

Cell cells[] = new Cell[cols*rows];

void setup() {
  frameRate(15);
  //strokeWeight(4);
  size(1024, 614);
 
  background(230, 250, 252);
   colorMode(HSB, 1.0);
  //float h = 0.6;
  float s = 0.4;
  //translate(width/2, height/2);
  //for(int i = 0; i < 360; i++){
  //   stroke(h,map(i,0,36,0,1),s);
  //  //pushMatrix();
  //  //rotate(radians(random(360)));

  ////brush(random(-width/2, width/2), random(-height/2, height/2), random(50,100), random(50,100));
  // brush(map(i, 0,10, -width/2,width/2),     sin(radians(i * 36 )* cos(i*51))*height, map(i+1, 0, 10, -width/2,width/2)  ,sin(radians((i +1)*36 )* cos((i+1)*51))*height);


  // //ellipse(map(i, 0, 10, -width/2,width/2),  sin(radians(i *36))*100,10,10);
  ////popMatrix();
  //}


  FloatList test = new FloatList();
  for (int y = 0; y < 50; y++) {
    test.append(random(1.0));
  }

  int w = width/cols;
  int h = height/rows;

  int x = 1;
  int y =0;
  cells[0] = new Cell();
  cells[0].on(true, 0, 0, w, h);
  cells[0].draw();


  for (int i = 1; i < cells.length; i++) {
    stroke(noise(i*second() * hour()),0.3,s,1-(noise(i)*0.5)) ;
 
 strokeWeight(noise(i) * 3);
    cells[i] = new Cell();
    if (random(1.0) > 0.8)
      cells[i].on(false, x*w, y*h, w, h, cells[i-1].returnOut());
    else
      cells[i].on(true, x*w, y*h, w, h, cells[i-1].returnOut());
    cells[i].draw();
    x++;
    if (x % 10 ==0) {
      x = 0;
      y++;
    }
  }

  //Cell cell = new Cell();
  //cells[0].on(true, 0, 0, 100,100);
  //Cell cell2 = new Cell();
  //cell2.on(true, 100, 0, 100,100, cell.returnOut());
  //Cell cell3 = new Cell();
  //cell3.on(false, 200, 0, 100,100, cell2.returnOut());
  //cell.draw();
  //cell3.draw();
  //cell2.draw();
  int numB = 10;
  float theta = 360/numB;
  float rx =50;
  float ry = 50;


  //brush(-100, -100, 100, 100);

  //for(int x = 0; x < 10; x++){


  //  int f = 0;
  //  for(int y = 0; y < 10; y++){

  //   float xt ;
  //    stroke(h,map(x,0,10,0,1),s);
  //      if(random(1.0)>0.5){
  //       //f++;
  //       //break;
  //      }
  //      //else

  //          xt = x * width/10;
  //    float yt = f * height/10;
  //     if(random(1.0)>0.5){
  //    brush(xt, yt, xt+width/10,  yt, (int)random(50), false);
  //     }else{
  //          brush(xt, yt, xt+width/10,  yt+height/10, (int)random(50), true);
  //     }
  //  f++;

  //  }

  //}
}
void draw() {
 // fill(0.7, 0.14, 0.8,0.2);
 // rect(0,0,width,height);
 //  int w = width/cols;
 // int h = height/rows;

 // int x = 1;
 // int y =0;
 // cells[0] = new Cell();
 // cells[0].on(true, 0, 0, w, h);
 // cells[0].draw();


 // for (int i = 1; i < cells.length; i++) {

 //stroke(noise(i*second() * hour()),0.3,0.4,1-(noise(i)*0.5)) ;
 //   cells[i] = new Cell();
 //   if (random(1.0) > 0.8)
 //     cells[i].on(false, x*w, y*h, w, h, cells[i-1].returnOut());
 //   else
 //     cells[i].on(true, x*w, y*h, w, h, cells[i-1].returnOut());
 //   cells[i].draw();
 //   x++;
 //   if (x % 10 ==0) {
 //     x = 0;
 //     y++;
 //   }
 // }
}





void brush(float x, float y, float x2, float y2, int dens, boolean start) {
  noFill();
  //stroke(0);
  //noStroke();
  strokeWeight(random(3.5, 4.5));
  int bristles =dens;// (int)random(8, 10);
  //x2 = x + 10;
  //y2 = y+10;

  float t = 0;
  for ( int b = 0; b < bristles; b++) {
    beginShape();
    strokeWeight(random(1, 3));
    curveVertex( x, y ); // the first control point
    //fill(255,0,0);
    //ellipse(x,y,40,40);
    t = 0;
    float nx = x+ random(-3, 3);
    float ny = y+ random(-3, 3);
    //println(x + " " + y + " "+ nx + " " +ny + " "+ x2 + " " +y2);
    for (int i = 0; i < 10; i++) {
      //curveVertex(x + i * gap + random(-5,5), y  + random(-3, 3)); // is also the start point of curve

      nx = nx+ ((x2-nx) * t) + random(-3, 3);
      ny = ny+ ((y2-ny) * t) + random(-3, 3);
      //fill(0,255,0);
      // ellipse(nx,ny,10,10);
      //vertex(nx,ny);
      curveVertex(nx, ny);
      t= map(i, 0, 10, 0, 1);
    }
    curveVertex(x2, y2); // is also the last control point
    endShape();
    //fill(0,0,255);
    //    ellipse(x2,y2,10,10);
    if (!start) {
      y+= random(3, 5);
      y2+=random(3, 5);
    } else
      y2+=random(3, 5);
  }
}
