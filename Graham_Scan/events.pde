void mouseClicked(){
  if(!isSet){
    points.add(new Point(mouseX,mouseY));
    for(Point p:points){
      if(base.pos.y < p.pos.y) base = p;
    }
    for(Point p:points){
      p.updateAngle();
    }
    Collections.sort(points);
  }
}

Point getPoint(int x){
  return points.get(x % points.size());
}

void drawHull(){
  fill(255,0,255);
  stroke(255,0,0);
  beginShape();
  for(Point p:convexHull) vertex(p.pos.x, p.pos.y);
  endShape();
  stroke(255);
}

void grahamScan(){
  for(int i=0;i<points.size();i++){
    while( convexHull.size()>2 && !checkCC(
      convexHull.get(convexHull.size()-2).pos, 
      convexHull.get(convexHull.size()-1).pos, 
      points.get(i).pos )) convexHull.remove(convexHull.size()-1);
    convexHull.add(points.get(i));
  }
}

void keyPressed(){
  if((key == 's' || key == 'S') && !isSet){
    convexHull.add(points.get(0));
    convexHull.add(points.get(1));
    // grahamScan(2);
    grahamScan();
    isSet = true;
  }
  if(key == 'r' || key == 'R'){
    base.pos.x = 0;
    base.pos.y = 0;
    points.clear();
    convexHull.clear();
    isSet = false;
  }
}
