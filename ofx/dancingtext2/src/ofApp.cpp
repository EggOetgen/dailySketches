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
   
//    img.load("blackBrain.png");
//        logo.load("logo.svg");
    //    shader
    mx = ofGetWidth()/2;
    my = ofGetHeight()/2;
    //    plane.set(ofGetWidth()*0.8, ofGetHeight()*0.8, ofGetWidth(), ofGetHeight(), OF_PRIMITIVE_TRIANGLE_STRIP);
//    plane.set(ofGetWidth(), ofGetHeight(),1000,500, OF_PRIMITIVE_TRIANGLE_STRIP);
        plane.set(ofGetWidth(), ofGetHeight(), ofGetWidth(), ofGetHeight(), OF_PRIMITIVE_TRIANGLE_STRIP);

    //    plane.mapTexCoords(0, 0, img.getWidth(), img.getHeight());
    
    
    f.loadFont("/Users/edmundoetgen/Documents/of_v0.10.1_osx_release/apps/myApps/type1/bin/data/HelveticaNeue-01.ttf", 20);
//    vidGrabber.listDevices();
//    vidGrabber.setDeviceID(1);
//    vidGrabber.initGrabber(1280, 960);
    
    string s = "  Go To  ";
    
    fbo.allocate(ofGetWidth(), ofGetHeight(), GL_RGBA);
    ofSetColor(255, 255, 255);
    plane.mapTexCoords(0, fbo.getHeight(), fbo.getWidth(), 0);
    
    fbo.begin();
    ofPushMatrix();
    ofTranslate(ofGetWidth()/2, ofGetHeight()/2);
    
    plane.draw();

    ofSetColor(0);
    ofPopMatrix();

    s = "Every Day the Same • ";
    w =f.getStringBoundingBox(s, 0, 0).getWidth() * 1.;

    cols = floor(ofGetWidth()*2/w);
    rows = floor(ofGetHeight()/f.getStringBoundingBox(s, 0, 0).getHeight());
    for(int x = -ofGetWidth()/2; x <= cols + 10; x++){
        for(int y = 0; y <= rows; y++){
                     f.drawString(s,( x * w) + y*(w/2) , rows * y );


        }

    }
//
    fbo.end();
    
    ofSetBackgroundColor(190, 190, 190);
    pos.set(600, 600);
    dest.set(600, 600);
    scale.set(767,767);
    scale2.set(767,767);

    vel.set(0,0);
}


//--------------------------------------------------------------
void ofApp::update() {
  
    float currTime;
    float burstA;
    float rando = ofRandom(1.0);
    float rangerange= 0;
    vidGrabber.update();
    

    ofVec2f acc;
    acc.set(0,0);

    t+=0.2;
scale2 =ofInterpolateCosine(scale2, scale, 0.2);
    pos =  ofInterpolateCosine(pos, dest, 0.2);

}

//--------------------------------------------------------------
void ofApp::draw() {
    ofSetBackgroundColor(0);
    ofSetColor(255,255,255,80);


    ofSetColor(255,255,255,80);

   
    fbo.getTexture().bind();
  
    shader.begin();
    

    
    shader.setUniform2f("u_resolution", ofGetWidth(), ofGetHeight());
  
    shader.setUniform1f("mouseX", pos.x);
    shader.setUniform1f("mouseY", pos.y);
        shader.setUniform1f("u_time", ofGetElapsedTimef());
    shader.setUniform2f("u_mouse", scale2.x,scale2.y);

    ofPushMatrix();
    
    //    ofSetColor(255,0,0);
    ofTranslate(ofGetWidth()/2, ofGetHeight()/2);
    
    //        plane.drawWireframe();
    plane.draw();
    
    
    ofPopMatrix();
    
    shader.end();

    ofSetColor(255,200,200,alphaR);
    ofDrawEllipse(dest.x,dest.y, 100,100);
    ofSetColor(200,200,255,alphaB);
    ofDrawEllipse(scale.x,scale.y, 100,100);
    ofPushStyle();
    ofSetColor(255);

    int wid =ofGetWidth()/25;
    int hei =wid;//ofGetHeight()/25;
    ofDrawRectangle(0, 0, wid, ofGetHeight());
    ofDrawRectangle(0, ofGetHeight() - hei, ofGetWidth(),hei);
    ofDrawRectangle(0, 0, ofGetWidth(), hei);
    ofDrawRectangle(ofGetWidth() - wid, 0, wid, ofGetHeight());
    
    ofSetColor(220,220, 220);

    ofDrawRectangle(0, 0, wid, ofGetHeight());
//    ofSetColor(0,255, 0,40);

     ofDrawRectangle(0, ofGetHeight() - hei, ofGetWidth(),hei);
//    ofSetColor(0,0, 255,40);

    ofDrawRectangle(0, 0, ofGetWidth(), hei);
//    ofSetColor(255,255, 0,40);

    ofDrawRectangle(ofGetWidth() - wid, 0, wid, ofGetHeight());

    ofSetColor(60,60, 80, 40);
    ofDrawRectangle(pos.x-wid,  0, wid *2 ,hei/2);
    ofDrawRectangle(dest.x-wid, hei/2, wid*2 ,hei/2);
    ofDrawRectangle(scale2.x-wid, ofGetHeight() - hei/2, wid*2 ,hei/2);
    ofDrawRectangle(scale.x-wid, ofGetHeight() - hei, wid*2 ,hei/2);

    ofDrawRectangle(0,  pos.y - hei, wid/2 ,hei * 2);
    ofDrawRectangle(wid/2, dest.y- hei, wid/2 ,hei * 2);
    ofDrawRectangle(ofGetWidth() - wid/2, scale2.y- hei, wid/2 ,hei*2);
    ofDrawRectangle(ofGetWidth() - wid, scale.y- hei, wid/2 ,hei*2);
    ofPopStyle();
//    logo.draw(0,0, 100,100);
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){
    
    dest.x = ofGetWidth()/2;//ofRandom(500,1000);
    dest.y = ofGetHeight()/2;//ofRandom(200,500);
    std::cout << mx << " " << my << "\n";
    if (key == ' '){
        scale.x = 767;
    scale.y= 767;
    }
}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y){
    
}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){
    
    if(ofDist(x, y, dest.x, dest.y) <100 && button ==0){
        dest.x = x;
    dest.y= y;
    }
    if(ofDist(x, y, scale.x, scale.y) <100&& button ==2){
        scale.x = x;
        scale.y= y;
    }
    
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){
    if(ofDist(x, y, dest.x, dest.y) <100){
//        dest.x = x;
//        dest.y= y;
        alphaR = 100;
    }
    if(ofDist(x, y, scale.x, scale.y) <100){
//        scale.x = x;
//        scale.y= y;
        alphaB = 100;
    }
}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){
        alphaR = 40;
    alphaB = 40;

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
