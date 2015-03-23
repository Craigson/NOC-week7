Location[] points = new Location[2000];
int myWidth = 900;
int myHeight = 900;
int myX, myY, myZ; 
int radius = 100;
float rotY = TWO_PI/25;
void setup()
{
  size(myWidth, myHeight, P3D);
  createPoints();
}

void draw()
{

// This is how the trails are made//
// Make a rect then fill it and put an alpha on it. 
// The lower the Alpha the more trails your get//
// No background//
  pushMatrix();
  translate(0, 0, -235);
  fill(215, 10);
  rect(-159, -160, 1235, 1174);
  popMatrix();
  
  
  translate(width/2, height/2, 200);
  rotateY(rotY);
  rotateX(rotY);

  // background(215,100);

  for (int i = 0; i <= points.length-1; i++)
  {
    rotateX(0.001);
    rotateY(0.001);
    rotateZ(0.001);
    pushMatrix();

    translate(points[i].x, points[i].y, points[i].z);
    rotateY(cos(map(cos(frameCount*.02),-1,1,-5,5)));
    point(0, 0, 0);
    popMatrix();
  }

  rotY = rotY + .01;
}
