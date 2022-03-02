float offsetX=700,
      radius=50,
      startY=50,
      offsetY=500;

float time=0,dt=0.3,
      posX=0,posY=0,
      pos2X=0,pos2Y=0;

float gravity=10,
      omega=sqrt(gravity/(offsetY-startY)),
      angle=45;

void setup(){
  fullScreen();
  surface.setTitle("Simple Pendulum");
  surface.setResizable(false);
  background(0);
  offsetY=50.0+getFloat("Enter the Length of the String in m");
  angle=getFloat("Enter max angle of the string wrt to mean position in degrees");
}

void draw(){
  float angleT=angle*cos(omega*time),
        angleT2=angle*sin(omega*time-PI/2);
  posY=(offsetY-startY)*(1-cos(radians(angleT)));
  posX=(offsetY-startY)*sin(radians(angleT));
  pos2Y=(offsetY-startY)*(1-cos(radians(angleT2)));
  pos2X=(offsetY-startY)*sin(radians(angleT2));
  time+=dt; clear();
  fill(0,255,0); 
  line(offsetX,startY,offsetX+posX,offsetY-posY+startY); stroke(255,255,255);
  circle(offsetX+posX,offsetY-posY+startY,radius);
  fill(255,255,0); 
  line(offsetX,startY,offsetX+pos2X,offsetY-pos2Y+startY); stroke(255,255,255);
  circle(offsetX+pos2X,offsetY-pos2Y+startY,radius);
}
