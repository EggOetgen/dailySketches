float r = 100;
float growSpeed = 0.01;

float grow = 0;
int numSpheres = 72;
boolean rot = false;
float[] displacers = new float[numSpheres];
void setup(){

  size(800,800, P3D);
  for(int theta = 0; theta < numSpheres; theta+=1){
  displacers[theta] = ((noise(theta*434325)*2)-1) * 100;
    //r+= displace;
  }
}

void draw(){
  fill(255 * abs(cos(grow*0.5)),2);
  rect(-10, -10, width+120, height + 120);
  lights();
  //background(255 * abs(cos(grow*0.5)));
  r = (100 * abs(sin(grow*0.5 * sin(grow*0.05)))) + 50*cos(grow*0.1);
   fill(225 * abs(sin(grow*0.5))+10,10);
  translate(width/2, height/2);
  ellipse(0,0,r*4, r*4);
  //fill(255 * abs(cos(grow*0.5)), 255 * abs(cos(grow*2)));
    fill(255 * abs(cos(grow*0.5)));

    //float displace = noise(frameCount)*10;
    //r+= displace;
  //  for(int theta = 0; theta < numSpheres; theta+=1){
  //displacers[theta] = ((noise(theta*434325 * frameCount)*2)-1) * 10;
  //  //r+= displace;
  //}
    int spacer = 360 / numSpheres;
    boolean rot = false;
    float rand = random(1.);
    if( rand> 0.8){
      rot = true;
    }
    rand = random(1.);
    if( rand> 0.9){
      rot = false;
    }
   sphere(r/2);
   noLights();
  for(int theta = 0; theta < 360; theta+=spacer){
    
       float x = (r + displacers[theta/spacer]) * cos(radians(theta));
       float y = (r + displacers[theta/spacer]) * sin(radians(theta));
     
      noStroke();
      pushMatrix();
      //if(rot){
       rotateX(sin(frameCount*0.02));
       rotateY(cos(frameCount*0.02));
      //}
        
       translate(x,y);
       sphere(5*cos(radians(theta)));
       popMatrix();
  }
  grow+= growSpeed;
   //fill(0,255,0);
  
}
