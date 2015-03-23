class Hair extends ParticleString {

  Vec3D pos; //start position of the strand
  Vec3D step; // step direcion and distance between each particle
  int num; //number of particles
  float mass; //particle mass
  float strength; //spring strength
  VerletParticle head, tail; //store information for head and tail of strand
  AttractionBehavior repelHair; //create an attractionbehaviour to ensure the strands always project outward and don'd tangle
  Vec3D origin; //centre of the world

    Hair(VerletPhysics physics, Vec3D _pos, Vec3D _step, int _num, float _mass, float _strength) {
    super(physics, _pos, _step, _num, _mass, _strength);
    origin = new Vec3D(0,0,0);
    num = _num; //number of particles in ParticleString
    head = this.getHead();
    tail = this.getTail();
    
    //create an attraction behaviour for repelling the tail
    repelHair = new AttractionBehavior(head, head.distanceTo(tail)*0.95, -0.01,0.00);
    physics.addBehavior(repelHair);
  }


  void render() {
    stroke(200,50);
    strokeWeight(0.75);
    noFill();
    
    //draw the hair strand
    beginShape();
    curveVertex(head.x,head.y,head.z);
    for (Iterator i=this.particles.iterator (); i.hasNext(); ) {
      VerletParticle p = (VerletParticle)i.next();
      curveVertex(p.x, p.y,p.z);
    }
    curveVertex(tail.x,tail.y,tail.z);
    endShape();
    pushMatrix();
    translate(this.tail.x,this.tail.y,this.tail.z);
    fill(150,30);
    sphere(0.5);
    popMatrix();
  }

  void update(Node n) {
    //set the string head to the node's position
    head.set(n.x, n.y, n.z);
    //repel the tail to keep the hair projecting outwards
    repelHair.apply(tail);
  }

  void run(Node n) {
    update(n);
    render();
  }
}
