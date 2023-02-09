float x, y;

void barnsley() {
  float nextX, nextY;
  float r = random(1);
  if (r < 0.01) {
    nextX =  0;
    nextY =  0.16 * y;
  } else if (r < 0.86) {
    nextX =  0.85 * x + 0.04 * y;
    nextY = -0.04 * x + 0.85 * y + 1.6;
  } else if (r < 0.93) {
    nextX =  0.20 * x - 0.26 * y;
    nextY =  0.23 * x + 0.22 * y + 1.6;
  } else {
    nextX = -0.15 * x + 0.28 * y;
    nextY =  0.26 * x + 0.24 * y + 0.44;
  }
  x = nextX;
  y = nextY;
  
  float i, g, b;
  float px = map(x, -3, 3, 0, width);
  float py = map(y, 0, 10, height, 0);
  if (py < height/6){
    //red to yellow, green fading in
   i = 255;
   g = map(py, 0, height/6, 0, 255);
   b = 0;
  } else if (py < height/3) {
   //yellow to green, red fading out
   i = map(py, height/6, height/3, 255, 0);
   g = 255;
   b = 0;
  } else if (py < height/2) {
   //green to cyan, blue fading in
   i = 0;
   g = 255;
   b = map(py, height/3, height/2, 0, 255);
  } else if (py < height/1.5) {
   //cyan to blue, green fading out
   i = 0;
   g = map(py, height/2, height/1.5, 255, 0);
   b = 255;
  } else if (py < 4*height/3) {
   //blue to purple, red fading in
   i = map(py, height/1.5, 4*height/3, 0, 255);
   g = 0;
   b = 255;
  } else {
   // purple to red, blue fading out
   i = 255;
   g = 0;
   b = map(py, height/1.5, 4*height/3, 0, 255);
  }
  stroke(i, g, b);
  strokeWeight(0.5);
  point(px, py);
}
