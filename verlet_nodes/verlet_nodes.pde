import toxi.physics.constraints.*;
import toxi.physics.*;
import toxi.geom;.*;


//create verlet springs to origin
//create attraction / repulsion forces
// create springs between neighbors
//send pulsexs between neigbhours
//have flocks following pulses

VerletPhysics physics;

void setup(){
  size(800,800,P3D);
  physics = new VerletPhysics();
}

void draw(){
  physics.update();
}
