#pragma once

#include "ofMain.h"

class ofApp : public ofBaseApp{
public:
    
    void setup();
    void update();
    void draw();
    
    void keyPressed(int key);
    void keyReleased(int key);
    void mouseMoved(int x, int y);
    void mouseDragged(int x, int y, int button);
    void mousePressed(int x, int y, int button);
    void mouseReleased(int x, int y, int button);
    void windowResized(int w, int h);
    void dragEvent(ofDragInfo dragInfo);
    void gotMessage(ofMessage msg);
    
    ofShader shader;
    ofPlanePrimitive plane;
    ofImage img;
    
    ofFbo fbo;
    float range = 10.0;
    float prevRange;
    
    bool burst = false;
    float burstTime = 400;
    int unlockTimer = 0;
    float ind = 0;
    float inc = 180/burstTime;
    
    ofTrueTypeFont f;
    ofVideoGrabber vidGrabber;
    
    float mx, my;
    
    
    ofVec2f pos, dest, vel;
    float t = 0;
};
