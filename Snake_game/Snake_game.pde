int size = 20;
int xRange = 20, yRange = 30;

int foodX = 0, foodY = 0;

Snake s;
Grid[][] grid;

void setup(){                      
  size(600,600);
  surface.setTitle("Snake Game");
  
  grid = new Grid[yRange][xRange];
  
  for(int i=0;i<yRange;i++){
    for(int j=0;j<xRange;j++){
      grid[i][j] = new Grid(j,i);
      grid[i][j].drawCell();
    }
  }
  
  s = new Snake(5,10);
  makeFood();
}

boolean isPrinted = false;
boolean isOver = false;

void draw(){  
  if(isOver){
    if(!isPrinted){
      fill(255,0,0);
      text("Game Over", 450, 160);
      isPrinted = true;
    }
  }
  else{
    clear();
    background(0);
    stroke(255);
    line(400,0,400,600);
    fill(255);
    textSize(20);
    text("Score", 450, 100);
    text(s.getScore(), 450, 130);
    s.move();
    s.drawSnake();
  }
}

void keyPressed(){
  if (key == CODED) {
    tuple t = s.state.get(0);
    if(isValidRange(t.x, t.y)){
      
      if(t.delY== 0){
        if (keyCode == UP) grid[t.y][t.x].direction = 'U';
        else if (keyCode == DOWN) grid[t.y][t.x].direction = 'D';
      }
      
      if(t.delX == 0){
        if (keyCode == LEFT) grid[t.y][t.x].direction = 'L';
        if (keyCode == RIGHT) grid[t.y][t.x].direction = 'R';
      }
      
    }
  }
}
