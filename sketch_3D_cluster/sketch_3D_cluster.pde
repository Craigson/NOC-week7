import toxi.physics.constraints.*;
import toxi.physics2d.constraints.*;
import toxi.physics2d.behaviors.*;
import toxi.physics.*;
import toxi.physics.behaviors.*;
import toxi.physics2d.*;
import toxi.geom.*;

VerletPhysics physics;

Cluster cluster;

void setup(){
  size(640,640, OPENGL);
  background(255);
  physics = new VerletPhysics();
 // physics.setWorldBounds
 pushMatrix();
 translate(width/2,height/2,0);
 cluster = new Cluster(30, 400, new Vec3D(0,0,0));
 popMatrix();
}


void draw(){
 physics.update();
 background(255);
 pushMatrix();
 translate(width/2,height/2,0);
 cluster.display();
 cluster.showConnections();
 popMatrix();
}
