#pragma once

#define NUM_CELLS 100000
#include "ofMain.h"
#include "cell.hpp"
#include "circles.hpp"

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
    
    vector<cell > cells;
    
    circles c{10};
		
    ofShader shaderBlurX;
    ofShader shaderBlurY;
    
    ofFbo test;
    ofFbo fboBlurOnePass;
    ofFbo fboBlurTwoPass;
    ofTexture tex;
    
};
