//create verlet springs to origin
//create attraction / repulsion forces
// create springs between neighbors
//send pulses between neigbhours
//have flocks following pulses

int randomPoints = 500;
float rotX, rotY = 0.0;
randomSpherePoints rsp;

//--------------------------------------------------------
void setup()
{
  size(512, 512, P3D);
  println (">>> PG_RandomSpherePoints_Cook v1.1 <<<");
  smooth();
  stroke(40, 166);
  strokeWeight(4.0);
  rsp = new randomSpherePoints (randomPoints, round(width / 2.5));
}
//--------------------------------------------------------
void draw()
{
  background(222);
  translate(width*0.5, height*0.5);
  rotateX (rotX);
  rotateY (rotY);
  rsp.draw();
  rsp.drawConnection();

  if (mousePressed)
  {
     rotY += (pmouseX - mouseX) * -0.002;
     rotX += (pmouseY - mouseY) * +0.002;
     println (round(frameRate) + " fps");
  }
  rotY += 0.002;
}
//--------------------------------------------------------
void keyPressed()
{
  if (key == 's') save("RandomSpherePoints.png");
  if (key == ' ') rsp = new randomSpherePoints (randomPoints, round(width / 2.5));
}
