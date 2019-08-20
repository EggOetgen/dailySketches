#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){

    shader.load("shader");
    
    shaderBlurX.load("shadersGL3/shaderBlurX");
    shaderBlurY.load("shadersGL3/shaderBlurY");
    for(int i = 0; i < NUM_POINTS; i+=3){
//
        points[i].x = ofRandom( ofGetWidth());
        points[i].y = ofRandom(ofGetHeight());
        
        points[i+1].x = ofRandom( ofGetWidth());
        points[i+1].y = ofRandom(ofGetHeight());
        
        points[i+2].x = ofRandom( ofGetWidth());
        points[i+2].y = ofRandom(ofGetHeight());
//        points[i+3].x = ofRandom( ofGetWidth());
//        points[i+3].y = ofRandom(ofGetHeight());
//
//        colors[i].x = ofRandom(1.0);
//        colors[i].y = ofRandom(1.0);
//        colors[i].z = ofRandom(1.0);
//        colors[i].y = ofRandom(0.0);
//        colors[i].z = ofRandom(0.0);
//
        freqs[i] = ofRandom(0.001   );
        freqs[i+1] = ofRandom(0.002   );
        freqs[i+2] = ofRandom(0.003   );
//        freqs[i+3] = ofRandom(0.003   );

//        freqs[i + NUM_POINTS] = ofRandom(0.3,0.8);
        
        colors[i].x = 0.99+ofRandom(-0.1,0.1 );
        colors[i].y = 1.0+ofRandom(-0.1,0.1 );;
        colors[i].z = 0.745+ofRandom(-0.1,0.1 );;
        
        colors[i+1].x = (0.776)+ofRandom(-0.1,0.1 );;
        colors[i+1].y = (0.886)+ofRandom(-0.1,0.1 );;
        colors[i+1].z = (0.914)+ofRandom(-0.1,0.1 );;
//
        colors[i+2].x = (0.945)+ofRandom(-0.1,0.1 );;
        colors[i+2].y = (0.89)+ofRandom(-0.1,0.1 );;
        colors[i+2].z = (0.953)+ofRandom(-0.1,0.1 );;
      
//        colors[i+3].x = (0.784);
//        colors[i+3].y = (0.275);
//        colors[i+3].z = (0.188);
       
    }
    colors[3].x = (0.784);
            colors[3].y = (0.275);
            colors[3].z = (0.188);
//    colors[0].x = ofRandom(0.3);
//    colors[0].y = ofRandom(0.0);
//    colors[0].z = ofRandom(0.6);
//
//    colors[1].x = ofRandom(1.0);
//    colors[1].y = ofRandom(1.0);
//    colors[1].z = ofRandom(1.0);
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
//
    for(int i = 0; i < NUM_POINTS; i++){
        colorsINV[i].x = 1.- colors[i].x;
        colorsINV[i].y = 1.- colors[i].y;
        colorsINV[i].z =1.- colors[i].z;
    }
//
    vor.allocate(ofGetWidth(),ofGetHeight());
    onePass.allocate(ofGetWidth(),ofGetHeight());
    twoPass.allocate(ofGetWidth(),ofGetHeight());
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
    for(int i = 0; i < NUM_POINTS; i++){
        points[i].x +=(cos(ofGetElapsedTimeMillis() *freqs[i]));
        points[i].y += (sin(ofGetElapsedTimeMillis() *freqs[NUM_POINTS-i]));
        
//        points[i].x = fmod(points[i].x, 1.0);
//          points[i].y = fmod(points[i].y, 1.0);
//         std::cout<<points[i].x<<"\n";
    }
}

//--------------------------------------------------------------
void ofApp::draw(){

    float blur = 20;//ofMap(mouseX, 0, ofGetWidth(), 0, 20, true);
    
    int w = ofGetWidth() * 0.8;
    int h = ofGetHeight() * 0.8;
   
    vor.begin();
    
    

            shader.begin();
                shader.setUniform1f("u_time", ofGetElapsedTimef());
                shader.setUniform1f("numPoints", NUM_POINTS);
                shader.setUniform2f("u_resolution", ofGetWidth(), ofGetHeight());
                shader.setUniform2f("u_mouse", ofGetMouseX(),  ofGetMouseY());
                shader.setUniform2fv("points", &points[0].x, NUM_POINTS * 2);
    if(inv)
                shader.setUniform3fv("colors", &colorsINV[0].x, NUM_POINTS * 2);
    else
                 shader.setUniform3fv("colors", &colors[0].x, NUM_POINTS * 2);
                ofRect(0,0,ofGetWidth(),ofGetHeight());

            shader.end();
    vor.end();
    
    onePass.begin();
        shaderBlurX.begin();
            shaderBlurX.setUniform1f("blurAmnt", blur);
    
            vor.draw(0,0);

        shaderBlurX.end();
    onePass.end();
    twoPass.begin();
        shaderBlurY.begin();
            shaderBlurX.setUniform1f("blurAmnt", blur);
    
            onePass.draw(0,0);
    
        shaderBlurY.end();
    twoPass.end();
    ofSetColor(ofColor::white);
    for(int i = 0; i < 15; i++){
    onePass.begin();
    shaderBlurX.begin();
    shaderBlurX.setUniform1f("blurAmnt", blur);
    
    twoPass.draw(0,0);
    
    shaderBlurX.end();
    onePass.end();
    twoPass.begin();
    shaderBlurY.begin();
    shaderBlurX.setUniform1f("blurAmnt", blur);
    
    onePass.draw(0,0);
    
    shaderBlurY.end();
    twoPass.end();
    }
    ofSetColor(ofColor::white);
    twoPass.draw(0,0);
   
//    for(int i = 0; i < NUM_POINTS; i++){
//        ofDrawEllipse(points[i].x , points[i].y  , 10, 10);
//
//
//}
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){
    inv = !inv;
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
