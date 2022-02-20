float radius=20,
      offsetX=radius,offsetY=600,
      posX=0,posY=0,
      gravity=1*10,
      velocity=0,angle=0,time=0;  //Velocity of the ball must be greater than it's radius
      
float Vx=0,Vy=0,maxTime=0;

void setup(){
  fullScreen();
  surface.setTitle("Projectile Motion");
  surface.setResizable(false);
  background(0,0,0); fill(0,255,0);
  velocity=radius*getFloat("Enter the velocity of the ball in (m/s)");
  angle=getFloat("Enter the launch angle in degrees");
  Vx=velocity*cos(radians(angle));
  Vy=velocity*sin(radians(angle));
  maxTime=2*Vy/gravity;
}

void draw(){
  clear();
  ellipse(offsetX+posX,offsetY-posY,radius,radius);
  if(time<maxTime){
    time+=0.05;
    posX=Vx*time;
    posY=Vy*time-(gravity/2)*time*time;
  }
  //println(time,Vx,Vy);
}
