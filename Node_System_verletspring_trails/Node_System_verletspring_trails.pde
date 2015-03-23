import toxi.physics.constraints.*;
import toxi.physics.*;
import toxi.physics.behaviors.*;
import toxi.geom.*;
import toxi.geom.Vec3D;
import processing.opengl.*;

Vec3D origin;
NodeSystem ns;
VerletPhysics physics;

void setup() {
  size(800, 800, P3D);
  physics = new VerletPhysics();
  origin = new Vec3D(0, 0, 0);
  ns = new NodeSystem(origin, 500);
}

void draw() {
  lights();
 // background(220);
  pushMatrix();
  translate(width/2, height/2, 0);
  ns.run();
  popMatrix();
  physics.update();
}

void keyPressed(){
  if (key == 's'){
    saveFrame("images/verletsystem-###.jpg");
  }
}
