//
//  cell.cpp
//  marchingSquares
//
//  Created by Edmund Oetgen on 06/08/2019.
//

#include "cell.hpp"
//cell::cell(){
//    w = 10;
//    h = 10;
//    pos = ofVec2f(0,0);
//    
//    onColor =  ofColor(0,255,0);
//    offColor = ofColor(255,0,0);
//    
//}

cell::cell(float w_, float h_,ofVec2f pos_){
    w = w_;
    h = h_;
    pos = pos_;
    
    
    onColor =  ofColor(242,209,201);
    offColor = ofColor(206,234,247);
    
}

void cell::draw(){
    
    if(state){
        ofSetColor(onColor);
        
    }else{
         ofSetColor(offColor);
    }
//    std::cout<< pos.x << " " <<pos.y<<std::endl;
    ofDrawRectangle(pos.x, pos.y, w, h);
    
}


ofVec2f& cell::returnPos(){
    
    return pos;
}

ofVec2f cell::returnCentre(){
    ofVec2f centre = ofVec2f(pos.x + w /2,pos.y + h /2 );
    return centre;
}


void cell::setState(bool & newState){
    
    state = newState;
}
