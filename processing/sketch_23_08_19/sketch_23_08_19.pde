float size = 40;
float inc = 0.2;
float zOff = 0;
int cols, rows;
node node;

boolean debug = true;
float r = 300;
spring cons[] = new spring[20*20];
node nodes[] = new node[20];
void setup() {

  size(900, 900);

  cols = floor(width/size);
  rows = floor(width/size);

  node = new node(new PVector(100, 100));

  int theta = 360 / 20;
  for (int i = 0; i < 360; i += theta) {

    //float x = random(50, r) * sin(radians(i));
    //float y = random(50, r) * cos(radians(i));
    float x = r* sin(radians(i));
    float y = r  * cos(radians(i ));
    nodes[i/theta] = new node(new PVector(x, y));
  }

  for (int i = 0; i < nodes.length; i++) {
    //con.setPos(nodes[i].pos);
    for (int j = 0; j < nodes.length; j++) {

      int ind = i + j * nodes.length;
      float l = nodes[i].pos.dist(nodes[j].pos);

      //float k = map(l, 0, r*2, 0.01, 1.0);
      float k =0.001;
      cons[ind] = new spring(nodes[i].pos, l, k);
      println(ind + " " + l + " " + k);
    }
  }
   background(215,253,240);  
}

void draw() {
  //background(255);
   background(215,253,240);  
    //fill(215,253,240, 1);  
    //rect(0,0,width,height);
  translate(width/2, height /2);
 // float yOff = 0;
 // for (int x = -cols/2; x < cols/2; x++) {
 //   float xOff = 0;
 //   for (int y = -rows/2; y < rows/2; y++) {


 //     float r = noise(xOff, yOff, zOff) * (TWO_PI *2);
 //     PVector v = PVector.fromAngle(r);
 //     //fill(r);
 //     //pushMatrix();
 //     //translate(x * size, y*size);
 //     //rotate(r);
 //     //line(0, 0, size, 0);
 //     ////rect(x*size, y * size, size, size);
 //     //popMatrix();
 //for (int i = 0; i < nodes.length; i++) {
 //     if (x*size <= nodes[i].pos.x && x*size + size >= nodes[i].pos.x &&y*size <= nodes[i].pos.y && y*size + size >= nodes[i].pos.y ) {
 //       nodes[i].applyForce(v);
 //       //println(x*size + " " + node.pos.x + " " + y*size + " "+ node.pos.y);
 //     }
 //     }
 //     xOff+= inc;
 //   }
 
 //   yOff+= inc;
   
 // }

  for (int i = 0; i < nodes.length; i++) {
    //  con.setPos(nodes[i].pos);
      float r = noise(inc * nodes[i].pos.x, inc * nodes[i].pos.y, zOff) * (TWO_PI *2);
    nodes[i].applyForce(PVector.fromAngle(r));

    for (int j = 0; j < nodes.length; j++) {
      //    //con.k = 0.0000009 * ( nodes.length-abs(i-j));
      //    if (j !=i) {
      //      //nodes[i].applyForce(con.calculate(nodes[j].pos));
      //      //con.draw();
      //    }
      int ind = i + j * nodes.length;

      nodes[i].applyForce(cons[ind].calculate(nodes[j].pos));

      //cons[ind].draw();
    }
    nodes[i].draw();
  }
  stroke(205*noise(zOff), 189+(30*(noise(zOff)*2)-1), 216+(30*(noise(zOff)*2)-1));
    fill(205*noise(zOff), 189+(30*(noise(zOff)*2)-1), 216+(30*(noise(zOff)*2)-1),20);
  //node.draw();
   //noFill();
   beginShape();
  vertex(nodes[0].pos.x, nodes[0].pos.y);
  for (int i = 0; i < nodes.length-1; i++) {
    bezierVertex(nodes[i].cpB.x, nodes[i].cpB.y, nodes[i+1].cpA.x, nodes[i+1].cpA.y, nodes[i+1].pos.x, nodes[i+1].pos.y);
  }

  bezierVertex(nodes[nodes.length-1].cpB.x, nodes[nodes.length-1].cpB.y, nodes[0].cpA.x, nodes[0].cpA.y, nodes[0].pos.x, nodes[0].pos.y);

  endShape();
  
   zOff += inc;
}

void mousePressed() {
  float x = map(mouseX, 0, width, -width/2, width/2);
  float y = map(mouseY, 0, height, -height/2, height/2);

  for (int i = 0; i < nodes.length; i++) {

  nodes[i].isWithin(x, y);
  }
}

void mouseReleased() {
  for (int i = 0; i <  nodes.length; i++) {
  nodes[i].drag=false;
  }
  //drag =false;
}

void keyPressed() {

  if (key =='c') { 
    for (int i = 0; i <  nodes.length; i ++) {
      nodes[i].offSet = map(mouseX, 0, width, 0, 200);
      ;
    }
  }
}
