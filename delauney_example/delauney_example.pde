
//-----------------------------------------------------------------------------
//libraries
//-----------------------------------------------------------------------------
import megamu.mesh.*;

//-----------------------------------------------------------------------------
Delaunay del;
float[][] delEdges;

PVector[] tri = new PVector[3];     //middle shape (hole)
ArrayList coord = new ArrayList();  //more flexible adding of points
float res;
int rand;
float rad;

void setup() {
  size(400,400);

  res = 36;
  rand = 10;
  rad = 100;

  createPoints();
}

void draw() {
  background(0);
  noFill();

  translate(width/2,height/2);

  //------------------------------------
  //facets  
  //------------------------------------
  stroke(255,0,255);  
  beginShape(LINES);
  //is there a way to use TRIANGLE_STRIP or QUAD_STRIP?
  //maybe even extract faces?
  for(int i=0; i<delEdges.length; i++) {
    float x1 = delEdges[i][0];
    float y1 = delEdges[i][1];
    float x2 = delEdges[i][2];
    float y2 = delEdges[i][3];

    vertex( x1,y1 );
    vertex( x2,y2 );
  }
  endShape(CLOSE);

  //------------------------------------
  //triangle
  //------------------------------------
  //just to see the triangle middle form
  stroke(0,255,255);
  triangle( tri[0].x, tri[0].y,
            tri[1].x, tri[1].y,
            tri[2].x, tri[2].y );

}


//-----------------------------------------------------------------------------
//methods
//-----------------------------------------------------------------------------
void createPoints() {
  coord.clear();

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

//-----------------------------------------------------------------------------
//interactvitiy
//-----------------------------------------------------------------------------
void mousePressed() {
  createPoints();
}
