/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/8885*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
// Flocking
// Daniel Shiffman <http://www.shiffman.net>
// The Nature of Code, Spring 2009

// Ported to 3D & toxiclibs by Karsten Schmidt

// Demonstration of Craig Reynolds' "Flocking" behavior
// See: http://www.red3d.com/cwr/
// Rules: Cohesion, Separation, Alignment

// Click mouse to add boids into the system

//import processing.opengl.*;
import toxi.processing.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.math.*;

int DIM = 200;
int NUM = 200;
int NEIGHBOR_DIST = 50;
int SEPARATION = 25;
float BOID_SIZE = 5;

Flock flock;

// color transformation matrix used to map XYZ position into RGB values
Matrix4x4 colorMatrix=new Matrix4x4().scale(255f/(DIM*2)).translate(DIM,DIM,DIM);

ToxiclibsSupport gfx;

void setup() {
  size(680,382,P3D);
  gfx=new ToxiclibsSupport(this);
  flock = new Flock();
  // Add an initial set of boids into the system
  for (int i = 0; i < NUM; i++) {
    flock.addBoid(new Boid(new Vec3D(), 3, 0.05, NEIGHBOR_DIST, SEPARATION));
  }
  smooth();
}

void draw() {
  background(0);
  lights();
  translate(width/2,height/2,0);
  rotateY(mouseX*0.01);
  noFill();
  stroke(255,50);
  box(DIM*2);
  fill(255);
  noStroke();
  flock.run();
}

// Add a new boid into the System
void mousePressed() {
  flock.addBoid(new Boid(new Vec3D(), 3, 0.05, NEIGHBOR_DIST, SEPARATION));
}

