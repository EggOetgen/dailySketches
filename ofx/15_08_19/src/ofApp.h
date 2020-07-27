#pragma once

#include "ofMain.h"

#define NUM_POINTS 7

class ofApp : public ofBaseApp{

	public:
		void setup();
		void update();
		void draw();

		void keyPressed(int key);
		void keyReleased(int key);
		void mouseMoved(int x, int y );
		void mouseDragged(int x, int y, int button);
		void mousePressed(int x, int y, int button);
		void mouseReleased(int x, int y, int button);
		void mouseEntered(int x, int y);
		void mouseExited(int x, int y);
		void windowResized(int w, int h);
		void dragEvent(ofDragInfo dragInfo);
		void gotMessage(ofMessage msg);
		
    ofShader shader;
    float freqs[NUM_POINTS*2];
    ofVec2f points[NUM_POINTS];
    ofVec3f colors[NUM_POINTS];
     ofVec3f colorsINV[NUM_POINTS];
    
     ofTrueTypeFont f;
};
