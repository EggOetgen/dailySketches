#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    shader.load("shader");
    shaderBG.load("shaderBG");
     s = "Drink Milk";
    
    f.loadFont("Hind-Regular.ttf", ofGetWidth()*0.5);

//    ofSetBackgroundAuto(false);
}

//--------------------------------------------------------------
void ofApp::update(){

}

//--------------------------------------------------------------
void ofApp::draw(){
     ofSetColor(240);
    
    shaderBG.begin();
    float t = ofGetElapsedTimef() * 0.5;
    shader.setUniform3f("a", abs(cos(t)*0.5) + 0.5,abs(sin(t)*0.5), abs(sin(t)) );
    //     shader.setUniform3f("a", ofMap(ofGetMouseX(), 0, ofGetWidth(), 0, 1.0),ofMap(ofGetMouseY(), 0, ofGetHeight(), 0, 1.0), 0.5 );
    shader.setUniform3f("b", 0.5, 0.5, 0.5 );
    shader.setUniform3f("c", 1.0, 1.0, 0.5 );
    shader.setUniform3f("d", 0.8, 0.9, 0.3 );
     shader.setUniform2f("u_resolution", ofGetWidth(), ofGetHeight());
     ofDrawRectangle(0, 0, ofGetWidth(), ofGetHeight());
    
    shaderBG.end();
    
   
  shader.begin();
    
   
//    float t = ofGetElapsedTimef() * 0.5;
      shader.setUniform1f("u_time", ofGetElapsedTimef()* 0.8);
      shader.setUniform1f("offset", ofGetMouseX());
      shader.setUniform2f("u_resolution", ofGetWidth(), ofGetHeight());
    shader.setUniform2f("u_mouse", ofGetMouseX(),ofGetMouseY());
//     shader.setUniform3f("a", abs(cos(t)*0.5) + 0.5,abs(sin(t)*0.5), abs(sin(t)) );
    shader.setUniform3f("a",0.5,0.5, 0.5 );
    shader.setUniform3f("b", 0.5, 0.5, 0.5 );
    shader.setUniform3f("c", 1.0, 1.0, 0.5 );
    shader.setUniform3f("d", 0.8, 0.9, 0.3 );
    shader.setUniform3f("u_color1", 1.0, 0.0, 0.0);
    shader.setUniform3f("u_color2", 10.0, 1.0, 0.0);
     shader.setUniform3f("u_color3", 0.0, 0.0, 1.0);
    ofDrawRectangle(0, 0, ofGetWidth(), ofGetHeight());
  
    shader.end();
    

  
    mv-=1;
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

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
void ofApp::mouseEntered(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y){

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
