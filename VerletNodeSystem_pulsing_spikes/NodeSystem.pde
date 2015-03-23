class NodeSystem {

  Node origin;
  ArrayList <Node> nodes;
  int numNodes;
  float systemRadius = 500;
  float strength;


  NodeSystem(Vec3D _origin, int _numNodes) {
    origin = new Node(_origin);
    numNodes = _numNodes;
    nodes = new ArrayList<Node>();
    for (int i = 0; i < numNodes; i++) {
      nodes.add(new Node(randomLocation(systemRadius)));
    }
    for (Node n : nodes){
      n.createSpring(origin, systemRadius);
  }
    //AttractionBehavior behavior = new AttractionBehavior(origin, systemRadius, -0.05);
    //physics.addBehavior(behavior);
   origin.lock();
  }


  Vec3D randomLocation(float systemRadius) {
    float a=0, b=0, c=0, d=0, k=99;
    while (k >= 1.0) 
    { 
      a = random (-1.0, 1.0);
      b = random (-1.0, 1.0);
      c = random (-1.0, 1.0);
      d = random (-1.0, 1.0);
      k = a*a +b*b +c*c +d*d;
    }
    k = k / systemRadius;
    return new Vec3D ( 2*(b*d + a*c) / k , 2*(c*d - a*b) / k  , (a*a + d*d - b*b - c*c) / k);
  }

  void run() {
    for (Node n : nodes) {
      n.run(systemRadius);
    }
  // drawConnections();
  }
  
    void drawConnections() {
    stroke(0,40);
    strokeWeight(0.5);
   for (Node n : nodes){
     for (Node nOther : nodes){
       float d = n.distanceTo(nOther);
       if (d < 150){
            line(n.x, n.y,n.z, nOther.x, nOther.y,nOther.z);
          }
     }
        }
      }
    


}
