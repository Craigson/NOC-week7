class Node extends VerletParticle {
 
  
  Node(Vec3D loc){
    super(loc);
    //physics.addBehavior(new AttractionBehavior(this,10,-0.1));
    sphereDetail(3);  
}
  
  void display() {
    fill(0);
    point(loc.x,loc.y,loc.z);
  }
  
  
}
