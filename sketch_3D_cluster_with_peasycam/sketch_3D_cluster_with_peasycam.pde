import toxi.physics.constraints.*;
import toxi.physics2d.constraints.*;
import toxi.physics2d.behaviors.*;
import toxi.physics.*;
import toxi.physics.behaviors.*;
import toxi.physics2d.*;
import toxi.geom.*;

//import PeasyCam library to manage camera controls
import peasy.PeasyCam;
import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

PeasyCam cam; //declare the peasy cam object

VerletPhysics physics;

Cluster cluster;

void setup() {
  
  size(640, 640, OPENGL);
  background(255);
  physics = new VerletPhysics();

  cam = new PeasyCam(this, 0, 0, 0, 600); //initialise the peasycam object
  cam.setMinimumDistance(430); //set minimum zoom distance
  cam.setMaximumDistance(1500); //set maximum zoom distance

  // physics.setWorldBounds
  pushMatrix();
  translate(width/2, height/2, 0);
  cluster = new Cluster(20, 400, new Vec3D(0, 0, 0));
  popMatrix();
  camera();
  
}


void draw() {
  lights();
  physics.update();
  background(255);
  pushMatrix();
  translate(width/2, height/2, 0);
  cluster.display();
  cluster.showConnections();
  popMatrix();
}
