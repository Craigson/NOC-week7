class Node extends VerletParticle { 

  Vec3D pos, prev;
  Vec3D acc;
  AttractionBehavior behavior;

  Node(Vec3D origin) {
    super(origin);
    physics.addParticle(this);
    AttractionBehavior behavior = new AttractionBehavior(this, 30, -0.2);
    physics.addBehavior(behavior);
    pos = new Vec3D();
    prev = new Vec3D();
    prev = null;
  }

  void run() {
    pos.x = this.x;
    pos.y = this.y;
    pos.z = this.z;
    this.update();
    this.render();
    drawTrail();
  }


  void render() {
    noStroke();
    fill(0);
    pushMatrix();
    translate(this.x, this.y, this.z);
    sphere(0.5);
    popMatrix();
  }

  void drawTrail() {
    stroke(0);
    strokeWeight(1);
    if (prev!=null) {
      line(pos.x, pos.y, pos.z, prev.x, prev.y, prev.z);
    prev.x = this.x;
    prev.y = this.y;
    prev.z = this.z;
  }
  }
}
