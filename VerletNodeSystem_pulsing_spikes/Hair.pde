
/*
class Hair extends ParticleString {

  // ParticleString strand; //create a new ParticleString object to act as the hair
  VerletPhysics hairPhysics; //reference the globabl physics engine
  Vec3D pos; //start position of the string
  Vec3D step; // step direcion and distance between each particle
  int num; //number of particles
  float mass; //particle mass
  float strength; //spring strength
  
  */
  
class Hair{
  
  Vec3D anchor, head, origin, dir;

    // Hair(VerletPhysics hairPhysics, Vec3D _pos, Vec3D _step, int _num, float _mass, float _strength) {
    // super(hairPhysics, _pos, _step, _num, _mass, _strength);
    // num = _num;
  //}

Hair(Vec3D _anchor, Vec3D _origin){
  anchor = _anchor.copy();
  origin = new Vec3D(_origin.x,_origin.y,_origin.z);
  // head = anchor.sub(origin);
  // head.normalizeTo(10);
}

  void render() {
    stroke(0);
    strokeWeight(1);
    // for (int i = 0; i < num; i++) {
    //   VerletSpring s = (VerletSpring).hairPhysics.get(i);
    //   line(s.a.x, s.a.y, s.a.z, s.b.x, s.b.y, s.b.z);
    // }
    // for (Iterator i=hairPhysics.springs.iterator (); i.hasNext(); ) {
    //   VerletSpring s=(VerletSpring)i.next();
    //   line(s.a.x, s.a.y, s.b.x, s.b.y);
    // }
    pushMatrix();
    translate(anchor.x,anchor.y,anchor.z);
    line(0,0,0,head.x,head.y,head.z);
    popMatrix();
    println("displaying line");
  }
  
  void update(Node n){
    anchor.x = n.x;
    anchor.y = n.y;
    anchor.z = n.z;
    head = anchor.sub(origin);
    head.normalizeTo(50);
    //head.scaleSelf(10);
  }
  
  void run(Node n){
    update(n);
    render();
  }
  
}

//(total n - 2) * 1.5 / total 
