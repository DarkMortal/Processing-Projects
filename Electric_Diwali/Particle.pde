class Particle{
  int col; float angle;
  PVector pos = new PVector(0,0),
          velocity = new PVector(0,0);
  static final float speed = 10.2, size = 5;
  boolean isDead = false;
  
  // for storing old positions
  ArrayList<PVector> old = new ArrayList<PVector>();
      
  Particle(float x, float y, float angle_in_radians, int c){
    this.pos.x = x;
    this.pos.y = y;
    this.col = c;
    this.angle = angle_in_radians;
    this.velocity.x = cos(this.angle) * Particle.speed;
    this.velocity.y = sin(this.angle) * Particle.speed;
  }
  
  void update(){
    if(random(1) > 0.95){
      this.angle += (PI/4) * ((random(1) > 0.5) ? 1 : -1);
      this.velocity.x = cos(this.angle) * Particle.speed;
      this.velocity.y = sin(this.angle) * Particle.speed;
    }
    // don't forget to add the current position to list of old positions
    this.old.add(new PVector(this.pos.x, this.pos.y));
    while(this.old.size() > 15) old.remove(0);
    this.pos.add(this.velocity);
    
    this.isDead = (
      this.old.get(0).x < 0 || this.old.get(0).x > width ||
      this.old.get(0).y < 0 || this.old.get(0).y > height
    );
  }
  
  void show(){
    fill(col, 255, 255);
    noStroke();
    ellipse(this.pos.x, this.pos.y, Particle.size, Particle.size);
    
    if(this.old.size() > 1)
      for(int i = 0; i < this.old.size(); i++){
        float opacity = map(i, 1, this.old.size(), 0, 255);
        fill(this.col, 255, 255, opacity);
        ellipse(this.old.get(i).x, this.old.get(i).y, Particle.size, Particle.size);
      }
  }
}
