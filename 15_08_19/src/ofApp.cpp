#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){

    shader.load("shader");
    for(int i = 0; i < NUM_POINTS; i++){
        
        points[i].x = ofRandom(1.0);
        points[i].y = ofRandom(1.0);
        
        colors[i].x = ofRandom(1.0);
        colors[i].y = ofRandom(1.0);
        colors[i].z = ofRandom(1.0);
        
        freqs[i] = ofRandom(0.00005   );
         freqs[i + NUM_POINTS] = ofRandom(0.3,0.8);
    }
    for(int i = 0; i < NUM_POINTS; i++){
        colorsINV[i].x = 1.- colors[i].x;
        colorsINV[i].y = 1.- colors[i].y;
        colorsINV[i].z =1.- colors[i].z;
    }
//    colors[0].x = ofRandom(0.3);
//    colors[0].y = ofRandom(0.0);
//    colors[0].z = ofRandom(0.6);
//
//    colors[1].x = ofRandom(0.0);
//    colors[1].y = ofRandom(1.0);
//    colors[1].z = ofRandom(0.0);
//
//    colors[2].x = ofRandom(1.0);
//    colors[2].y = ofRandom(0.0);
//    colors[2].z = ofRandom(0.0);
//    
//        colors[0].x = 0.99;
//        colors[0].y = 1.0;
//        colors[0].z = 0.745;
//    
//        colors[2].x = (0.776);
//        colors[2].y = (0.886);
//        colors[2].z = (0.914);
//    
//        colors[1].x = (0.945);
//        colors[1].y = (0.89);
//        colors[1].z = (0.953);
    
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
     for(int i = 0; i < NUM_POINTS; i++){
         points[i].x = sin(ofGetElapsedTimeMillis() *freqs[i]* TWO_PI) *freqs[i + NUM_POINTS]+ 0.5;
         points[i].y = cos((ofGetElapsedTimeMillis() *freqs[i] * TWO_PI)
                           * cos((ofGetElapsedTimeMillis() *0.0001 * TWO_PI))
                           ) *freqs[i + NUM_POINTS]+ 0.5;
     }
    
}

//--------------------------------------------------------------
void ofApp::draw(){

    
    int w = ofGetWidth() * 0.8;
    int h = ofGetHeight() * 0.8;
   
    shader.begin();
    shader.setUniform1f("u_time", ofGetElapsedTimef());
    shader.setUniform1f("numPoints", NUM_POINTS);
    shader.setUniform2f("u_resolution", ofGetWidth(), ofGetHeight());
    shader.setUniform2f("u_mouse", ofGetMouseX(),  ofGetMouseY());
    shader.setUniform2fv("points", &points[0].x, NUM_POINTS * 2);
    shader.setUniform3fv("colors", &colorsINV[0].x, NUM_POINTS * 2);
    ofRect(0,0,ofGetWidth(),ofGetHeight());
    
    shader.end();
    //
    
    shader.begin();
    shader.setUniform1f("u_time", ofGetElapsedTimef());
     shader.setUniform1f("numPoints", NUM_POINTS);
    shader.setUniform2f("u_resolution", ofGetWidth(), ofGetHeight());
    shader.setUniform2f("u_mouse", ofGetMouseX(),  ofGetMouseY());
    shader.setUniform2fv("points", &points[0].x, NUM_POINTS * 2);
    shader.setUniform3fv("colors", &colors[0].x, NUM_POINTS * 2);
     ofRect((ofGetWidth() - w) /2,(ofGetHeight() - h) /2,w, w);
    
    shader.end();
    
   
//    for(int i = 0; i < NUM_POINTS; i++){
//        ofDrawEllipse(points[i].x* ofGetWidth() , points[i].y  *ofGetHeight(), 10, 10);
//
//
//}
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
