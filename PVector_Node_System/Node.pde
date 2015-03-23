class Node {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass, strength;

  Node(PVector loc) {
    sphereDetail(3);
    mass = 1;
    location = loc.get();
    velocity = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
  }

  void applyForce(PVector force) {
    // PVector f = PVector.div(force, mass);
    acceleration.add(force);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    noStroke();
    fill(0);
    pushMatrix();
    translate(location.x,location.y,location.z);
    sphere(1);
    popMatrix();
    //println("displaying");
    println(location);
  }

  PVector attract(Node n) {
    PVector force = PVector.sub(location, n.location);             // Calculate direction of force
    float distance = force.mag();                                 // Distance between objects
    // distance = constrain(distance, 5.0, 25.0);                             // Limiting the distance to eliminate "extreme" results for very close or very far objects
    //force.normalize();                                            // Normalize vector (distance doesn't matter here, we just want this vector for direction

    //adding the extra 100.0 to the denominator prevents the value going to infinity
    //when removing the conditional statment in draw where the particle checks
    //itself

    //remove g and apply it in the main update
    strength = (mass) / (distance * distance * distance + 100.0); // Calculate gravitional force magnitude
    force.mult(strength);                                         // Get force vector --> magnitude * direction
    return force;
  }
}
