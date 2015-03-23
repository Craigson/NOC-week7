class NodeSystem {

  Vec3D origin;
  ArrayList <Node> nodes;
  int numNodes;
  float systemRadius = 100;


  NodeSystem(Vec3D _origin, int _numNodes) {
    origin = _origin;
    numNodes = _numNodes;
    nodes = new ArrayList<Node>();
    sphereDetail(3);
    for (int i = 0; i < numNodes; i++) {
      nodes.add(new Node(randomLocation(systemRadius)));
    }
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
    return new Vec3D 
      ( 2*(b*d + a*c) / k 
      , 2*(c*d - a*b) / k  
      , (a*a + d*d - b*b - c*c) / k);
  }

  void run() {
    for (Node n : nodes) {
      n.run();
    }
  }
}
