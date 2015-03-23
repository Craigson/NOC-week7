class NodeGrid {
  
  Vec3D origin;
  int numNodes;
  ArrayList<Vec3D> nodes;
  float threshold;
  float radius = 50;
  
  nodeGrid(int _numNodes){
    numNode = _numNodes;
    node = new ArrayList<Vec3D>();
    for (int i = 0; i < numPoints; i++){
      nodes.add(randomNode(radius));
    }
  }
  
  void display(){
    for (Node n : nodes){
      n.display();
    }
    
  }
  
  Vec3D randomNode(float radius){
    float a = b = c = d = 0;
    k = 99;
        while (k >= 1.0) 
    { 
      a = random (-1.0, 1.0);
      b = random (-1.0, 1.0);
      c = random (-1.0, 1.0);
      d = random (-1.0, 1.0);
      k = a*a +b*b +c*c +d*d;
    }
    k = k / radius;
    return new Vec3D 
      ( 2*(b*d + a*c) / k  
      , 2*(c*d - a*b) / k  
      , (a*a + d*d - b*b - c*c) / k);
  }
  
}
