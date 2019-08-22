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
    ofVec3f cols[6] = { ofVec3f(0.251, 0.471, 0.6), ofVec3f(0.886, 0.753, 0.267), ofVec3f(0.792, 0.082, 0.318), ofVec3f(0.059, 1.0, 0.584), ofVec3f(105./255., 98./255., 109./255.),ofVec3f(212./255., 242./255., 219./255.)};
    
    int col = 0;;
    float mD, fD, sQ, mO, mW, mX, mY, lE, rE, eX, eY;
};
