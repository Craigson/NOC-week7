/*

class HairBall {

  ArrayList <Hair> fur;
  VerletPhysics hairPhysics;

  HairBall(NodeSystem ns, VerletPhysics physics) {
    fur = new ArrayList<Hair>();
    hairPhysics = new VerletPhysics();

    for (int i = 0; i < ns.nodes.size (); i++) {
      for (Node n : ns.nodes) {
        Vec3D nodePos = new Vec3D(n.x, n.y, n.z);
        Vec3D dir = nodePos.sub(ns.origin);
        dir.normalizeTo(10);
        fur.add(new Hair(hairPhysics, nodePos, dir, 10, 1, 0.1));
      }
    }
  }

  void run() {
    render();
    h.run(this);
  }

  void update() {
  }

  void render() {
    for (Hair h : fur) {
      h.render();
    }
  }
}

*/
