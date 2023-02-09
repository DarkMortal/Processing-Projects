class Grid{
  int x,y;
  public boolean isSnake, isFood, isSnakeHead;
  public char direction;
  Grid(int a,int b){
    this.x = a;
    this.y = b;
    this.isSnake = this.isFood = this.isSnakeHead = false;
    this.direction = 'O';
  }
  void drawCell(){
    if(this.isSnakeHead){ stroke(255); fill(color(0,0,255)); }
    else if(this.isSnake){ stroke(255); fill(color(255,0,0)); }
    else if(this.isFood){ stroke(255); fill(color(255,255,0)); }
    // else if(this.direction == 'O'){ noStroke(); fill(color(0,255,0)); }
    else{ fill(color(0,255,0)); noStroke(); }
    rect(x*size,y*size,size,size);
  }
};

void drawGrid(){
  for(int i=0;i<yRange;i++){
    for(int j=0;j<xRange;j++){
      grid[i][j].drawCell();
    }
  }
}

void resetGrid(){
  for(int i=0;i<yRange;i++){
    for(int j=0;j<xRange;j++){
      grid[i][j].isSnake = grid[i][j].isFood = grid[i][j].isSnakeHead = false;
    }
  }
}

void makeFood(){
  foodX = floor(random(xRange));
  foodY = floor(random(yRange));
  if(grid[foodY][foodX].isFood || grid[foodY][foodX].isSnake) makeFood();
  else grid[foodY][foodX].isFood = true;
}
