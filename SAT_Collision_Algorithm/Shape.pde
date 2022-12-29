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
     for(PVector v: v1){
        float len = axis.dot(v);
        if(len>maxA) maxA = len;
        if(len<minA) minA = len;
     }
     for(PVector v: v2){
        float len = axis.dot(v);
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
      PVector normal = new PVector(b.y-a.y,a.x-b.x);
      float[][] deltaArray = projectVertices(this.arr,sh.arr,normal);
      if(deltaArray[0][0] > deltaArray[1][1] || deltaArray[1][0] > deltaArray[0][1]){
        this.isCollided = sh.isCollided = false;
        return;
      }
    }
    for(int i=0;i<sh.arr.length;i++){
      PVector a = sh.arr[i], b = sh.arr[(i+1)%sh.arr.length];
      PVector normal = new PVector(b.y-a.y,a.x-b.x);
      float[][] deltaArray = projectVertices(this.arr,sh.arr,normal);
      if(deltaArray[0][0] > deltaArray[1][1] || deltaArray[1][0] > deltaArray[0][1]){
        this.isCollided = sh.isCollided = false;
        return;
      }
    }
    this.isCollided = sh.isCollided = true;
  }
}
