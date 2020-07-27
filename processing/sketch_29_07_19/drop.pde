class drop{

  PVector pos;
  float r, rSq;
  drop(PVector pos_, float r_){
    pos = pos_;
    r = r_;
    rSq = r*r;
  }
  
  boolean isWithin(PVector point){
  
rSq = r*r;
    
    if(sqrDist( point, pos ) < rSq)
      return true;
    else
      return false;
      
      
  }
  
  boolean isWithin(float x, float y){
  
    PVector point = new PVector(x,y);
    
    if(sqrDist( point, pos ) < rSq)
      return true;
    else
      return false;
  }

}
