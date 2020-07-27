#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    
    shader.load("shader");
    
    
    pic.load("4.jpg");
//    pic.load("atonal.jpg");

    width = ofGetWidth();
    height = ofGetHeight();
    
     plane.set(width,height,width,height, OF_PRIMITIVE_TRIANGLE_STRIP);
     plane.mapTexCoords(0, fbo.getHeight(), fbo.getWidth(), 0);
    fbo.allocate(width, height, GL_RGBA);
     fbo2.allocate(width, height, GL_RGBA);
    fbo.begin();
    ofPushMatrix();
    ofTranslate(ofGetWidth()/2, ofGetHeight()/2);
    
    plane.draw();
    ofPopMatrix();
    float picSize = 0.75;
    float scale = pic.getHeight() / pic.getWidth();
    pic.draw(width * 0.125,height - ( (width * picSize) * scale), width *picSize,  (width * picSize) * scale);
    fbo.end();
  
    vidGrabber.listDevices();
    vidGrabber.setDeviceID(1);
    vidGrabber.setDesiredFrameRate(60);
    vidGrabber.initGrabber(width, height);
}

//--------------------------------------------------------------
void ofApp::update(){
    vidGrabber.update();

    
}

//--------------------------------------------------------------
void ofApp::draw(){
    
   
    
    
    
    float blur = ofMap(mouseX, 0, ofGetWidth(), 0, 10, true);
    
    //----------------------------------------------------------
    fbo.begin();
    
    shader.begin();
    shader.setUniform1f("blurAmnt", blur);
    shader.setUniform1f("u_time", ofGetElapsedTimef());
    shader.setUniform2f("u_mouse", ofGetMouseX(),  ofGetMouseY());
    shader.setUniform2f("u_resolution", ofGetWidth(), ofGetHeight());

//    float picSize = 1.5;
//    float scale = pic.getHeight() / pic.getWidth();
//    pic.draw(width * 0.125,height - ( (width * picSize) * scale), width *picSize,  (width * picSize) * scale);
//
  
//    pic.draw(0,0,width,height);
    vidGrabber.draw(0,0,width,height);

    shader.end();
    
    fbo.end();
//
    //----------------------------------------------------------
    for(int i = 0 ; i < reps; i ++){
    fbo2.begin();

    shader.begin();
    shader.setUniform1f("blurAmnt", blur);
    shader.setUniform1f("u_time", ofGetElapsedTimef());
    shader.setUniform2f("u_mouse", ofGetMouseX(),  ofGetMouseY());

        shader.setUniform2f("u_resolution", ofGetWidth(), ofGetHeight());


    fbo.draw(0, 0);

    shader.end();

    fbo2.end();
        fbo.begin();
        
        shader.begin();
        shader.setUniform1f("blurAmnt", blur);
        shader.setUniform1f("u_time", ofGetElapsedTimef());
        shader.setUniform2f("u_mouse",
                            ofGetMouseX(),  ofGetMouseY());
        
        shader.setUniform2f("u_resolution", ofGetWidth(), ofGetHeight());

        
        fbo2.draw(0, 0);
        
        shader.end();
        
        fbo.end();
    }
//    reps = ofGetMouseX(); //----------------------------------------------------------
    ofSetColor(ofColor::white);
    fbo.draw(0, 0);
   
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
