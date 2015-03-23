import java.util.*;

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

VerletPhysics physics;

PeasyCam cam; //declare the peasy cam object
Vec3D origin;
NodeSystem ns;

//HairBall fluffBall;

void setup() {
  size(800, 800, P3D);
  sphereDetail(3);
  physics = new VerletPhysics();
  physics.setDrag(0.01);
  origin = new Vec3D(0, 0, 0);
  ns = new NodeSystem(origin, 100);

//fluffBall = new HairBall(ns, physics);

  cam = new PeasyCam(this, 0, 0, 0, 600); //initialise the peasycam object
  cam.setMinimumDistance(500); //set minimum zoom distance
  cam.setMaximumDistance(1500); //set maximum zoom distance
  camera();
}

void draw() {
  physics.update();
  lights();
  background(220);
  pushMatrix();
  translate(width/2, height/2, 0);
    cam.rotateY(0.001);
  ns.run();
  //fluffBall.run();
  popMatrix();
println(frameRate);
//saveGif();
}

void saveGif(){
   if (frameCount % 4 == 0 && frameCount < 120){
    saveFrame("gif/image-####.gif");
   }
}
