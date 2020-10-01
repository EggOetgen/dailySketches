class node {

  PVector pos;
  PVector prevPos=new  PVector(0, 0);
  PVector acc =new  PVector(0, 0);
  PVector vel  =new  PVector(0, 0);
  float r = 4;
  PVector cpA = new  PVector(0, 0);
  ;
  PVector cpB = new  PVector(0, 0);
  ;
  //spring cornerSprings[] = new spring[4];

  float offSet = 10;

  boolean drag = false;

  node(PVector pos_) {

    pos = pos_;
    prevPos.x = pos.x;
        prevPos.y = pos.y;
r = random(3);

    //for (int x = 0; x < 2; x++) {
    //  for (int y = 0; y < 2; y++) {
    //    int i = x + y *2;

    //    PVector p = new PVector(x * width - width/2, y * height - height/2);
    //    float d = p.dist(pos);
    //    //println(d);
    //    cornerSprings[i] = new spring (p, d, 0.02);
    //  }
    //}
  }
  void updateSpring() {
    //for (int i = 0; i < 4; i ++) {
    //  cornerSprings[i].setPos(pos);
    //}
  }


  void draw() {

    if (drag) {
      pos.x = map(mouseX, 0, width, -width/2, width/2);
      pos.y = map(mouseY, 0, height, -height/2, height/2);
    }

    //for (int i = 0; i < 4; i ++) {
    //  //if (!drag) 
    //  applyForce(cornerSprings[i].calculate(pos));

    //  //cornerSprings[i].draw();
    //}
    if (!drag) {
      vel.add(acc);
      pos.add(vel);
      vel.mult(0.85);
    }

    //float m = (-pos.y) / ( -pos.x);
    //println(m);
    //float m2 = m / -1;
    float scale = pos.dist(new PVector(0, 0));
    //float angle = PVector.angleBetween(pos, new PVector(1,0));
    float angle = atan2(pos.y, pos.x) - atan2(0, 0);



    cpA.x  = pos.x + (offSet * cos(PI/2 + angle));
    cpA.y =pos.y + (offSet * sin(PI/2 + angle));
    cpB.x  = pos.x + (offSet * cos(PI * 1.5 + angle));
    cpB.y =  pos.y + (offSet * sin(PI * 1.5 + angle));
    
    //if(pos.x > width/2)
    //  pos.x = -width/2;
    //else if (pos.x < -width/2)
    //  pos.x = width/2;
    //else if(pos.y > height/2)
    //  pos.y = -height/2;
    // else if (pos.y < -height/2)
    //  pos.y = height/2;
       if(pos.x > width)
      pos.x = 0;
    else if (pos.x < 0)
      pos.x = width;
    else if(pos.y > height)
      pos.y =0 ;
     else if (pos.y < 0)
      pos.y = height;
  //if(debug){
    //if(abs(pos.x - prevPos.x) < width/2 &&abs(pos.y - prevPos.y) < height/2){ 
    //  line(pos.x, pos.y, prevPos.x, prevPos.y);
    //}else{
    //    //point(pos.x, pos.y);
    //}
    ellipse(pos.x, pos.y, r, r);
  //  //fill(0);
  //  //ellipse(pos.x, pos.y, r/3, r/3);
  
  //  pushStyle();
  //  fill(255, 0, 0);
  //  ellipse(cpA.x, cpA.y, 5, 5);
  //  fill(255, 255, 0);
  //  ellipse(cpB.x, cpB.y, 5, 5);
  //  popStyle();
  //  }
    acc.mult(0);
 prevPos.x = pos.x;
        prevPos.y = pos.y;
  }

  void applyForce(PVector f) {
    //PVector f = PVector.div(force,mass);
    acc.add(f);
  }

  void isWithin( float x, float y) {
    if (x > pos.x-100 && x < pos.x+100 && y > pos.y-100 && y < pos.y+100) {
      drag = true;
    }
  }
}
