final float radius = 10.0;

PVector p, p1, p2, p3;

PVector centroid;

void setup(){
  size(600,500);
  surface.setTitle("Point Inside Triangle");
  p = new PVector(random(0,width), random(0,height));
  p1 = new PVector(random(0,width), random(0,height));
  p2 = new PVector(random(0,width), random(0,height));
  p3 = new PVector(random(0,width), random(0,height));
  centroid = new PVector((p1.x+p2.x+p3.x)/3,(p1.y+p2.y+p3.y)/3);
  
  cay = p3.y - p1.y;
  cax = p3.x - p1.x;
  bax = p2.x - p1.x;
  bay = p2.y - p1.y;
  den = bay * cax - bax * cay;
  
  isInsideTriangle();
}

void draw(){
  clear();
  background(0);
  
  fill(255);
  textSize(25);
  text("W1 = "+w1, 10, 25);
  text("W2 = "+w2, 10, 60);
  
  text((isInside)?"Inside":"Outside", 250, 60);
  
  // draw the points
  fill((isInside)?(color(0,255,0)):color(255,0,0));
  ellipse(p.x, p.y, radius, radius);
  fill(255);
  ellipse(p1.x, p1.y, radius, radius);
  ellipse(p2.x, p2.y, radius, radius);
  ellipse(p3.x, p3.y, radius, radius);
  ellipse(centroid.x, centroid.y, radius, radius);
  
  // marking the points
  fill(255,0,0);
  text('P',p.x+3, p.y-3);
  text('A',p1.x+3, p1.y-3);
  text('B',p2.x+3, p2.y-3);
  text('C',p3.x+3, p3.y-3);
  
  // draw the triangle
  stroke(255);
  line(p1.x, p1.y, p2.x, p2.y);
  line(p2.x, p2.y, p3.x, p3.y);
  line(p3.x, p3.y, p1.x, p1.y);
}

boolean isInside = false;
char selectedPoint = '0';

void mousePressed(){
  float d = dist(p1.x, p1.y, mouseX, mouseY);
  if(d <= radius) selectedPoint = '1';
  
  d = dist(p2.x, p2.y, mouseX, mouseY);
  if(d <= radius) selectedPoint = '2';
  
  d = dist(p3.x, p3.y, mouseX, mouseY);
  if(d <= radius) selectedPoint = '3';
  
  d = dist(p.x, p.y, mouseX, mouseY);
  if(d <= radius) selectedPoint = 'p';
  
  d = dist(centroid.x, centroid.y, mouseX, mouseY);
  if(d <= radius) selectedPoint = 'g';
}

void mouseReleased(){
  selectedPoint = '0';
}

void mouseDragged(){
  switch(selectedPoint){
    case '1':{
      p1.x = mouseX;
      p1.y = mouseY;
      break;
    }
    case '2':{
      p2.x = mouseX;
      p2.y = mouseY;
      break;
    }
    case '3':{
      p3.x = mouseX;
      p3.y = mouseY;
      break;
    }
    case 'p':{
      p.x = mouseX;
      p.y = mouseY;
      break;
    }
    case 'g':{
      p1.x += (mouseX - pmouseX);
      p1.y += (mouseY - pmouseY);
      
      p2.x += (mouseX - pmouseX);
      p2.y += (mouseY - pmouseY);
      
      p3.x += (mouseX - pmouseX);
      p3.y += (mouseY - pmouseY);
      
      break;
    }
  }
  
  if(selectedPoint != 'o' && selectedPoint != 'p'){
    centroid.x = (p1.x+p2.x+p3.x)/3;
    centroid.y = (p1.y+p2.y+p3.y)/3;
    
    cay = p3.y - p1.y;
    cax = p3.x - p1.x;
    bax = p2.x - p1.x;
    bay = p2.y - p1.y;
    den = bay * cax - bax * cay;
    
    isInsideTriangle();
  }
  
  if(selectedPoint == 'p') isInsideTriangle();
}
