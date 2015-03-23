
//==========================================================
// file:    RandomSpherePoints_Cook.pde
//          create random points on a sphere surface
// version: v1.0  2012-09-07   initial version  
//          v1.1  2014-04-14   source code embedded to class
// see  http://mathworld.wolfram.com/SpherePointPicking.html
//==========================================================
class randomSpherePoints
{
  int maxPoints = 0;
  PVector[] points;

  //--------------------------------------------------------
  // create random sphere points
  //--------------------------------------------------------
  randomSpherePoints (int pointCount, float sphereRadius)
  { 
    maxPoints = pointCount; 
    points = new PVector[pointCount];
    for (int ni=0; ni < maxPoints; ni++)
      points[ni] = randomSpherePoint (sphereRadius);
  }

  //--------------------------------------------------------
  // draw random sphere points  
  //--------------------------------------------------------
  void draw()
  {  
    for (int ni=0; ni < maxPoints; ni++){
      point (points[ni].x, points[ni].y, points[ni].z);
      pushMatrix();
      translate(points[ni].x, points[ni].y, points[ni].z);
      fill(0);
      sphereDetail(3);
      sphere(1);
      popMatrix();
      
    } 
  }

  //--------------------------------------------------------
  // return random sphere point using method of Cook/Neumann
  //--------------------------------------------------------
  PVector randomSpherePoint (float sphereRadius)
  {
    float a=0, b=0, c=0, d=0, k=99;
    while (k >= 1.0) 
    { 
      a = random (-1.0, 1.0);
      b = random (-1.0, 1.0);
      c = random (-1.0, 1.0);
      d = random (-1.0, 1.0);
      k = a*a +b*b +c*c +d*d;
    }
    k = k / sphereRadius;
    return new PVector 
      ( 2*(b*d + a*c) / k 
      , 2*(c*d - a*b) / k  
      , (a*a + d*d - b*b - c*c) / k);
  }

  void drawConnection() {
    stroke(0,20);
    strokeWeight(0.5);
    for (int i = 0; i < points.length; i ++) {
      PVector a = points[i].get();
      for (int j = 0; j < points.length; j++) {
        PVector b = points[j].get();
        if ( i != j) {
          float d = dist(a.x, a.y,a.z, b.x, b.y,b.z);
          if (d < 100) {
            line(a.x, a.y,a.z, b.x, b.y,b.z);
          }
        }
      }
    }
  }
}
