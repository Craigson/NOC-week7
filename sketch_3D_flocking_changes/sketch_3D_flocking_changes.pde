import toxi.physics.constraints.*;
import toxi.physics.*;
import toxi.physics.behaviors.*;
import toxi.processing.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.math.*;

//import PeasyCam library to manage camera controls
import peasy.PeasyCam;
import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

PeasyCam cam; //declare the peasy cam object

int numBoids = 20;
int DIM = 200;
int NUM = 500;
int NEIGHBOR_DIST = 50;
int SEPARATION = 15;

Flock flock;
VerletPhysics physics;
public int SPHERE_RADIUS=150;
ParticleConstraint sphere;

void setup() {
  size(800, 800, P3D);
  sphere=new SphereConstraint(new Vec3D(),SPHERE_RADIUS,true);


  physics = new VerletPhysics();
  flock = new Flock();
  sphereDetail(20);

  for (int i = 0; i < numBoids; i++) {
    flock.addBoid(new Boid(new Vec3D(), 2, 0.1, NEIGHBOR_DIST, SEPARATION, sphere));
  }
  smooth();
  background(220);
    cam = new PeasyCam(this, 0, 0, 0, 1500); //initialise the peasycam object
  cam.setMinimumDistance(150); //set minimum zoom distance
  cam.setMaximumDistance(1500); //set maximum zoom distance
  camera();
}
void draw() {
   physics.update();
  background(255);
  lights();
  pushMatrix();
  translate(width/2, height/2, 0);
  cam.rotateX(0);
  noFill();
  stroke(0);
  strokeWeight(0.25);
  sphere(SPHERE_RADIUS*2);
  flock.run();
  popMatrix();
  println(flock.boids.size());
 
}

void mousePressed() {
  flock.addBoid(new Boid(Vec3D.randomVector().scaleSelf(SPHERE_RADIUS*2-100), 3, 0.05, NEIGHBOR_DIST, SEPARATION, sphere));
}

void blur() {
  pushMatrix();
  translate(0, 0, -235);
  fill(215, 10);
  rect(-159, -160, 1235, 1174);
  popMatrix();
}
