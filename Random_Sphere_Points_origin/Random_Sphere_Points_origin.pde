//create verlet springs to origin
//create attraction / repulsion forces
// create springs between neighbors
//send pulses between neigbhours
//have flocks following pulses

int randomPoints = 200;
float rotX, rotY = 0.0;
NodeSphere rsp;

//--------------------------------------------------------
void setup()
{
  size(800, 800, P3D);

  smooth();
  stroke(40, 166);
  strokeWeight(4.0);
  rsp = new NodeSphere (randomPoints, round(width / 2.5));
}
//--------------------------------------------------------
void draw()
{
  background(100);
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
  rotX += 0.002;
  println(frameRate);
}
//--------------------------------------------------------
void keyPressed()
{
  if (key == 's') save("RandomSpherePoints.png");
  if (key == ' ') rsp = new NodeSphere (randomPoints, round(width / 2.5));
}
