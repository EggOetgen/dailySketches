#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    
    shader.load("shader");
    
    f.loadFont("Allerta-Regular.ttf", 180);
    
//    pic.load("pb.jpg");
        pic.load("atonal copy 2.jpg");
    
    width = ofGetWidth();
    height = ofGetHeight();
    
    plane.set(width,height,width,height, OF_PRIMITIVE_TRIANGLE_STRIP);
    plane.mapTexCoords(0, fbo.getHeight(), fbo.getWidth(), 0);
    fbo.allocate(width, height, GL_RGBA);
    fbo.begin();
    ofPushMatrix();
    ofTranslate(ofGetWidth()/2, ofGetHeight()/2);
    
    plane.draw();
    ofPopMatrix();
    float picSize = 0.75;
    float scale = pic.getHeight() / pic.getWidth();
    pic.draw(0,0, width ,  height);
    fbo.end();
}

//--------------------------------------------------------------
void ofApp::update(){
    
    
}

//--------------------------------------------------------------
void ofApp::draw(){
    
    
    shader.begin();
    shader.setUniformTexture("fboTexture", fbo.getTextureReference(0), 0);
    shader.setUniform1f("u_time", ofGetElapsedTimef());
    
    shader.setUniform2f("u_resolution", ofGetWidth(), ofGetHeight());
    shader.setUniform2f("u_mouse", ofGetMouseX(),  ofGetMouseY());
    shader.setUniform1i("simple", simple);
    ofRect(0,0,ofGetWidth(),ofGetHeight());
    
    shader.end();
    
    ofSetColor(100, 50);
    //    fbo.draw(0,0);
    
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
    std::cout<< ofGetMouseX() / float(width) <<" " << ofGetMouseY()/ float(width) <<"\n";
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
