float l=500,b=600;

float radius = 20,
      e=0.66,  //Coefficient of restitution
      d=1.225,  //Density of Air
      el=1000,  //Elasticity of the ball
      height_of_ground=40,
      offsetX = l/2,
      offsetY = b-height_of_ground;

float Vi=120,
      mass=5,
      gravity=10,
      H_max=(Vi*Vi)/(2*gravity);

float H=0 , dt=0.055 , t=0 , strainX=0 , strainY=0;

void setup(){
  size(500,600);
  surface.setTitle("Bouncing Ball");
  surface.setResizable(false);
  Vi=getFloat("Enter the velocity of the ball in (m/s)");
  e=getFloat("Enter the coefficient of restitution");
  el=getFloat("Enter the elasticity of the ball");
}

void draw(){
  clear();
  background(50,90,100);
  fill(50,150,100);
  rect(0,offsetY,width,height_of_ground);
  t+=dt;
  strainX=0;
  float H0=(Vi*t-(gravity/2)*t*t),v=Vi-gravity*t;
  strainY=sqrt((d*v*v)/el);
  if(H0>=0) H=H0;
  else{
    t=0;
    float energy=Vi*Vi;
    Vi*=e;
    energy-=(Vi*Vi);
    strainX=sqrt(mass*energy/el);
  }
  fill(0,255,0);
  ellipse(offsetX,offsetY-H-radius+10,radius+strainX,radius+strainY);
}
