#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    
#ifdef TARGET_OPENGLES
	shader.load("shadersES2/shader");
#else
	if(ofIsGLProgrammableRenderer()){
        std::cout<<"3"<<std::endl;
		shader.load("shadersGL3/shader");
	}else{
         std::cout<<"2"<<std::endl;
		shader.load("shadersGL2/shader");
	}
#endif
    
    mD = 0.8;
    fD = 1.0;
    sQ = 1.0;
    mO = 0.4;
    mW = 0.8;
    
    mX = 0.;
    mY = 0.;
    
    lE = rE = 0.2;
    eX = eY =0.4;
}

//--------------------------------------------------------------
void ofApp::update(){
    //
//mY = ofGetMouseX() / ofGetWidth();
//    std::cout << mY << "\n";
}

//--------------------------------------------------------------
void ofApp::draw(){
    ofSetColor(255);
    
    shader.begin();
    shader.setUniform2f("u_resolution", ofGetWidth(), ofGetHeight());
     shader.setUniform1f("u_time", ofGetElapsedTimef());
    shader.setUniform2f("u_mouse", ofGetMouseX(),ofGetMouseY());
    shader.setUniform2f("sphere2", cos(ofGetElapsedTimef()*0.1), sin(ofGetElapsedTimef()* ofNoise(ofGetElapsedTimef())));
    
    shader.setUniform3f("colA", cols[col].x, cols[col].y, cols[col].z);
    shader.setUniform3f("colB", cols[col+1].x, cols[col+1].y, cols[col+1].z);
     shader.setUniform1f("mouthDist", mD);
    
     shader.setUniform1f("faceDist", fD);
     shader.setUniform1f("squish", sQ);
    shader.setUniform1f("mouthWid", mW);
    shader.setUniform1f("mouthOp", mO);
    shader.setUniform1f("mx", mX);
    shader.setUniform1f("my", mY);
    
    
    shader.setUniform1f("leftEye", lE);
    shader.setUniform1f("rightEye", rE);
    shader.setUniform1f("eyeX", eX);
    shader.setUniform1f("eyeY", eY);
    ofDrawRectangle(0, 0, ofGetWidth(), ofGetHeight());
    
    shader.end();
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){
    
    sQ = ofRandom(0.9, 1.5  ); 
    mD = ofRandom(0.9, 1.0);
    mO = ofRandom(0.1, 0.7 );
    mW = ofRandom(0.2, 2.0);
//    mO = ofRandom(0.1, 0.7 );
//    mY = ofRandom(0.2, 8.0);
    lE = ofRandom(0.2,0.5);
    eX = ofRandom(lE, 0.9);
    eY = ofRandom(0.7, 0.9);
    fD = ofRandom(0.9, 1.0);
//    col = floor(ofRandom(3)) * 2;
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
