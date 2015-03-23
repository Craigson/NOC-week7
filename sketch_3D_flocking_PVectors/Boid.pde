class Boid {

  PVector loc, vel, acc;
  float maxforce;
  float maxspeed;

  float neighborDist;
  float desiredSeparation;

  Boid(PVector l, float ms, float mf, float nd, float sep) {
    loc = l.get();
    acc = new PVector(random(-2, 2), random(-2, 2), random(-2, 2));
    vel = new PVector();
    maxspeed = ms;
    maxforce = mf;
    neighborDist=nd*nd;
    desiredSeparation=sep;
  }

  void run(ArrayList boids, PVector origin) {
    flock(boids);
    update();
    render();
    attractCenter(origin);
  }

  void attractCenter(PVector origin) {
    PVector centreForce = PVector.sub(loc, origin);
    float d = centreForce.mag();
    centreForce.normalize();
    centreForce.mult(-5);
    if (d > 300) {
      seek(origin);
    }
  }


  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList boids) {
    PVector sep = separate(boids);   // Separation
    PVector ali = align(boids);      // Alignment
    PVector coh = cohesion(boids);   // Cohesion
    // Arbitrarily weight these forces
    sep.mult(1.8);
    ali.mult(1.0);
    coh.mult(1.0);
    // Add the force vectors to acceleration
    acc.add(sep);
    acc.add(ali);
    acc.add(coh);
  }

  // Method to update location
  void update() {
    // Update velocity
    vel.add(acc);
    // Limit speed
    vel.limit(maxspeed);

    loc.add(vel);
    // Reset accelertion to 0 each cycle
    acc.mult(0);
  }

  void seek(PVector target) {
    acc.add(steer(target, false));
  } 

  void arrive(PVector target) {
    acc.add(steer(target, true));
  }


  // A method that calculates a steering vector towards a target
  // Takes a second argument, if true, it slows down as it approaches the target
  PVector steer(PVector _target, boolean slowdown) {
    PVector steer;  // The steering vector
    PVector target = _target.get();
    PVector desired = PVector.sub(target, loc);  // A vector pointing from the location to the target
    float d = desired.mag(); // Distance from the target is the magnitude of the vector
    // If the distance is greater than 0, calc steering (otherwise return zero vector)

    if (d > 0) {
      // Normalize desired
      desired.normalize();
      // Two options for desired vector magnitude (1 -- based on distance, 2 -- maxspeed)
      if ((slowdown) && (d < 100.0f)) desired.mult(maxspeed*(d/100.0f)); // This damping is somewhat arbitrary
      else desired.mult(maxspeed);
      // Steering = Desired minus Velocity
      steer = PVector.sub(desired, vel);
      steer.limit(maxforce);  // Limit to maximum steering force
    } else {
      steer = new PVector();
    }
    return steer;
  }

  void render() {
    fill(0);
    noStroke();
    pushMatrix();
    translate(loc.x, loc.y, loc.z);
    sphere(1);
    popMatrix();
  }


  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList boids) {
    PVector steer = new PVector();
    int count = 0;
    // For every boid in the system, check if it's too close
    for (int i = boids.size ()-1; i >= 0; i--) {
      Boid other = (Boid) boids.get(i);
      if (this != other) {

        PVector dist = PVector.sub(loc, other.loc);  // A vector pointing from the location to the target

        float d = dist.mag();
        // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
        if (d < desiredSeparation) {
          // Calculate vector pointing away from neighbor
          PVector diff = PVector.sub(loc, other.loc);
          diff.normalize();
          steer.add(diff);
          count++;
        }
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.mult(1.0/count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(vel);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList boids) {
    PVector steer = new PVector();
    int count = 0;
    for (int i = boids.size ()-1; i >= 0; i--) {
      Boid other = (Boid) boids.get(i);
      if (this != other) {
        PVector dist = PVector.sub(loc, other.loc);  // A vector pointing from the location to the target
        float d = dist.mag();
        if (d < neighborDist) {
          steer.add(other.vel);
          count++;
        }
      }
    }
    if (count > 0) {
      steer.mult(1.0/count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {

      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(vel);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Cohesion
  // For the average location (i.e. center) of all nearby boids, calculate steering vector towards that location
  PVector cohesion (ArrayList boids) {
    PVector sum = new PVector();   // Start with empty vector to accumulate all locations
    int count = 0;
    for (int i = boids.size ()-1; i >= 0; i--) {
      Boid other = (Boid) boids.get(i);
      if (this != other) {
        PVector dist = PVector.sub(loc, other.loc);  // A vector pointing from the location to the target
        float d = dist.mag();
        if (d < neighborDist) {
          sum.add(other.loc); // Add location
          count++;
        }
      }
    }
    if (count > 0) {
      sum.mult(1.0/count);
      return steer(sum, false);  // Steer towards the location
    }
    return sum;
  }
}
