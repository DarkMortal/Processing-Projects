import java.util.Collections;

class Cell{
  public static final int SIZE = 25;
  public int posX,posY,dValue;
  public boolean isPath;
  Cell(int a,int b){
    posX = a;
    posY = b;
    dValue = 0;
    isPath = false;
  }
  void drawCell(){
    stroke(blocked);
    if(dValue < 0) fill(blocked);
    else{
       if(posY==startY && posX==startX) fill(color(0,255,0));
       else if(posY==endY && posX==endX) fill(color(255,0,0));
       else fill(notBlocked);
    }
    rect(posX*SIZE, posY*SIZE, SIZE, SIZE, 5);
    if(isPath){
      fill(color(255,255,0));
      circle((posX+0.5)*SIZE, (posY+0.5)*SIZE, SIZE/2);
    }
    // To display the dValues
    // textSize(15); fill(color(255,255,255));
    // text(dValue, posX*SIZE+10, posY*SIZE+15);
  }
};

// Wrapper class for tuple
class tuple implements Comparable<tuple>{
    public int x,y,d;
    tuple(int a,int b,int c){
        x = a; y = b; d = c;
    }
    @Override
    int compareTo(tuple other) {
      return this.d - other.d;
    }
};

void updateAllDvalues(int x,int y,int val){   
   ArrayList<tuple> arrTuple = new ArrayList<tuple>();
   arrTuple.add(new tuple(x,y,val));
   
   while(arrTuple.size()>0){
     ArrayList<tuple> arrTuple2 = new ArrayList<tuple>();
     for(tuple t : arrTuple){
        cellArr[t.x][t.y].dValue = t.d;
        
        // Checking the eastern neighbour
        if(t.x < (xCount - 1) && cellArr[t.x+1][t.y].dValue == 0){
           // Check if the current node already exist
           boolean isPresent = false;
           for(tuple s : arrTuple2){
             isPresent = (s.x == t.x+1 && s.y == t.y && s.d == t.d+1);
             if(isPresent) break;
           }
           // Push it to stack if it's not present
           if(!isPresent) arrTuple2.add(new tuple(t.x+1,t.y,t.d+1));
        }
        
        // Checking the western neighbour
        if(t.x >= 1 && cellArr[t.x-1][t.y].dValue == 0){
           // Check if the current node already exist
           boolean isPresent = false;
           for(tuple s : arrTuple2){
             isPresent = (s.x == t.x-1 && s.y == t.y && s.d == t.d+1);
             if(isPresent) break;
           }
           // Push it to stack if it's not present
           if(!isPresent) arrTuple2.add(new tuple(t.x-1,t.y,t.d+1));
        }
        
        // Checking the northern neighbour
        if(t.y >= 1 && cellArr[t.x][t.y-1].dValue == 0){
           // Check if the current node already exist
           boolean isPresent = false;
           for(tuple s : arrTuple2){
             isPresent = (s.x == t.x && s.y == t.y-1 && s.d == t.d+1);
             if(isPresent) break;
           }
           // Push it to stack if it's not present
           if(!isPresent) arrTuple2.add(new tuple(t.x,t.y-1,t.d+1));
        }
        
        // Checking the southern neighbour
        if(t.y < (yCount - 1) && cellArr[t.x][t.y+1].dValue == 0){
           // Check if the current node already exist
           boolean isPresent = false;
           for(tuple s : arrTuple2){
             isPresent = (s.x == t.x && s.y == t.y+1 && s.d == t.d+1);
             if(isPresent) break;
           }
           // Push it to stack if it's not present
           if(!isPresent) arrTuple2.add(new tuple(t.x,t.y+1,t.d+1));
        }
        
     }
     
     arrTuple.clear();
     for(tuple s : arrTuple2){
       arrTuple.add(new tuple(s.x,s.y,s.d));
     }
     
   }
}

void refreshAllDvalues(){
  for(int i=0;i<yCount;i++){
    for(int j=0;j<xCount;j++){
      if(cellArr[j][i].dValue>0) cellArr[j][i].dValue = 0;
      cellArr[j][i].isPath = false;
    }
  }
}

void drawRetracePath(){
   int lockX = startX, lockY = startY;
   boolean noPath = false;
   ArrayList<tuple> arrTuple1 = new ArrayList<tuple>();
   
   while(!(lockX == endX && lockY == endY) && !noPath){
     arrTuple1.clear();
     // 4 way connectivity
     
     // For North
     if(lockY >= 1 && cellArr[lockX][lockY-1].dValue > 0)
       arrTuple1.add(new tuple(lockX,lockY-1,cellArr[lockX][lockY-1].dValue));
     // For South
     if(lockY < yCount-1 && cellArr[lockX][lockY+1].dValue > 0)
       arrTuple1.add(new tuple(lockX,lockY+1,cellArr[lockX][lockY+1].dValue));
     // For West
     if(lockX >= 1 && cellArr[lockX-1][lockY].dValue > 0)
       arrTuple1.add(new tuple(lockX-1,lockY,cellArr[lockX-1][lockY].dValue));
     // For East
     if(lockX < xCount-1 && cellArr[lockX+1][lockY].dValue > 0)
       arrTuple1.add(new tuple(lockX+1,lockY,cellArr[lockX+1][lockY].dValue));
          
     noPath = (arrTuple1.size() == 0);
     
     if(!noPath){
       Collections.sort(arrTuple1);
       tuple t = arrTuple1.get(0);
       cellArr[t.x][t.y].isPath = true;
       lockX = t.x; lockY = t.y;
     }
     
   }
}
