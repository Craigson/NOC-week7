PVector origin;
NodeSystem ns;

void setup(){
  size(800,800,P3D);
  origin = new PVector(0,0,0);
  ns = new NodeSystem(origin, 200);
}

void draw(){
  background(220);
  pushMatrix();
  translate(width/2,height/2,0);
  ns.run();
  popMatrix();
}
