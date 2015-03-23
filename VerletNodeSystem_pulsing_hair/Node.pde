class Node extends VerletParticle { 

  Vec3D pos;
  Vec3D acc;
  AttractionBehavior behavior;
  float t, dt;
  VerletSpring spring;
  Hair h;

  Node(Vec3D loc) {
    super(loc);
    physics.addParticle(this);
    t = random (0, 1000);
    dt = random(0, 0.01);
    AttractionBehavior behavior = new AttractionBehavior(this, 20, -0.05);
    //physics.addBehavior(behavior);
    pos = new Vec3D(this.x, this.y, this.z);
    createHair();
  }

  void run(float r) {
    this.update();
    this.render();
     updateSpring(r);
     h.run(this);
  }


  void render() {
    //noStroke();
    fill(255,100);
    stroke(1);
    pushMatrix();
    translate(this.x, this.y, this.z);
    //sphere(0.5);
    point(this.x,this.y,this.z);
    popMatrix();
  }

  void createSpring(Node origin, float sphereRadius) {
    spring = new VerletSpring(this, origin, sphereRadius, 0.01);
    physics.addSpring(spring);
  }

  void updateSpring(float r) {
    spring.setRestLength(map(noise(t), 0, 1, r-r/4, r+r/4));
    t += dt;
  }

  void createHair() {
    Vec3D origin = new Vec3D(0, 0, 0);
    Vec3D dir = pos.sub(origin);
    dir.normalizeTo(10);
    h = new Hair(physics, pos, dir, 25, 1, 0.1);
  }
}
