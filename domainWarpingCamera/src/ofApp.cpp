#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    
    shader.load("shader");
    
    f.loadFont("Allerta-Regular.ttf", 180);
    
    pic.load("pb.jpg");
    //    pic.load("atonal copy 2.jpg");
    
    width = ofGetWidth();
    height = ofGetHeight();
    
    vidGrabber.setDeviceID(1);
    vidGrabber.setDesiredFrameRate(60);
    vidGrabber.initGrabber(width, height);
     vidGrabber.update();
   
  
    plane.set(width,height,width,height, OF_PRIMITIVE_TRIANGLE_STRIP);
    plane.mapTexCoords(0, fbo.getHeight(), fbo.getWidth(), 0);
   
    fbo.allocate(width, height, GL_RGBA);
      dif.allocate(width, height, GL_RGBA);
    
    fbo.begin();
    ofPushMatrix();
    ofTranslate(ofGetWidth()/2, ofGetHeight()/2);
    
    plane.draw();
    ofPopMatrix();
    float picSize = 0.75;
    float scale = pic.getHeight() / pic.getWidth();
   
    background.draw(width * 0.125,height - ( (width * picSize) * scale), width *picSize,  (width * picSize) * scale);
    fbo.end();
}

//--------------------------------------------------------------
void ofApp::update(){
    
    
    vidGrabber.update();
    if(firstFrame){
        background.setFromPixels(vidGrabber.getPixels());
        ofxCvColorImage backgroundCV;
        backgroundCV.setFromPixels(background.getPixels());
        backgreynd = backgroundCV;
        firstFrame = false;
    }else{
    
    ofFloatImage temp;
    temp.setFromPixels(vidGrabber.getPixels());
    ofxCvColorImage tempCV;
    tempCV.setFromPixels(temp.getPixels());
    currentGreym = tempCV;
//        currentGreym.blur();
//        backgreynd.blur();
//        backgreynd = 0.99*backgreynd + 0.01*currentGreym;
    grayDiff.absDiff( currentGreym, backgreynd);
        grayDiff.blur();
    grayDiff.threshold(thresh);
        grayDiff.erode();
//    if(grayDiff.width > 0)
//        contourFinder.findContours(grayDiff, 20, width * height, 10, true);
    }
    
    
//    ofSetRectMode(OF_RECTMODE_CENTER);
}

//--------------------------------------------------------------
void ofApp::draw(){
    if(!firstFrame){
    
    fbo.begin();
        background.draw(-width, 0, width,  height);

    ofPushMatrix();
    ofTranslate(ofGetWidth()/2, ofGetHeight()/2);

    plane.draw();
    ofPopMatrix();
    float picSize = 0.75;
    float scale = pic.getHeight() / pic.getWidth();
//      background.draw(-width, 0, width,  height);
//        background.draw(width, 0, width,  height);
//        background.draw(width, -height, width,  height);
//        background.draw(-width, height, width,  height);


    background.draw(0, 0, width,  height);
//        vidGrabber.draw(0, 0, width,  height);

    fbo.end();
    
    dif.begin();
        ofPushMatrix();
        ofTranslate(ofGetWidth()/2, ofGetHeight()/2);
        
        plane.draw();
        ofPopMatrix();
      
        
        grayDiff.draw(0,0, width,  height);
    dif.end();

    
    shader.begin();
    shader.setUniformTexture("tex0", fbo.getTextureReference(), 0);
    shader.setUniformTexture("dif", dif.getTextureReference(), 1);
        shader.setUniformTexture("bg", background, 2);

    shader.setUniform1f("u_time", ofGetElapsedTimef());
//        shader.setUniform1f("u_time", 500);

    shader.setUniform2f("u_resolution", ofGetWidth(), ofGetHeight());
    shader.setUniform2f("u_mouse", ofGetMouseX(),  ofGetMouseY());
    shader.setUniform1i("simple", simple);
    ofRect(0,0,ofGetWidth(),ofGetHeight());

    shader.end();
//         grayDiff.draw(width * 0.125,height - ( (width * picSize) * scale), width *picSize,  (width * picSize) * scale);
//        ofSetColor(100, 50);
    //    fbo.draw(0,0);
    }
//     contourFinder.draw(0,0, width, height);
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){
    simple = !simple;
}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){
    background.setFromPixels(vidGrabber.getPixels());
    ofxCvColorImage backgroundCV;
    backgroundCV.setFromPixels(background.getPixels());
    backgreynd = backgroundCV;
    
}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){
    
}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){
    
    thresh = ofMap(ofGetMouseX(), 0, width, 0, 100);
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){
    std::cout<< ofGetMouseX() / float(width) <<" " << ofGetMouseY()/ float(width) <<"\n";
}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){
    firstFrame = true;
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
