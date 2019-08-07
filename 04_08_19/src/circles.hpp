//
//  circles.hpp
//  marchingSquares
//
//  Created by Edmund Oetgen on 06/08/2019.
//

#ifndef circles_hpp
#define circles_hpp

#include <stdio.h>
#include "ofMain.h"

class circles{
    
public:
    circles(int numCirc_);
    
    void update();
    void draw();
    
    bool isWithin(const ofVec2f & p );
    
    vector<ofVec2f> centres;
    vector<ofVec2f> velocities;
    vector<float> radii;
    
    int numCirc;
};
#endif /* circles_hpp */
