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
    
//    plane.set(ofGetWidth(), ofGetHeight(), ofGetWidth(), ofGetHeight(), OF_PRIMITIVE_TRIANGLE_STRIP);
      plane.set(ofGetWidth(), ofGetHeight(),70,50, OF_PRIMITIVE_TRIANGLE_STRIP);
    //    plane.mapTexCoords(0, 0, img.getWidth(), img.getHeight());
    
    
    ofTrueTypeFont f;
    f.loadFont("/Users/edmundoetgen/Documents/of_v0.10.1_osx_release/apps/myApps/type1/bin/data/HelveticaNeue-01.ttf", 125);
    
    
    string s = "  Go To  ";
    
    fbo.allocate(ofGetWidth(), ofGetHeight(), GL_RGBA);
    plane.mapTexCoords(0, fbo.getHeight(), fbo.getWidth(), 0);
    fbo.begin();
    ofRectangle r = f.getStringBoundingBox(s, 0, 0);
    ofVec2f offset = ofVec2f(floor(-r.x - r.width * 0.5f), floor(-r.y - r.height * 0.5f));
    ofSetColor(0);
    f.drawString(s, fbo.getWidth() / 2 + offset.x*0.9, fbo.getHeight() / 2 - offset.y);
    s = "The Party";
      f.drawString(s, fbo.getWidth() / 2 + offset.x*1.1, fbo.getHeight() / 2 + offset.y*2.);
    
    fbo.end();
    
    ofSetBackgroundColor(190, 190, 190);
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
    
    if (!burst && rando > 0.99){
        burst = true;
        ind =0 ;
//        rangerange = 50.;
        unlockTimer = ofGetElapsedTimeMillis() + burstTime;
        burstTime = ofRandom(400);
    }
    if(burst ){
            burstA= 50 * abs(sin(ind));
        ind+=inc;
    }
        rangerange = 4;
    
    range = abs(sin(ofGetElapsedTimef() *sin(ofNoise(ofGetElapsedTimef()*0.05)) )) * rangerange + burstA;
   if(ofGetElapsedTimeMillis() > unlockTimer)
       burst =false;
    
}

//--------------------------------------------------------------
void ofApp::draw() {
    
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
    shader.setUniform1f("mouseX", ofGetMouseX());
    shader.setUniform1f("mouseY", ofGetMouseX());

//     shader.setUniform1f("offset", sin(ofGetElapsedTimef()) * 1000);
    
    ofPushMatrix();
    
    ofSetColor(255,0,0);
    ofTranslate(ofGetWidth()/2 -inc, ofGetHeight()/2);
     
    //    plane.drawWireframe();
    plane.draw();
    
    
    ofPopMatrix();
    
    shader.end();
    
//    img.getTexture().unbind();
    
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){
    
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
