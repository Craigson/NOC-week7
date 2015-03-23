
class Node extends VerletParticle {

  Node(Vec3D pos) {
    super(pos);
  }

  // All we're doing really is adding a display() function to a VerletParticle
  void display() {
    fill(0,150);
    pushMatrix();
    translate(width/2, height/2,0);
    sphere(15);
    popMatrix();
  }
}
