class Boid extends VerletParticle {

  Vec3D loc;
  Vec3D vel;
  Vec3D acc;
  float maxforce;
  float maxspeed;
  float neighborDist;
  float desiredSeparation;
  VerletSpring spring;

  Boid(Vec3D l, float ms, float mf, float nd, float sep, ParticleConstraint sphere) {
    super(l);
    loc=l;
    acc = new Vec3D();
    vel = Vec3D.randomVector();
    maxspeed = ms;
    maxforce = mf;
    neighborDist=nd*nd;
    desiredSeparation=sep;
    Vec3D origin = new Vec3D(0,0,0);
    VerletParticle p = new VerletParticle(origin);
    physics.addParticle(p);
    physics.addParticle(this);
    spring = new VerletSpring(p, this, (float)SPHERE_RADIUS,10.0f);
    physics.addSpring(spring);
    p.lock();
  }

  void run(ArrayList boids) {
    flock(boids);
    update();
    // ---> world();
    render();
  }
  
  void applyForce(Vec3D force){
    acc.addSelf(force);
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList boids) {
    Vec3D sep = separate(boids);   // Separation
    Vec3D ali = align(boids);      // Alignment
    Vec3D coh = cohesion(boids);   // Cohesion
    // Arbitrarily weight these forces
    sep.scaleSelf(25.0);
    ali.scaleSelf(4.0);
    coh.scaleSelf(5.0);
    // Add the force vectors to acceleration
    acc.addSelf(sep);
    acc.addSelf(ali);
    acc.addSelf(coh);
  }

  // Method to update location
  void update() {
    //this.update();
    vel.addSelf(acc);
    vel.limit(maxspeed);
    loc.addSelf(vel);
    acc.clear();
  }

  void seek(Vec3D target) {
    acc.addSelf(steer(target, false));
  }

  void arrive(Vec3D target) {
    acc.addSelf(steer(target, true));
  }

  Vec3D steer(Vec3D target, boolean slowdown) {
    Vec3D steer;  // The steering vector
    Vec3D desired = target.sub(loc);  // A vector pointing from the location to the target
    float d = desired.magnitude(); // Distance from the target is the magnitude of the vector
    // If the distance is greater than 0, calc steering (otherwise return zero vector)
    if (d > 0) {
      // Normalize desired
      desired.normalize();
      // Two options for desired vector magnitude (1 -- based on distance, 2 -- maxspeed)
     // ----> if ((slowdown) && (d < 100.0f)) desired.scaleSelf(maxspeed*(d/100.0f)); // This damping is somewhat arbitrary
      desired.scaleSelf(maxspeed);
      // Steering = Desired minus Velocity
      steer = desired.sub(vel).limit(maxforce);  // Limit to maximum steering force
    } else {
      steer = new Vec3D();
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

void world(){
  
}


  // Separation
  // Method checks for nearby boids and steers away
  Vec3D separate (ArrayList boids) {
    Vec3D steer = new Vec3D();
    int count = 0;
    // For every boid in the system, check if it's too close
    for (int i = boids.size ()-1; i >= 0; i--) {
      Boid other = (Boid) boids.get(i);
      if (this != other) {
        float d = loc.distanceTo(other.loc);
        // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
        if (d < desiredSeparation) {
          // Calculate vector pointing away from neighbor
          Vec3D diff = loc.sub(other.loc);
          diff.normalizeTo(1.0/d);
          steer.addSelf(diff);
          count++;
        }
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.scaleSelf(1.0/count);
    }

    // As long as the vector is greater than 0
    if (steer.magSquared() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalizeTo(maxspeed);
      steer.subSelf(vel);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  Vec3D align (ArrayList boids) {
    Vec3D steer = new Vec3D();
    int count = 0;
    for (int i = boids.size ()-1; i >= 0; i--) {
      Boid other = (Boid) boids.get(i);
      if (this != other) {
        if (loc.distanceToSquared(other.loc) < neighborDist) {
          steer.addSelf(other.vel);
          count++;
        }
      }
    }
    if (count > 0) {
      steer.scaleSelf(1.0/count);
    }

    // As long as the vector is greater than 0
    if (steer.magSquared() > 0) {
      
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalizeTo(maxspeed);
      steer.subSelf(vel);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Cohesion
  // For the average location (i.e. center) of all nearby boids, calculate steering vector towards that location
  Vec3D cohesion (ArrayList boids) {
    Vec3D sum = new Vec3D();   // Start with empty vector to accumulate all locations
    int count = 0;
    for (int i = boids.size ()-1; i >= 0; i--) {
      Boid other = (Boid) boids.get(i);
      if (this != other) {
        if (loc.distanceToSquared(other.loc) < neighborDist) {
          sum.addSelf(other.loc); // Add location
          count++;
        }
      }
    }
    if (count > 0) {
      sum.scaleSelf(1.0/count);
      return steer(sum, false);  // Steer towards the location
    }
    return sum;
  }
}
