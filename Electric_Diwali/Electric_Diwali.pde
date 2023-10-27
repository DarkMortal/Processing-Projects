ArrayList<Particle> particles = new ArrayList<Particle>();

void setup(){
  size(1080, 720);
  colorMode(HSB);
  createParticles(100, width/2, height/2);
}

void draw(){
  background(0);
  for(int i = particles.size() - 1; i >= 0; i--){
    if(particles.get(i).isDead){
      particles.remove(i);
      continue;
    }else{
      particles.get(i).update();
      particles.get(i).show();
    }
  }
}

void keyPressed(){
  if(key == ' ') createParticles(100, width/2, height/2);
}

void mousePressed(){
  createParticles(100, mouseX, mouseY);
}

void createParticles(int num, float x, float y){
  int c = int(random(255));
  for(int i = 0; i <= num; i++){
    float a = int(random(8)) * PI/4;
    particles.add(new Particle(x, y, a, c));
  }
}
