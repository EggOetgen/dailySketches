#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
#ifdef TARGET_OPENGLES
    shader.load("shadersES2/shader");
#else
    if(ofIsGLProgrammableRenderer()){
        shader.load("shaders/shader");
    }else{
        shader.load("shaders/shader");
    }
#endif
    
//    img.load("img.jpg");
//    shader
    mx = ofGetWidth()/2;
    my = ofGetHeight()/2;
    plane.set(ofGetWidth()*0.8, ofGetHeight()*0.8, ofGetWidth(), ofGetHeight(), OF_PRIMITIVE_TRIANGLE_STRIP);
//      plane.set(ofGetWidth(), ofGetHeight(),1000,500, OF_PRIMITIVE_TRIANGLE_STRIP);
    //    plane.mapTexCoords(0, 0, img.getWidth(), img.getHeight());
    
    
    f.loadFont("/Users/edmundoetgen/Documents/of_v0.10.1_osx_release/apps/myApps/type1/bin/data/HelveticaNeue-01.ttf", 160);
    
     vidGrabber.setDeviceID(1);
    vidGrabber.setDesiredFrameRate(60);
    vidGrabber.initGrabber(ofGetWidth(), ofGetHeight());

    string s = "  Go To  ";
    
    fbo.allocate(ofGetWidth(), ofGetHeight(), GL_RGBA);
    ofSetColor(255, 255, 255);
    plane.mapTexCoords(0, fbo.getHeight(), fbo.getWidth(), 0);
 
    fbo.begin();
    ofPushMatrix();
    ofTranslate(ofGetWidth()/2, ofGetHeight()/2);
 
       plane.draw();
       ofPopMatrix();
    ofRectangle r = f.getStringBoundingBox(s, 0, 0);
    ofVec2f offset = ofVec2f(floor(-r.x - r.width * 0.5f), floor(-r.y - r.height * 0.5f));
    ofSetColor(0);
   
    f.drawString(s, fbo.getWidth() / 2 + offset.x*0.9, fbo.getHeight() / 2 - offset.y);
    s = "The Party";
      f.drawString(s, fbo.getWidth() / 2 + offset.x*1.1, fbo.getHeight() / 2 + offset.y*2.);
//    ofDrawEllipse(200, 300, 500, 50);
    fbo.end();
    
    ofSetBackgroundColor(190, 190, 190);
    pos.set(650, 350);
    dest.set(350, 350);
    vel.set(0,0);
}


//--------------------------------------------------------------
void ofApp::update() {
//    range = ofMap(ofGetMouseX(),0,ofGetWidth(), 2, 50);
//    prevRange = range;
//    range = ofMap(ofNoise(ofGetElapsedTimef()*2),0,1, 2, 50);
//    range += prevRange;
//    range /=2.0;
    float currTime;
    float burstA;
    float rando = ofRandom(1.0);
    float rangerange= 0;
       vidGrabber.update();
//    if (!burst && rando > 0.99){
//        burst = true;
//        ind =0 ;
////        rangerange = 50.;
//        unlockTimer = ofGetElapsedTimeMillis() + burstTime;
//        burstTime = ofRandom(400);
//    }
//    if(burst ){
//            burstA= 50 * abs(sin(ind));
//        ind+=inc;
//    }
//        rangerange = 4;
//
//    range = abs(sin(ofGetElapsedTimef() *sin(ofNoise(ofGetElapsedTimef()*0.05)) )) * rangerange + burstA;
//   if(ofGetElapsedTimeMillis() > unlockTimer)
//       burst =false;

//    mx = abs((sin(t) * 200) )+ 200;
//    my = ofRandom(0,800);
//    my = abs((cos(t*0.7424) * 300)) + 500;
    ofVec2f acc;
    acc.set(0,0);
    ofVec2f force = pos - dest;
    float length = force.distance(dest);
    if(length > 0.1){
    force = force.getNormalized();
    force*=(-1 * 0.001 * length);
    
    acc+= force;
    vel += acc;
    vel *=  0.95;
    pos+=vel;
    }
    t+=0.01;
     std::cout  <<length<< " " << force <<"\n";
//    if(force > -0.1){
//        dest.x = ofRandom(500,800);
//        dest.y = ofRandom(200,500);
//    }
}

//--------------------------------------------------------------
void ofApp::draw() {
    ofSetBackgroundColor(0);
    ofDrawEllipse(pos.x,pos.y, 1000,100);
    ofDrawEllipse(dest.x,dest.y, 100,1000);
//string s = "  Go To  ";
//    fbo.begin();
////    ofPushMatrix();
////    ofTranslate(ofGetWidth()/2, ofGetHeight()/2);
//    vidGrabber.draw(0,0);
//    ofRectangle r = f.getStringBoundingBox(s, 0, 0);
//    ofVec2f offset = ofVec2f(floor(-r.x - r.width * 0.5f), floor(-r.y - r.height * 0.5f));
//    ofSetColor(0);
//
//    f.drawString(s, fbo.getWidth() / 2 + offset.x*0.9, fbo.getHeight() / 2 - offset.y);
//    s = "The Party";
//    f.drawString(s, fbo.getWidth() / 2 + offset.x*1.1, fbo.getHeight() / 2 + offset.y*2.);
//    //    ofDrawEllipse(200, 300, 500, 50);
//    fbo.end();
    
    // bind our texture. in our shader this will now be tex0 by default
    // so we can just go ahead and access it there.
    //    img.getTexture().bind();
    fbo.getTexture().bind();
    // start our shader, in our OpenGL3 shader this will automagically set
    // up a lot of matrices that we want for figuring out the texture matrix
    // and the modelView matrix
    shader.begin();
    
    // get mouse position relative to center of screen
    float mousePosition = ofMap(mouseX, 0, ofGetWidth(), 1.0, -1.0, true);
#ifndef TARGET_OPENGLES
    // when texture coordinates are normalised, they are always between 0 and 1.
    // in GL2 and GL3 the texture coordinates are not normalised,
    // so we have to multiply the normalised mouse position by the plane width.
    mousePosition *= plane.getWidth();
#endif
    
    shader.setUniform2f("u_resolution", ofGetWidth(), ofGetHeight());
//    shader.setUniform1f("mouseX", ofGetMouseX());
//    shader.setUniform1f("mouseY", ofGetMouseY());
//    shader.setUniform1f("mouseX", mx);
//    shader.setUniform1f("mouseY", my);
    shader.setUniform1f("mouseX", pos.x);
    shader.setUniform1f("mouseY", pos.y);
    shader.setUniform1f("u_time", ofGetElapsedTimef());
//    shader.setUniform1f("u_time", 1.);

//     shader.setUniform1f("offset", sin(ofGetElapsedTimef()) * 1000);
    
    ofPushMatrix();
    
//    ofSetColor(255,0,0);
    ofTranslate(ofGetWidth()/2, ofGetHeight()/2);
     
    //    plane.drawWireframe();
    plane.draw();
    
    
    ofPopMatrix();
    
    shader.end();
    
//    img.getTexture().unbind();
    
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){
    dest.x = ofRandom(500,800);
   dest.y = ofRandom(200,500);
    std::cout << mx << " " << my << "\n";
}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){
    
}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y){
    
}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){
    
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){
    
}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){
    
}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){
    
}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){
    
}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){
    
}
