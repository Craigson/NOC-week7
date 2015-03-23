class Node extends VerletParticle { 

  Vec3D pos;
  Vec3D acc;
  AttractionBehavior behavior;
  float theta, dt;
  VerletSpring spring;

  Node(Vec3D _origin, VerletParticle p) {
    super(_origin);
    physics.addParticle(this);
    AttractionBehavior behavior = new AttractionBehavior(this, 150, random(-0.05,0.05));
    theta = random(0, TWO_PI);
    dt = random(0, 0.005);
    physics.addBehavior(behavior);
    pos = new Vec3D(this.x,this.y,this.z);
    spring = new VerletSpring(this, p, random(250, 300), 0.01);
    physics.addSpring(spring);
  }
  
  
    Node(Vec3D _origin) {
    super(_origin);
    physics.addParticle(this);
    AttractionBehavior behavior = new AttractionBehavior(this, 150, random(-0.05,0.05));
    physics.addBehavior(behavior);
    pos = new Vec3D(this.x,this.y,this.z);
  }

  void run() {
    this.update();
    this.render();
    applySpring();
  }


  void render() {
    pos = new Vec3D(this.x,this.y,this.z);
    noStroke();
    fill(0);
    pushMatrix();
    translate(this.x, this.y, this.z);
    sphere(1);
    popMatrix();
  }

  void applySpring() {
    spring.setRestLength(map(cos(theta), -1, 1, 250, 300));
    theta += dt;
  }
}
