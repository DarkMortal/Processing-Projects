import processing.sound.*;
float offsetX=700,
      radius=25,
      offsetY=650;

SoundFile file;

float gravity=10,
      dt=0.1,
      factor=sqrt(2),
      launchAngle=45;

class Ball{
  public float len,velocity;
  public color fill;
  public float time=0;
  private boolean isRight=true;
  private float thisOffsetX=offsetX,Vx,Vy;
  public float posX=0,posY=0;
  public Ball(float a,color c){
    len=a; fill=c; 
    velocity=sqrt(2*gravity*len/factor);
    Vy=velocity*sin(radians(launchAngle));
    Vx=velocity*cos(radians(launchAngle));
  }
  public void Draw(){
    fill(fill);
    stroke(0,0,0);
    circle(thisOffsetX+posX+len/factor,offsetY-posY-len/factor,radius);
  }
  public void Update(){
    if(posX>=(2*len/factor)){
      thisOffsetX=offsetX;
      posX=posY=time=0; isRight=true;
      file.play();
    }
    else if(posX<=(len/factor)*(-2)){
      thisOffsetX=offsetX-2*len/factor;
      posX=posY=time=0; isRight=false;
      file.play();
    }
    time+=dt;
    posX=(isRight)?(Vx*time*(-1)):(Vx*time);
    posY=Vy*time-(gravity/2)*time*time;
    Draw();
  }
}

Ball balls[]={new Ball(500,color(255,0,0)),
              new Ball(450,color(255,255,0)),
              new Ball(400,color(0,255,0)),
              new Ball(350,color(0,255,255)),
              new Ball(300,color(255,255,0)),
              new Ball(250,color(0,255,0)),
              new Ball(200,color(255,0,255))};

void drawCircles(){
  for(int i=0;i<7;i++) balls[i].Update();
}

void drawLine(float x1,float y1,float angle,float l){
  if(angle==90) line(x1,y1,x1,y1-l);
  else if(angle==-90) line(x1,y1,x1,y1+l);
  else{
    float m=tan(radians(abs(angle))),
    x2=(m>=0)?(x1+l/sqrt(1+m*m)):(x1-l/sqrt(1+m*m)),
    y2=y1+m*(x1-x2);
    line(x1,y1,x2,y2);
  }
} 

void setup(){
  fullScreen();
  surface.setTitle("Bouncing Balls 2");
  surface.setResizable(false);
  background(0);
  file = new SoundFile(this,"Bounce.aiff");
}

void draw(){
  clear();
  drawCircles();
  stroke(255,255,255);
  drawLine(offsetX,offsetY,45,600); 
  drawLine(offsetX,offsetY,45+90,600);
}
