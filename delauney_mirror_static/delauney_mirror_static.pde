//shiffmans 16-2 example might be useful

import megamu.mesh.*;

PImage img;
Delaunay mesh;
float[][] delaunayEdges;

ArrayList points;
float res;
int rand;
float rad;

void setup(){
  size(640,480);
  points = new ArrayList();
  img = loadImage("bruce.png");
createPoints();
}

void draw(){
   if (cam.available()) {
   cam.read(); 
   }
  image(img,0,0);
}

void createPoints() {
  points.clear();

  //create triangle points
  //keeps them at the front of mt coords array
  //should the be seperate?
  int index = 0;
  for(int i=0; i<360; i+=360/tri.length) {
    float x = cos( radians(i) ) * rad * 0.61;
    float y = sin( radians(i) ) * rad * 0.61;
    tri[index] = new PVector(x,y);
    coord.add( tri[index].array() );

    index++;
  }

  //create points for circle
  for(int i=0; i<360/res; i++) {
    float x = cos( radians(i*res) ) * rad;
    float y = sin( radians(i*res) ) * rad;
    coord.add( new float[]{x,y} );
  }

  //create the random points
  //not sure how to exclude from the middle form
  for(int i=0; i<rand; i++) {
    float x = random( -cos( radians(i*res) ), cos( radians(i*res) ) ) * rad;
    float y = random( -sin( radians(i*res) ), sin( radians(i*res) ) ) * rad;
    coord.add( new float[]{x,y} );
  }

  del = new Delaunay( getFloatArray(coord) );
  delEdges = del.getEdges();
}


float[][] getFloatArray(ArrayList a) {
  float[][] floatArray = new float[a.size()][3];
  
  for(int i=0; i<a.size(); i++) {
    float[] temp = (float[]) a.get(i);
    floatArray[i] = temp; 
  }

  return floatArray;
}
