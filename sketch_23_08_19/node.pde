class node {

  PVector pos;
  PVector acc =new  PVector(0, 0);
  PVector vel  =new  PVector(0, 0);
  float r = 20;
  PVector cpA = new  PVector(0, 0);
  ;
  PVector cpB = new  PVector(0, 0);
  ;
  spring cornerSprings[] = new spring[4];

  float offSet = 10;

  boolean drag = false;

  node(PVector pos_) {

    pos = pos_;

    for (int x = 0; x < 2; x++) {
      for (int y = 0; y < 2; y++) {
        int i = x + y *2;

        PVector p = new PVector(x * width - width/2, y * height - height/2);
        float d = p.dist(pos);
        //println(d);
        cornerSprings[i] = new spring (p, d, 0.02);
      }
    }
  }
  void updateSpring() {
    for (int i = 0; i < 4; i ++) {
      cornerSprings[i].setPos(pos);
    }
  }


  void draw() {

    if (drag) {
      pos.x = map(mouseX, 0, width, -width/2, width/2);
      pos.y = map(mouseY, 0, height, -height/2, height/2);
    }

    for (int i = 0; i < 4; i ++) {
      //if (!drag) 
      applyForce(cornerSprings[i].calculate(pos));

      //cornerSprings[i].draw();
    }
    if (!drag) {
      vel.add(acc);
      pos.add(vel);
      vel.mult(0.9);
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
    //cpA = PVector.fromAngle(radians(angle));

    //cpA.y = pos.y+(PVector.fromAngle(radians(angle)).mult(100.)).y;
    // cpB.x = pos.x-(PVector.fromAngle(radians(angle)).mult(100.)).x;
    //cpB.y = pos.y-(PVector.fromAngle(radians(angle)).mult(100.)).y;
    //angle = degrees(angle)  -40; 
    //cpB = PVector.fromAngle(radians(angle)).mult(scale);
    
    //cpA.x = *m* 
    //cpA.x = pos.x + 10;
    //cpA.y = pos.y + 10;
    ////cpA = PVector.fromAngle(atan2(pos.x-450, pos.y-350));
    ////println(cpA.x +" " +  cpA.y);
    //cpB.x = pos.x - 10;
    //cpB.y = pos.y - 10;
  if(debug){
    ellipse(pos.x, pos.y, r, r);
    //fill(0);
    //ellipse(pos.x, pos.y, r/3, r/3);
  
    pushStyle();
    fill(255, 0, 0);
    ellipse(cpA.x, cpA.y, 5, 5);
    fill(255, 255, 0);
    ellipse(cpB.x, cpB.y, 5, 5);
    popStyle();
    }
    acc.mult(0);
  }

  void applyForce(PVector f) {

    //PVector f = PVector.div(force,mass);
    acc.add(f);
  }

  void isWithin( float x, float y) {
    if (x > pos.x-r && x < pos.x+r && y > pos.y-r && y < pos.y+r) {
      drag = true;
    }
  }
}
