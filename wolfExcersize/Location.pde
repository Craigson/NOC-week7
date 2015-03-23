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

void createPoints()
{

  float r,t,s;
  float tx, ty, tz;
  tx = 0;
  ty = 10000;
  tz = 100;
  for(int i = 0; i <= points.length-1; i++)
  {
    float angleA = random(0, TWO_PI);
    float angleB = random(0, TWO_PI);
    r = map(noise(tx), 0, 1, 0, 100);
    t = map(noise(ty), 0, 1, 0, 100);
    s = map(noise(tz), 0, 1, 0, 100);
    
    float breath = int(cos(map(cos(frameCount*10),-1,1,-10,10)));

         myX = int(radius*sin(angleA)*cos(angleB));
      myY = int(radius*sin(angleA)*sin(angleB));
      myZ = int(radius*cos(angleA));
    tx += .01;
    ty += .01;
    tz += .01;
    points[i] = new Location(myX, myY, myZ);
  }
}
