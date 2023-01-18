import processing.javafx.*;

Grid mesh;
void setup() {
  fullScreen(FX2D);
  mesh = new Grid(new PVector(192, 108), 10);
}
void draw() {
  background(0);
  mesh.update();
  mesh.display();
}
void keyPressed(){
  if(key == 'q'){
    exit();
  }
}
