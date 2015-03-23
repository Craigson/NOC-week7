
int numBoids = 100;
int DIM = 200;
int NUM = 100;
int NEIGHBOR_DIST = 100;
int SEPARATION = 30;

Flock flock;

void setup(){
  size(800,800,P3D);
  flock = new Flock();
  sphereDetail(3);
  
  for (int i = 0; i < numBoids; i++){
    flock.addBoid(new Boid(new PVector(), 2, 0.05, NEIGHBOR_DIST, SEPARATION));
  }
  smooth();
  background(220);
}
void draw() {
  background(255);
  // if (frameCount < 50){
  //   flock.addBoid(new Boid(new PVector(), 2, 0.05, NEIGHBOR_DIST, SEPARATION));
  // }
  blur();
  lights();
  pushMatrix();
  translate(width/2,height/2,0);
  noFill();
  flock.run();
  popMatrix();
  println(flock.boids.size());
}

void mousePressed() {
  flock.addBoid(new Boid(new PVector(), 3, 0.05, NEIGHBOR_DIST, SEPARATION));
}

void blur(){
     pushMatrix();
  translate(0, 0,1235);
  fill(215, 10);
  rect(0,0,width,height);
  popMatrix();
}
  
  
  void keyPressed(){
    if (key == 's'){
        for (int i = 0; i < numBoids; i++){
    flock.addBoid(new Boid(new PVector(), 2, 0.05, NEIGHBOR_DIST, SEPARATION));
  }
    }
  }
