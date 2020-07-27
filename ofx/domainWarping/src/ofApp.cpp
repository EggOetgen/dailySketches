#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){

    shader.load("shader");
   
    f.loadFont("Allerta-Regular.ttf", 180);

}

//--------------------------------------------------------------
void ofApp::update(){
//    points[0].x = ofMap(ofGetMouseX(), 0, ofGetWidth(), 0, 1.0);
//    points[0].y = ofMap(ofGetMouseY(), 0, ofGetHeight(), 0, 1.0);
//    points[0].x += sin(ofGetElapsedTimeMillis() *0.0002 * TWO_PI) *2+ 0.5;
//     points[0].y = cos((ofGetElapsedTimeMillis() *0.0002  * TWO_PI)
//                 * cos((ofGetElapsedTimeMillis() *0.00008 * TWO_PI))
//                       )+ 0.5;
//
//     for(int i = 0; i < NUM_POINTS; i++){
//         points[i].x = sin(ofGetElapsedTimeMillis() *freqs[i]* TWO_PI) *freqs[i + NUM_POINTS]+ 0.5;
//         points[i].y = cos((ofGetElapsedTimeMillis() *freqs[i] * TWO_PI)
//                           * cos((ofGetElapsedTimeMillis() *0.0001 * TWO_PI))
//                           ) *freqs[i + NUM_POINTS]+ 0.5;
//     }
    
}

//--------------------------------------------------------------
void ofApp::draw(){

    
    
    shader.begin();
    shader.setUniform1f("u_time", ofGetElapsedTimef());
 
    shader.setUniform2f("u_resolution", ofGetWidth(), ofGetHeight());
    shader.setUniform2f("u_mouse", ofGetMouseX(),  ofGetMouseY());
    shader.setUniform1i("simple", simple);
    ofRect(0,0,ofGetWidth(),ofGetHeight());

    shader.end();
    
    ofSetColor(100, 50);
    f.drawString("things \n that \n never \n happened", ofGetWidth()*0.1,200);

}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){
    simple = !simple;
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
