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

public VerletPhysics physics;

PeasyCam cam; //declare the peasy cam object
Vec3D origin;
NodeSystem ns;

void setup() {
  smooth();
  size(1280, 720, OPENGL);
  background(150);
  sphereDetail(3);
  physics = new VerletPhysics();
  physics.setDrag(0.01);
  origin = new Vec3D(0, 0, 0);
  ns = new NodeSystem(origin, 100);

  cam = new PeasyCam(this, 0, 0, 0, 1500); //initialise the peasycam object
  cam.setMinimumDistance(150); //set minimum zoom distance
  cam.setMaximumDistance(1500); //set maximum zoom distance
  camera();
}

void draw() {

  lights();
  background(20);
  blendMode(ADD);
  pushMatrix();
  translate(width/2, height/2, 0);
  cam.rotateY(0.001);
  //cam.rotateZ(0.05);
  ns.run();

  popMatrix();
  //println(frameRate);
  physics.update();

  //saveGif();
  //saveMovie();

  println(frameCount);
}

void saveGif() {
  if (frameCount % 4 == 0 && frameCount < 240) {
    saveFrame("singluarity-gif/image-####.gif");
    println("saving image");
  }
}

void saveMovie() {
  if (frameCount < 150) {
    saveFrame("movie/movie-####.jpeg");
    println("saving image");
  }
  if (frameCount > 150) {
    exit();
  }
}


void keyPressed() {
  if (key == 's') {
    saveFrame("images/hairball-still-###.jpeg");
    println("saving image");
  }
}
