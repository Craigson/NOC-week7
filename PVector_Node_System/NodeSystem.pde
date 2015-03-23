class NodeSystem {

  PVector origin;
  ArrayList <Node> nodes;
  int numNodes;
  float systemRadius = 300;


  NodeSystem(PVector _origin, int _numNodes) {
    origin = _origin.get();
    numNodes = _numNodes;
    nodes = new ArrayList<Node>();
    for (int i = 0; i < numNodes; i++) {
      nodes.add(new Node(randomLocation(systemRadius)));
    }
  }
  

  PVector randomLocation(float systemRadius) {
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
    return new PVector 
      ( 2*(b*d + a*c) / k 
      , 2*(c*d - a*b) / k  
      , (a*a + d*d - b*b - c*c) / k);
  }

  void run() {
    for (Node n : nodes) {
     PVector dist = PVector.sub(n.location,origin);
     float d = dist.mag();
     d = constrain(d, systemRadius -20, systemRadius + 20);
     n.display();
     n.update();
    }
  }
}
