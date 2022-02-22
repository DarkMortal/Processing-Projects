float offsetX=700,
      radius=50,
      startY=50,
      offsetY=500;

float time=0,dt=0.3,
      posX=0,posY=0;

float gravity=10,
      omega=sqrt(gravity/offsetY),
      angle=45;

void setup(){
  fullScreen();
  surface.setTitle("Simple Pendulum");
  surface.setResizable(false);
  fill(0,255,0); background(0);
  offsetY=50.0+getFloat("Enter the Length of the String in m");
  angle=getFloat("Enter max angle of the string wrt to mean position in degrees");
}

void draw(){
  float angleT=angle*sin(omega*time);
  posY=(offsetY-startY)*(1-cos(radians(angleT)));
  posX=(offsetY-startY)*sin(radians(angleT));
  time+=dt; clear();
  line(offsetX,startY,offsetX+posX,offsetY-posY+startY); stroke(255,0,0);
  circle(offsetX+posX,offsetY-posY+startY,radius);
}
