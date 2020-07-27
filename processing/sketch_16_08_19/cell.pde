class Cell {

  boolean state;
  FloatList out = new FloatList();
  FloatList in;
  int brushes;


  float x, y, w, h;
  boolean vertOrHoz;

  Cell() {

    state = false;
  }

  void on(boolean vert, float x_, float y_, float w_, float h_) {
    brushes = (int)random(20);
    brushes = 70;
    vertOrHoz = vert;

    x = x_;
    y = y_;
    w = w_;
    h = h_;

    in = new FloatList();
    for (int i = 0; i < brushes; i++) {
      in.append(random(1.0));
    }

    if (vertOrHoz) {
      for (int i = 0; i < brushes; i++) {
        out.append(random(1.0));
      }
    } else {
      for (int i = 0; i < brushes; i++) {
        out.append(1.0);
      }
    }
  }
  void on(boolean vert, float x_, float y_, float w_, float h_, FloatList in_) {
    vertOrHoz = vert;


    x = x_;
    y = y_;
    w = w_;
    h = h_;

    in = in_;

    brushes = in.size();
    //println(in.get(0));

    if (vertOrHoz) {
      for (int i = 0; i < brushes; i++) {
        out.append(random(1.0));
      }
    } else {
      
      float r = random(1.0);
      for (int i = 0; i < brushes; i++) {
      out.append(r);
      }
      //if (random(1.0) > 0.5)
      //  for (int i = 0; i < brushes; i++) {
      //    out.append(1.0);
      //  } else if (random(1.0) > 0.9)
      //  for (int i = 0; i < brushes; i++) {
      //    out.append(0.0);
      //  } else {
      //  for (int i = 0; i < brushes/2; i++) {
      //    out.append(0.0);
      //  }
      //  for (int i = brushes/2; i < brushes; i++) {
      //    out.append(1.0);
      //  }
      //}
    }
  }

  void draw() {

    noFill();
strokeWeight(random(3));
    float x2 = x + w;
  float r = random(1.0);
    for ( int b = 0; b < brushes; b++) {
      beginShape();
      float Y = y +(h * in.get(b));
      float y2 =y +(h *  out.get(b));
      if (r> 0.96) {
         pushStyle();
        fill(0,0,0);
      ellipse(x, Y, 5, 5);
      line(x,Y,x2,y2);
      ellipse(x2,y2,5,5);
      popStyle();
      }
      else{
       
        curveVertex( x, Y ); // the first control point

        float    t = 0;
        float nx = x;
        float ny = Y;
        //println(x + " " + y + " "+ nx + " " +ny + " "+ x2 + " " +y2);
        for (int i = 0; i < 10; i++) {
          //curveVertex(x + i * gap + random(-5,5), y  + random(-3, 3)); // is also the start point of curve

          nx = nx+ ((x2-nx) * t) + random(-3, 3);
          ny = ny+ ((y2-ny) * t) + random(-3, 3);
          //fill(0,255,0);
          // ellipse(nx,ny,10,10);
          //vertex(nx,ny);
          curveVertex(nx, ny);
          t= map(i, 0, 9, 0, 1);
        }
        curveVertex(x2, y2); // is also the last control point
        endShape();
        pushStyle();
        //fill(0,0,0);
        //ellipse(x2,y2,2,2);

        popStyle();
        //if (!hoz) {
        //  y+= random(3, 5);
        //  y2+=random(3, 5);
        //} else
        //  y2+=random(3, 5);
      }
    }
  }

  FloatList returnOut() {
    return out;
  }
}
