class Node extends VerletParticle { 

  Vec3D pos, prevPos;
  Vec3D acc;
  AttractionBehavior behavior;
  ArrayList<Vec3D> history = new ArrayList<Vec3D>();

  
  Node(Vec3D origin) {
    super(origin);
    physics.addParticle(this);
    AttractionBehavior behavior = new AttractionBehavior(this, 20, random(-0.05,-0.02));
    physics.addBehavior(behavior);
    pos = new Vec3D(this.x,this.y,this.z);
  }

  void run() {
    
    this.update();
    updatePos();
    this.render();
   // drawTail();
   // println(this.getPreviousPosition());
  }


  void render() {
    //noStroke();
    //fill(0);
    noFill();
    stroke(0);
    strokeWeight(0.5);
    pushMatrix();
    beginShape();
    for (Vec3D v : history) {
      curveVertex(v.x, v.y,v.z);
    }
    endShape();
    translate(this.x, this.y, this.z);
   // sphere(0.5);
    popMatrix();
  }
  
  void updatePos(){
    // pos.x = this.x;
    // pos.y = this.y;
    // pos.z = this.z;
    history.add(new Vec3D(this.x, this.y, this.z));
  }
  
  void drawTail(){
    stroke(0);
    strokeWeight(0.5);
   // prevPos = this.getPreviousPosition();
    //line(this.x,this.y,this.z,prevPos.x,prevPos.y,prevPos.z);
    beginShape();
      curveVertex(this.x,this.y,this.z);
    endShape();
}

}
