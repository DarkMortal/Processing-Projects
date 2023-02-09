class tuple{
  public int x,y;
  public int delX, delY;
  tuple(){
    x = y = 0;
    delX = 1; delY = 0;
  }
  void update(){
    this.x += this.delX;
    this.y += this.delY;
  }
}

boolean isValidRange(int x,int y){
  boolean a = x < xRange && y < yRange;
  boolean b = x >= 0 && y >= 0;
  return a && b;
}

class Snake{
  int startX, startY;
  public int score = 0;
  public ArrayList<tuple> state;
  public ArrayList<tuple> extended;
  private boolean nextCycle;
  Snake(int a,int b){
    startX = a;
    startY = b;
    nextCycle = false;
    
    state = new ArrayList<tuple>();
    extended = new ArrayList<tuple>();
    state.add(new tuple());
    
    state.get(0).x = startX;
    state.get(0).y = startY;
  }
  void move(){
    if(nextCycle){
      tuple t = extended.get(extended.size()-1);
      t.delX = state.get(state.size()-1).delX;
      t.delY = state.get(state.size()-1).delY;
      state.add(t);
      extended.remove(extended.size()-1);
      nextCycle = false;
    }
    boolean hasEaten = state.get(0).x == foodX && state.get(0).y == foodY;
    if(hasEaten){
      int X = state.get(state.size()-1).x;
      int Y = state.get(state.size()-1).y;
      extended.add(new tuple());
      extended.get(extended.size()-1).x = X;
      extended.get(extended.size()-1).y = Y;
      extended.get(extended.size()-1).delX = 0;
      makeFood();
    }
    delay(200);
    
    for(int i=0;i<state.size();i++){
      switch(grid[state.get(i).y][state.get(i).x].direction){
        case 'U': {
            state.get(i).delX = 0;
            state.get(i).delY = -1;
            break;
        }
        case 'D': {
            state.get(i).delX = 0;
            state.get(i).delY = 1;
            break;
        }
        case 'R': {
            state.get(i).delX = 1;
            state.get(i).delY = 0;
            break;
        }
        case 'L': {
            state.get(i).delX = -1;
            state.get(i).delY = 0;
            break;
        }
        default: break;
      }
      if(i==state.size()-1) 
         grid[state.get(i).y][state.get(i).x].direction = 'O';
      state.get(i).update();
    }
    nextCycle = hasEaten;
  }
  void drawSnake(){
    resetGrid();
    grid[foodY][foodX].isFood = true;
    isOver = !isValidRange(state.get(0).x, state.get(0).y);
    if(!isOver){
      for(int i=0;i<state.size();i++){
        if(i == 0) grid[state.get(i).y][state.get(i).x].isSnakeHead = true;
        isOver = grid[state.get(i).y][state.get(i).x].isSnake;
        if(!isOver) grid[state.get(i).y][state.get(i).x].isSnake = true;
        else break;
      }
    }
    drawGrid();
  }
  int getScore(){ return state.size()-1; }
}
