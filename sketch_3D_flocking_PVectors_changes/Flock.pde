class Flock {
  ArrayList boids; // An arraylist for all the boids
  PVector origin;

    Flock() {
    boids = new ArrayList(); // Initialize the arraylist
    origin = new PVector(0,0,0);
  }

  void run() {
    for (int i = boids.size()-1 ; i >= 0 ; i--) {
      Boid b = (Boid) boids.get(i);  
      b.run(boids, origin);  // Passing the entire list of boids to each boid individually
     }
    
   }
  

  void addBoid(Boid b) {
    boids.add(b);
  }
}
