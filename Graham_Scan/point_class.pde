import java.util.Collections;

Point base;
float inf = 1e6; // will be used as infinity

// wrapper class for PVector
class Point implements Comparable<Point>{
   static final int radius = 10;
   PVector pos;
   float angle;
   Point(float a,float b){
     this.pos = new PVector(a,b);
   }
   void updateAngle(){
     float delX = this.pos.x - base.pos.x;
     float delY = this.pos.y - base.pos.y;
     this.angle = abs(degrees(atan2(delY,delX)));
     // # line(base.pos.x, base.pos.y, base.pos.x + 200, base.pos.y);
     // # line(this.pos.x, this.pos.y, base.pos.x, base.pos.y);
   }
   @Override
   int compareTo(Point other) {
     return (int)(this.angle - other.angle);
   }
}

boolean isSet = false;
ArrayList<Point> points;
ArrayList<Point> convexHull;

boolean checkCC(PVector p1,PVector p2,PVector p3){
  float m = (p3.y - p2.y)*(p2.x - p1.x) - (p2.y - p1.y)*(p3.x - p2.x);
  return m <= 0;
}

/*boolean grahamScan(int head){
  if(head >= points.size()+1 ) return true;
  boolean check = checkCC(
    convexHull.get(convexHull.size()-2).pos, 
    convexHull.get(convexHull.size()-1).pos, 
    getPoint(head).pos 
  );
  if( !check ){
    if(convexHull.size() > 2) convexHull.remove(convexHull.size()-1);
    int index = head;
    while( ! checkCC(
      convexHull.get(convexHull.size()-2).pos, 
      convexHull.get(convexHull.size()-1).pos, 
      getPoint(index).pos )) index++; 
    convexHull.add( getPoint( index ) );
    return grahamScan( index + 1 );
  }else{
    convexHull.add( getPoint( head ) );
    return grahamScan( head + 1 );
  }
}*/
