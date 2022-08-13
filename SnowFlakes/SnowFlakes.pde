final float d = 6;

class Particle{
  PVector pos;
  Particle(float a,float b){
    pos = new PVector(a,b);
  }
  void update(PApplet sketch){
    this.pos.x -= 1;
    this.pos.y += sketch.random(-3,3);
    float angle = this.pos.heading();
    angle = constrain(angle,0,PI/6);
    float magnitude = pos.mag();
    pos = PVector.fromAngle(angle);
    pos.setMag(magnitude);
  }
  void show(){
    fill(255);
    stroke(255);
    ellipse(this.pos.x,this.pos.y,d,d);
  }
  boolean finished(){ return (this.pos.x<1); }
  boolean collides(ArrayList<Particle> snowflake){
    for(Particle p: snowflake){
      float dist = dist(p.pos.x,p.pos.y,this.pos.x,this.pos.y);
      if(dist<d) return true;
    }
    return false;
  }
}

Particle current;
ArrayList<Particle> snowFlakes;

void setup(){
  size(600,600);
  current = new Particle(width/2,0);
  snowFlakes = new ArrayList<Particle>();
}

void draw(){
  background(0);
  translate(width/2,height/2);
  rotate(PI/6);
  while(!current.finished() && !current.collides(snowFlakes))
    current.update(this);
    snowFlakes.add(current);
    current = new Particle(width/2,0);
  for(int i=0;i<6;i++){
    rotate(PI/3);
    current.show();
    for(Particle p: snowFlakes)
    p.show(); push(); scale(1,-1);
    current.show();
    for(Particle p: snowFlakes) 
    p.show(); pop();
  }
}
