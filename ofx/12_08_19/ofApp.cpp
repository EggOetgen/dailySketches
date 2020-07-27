#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
  shader.load("shader.vert","shader.frag");
    
    
#ifdef TARGET_OPENGLES
    shaderBlurX.load("shadersES2/shaderBlurX");
    shaderBlurY.load("shadersES2/shaderBlurY");
#else
    if(ofIsGLProgrammableRenderer()){
        std::cout<<"3"<<std::endl;
        shaderBlurX.load("shadersGL3/shaderBlurX");
        shaderBlurY.load("shadersGL3/shaderBlurY");
    }else{
         std::cout<<"2"<<std::endl;
        shaderBlurX.load("shadersGL2/shaderBlurX");
        shaderBlurY.load("shadersGL2/shaderBlurY");
    }
#endif
    
//    image.load("img.jpg");
    
    ofSetBackgroundColor(0);
    ofSetColor(200, 20);
    fboBlurOnePass.allocate(ofGetWidth(), ofGetHeight());
    fboBlurTwoPass.allocate(ofGetWidth(), ofGetHeight());
}

//--------------------------------------------------------------
void ofApp::update(){
//    c.update();
    std::cout<<ofGetMouseY()<<std::endl;
}

//--------------------------------------------------------------
void ofApp::draw(){
    
    float x = 30;
    float y = 30;
    float w = ofGetWidth()-62;
    float h = ofGetHeight()-62;
    float blur = 40;
     ofSetColor(200, 190);
    
    ofDrawRectangle(x-1, y-1, w+2, h + 2);
//    ofNoise(ofGetElapsedTimef() * ofGetHeight()
    //----------------------------------------------------------
    fboBlurOnePass.begin();
    
    shaderBlurX.begin();
    shaderBlurX.setUniform1f("blurAmnt", blur);
    
    ofVec2f *cent = c.returnCentres();
      ofSetColor(255);
    shader.begin();
    shader.setUniform1f("u_time", ofGetElapsedTimef());
    shader.setUniform1f("radius", 0.2);
    shader.setUniform2f("u_resolution", ofGetWidth(), ofGetHeight());
    shader.setUniform3f("col1",0.035, 0.251,0.455);
      shader.setUniform3f("col2",0.788, 0.482,0.518);
    shader.setUniform2f("u_mouse", ofGetWidth()/2,  614);
    shader.setUniform2f("u_mouse2", cent[1].x, cent[1].y);
    if(useMouse)
    shader.setUniform2f("u_mouse3", ofGetMouseX(), ofGetMouseY());
    shader.setUniform3fv("centres", &cent[0].x, 20);
    ofRect(0,0,ofGetWidth(), ofGetHeight());
    shader.end();
    shaderBlurX.end();
    
    fboBlurOnePass.end();
//    ofDrawEllipse(cent[0].x, cent[1].y, 10, 10);
     //----------------------------------------------------------
    fboBlurTwoPass.begin();
    
    shaderBlurY.begin();
    shaderBlurY.setUniform1f("blurAmnt", blur);
    
    fboBlurOnePass.draw(x, y, 2*w/3,h);
//       fboBlurOnePass.draw(500, 0, 500,ofGetHeight());
    
    shaderBlurY.end();
    
    fboBlurTwoPass.end();
    
    fboBlurOnePass.begin();
    
    shaderBlurX.begin();
    shaderBlurX.setUniform1f("blurAmnt", blur);
    
//    ofVec2f *cent = c.returnCentres();
    ofSetColor(255);
    shader.begin();
    shader.setUniform1f("u_time", ofGetElapsedTimef());
    shader.setUniform1f("radius", 0.2);
    shader.setUniform2f("u_resolution", ofGetWidth(), ofGetHeight());
   shader.setUniform2f("u_mouse", ofGetWidth()/2,  614);
//    shader.setUniform3f("col2",0.035, 0.251,0.455);
//    shader.setUniform3f("col1",0.788, 0.482,0.518);
    shader.setUniform3f("col1",1.0,1.0,1.0);
    shader.setUniform3f("col2",0.0, 0.0,0.0);
    
    shader.setUniform2f("u_mouse2", cent[1].x, cent[1].y);
    if(useMouse)
        shader.setUniform2f("u_mouse3", ofGetMouseX(), ofGetMouseY());
    shader.setUniform3fv("centres", &cent[0].x, 20);
    ofRect(0,0,ofGetWidth(), ofGetHeight());
    shader.end();
    shaderBlurX.end();
    
    fboBlurOnePass.end();
    //    ofDrawEllipse(cent[0].x, cent[1].y, 10, 10);
     //----------------------------------------------------------
    fboBlurTwoPass.begin();
    
    shaderBlurY.begin();
    shaderBlurY.setUniform1f("blurAmnt", blur);
    
    fboBlurOnePass.draw( x + 2*w/3,y, w/3,h/2);
    //       fboBlurOnePass.draw(500, 0, 500,ofGetHeight());
    
    shaderBlurY.end();
    
    fboBlurTwoPass.end();
    
    fboBlurOnePass.begin();
    
    shaderBlurX.begin();
    shaderBlurX.setUniform1f("blurAmnt", blur);
    
    //    ofVec2f *cent = c.returnCentres();
    ofSetColor(255);
    shader.begin();
    shader.setUniform1f("u_time", ofGetElapsedTimef());
    shader.setUniform1f("radius", 0.2);
    shader.setUniform2f("u_resolution", ofGetWidth(), ofGetHeight());
    shader.setUniform2f("u_mouse", ofGetWidth()/2,  614);
//    shader.setUniform3f("col1",1.0-0.035,1.0- 0.251,1.0-0.455);
//    shader.setUniform3f("col2",1.0-0.788, 1.0-0.482,1.0-0.518);
        shader.setUniform3f("col2",1.0,1.0,1.0);
        shader.setUniform3f("col1",0.0, 0.0,0.0);
    shader.setUniform2f("u_mouse2", cent[1].x, cent[1].y);
    if(useMouse)
        shader.setUniform2f("u_mouse3", ofGetMouseX(), ofGetMouseY());
    shader.setUniform3fv("centres", &cent[0].x, 20);
    ofRect(0,0,ofGetWidth(), ofGetHeight());
    shader.end();
    shaderBlurX.end();
    
    fboBlurOnePass.end();
    //    ofDrawEllipse(cent[0].x, cent[1].y, 10, 10);
    
    fboBlurTwoPass.begin();
    
    shaderBlurY.begin();
    shaderBlurY.setUniform1f("blurAmnt", blur);
    
    fboBlurOnePass.draw( x + 2*w/3, y +h/2, w/3,h/2);
    //       fboBlurOnePass.draw(500, 0, 500,ofGetHeight());
    
    shaderBlurY.end();
    
    fboBlurTwoPass.end();
    
    //----------------------------------------------------------
    ofSetColor(ofColor::white);
    fboBlurTwoPass.draw(0, 0);
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
