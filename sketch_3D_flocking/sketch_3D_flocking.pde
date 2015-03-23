import toxi.physics.constraints.*;
import toxi.physics2d.constraints.*;
import toxi.physics2d.behaviors.*;
import toxi.physics.*;
import toxi.physics.behaviors.*;
import toxi.physics2d.*;

import toxi.processing.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.math.*;

int numBoids = 500;
int DIM = 200;
int NUM = 500;
int NEIGHBOR_DIST = 50;
int SEPARATION = 15;

Flock flock;
VerletPhysics physics;

void setup(){
  size(800,800,P3D);
  physics = new VerletPhysics();
  physics.setWorldBounds(new AABB(new Vec3D(0,0,0), 200));
  flock = new Flock();
  sphereDetail(3);
  
  // for (int i = 0; i < numBoids; i++){
  //   flock.addBoid(new Boid(new Vec3D(), 2, 0.05, NEIGHBOR_DIST, SEPARATION));
  // }
  smooth();
  background(220);
}
void draw() {
  background(255);
  if (frameCount < 500){
    flock.addBoid(new Boid(new Vec3D(), 2, 0.05, NEIGHBOR_DIST, SEPARATION));
  }
  //blur();
  lights();
  pushMatrix();
  translate(width/2,height/2,0);
  noFill();
  flock.run();
  popMatrix();
  println(flock.boids.size());
}

void mousePressed() {
  flock.addBoid(new Boid(new Vec3D(), 3, 0.05, NEIGHBOR_DIST, SEPARATION));
}

void blur(){
     pushMatrix();
  translate(0, 0, -235);
  fill(215, 10);
  rect(-159, -160, 1235, 1174);
  popMatrix();
}
  
