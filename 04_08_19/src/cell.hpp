//
//  cell.hpp
//  marchingSquares
//
//  Created by Edmund Oetgen on 06/08/2019.
//

#ifndef cell_hpp
#define cell_hpp

#include <stdio.h>
#include "ofMain.h"
class cell{
    
public:
     cell();
     cell(float w_, float h_, ofVec2f pos_);
    
    void draw();
    void setState(bool & newState);
    ofVec2f& returnPos();
    ofVec2f returnCentre();

    

        bool state = false;
        float w, h;
        ofVec2f pos;
        ofColor onColor;
        ofColor offColor;
protected:
    
};
#endif /* cell_hpp */
