import toxi.physics.constraints.*;
import toxi.physics.*;
import toxi.physics.behaviors.*;
import toxi.geom.*;
import processing.opengl.*;


//import PeasyCam library to manage camera controls
import peasy.PeasyCam;
import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

PeasyCam cam; //declare the peasy cam object
Vec3D origin;
NodeSystem ns;
VerletPhysics physics;

void setup() {
  size(800, 800, P3D);
  
  cam = new PeasyCam(this, 0, 0, 0, 600); //initialise the peasycam object
  cam.setMinimumDistance(430); //set minimum zoom distance
  cam.setMaximumDistance(1500); //set maximum zoom distance

  physics = new VerletPhysics();
  origin = new Vec3D(0, 0, 0);
  ns = new NodeSystem(origin, 1000);
    camera();
}

void draw() {
  lights();
  background(220);
  pushMatrix();
  translate(width/2, height/2, 0);
    cam.rotateY(0.01);
  cam.rotateX(-0.01);
  cam.rotateZ(-0.005);
  ns.run();
  popMatrix();
  physics.update();
}

void keyPressed(){
  if (key == 's'){
    saveFrame("images/verlet_orb-####.jpg");
    println("saving");
  }
}
