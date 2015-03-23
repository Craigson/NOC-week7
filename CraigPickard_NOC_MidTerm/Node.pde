class Node extends VerletParticle { 

  Vec3D pos;
  Vec3D acc;
  AttractionBehavior behavior; //attraction behavior between all the nodes
  float t, dt;
  VerletSpring spring; //create a spring for oscillating the nodes distance from the centre
  Hair h; //a new hair strand object

  Node(Vec3D loc) {
    super(loc);
    physics.addParticle(this);
    t = random (0, 1000);
    dt = random(0, 0.01);
    AttractionBehavior behavior = new AttractionBehavior(this, 20, -0.05);
    //physics.addBehavior(behavior);
    pos = new Vec3D(this.x, this.y, this.z);
    createHair(); //method for attaching a hair strand to each node
  }

  void run(float r) {
    this.update();
    this.render();
     //updateSpring(r);
     h.run(this); //pass the node into the hair object to set the head position
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

//this method is called inside the nodeSystem class to create a spring between the node and origin
  void createSpring(Node origin, float sphereRadius) {
    spring = new VerletSpring(this, origin, sphereRadius, 0.01);
    physics.addSpring(spring);
  }

  void updateSpring(float r) {
    spring.setRestLength(map(noise(t), 0, 1, r-r/4, r+r/4));
    t += dt;
  }

//a method for creating and attaching the hair objects
  void createHair() {
    Vec3D origin = new Vec3D(0, 0, 0);
    Vec3D dir = pos.sub(origin);
    int d = (int)(random(15,30));
    dir.normalizeTo(d);
    //a VerletPhysics object (physics) needs to be passed into the ParticleString constructor
    h = new Hair(physics, pos, dir, d/2, 1, 0.1);
  }
}
