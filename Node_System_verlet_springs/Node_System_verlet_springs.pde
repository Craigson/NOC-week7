 import toxi.physics.constraints.*;
import toxi.physics.*;
import toxi.physics.behaviors.*;
import toxi.geom.*;
import processing.opengl.*;

Vec3D origin;
NodeSystem ns;
VerletPhysics physics;

void setup() {
  size(800, 800, P3D);
  physics = new VerletPhysics();
    //physics.setDrag(0.01);
  origin = new Vec3D(0, 0, 0);
  ns = new NodeSystem(origin, 500);
}

void draw() {
physics.update();
  lights();
  background(220);
  pushMatrix();
  translate(width/2, height/2, 0);
  ns.run();
  popMatrix();
  
  // if (frameCount % 4 == 0){
  //   saveFrame("gif/image-####.gif");
}
