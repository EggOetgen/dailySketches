import controlP5.*;

//float k = 0.1;

float r = 100;
boolean debug = false;
boolean debug2 = false;
spring con;
spring cons[] = new spring[10*10];
node nodes[] = new node[10];
node node, node2, node3;
void setup() {
  size(900, 900);
  con = new spring(new PVector(0, 0), 1, 0.0000055);
  int theta = 360 / 10;
  //println(theta);
  for (int i = 0; i < 360; i += theta) {

    //float x = random(50, r) * sin(radians(i));
    //float y = random(50, r) * cos(radians(i));
    float x = r* sin(radians(i));
    float y = r * 0.5 * cos(radians(i ));
    nodes[i/theta] = new node(new PVector(x, y));
  }

  strokeCap(ROUND);

  for (int i = 0; i < nodes.length; i++) {
    //con.setPos(nodes[i].pos);
    for (int j = 0; j < nodes.length; j++) {

      int ind = i + j * nodes.length;
      float l = nodes[i].pos.dist(nodes[j].pos);

      //float k = map(l, 0, r*2, 0.01, 1.0);
      float k =0.01;
      cons[ind] = new spring(nodes[i].pos, l, k);
      println(ind + " " + l + " " + k);
    }
  }
}

void draw() {
  translate(width/2, height/2);
  noFill();
  background(215,253,240);  

  fill(255);

  for (int i = 0; i < nodes.length; i++) {
    //  con.setPos(nodes[i].pos);


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

    nodes[i].pos.x *= noise(millis()* (i+1) *0.0001);
    nodes[i].pos.y *= noise(millis()*(i + 1)*0.0001);
    float f = map(i, 0, nodes.length, 0, 255);
    fill(255, f, f);
    nodes[i].draw();
  }
  if (debug)
    fill(205, 189, 216, 60);
  else
    fill(205, 189, 216);
    
    noStroke();
  beginShape();
  vertex(nodes[0].pos.x, nodes[0].pos.y);
  for (int i = 0; i < nodes.length-1; i++) {
    bezierVertex(nodes[i].cpB.x, nodes[i].cpB.y, nodes[i+1].cpA.x, nodes[i+1].cpA.y, nodes[i+1].pos.x, nodes[i+1].pos.y);
  }

  bezierVertex(nodes[nodes.length-1].cpB.x, nodes[nodes.length-1].cpB.y, nodes[0].cpA.x, nodes[0].cpA.y, nodes[0].pos.x, nodes[0].pos.y);

  endShape();
  pushStyle();
  stroke(0);
  fill(0);
  ellipse(-20, -40, 5, 5);
  ellipse(20, -40, 5, 5);
  strokeWeight(5);
  line(-20, 10, 20, 10);
  popStyle();
}



void applyForce(PVector f) {

  //PVector f = PVector.div(force,mass);
  //acc.add(f);
}
void mousePressed() {
  float x = map(mouseX, 0, width, -width/2, width/2);
  float y = map(mouseY, 0, height, -height/2, height/2);

  for (int i = 0; i < nodes.length; i++) {

    nodes[i].isWithin(x, y);
  }
  //if(mouseX > pos.x-r && mouseX < pos.x+r && mouseY > pos.y-r && mouseY < pos.y+r){
  //  drag =true;

  //}
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
  } else if (key == ' ') {
    int theta = 360 / nodes.length;
    ;
    for (int i = 0; i < 360; i += theta) {

      nodes[i/theta].pos.x  = random(20, r) * sin(radians(i));
      nodes[i/theta].pos.y = random(20, r) * cos(radians(i));
      //nodes[i/36].updateSpring();
      for (int j = 0; j < nodes.length; j++) {

        int ind = (i/theta) + j * nodes.length;
        float l = nodes[i/theta].pos.dist(nodes[j].pos);


        cons[ind].anchor = nodes[i/theta].pos;
      }
    }
  } else if (key =='l') { 
    debug2 = !debug2;
  }else
    debug = !debug;
}
