Location[] points = new Location[500];
int myWidth = 768;
int myHeight = 576;
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
  
  frameRate(25);
  translate(768/2, 576/2, 0);
  rotateY(rotY);
  
  background(215);
  
  for(int i = 0; i <= points.length-1; i++)
  {
    pushMatrix();
    translate(points[i].x, points[i].y, points[i].z);
    //rotateY(-rotY);
    rect(0, 0, 5, 5);
    popMatrix();
  }

  rotY = rotY + TWO_PI/25;
}

void createPoints()
{
  for(int i = 0; i <= points.length-1; i++)
  {
    float angleA = random(0, TWO_PI);
    float angleB = random(0, TWO_PI);
      
    myX = int(radius*sin(angleA)*cos(angleB));
    myY = int(radius*sin(angleA)*sin(angleB));
    myZ = int(radius*cos(angleA));
    
    points[i] = new Location (myX, myY, myZ);
  }
}

class Location
{
  int x, y, z;
  
  Location (int myX, int myY, int myZ)
  {
    x = myX;
    y = myY;
    z = myZ;    
  }
} 
