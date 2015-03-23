class Hair extends ParticleString {

  Vec3D pos; //start position of the string
  Vec3D step; // step direcion and distance between each particle
  int num; //number of particles
  float mass; //particle mass
  float strength; //spring strength
  VerletParticle head, tail;
  //VerletSpring repeller;
  AttractionBehavior repelHair;
  Vec3D origin;

    Hair(VerletPhysics physics, Vec3D _pos, Vec3D _step, int _num, float _mass, float _strength) {
    super(physics, _pos, _step, _num, _mass, _strength);
    origin = new Vec3D(0,0,0);
    num = _num;
    head = this.getHead();
    tail = this.getTail();
    repelHair = new AttractionBehavior(head, head.distanceTo(tail), -0.1,0.5);
    //  AttractionBehavior behavior = new AttractionBehavior(p, distance, strength);
    physics.addBehavior(repelHair);
    //repeller = new VerletSpring(head,tail, head.distanceTo(tail),1);
    //physics.addSpring(repeller);
  }


  void render() {
    stroke(200,5);
    strokeWeight(0.5);
    noFill();
    beginShape();
    curveVertex(head.x,head.y,head.z);
    for (Iterator i=this.particles.iterator (); i.hasNext(); ) {
      VerletParticle p = (VerletParticle)i.next();
      curveVertex(p.x, p.y,p.z);
    }
    endShape();
    //println("displaying line");
  }

  void update(Node n) {
    head.set(n.x, n.y, n.z);
   // repelHair.apply(tail);
  }

  void run(Node n) {
    update(n);
    render();
  }
}

//(total n - 2) * 1.5 / total 
