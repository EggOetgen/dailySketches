class spring {

  PVector anchor = new PVector(0, 0);
  float l;
  PVector pos;
  float k;
  spring(PVector anc, float l_, float k_) {

    anchor = anc;
    //pos = pos_;
    k = k_;
    l = l_;
  };

  void draw() {
    line(anchor.x, anchor.y, pos.x, pos.y);
  }

  PVector calculate(PVector p) {
    pos = p;
    if(debug)
      draw();
    PVector force = PVector.sub(pos, anchor);
    float currentLength = force.mag();
    float x = currentLength - l;

    force.normalize();

    force.mult(-1 * k * x);
    //force.mult(-1 * k * x);
    //applyForce(force);
    return force;
  }
  
  void setPos(PVector newPos){
    anchor = newPos;
  }
}
