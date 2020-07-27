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
     s = "Odmund Eetgen";

//    plane.set(ofGetWidth()+100, ofGetHeight()+100,1500,1300, OF_PRIMITIVE_TRIANGLE_STRIP);
    
//    plane.set(ofGetWidth()+100, ofGetHeight()+100,1000,800, OF_PRIMITIVE_TRIANGLE_STRIP);

 plane.set(ofGetWidth()+100, ofGetHeight()+100,70,50, OF_PRIMITIVE_TRIANGLE_STRIP);
    f.loadFont("/Users/edmundoetgen/Documents/of_v0.10.1_osx_release/apps/myApps/type1/bin/data/HelveticaNeue-01.ttf", 90);


    fbo.allocate(ofGetWidth(), ofGetHeight(), GL_RGBA);
    plane.mapTexCoords(0, fbo.getHeight(), fbo.getWidth(), 0);
    fbo.begin();
    ofRectangle r = f.getStringBoundingBox(s, 0, 0);
    ofVec2f offset = ofVec2f(floor(-r.x - r.width * 0.5f), floor(-r.y - r.height * 0.5f));
    ofSetColor(0);
    f.drawString(s, fbo.getWidth() / 2 + offset.x, fbo.getHeight() / 2 );
    
    fbo.end();
    
}

//--------------------------------------------------------------
void ofApp::update(){
    //
}

//--------------------------------------------------------------
void ofApp::draw(){
//    
//    fbo.begin();
//    ofDrawRectangle(0, 0, 0, fbo.getWidth(), fbo.getHeight());
//    fbo.end();
//    shader.begin();
//    shader.setUniform2f("u_resolution", ofGetWidth(), ofGetHeight());
//    shader.setUniform2f("u_mouse", ofGetMouseX(), ofGetMouseY());
//    shader.setUniform1f("u_time", ofGetElapsedTimef());
//    shader.setUniform3f("a", 0.5, 0.5, 0.5 );
//    shader.setUniform3f("b", 0.5, 0.5, 0.5 );
//    shader.setUniform3f("c", 1.0, 1.0, 0.5 );
//    shader.setUniform3f("d", 0.0, 0.0, 0.3 );
//    ofPushMatrix();
//    
//    ofSetColor(255,0,0);
//    ofTranslate(ofGetWidth()/2 , ofGetHeight()/2);
//    
//    //        plane.drawWireframe();
//    plane.draw();
//    
//    
//    ofPopMatrix();
//    
//    shader.end();
    
    
//s = "Odmund";
    
    float t = ofGetElapsedTimef() * 0.8;
    fbo.begin();
    ofClear(255,255,255, 0);
    ofRectangle r = f.getStringBoundingBox(s, 0, 0);
    ofVec2f offset = ofVec2f(floor(-r.x - r.width * 0.5f), floor(-r.y - r.height * 0.5f));
    ofSetColor(0);
    f.drawString(s, fbo.getWidth() / 2 + offset.x, fbo.getHeight() / 2 );
     f.drawString(s, fbo.getWidth() / 2 + offset.x, fbo.getHeight() / 4);
    f.drawString(s, fbo.getWidth() / 2 + offset.x, 3*(fbo.getHeight() / 4));
    
    fbo.end();
fbo.getTexture().bind();
    ofSetColor(255);
    
    shader.begin();
    shader.setUniform2f("u_resolution", ofGetWidth(), ofGetHeight());
    shader.setUniform2f("u_mouse", ofGetMouseX(), ofGetMouseY());
    shader.setUniform1f("u_time",t );
//    shader.setUniform1f("mouseX", ofMap(ofGetMouseX(),0, ofGetWidth(), -range, range));
//    shader.setUniform1f("mouseY", ofMap(ofGetMouseY(),0, ofGetHeight(), -range, range));
    shader.setUniform1f("mouseX", sin(t)*range);
    shader.setUniform1f("mouseY", cos(t)*range);
    shader.setUniform3f("a", abs(sin(t)), abs(cos(t)), 0.5 );
    shader.setUniform3f("b", 0.5, 0.5, 0.5 );
    shader.setUniform3f("c", 1.0, 1.0, 0.5 );
    shader.setUniform3f("d", 0.8, 0.9, 0.3 );
    ofPushMatrix();
    
    ofSetColor(255,0,0);
    ofTranslate(ofGetWidth()/2 , ofGetHeight()/2);
    
    //        plane.drawWireframe();
    plane.draw();
    
    
    ofPopMatrix();
    
    shader.end();

}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){
    if(bol){
        s = "Eetgen";
        bol = false;
    }else{
    s = "Odmund";
    bol = true;
    }
    
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
