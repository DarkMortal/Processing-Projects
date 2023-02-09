float time = 0.0;

final float dt = 0.05, R = 120;

float currentY = 0.0;

int num = 1;

FloatList points = new FloatList();

void setup(){
  size(950,600);
  surface.setTitle("Fourier Series");
  surface.setResizable(false);
  num = getInt("Enter n");
  background(0);
}

void draw(){
  clear();
  translate(250,250);
  float x = 0.0 , y = 0.0;
  float prevX = 0.0, prevY = 0.0;
  float radius = 0.0;
  
  for(int i=0;i<num;i++){
    float n = 2*i+1;
    prevX = x; prevY = y;
    radius = R * (4 / (n*PI));
    float diameter = radius * 2;
    
    noFill();
    stroke(255);
    ellipse(prevX,prevY,diameter,diameter);
    
    x += radius*cos(n*time);
    y += radius*sin(n*time);
        
    fill(255);
    line(prevX,prevY,x,y);
    ellipse(x,y,10,10);
  }
  
  if(points.size() == 700)
  points.remove(0);
  
  points.append(y);
  
  beginShape();
  noFill();
  for(int i=points.size()-1;i>=0;i--) 
  vertex((points.size()-i)+R+100,points.get(i));
  endShape();
  
  line(x,y,R+100,y);
  
  time += dt;
  if(time >= 2*PI) time = 0.0;
}
