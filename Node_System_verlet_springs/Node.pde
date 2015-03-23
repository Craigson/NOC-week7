class Node extends VerletParticle { 

  Vec3D pos;
  Vec3D acc;
  AttractionBehavior behavior;
  
  Node(Vec3D origin) {
    super(origin);
    physics.addParticle(this);
    AttractionBehavior behavior = new AttractionBehavior(this, 150, -0.05);

    physics.addBehavior(behavior);
  }

  void run() {
    this.update();
    this.render();
  }


  void render() {
    noStroke();
    fill(0);
    pushMatrix();
    translate(this.x, this.y, this.z);
    sphere(1);
    popMatrix();
  }
}
