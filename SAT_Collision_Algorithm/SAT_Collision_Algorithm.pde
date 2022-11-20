final int offsetX = 50, offsetY = 50;

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
