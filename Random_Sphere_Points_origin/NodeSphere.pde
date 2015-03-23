class NodeSphere
{
  int maxPoints = 0;
  PVector[] points;

   NodeSphere (int pointCount, float sphereRadius)
  { 
    maxPoints = pointCount; 
    points = new PVector[pointCount];
    for (int ni=0; ni < maxPoints; ni++)
      points[ni] = randomNode (sphereRadius);
  }

 void draw()
  {  
    for (int ni=0; ni < maxPoints; ni++){
      point (points[ni].x, points[ni].y, points[ni].z);
      pushMatrix();
      translate(points[ni].x, points[ni].y, points[ni].z);
      fill(255);
      noStroke();
      sphereDetail(3);
      sphere(0.5);
      popMatrix();
      
    } 
  }

  PVector randomNode (float sphereRadius)
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
    stroke(220,20);
    strokeWeight(0.5);
    for (int i = 0; i < points.length; i ++) {
      PVector a = points[i].get();
      for (int j = 0; j < points.length; j++) {
        PVector b = points[j].get();
        if ( i != j) {
          float d = dist(a.x, a.y,a.z, b.x, b.y,b.z);
          if (d < 100 && d > 10) {
            line(a.x, a.y,a.z, b.x, b.y,b.z);
          }
        }
      }
    }
  }
}
