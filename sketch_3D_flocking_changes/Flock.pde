class Flock {
  ArrayList boids; // An arraylist for all the boids
  Vec3D origin;
  AttractionBehavior controlBirds;

    Flock() {
    boids = new ArrayList(); // Initialize the arraylist
    origin = new Vec3D(0,0,0);
    controlBirds = new AttractionBehavior(origin,SPHERE_RADIUS, 10);
    physics.addBehavior(controlBirds);
  }

  void run() {
    for (int i = boids.size()-1 ; i >= 0 ; i--) {
      Boid b = (Boid) boids.get(i);  
      b.run(boids);  // Passing the entire list of boids to each boid individually
    b.applyConstraints();
    controlBirds.apply(b);
  }
  }

  void addBoid(Boid b) {
    boids.add(b);
  }
}
