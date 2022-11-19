final int offsetX = 50, offsetY = 50;

class Shape{
  public PVector[] arr;
  public PVector COM;
  public color col;
  public boolean isCollided;
  public Shape(PVector[] pArr,color c){
    arr = pArr; col = c;
    int i=0; isCollided = false;
    float x=0.0, y=0.0;
    for(i=0;i<arr.length;i++){
      x += arr[i].x;
      y += arr[i].y;
    }
    COM = new PVector(x/(float(i)),y/(float(i)));
  }
  //Using Rotations Matrices
  public void Rotate(float a){
    for(int i=0;i<arr.length;i++){
      float x = arr[i].x - COM.x;
      float y = arr[i].y - COM.y;
      arr[i].x = x*cos(a)-y*sin(a) + COM.x;
      arr[i].y = x*sin(a)+y*cos(a) + COM.y;
    }
  }
  public void translateX(float x){
    for(int i=0;i<arr.length;i++) arr[i].x += x;
    COM.x += x;
  }
  public void translateY(float y){
    for(int i=0;i<arr.length;i++) arr[i].y += y;
    COM.y += y;
  }
  public void show(){
    fill(this.isCollided?color(255,0,0):col);
    beginShape();
    for(int i=0;i<arr.length;i++)
      vertex(arr[i].x, arr[i].y);
    endShape(CLOSE);
    fill(255,255,255);
    circle(COM.x,COM.y,10);
  }
  private float[][] projectVertices(PVector[] v1, PVector[] v2, PVector axis){
     float maxA = -1e5, maxB = -1e5; //A very small value
     float minA = 1e5, minB = 1e5; //A very large value
     for(int i=0;i<v1.length;i++){
        float len = axis.dot(v1[i]);
        if(len>maxA) maxA = len;
        if(len<minA) minA = len;
     }
     for(int i=0;i<v2.length;i++){
        float len = axis.dot(v2[i]);
        if(len>maxB) maxB = len;
        if(len<minB) minB = len;
     }
     float[][] res = {
       {minA,maxA},
       {minB,maxB}
     };
     return res;
  }
  public void checkCollision(Shape sh){
    for(int i=0;i<this.arr.length;i++){
      PVector a = this.arr[i], b = this.arr[(i+1)%this.arr.length];
      PVector normal = new PVector(b.y-a.y,b.x-a.x);
      normal.x = -1.0*normal.x;
      float[][] deltaArray = projectVertices(this.arr,sh.arr,normal);
      if(deltaArray[0][0] > deltaArray[1][1] || deltaArray[1][0] > deltaArray[0][1]){
        this.isCollided = sh.isCollided = false;
        return;
      }
    }
    for(int i=0;i<sh.arr.length;i++){
      PVector a = sh.arr[i], b = sh.arr[(i+1)%sh.arr.length];
      PVector normal = new PVector(b.y-a.y,b.x-a.x);
      normal.x = -1.0*normal.x;
      float[][] deltaArray = projectVertices(this.arr,sh.arr,normal);
      if(deltaArray[0][0] > deltaArray[1][1] || deltaArray[1][0] > deltaArray[0][1]){
        this.isCollided = sh.isCollided = false;
        return;
      }
    }
    this.isCollided = sh.isCollided = true;
  }
}

Shape sh1 = new Shape(new PVector[]{
  new PVector(10,10),
  new PVector(75,120),
  new PVector(100,60),
  new PVector(60,20)
},color(0,255,255));

Shape sh2 = new Shape(new PVector[]{
  new PVector(10,10),
  new PVector(75,10),
  new PVector(75,75),
  new PVector(10,75),
},color(0,255,0));

Shape sh3 = new Shape(new PVector[]{
  new PVector(10,10),
  new PVector(75,100),
  new PVector(60,20)
},color(255,255,0));

Shape activeShape;
String activeString;

void keyPressed(){
  if (key=='L' || key=='l') activeShape.Rotate(-0.08);
  if (key=='R' || key=='r') activeShape.Rotate(0.08);
  if (key=='Q' || key=='q'){
    activeShape = sh1;
    activeString = "Quadrilateral";
  }
  if (key=='S' || key=='s'){
    activeShape = sh2;
    activeString = "Square";
  }
  if (key=='T' || key=='t'){
    activeShape = sh3;
    activeString = "Triangle";
  }
  if (key == CODED) {
    if (keyCode == UP) activeShape.translateY(-5);
    if (keyCode == DOWN) activeShape.translateY(5);
    if (keyCode == LEFT) activeShape.translateX(-5);
    if (keyCode == RIGHT) activeShape.translateX(5);
  }
  if(activeString == "Quadrilateral"){
    activeShape.checkCollision(sh2);
    boolean d = activeShape.isCollided;
    activeShape.checkCollision(sh3);
    activeShape.isCollided = activeShape.isCollided || d;
  }
  else if (activeString == "Square"){
    activeShape.checkCollision(sh1);
    boolean d = activeShape.isCollided;
    activeShape.checkCollision(sh3);
    activeShape.isCollided = activeShape.isCollided || d;
  }
  else if (activeString == "Triangle"){
    activeShape.checkCollision(sh1);
    boolean d = activeShape.isCollided;
    activeShape.checkCollision(sh2);
    activeShape.isCollided = activeShape.isCollided || d;
  }
}

void setup(){
  fullScreen();
  background(0);
  
  //Shift these shapes
  sh2.translateX(200.0);
  sh3.translateX(300.0);
  
  // Quadrilateral is initial shape
  activeShape = sh1;
  activeString = "Quadrilateral";
}

void draw(){
  clear();
  textSize(20);
  text("Selected Shape: "+activeString, 700,25);
  translate(offsetX,offsetY);
  sh1.show();
  sh2.show();
  sh3.show();
}
