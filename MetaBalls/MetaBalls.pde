class Ball{
  PVector pos;
  float r;
  PVector vel;
  
  Ball(float x,float y,float radius){
    pos = new PVector(x,y);
    r = radius;
    vel = PVector.random2D();
    vel.mult(random(2,5));
  }
  
  void show(){
    noFill();
    stroke(255);
    ellipse(pos.x, pos.y, r*2, r*2);
  }
  
  void update(){
    pos.add(vel);
    if(this.pos.x>width || this.pos.x<0) vel.x *= -1.0;
    if(this.pos.y>height || this.pos.y<0) vel.y *= -1.0;
  }
}

Ball[] balls = {
  new Ball(0,0,20),
  new Ball(10,10,30),
  new Ball(15,20,30),
  new Ball(10,30,20),
  new Ball(20,50,40),
  new Ball(30,40,50),
};

void setup(){
  size(600, 400);
  colorMode(HSB);
}

void draw(){
  loadPixels();
  for(int x=0;x<width;x++){
    for(int y=0;y<height;y++){
      float sum = 0.0;
      for(Ball b : balls){
        float d = dist(x,y, b.pos.x, b.pos.y);
        sum += 100*b.r/d;
      }
      pixels[x+y*width] = color(sum,255,255);
    }
  }
  updatePixels();
  for(Ball b : balls) b.update();
}
