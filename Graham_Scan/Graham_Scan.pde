// lines marked with # are used for debugging

void setup(){
  size(500,500);
  surface.setTitle("Graham Scan");
  points = new ArrayList<Point>();
  convexHull = new ArrayList<Point>();
  base = new Point(0,0);
}

void draw(){
  clear();
  background(0);
  drawHull();
  for(Point p:points){
    fill(255);
    p.updateAngle();
    ellipse(p.pos.x,p.pos.y,Point.radius,Point.radius);
    /* # fill(0,255,0);
       # textSize(20);
       # text(i+1,p.pos.x,p.pos.y); */
  }
  // # fill(255,0,0);
  // # ellipse(base.pos.x,base.pos.y,Point.radius,Point.radius);
}
