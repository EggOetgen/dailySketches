//float k = 0.1;
float restLength = 0;
PVector pos = new PVector(-150, -150 );
PVector pos2 = new PVector(150, -150 );
PVector pos3 = new PVector(00, 150 );

//PVector pos = new PVector(300, 300 );
//PVector acc =new  PVector(0, 0);
//PVector vel  =new  PVector(0, 0);

boolean debug = false;
spring con;

node node, node2, node3;
void setup() {
  size(900, 900);
  node = new node(pos);
  node2 = new node(pos2);
  node3 = new node(pos3);
  con = new spring(pos, 100, 0.01);
  //for (int x = 0; x < 2; x++) {
  //  for (int y = 0; y < 2; y++) {
  //    int i = x + y *2;

  //    PVector p = new PVector(x * width, y * height);
  //    float d = p.dist(pos);
  //    println(d);
  //    cornerSprings[i] = new spring (p,  d, 0.05);
  //  }
  //}
}

void draw() {
  translate(width/2,height/2);
noFill();
  background(120);  
  if (debug) {
    con.setPos(node.pos);
    node.applyForce(con.calculate(node2.pos));
    con.draw();
    node.applyForce(con.calculate(node3.pos));
    con.draw();

    con.setPos(node2.pos);
    node2.applyForce(con.calculate(node.pos));
    con.draw();
    node2.applyForce(con.calculate(node3.pos));
    con.draw();

    con.setPos(node3.pos);
    node3.applyForce(con.calculate(node.pos));
    con.draw();
    node3.applyForce(con.calculate(node2.pos));
    con.draw();
  } else {
    con.setPos(node.pos);
    node.applyForce(con.calculate(node2.pos));
    //con.draw();
    node.applyForce(con.calculate(node3.pos));
    //con.draw();

    con.setPos(node2.pos);
    node2.applyForce(con.calculate(node.pos));
    //con.draw();
    node2.applyForce(con.calculate(node3.pos));
    //con.draw();

    con.setPos(node3.pos);
    node3.applyForce(con.calculate(node.pos));
    //con.draw();
    node3.applyForce(con.calculate(node2.pos));
    //con.draw();
  }
  fill(255);
  
  node.draw();
  fill(255);
  node2.draw();
  fill(0);
  node3.draw();
  //noFill();
  //bezier(node.pos.x, node.pos.y, 10, 10, 90, 90, node2.pos.x, node2.pos.y);
  //  bezier(node2.pos.x, node2.pos.y, 10, 10, 90, 90, node3.pos.x, node3.pos.y);
  //    bezier(node3.pos.x, node3.pos.y, 10, 10, 90, 90, node.pos.x, node.pos.y);
  fill(255,200,200);
  beginShape();
  vertex(node.pos.x, node.pos.y); // first point
 bezierVertex(node.cpB.x,  node.cpB.y, node2.cpA.x, node2.cpA.y, node2.pos.x, node2.pos.y);
bezierVertex(node2.cpB.x, node2.cpB.y, node3.cpA.x, node3.cpA.y, node3.pos.x,node3.pos.y);
bezierVertex(node3.cpB.x, node3.cpB.y, node.cpA.x, node.cpA.y, node.pos.x,node.pos.y);
  endShape();
  //if (drag) {
  //  pos.x = mouseX;
  //  pos.y = mouseY;
  //}

  //for (int i = 0; i < 4; i ++) {
  //   //if (!drag) 
  //  applyForce(cornerSprings[i].calculate(pos));
  //  //cornerSprings[i].draw();
  //}
  // if (!drag) {
  //vel.add(acc);
  //pos.add(vel);
  //vel.mult(0.93);
  // }
  //ellipse(pos.x, pos.y, r, r);

  //acc.mult(0);
}



void applyForce(PVector f) {

  //PVector f = PVector.div(force,mass);
  //acc.add(f);
}
void mousePressed() {
  float x = map(mouseX, 0, width, -width/2, width/2);
   float y = map(mouseY, 0, height, -height/2, height/2);
  node.isWithin(x, y);
  node2.isWithin(x, y);
  node3.isWithin(x, y);
  //if(mouseX > pos.x-r && mouseX < pos.x+r && mouseY > pos.y-r && mouseY < pos.y+r){
  //  drag =true;

  //}
}

void mouseReleased() {
  node.drag =false;
  node2.drag =false;
  node3.drag =false;
  //drag =false;
}


void keyPressed() {
 
  if(key =='c')
  node3.offSet = node2.offSet = node.offSet = mouseX;
  else
   debug = !debug;
}

  
