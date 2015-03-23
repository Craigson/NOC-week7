class Node extends VerletParticle { 

  Vec3D prevPos = new Vec3D();
  AttractionBehavior behavior;
  ArrayList<Vec3D> history;

  Node(Vec3D origin) {
    super(origin);
    physics.addParticle(this);
    AttractionBehavior behavior = new AttractionBehavior(this, 30, -0.2);
    physics.addBehavior(behavior);
    history = new ArrayList<Vec3D>();
    prevPos = null;
  }

  void run() {
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
    beginShape();
    strokeWeight(0.5);
    stroke(0);
    if (prevPos != null) {
      for (Vec3D v : history) {
        curveVertex(prevPos.x, prevPos.y, prevPos.z);
      }
    prevPos.x = this.x;
    prevPos.y = this.y;
    prevPos.z = this.z;
    history.add(prevPos);
    } 
    endShape();
  }
}
