//
//  circles.cpp
//  marchingSquares
//
//  Created by Edmund Oetgen on 06/08/2019.
//

#include "circles.hpp"
circles::circles(int numCirc_){
    
    numCirc = numCirc_;
    
    for (int i = 0; i < numCirc; i ++){
        
//        centres.push_back(  ofVec2f(   ofRandom(0, ofGetWidth()),  ofRandom(0,ofGetHeight())  )  );
        
                centres[i] =   ofVec2f(   ofRandom(0, ofGetWidth()),  ofRandom(0,ofGetHeight())  )  ;

        
          radii.push_back(ofRandom(200));
//        radii.push_back(50);
        velocities.push_back(  ofVec2f( ofRandom(-10, 10) ,  ofRandom(-10,10)   )   );
    }
}


void circles::update(){
    
    int w = ofGetWidth();
    int h = ofGetHeight();
    
    for (int i = 0; i < numCirc; i ++){
        
        //        centres[i].x > ofGetWidth() ? velocities[i].x *= -1. : velocities[i].x *= 1.;
        if(centres[i].x > w - radii[i]/2 || centres[i].x <  radii[i]/2 ){
            velocities[i].x *= -1.;
        }
        if(centres[i].y > h - radii[i]/2 || centres[i].y <  radii[i]/2){
            velocities[i].y *= -1.;
        }
        centres[i] += velocities[i];
    }
}



void circles::draw(){
    
    for (int i = 0; i < numCirc; i ++){
        ofDrawEllipse(centres[i], radii[i]*2, radii[i]*2);
    }
}

bool circles::isWithin(const ofVec2f & p ){
    
    float f = 0;
    
    for (int i = 0; i < numCirc; i ++){
        
        float numer =  radii[i] * radii[i];
        
        float denom = ((p.x - centres[i].x) * (p.x - centres[i].x)) + ((p.y - centres[i].y) * (p.y - centres[i].y));
        
        f += (numer / denom);
    }
    
    return f > 1.0 ?  true : false;
}


ofVec2f * circles::returnCentres(){
    
    return centres;
}
