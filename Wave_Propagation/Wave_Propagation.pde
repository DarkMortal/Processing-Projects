// All global scoped variables
final int xCount = 20, yCount = 20;
final color blocked = color(1,33,72), notBlocked = color(0,0,255);
int startX = 5, endX = 10, startY = 5, endY = 15;
Cell[][] cellArr = new Cell[xCount][yCount];

void setup(){
  size(500,500);
  startX = getInt("Enter start x coordinate");
  startY = getInt("Enter start y coordinate");
  endX = getInt("Enter end x coordinate");
  endY = getInt("Enter end y coordinate");
  
  for(int i=0;i<yCount;i++){
    for(int j=0;j<xCount;j++){
      cellArr[j][i] = new Cell(j,i);
      //cellArr[j][i].drawCell();
    }
  }
  updateAllDvalues(endX,endY,1);
  drawRetracePath();
}

void mouseClicked() {
   int a = mouseX/Cell.SIZE;
   int b = mouseY/Cell.SIZE;
   if(!((a==startX && b==startY) || (a==endX && b==endY))){
     refreshAllDvalues();
     
     if(mouseButton == LEFT) cellArr[a][b].dValue = -1;
     else if(mouseButton == RIGHT) cellArr[a][b].dValue = 0;
     
     refreshAllDvalues();
     updateAllDvalues(endX,endY,1);
     drawRetracePath();
   }
}

void draw(){
  clear();
  background(blocked);
  for(int i=0;i<yCount;i++){
    for(int j=0;j<xCount;j++){
      cellArr[j][i].drawCell();
    }
  }
}
