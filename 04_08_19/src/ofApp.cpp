#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
#ifdef TARGET_OPENGLES
    shaderBlurX.load("shadersES2/shaderBlurX");
    shaderBlurY.load("shadersES2/shaderBlurY");
#else
    if(ofIsGLProgrammableRenderer()){
        std::cout << "3" <<std::endl;
        shaderBlurX.load("shadersGL3/shaderBlurX");
        shaderBlurY.load("shadersGL3/shaderBlurY");
    }else{
         std::cout << "2" <<std::endl;
        shaderBlurX.load("shadersGL2/shaderBlurX");
        shaderBlurY.load("shadersGL2/shaderBlurY");
    }
#endif

    float s = sqrt(NUM_CELLS);
    float sW = ofGetWidth() / s;
    float sH = ofGetHeight() / s;
    for(int x = 0; x < s; x++){
        for(int y = 0; y < s; y++){
            ofVec2f temp = ofVec2f(x*sW, y*sH);
//            std::cout<< temp.x <<" + "<< temp.y <<" "<< s<<std::endl;
            cells.push_back(cell(sW, sH, temp));
        }
    }
    
     test.allocate(ofGetWidth(), ofGetHeight());
    fboBlurOnePass.allocate(ofGetWidth(), ofGetHeight());
    fboBlurTwoPass.allocate(ofGetWidth(), ofGetHeight());
//    ofNoFill();
}

//--------------------------------------------------------------
void ofApp::update(){
    c.update();
    
     for(int i = 0; i < NUM_CELLS; i++){
         bool isOn =c.isWithin(cells[i].returnCentre());
         
         cells[i].setState(isOn);
     }
    
}

//--------------------------------------------------------------
void ofApp::draw(){
    float blur = 4;
    
    
    test.begin();
    for(int i = 0; i < NUM_CELLS; i++){
        //          std::cout<< cells[i].pos.x <<" + "<< cells[i].pos.y <<" "<<i <<std::endl;
        cells[i].draw();
        
        
    }
    ofSetColor(237,106,90, 30);
    c.draw();
    test.end();
    
    ofPixels pix;
    test.readToPixels(pix);
    tex.allocate(pix);
    
    //----------------------------------------------------------
    fboBlurOnePass.begin();
    
    shaderBlurX.begin();
    shaderBlurX.setUniform1f("blurAmnt", blur);
    
    tex.draw(0,0);
//    tex.allocate(ofGetPixels());
    
    shaderBlurX.end();
    
    fboBlurOnePass.end();
    
    //----------------------------------------------------------
    fboBlurTwoPass.begin();
    
    shaderBlurY.begin();
    shaderBlurY.setUniform1f("blurAmnt", blur);
    
    fboBlurOnePass.draw(0, 0);
    
    shaderBlurY.end();
    
    fboBlurTwoPass.end();
    
    //----------------------------------------------------------
    ofSetColor(ofColor::white);
    fboBlurTwoPass.draw(0, 0);
//    for(int i = 0; i < NUM_CELLS; i++){
////          std::cout<< cells[i].pos.x <<" + "<< cells[i].pos.y <<" "<<i <<std::endl;
//        cells[i].draw();
//
//
//    }
//    ofSetColor(0,0,255, 20);
//    c.draw();
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
