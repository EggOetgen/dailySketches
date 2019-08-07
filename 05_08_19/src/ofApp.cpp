#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
  shader.load("shader.vert","shader.frag");
}

//--------------------------------------------------------------
void ofApp::update(){
    c.update();
}

//--------------------------------------------------------------
void ofApp::draw(){
    ofVec2f *cent = c.returnCentres();
      ofSetColor(255);
    shader.begin();
    shader.setUniform1f("u_time", ofGetElapsedTimef());
    shader.setUniform2f("u_resolution", ofGetWidth(), ofGetHeight());
    shader.setUniform2f("u_mouse", cent[0].x, cent[0].y);
    shader.setUniform2f("u_mouse2", cent[1].x, cent[1].y);
    if(useMouse)
    shader.setUniform2f("u_mouse3", ofGetMouseX(), ofGetMouseY());
    shader.setUniform3fv("centres", &cent[0].x, 20);
    ofRect(0,0,ofGetWidth(), ofGetHeight());
    shader.end();
    
//    ofDrawEllipse(cent[0].x, cent[1].y, 10, 10);
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){
    useMouse = !useMouse;
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
