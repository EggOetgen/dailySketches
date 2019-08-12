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
   ofVec2f *   returnCentres();
    
    bool isWithin(const ofVec2f & p );
    
    ofVec2f centres[10];
    vector<ofVec2f> velocities;
    vector<float> radii;
    
    int numCirc;
};
#endif /* circles_hpp */
