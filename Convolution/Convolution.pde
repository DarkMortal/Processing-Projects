PImage img;

// Convolution Matrix
/*float[][] c_matrix = {
  {0.25,0.00,-0.25},
  {0.50,0.00,-0.50},
  {0.25,0.00,-0.25}
};*/

/*float[][] c_matrix = {
  {1.0/9.0,1.0/9.0,1.0/9.0},
  {1.0/9.0,1.0/9.0,1.0/9.0},
  {1.0/9.0,1.0/9.0,1.0/9.0}
};*/

float[][] c_matrix = {
  {0.0,0.0,-0.2,0.0,0.0},
  {0.0,-0.2,-0.5,-0.2,0.0},
  {-0.2,-0.5,5.0,-0.5,-0.2},
  {0.0,-0.2,-0.5,-0.2,0.0},
  {0.0,0.0,-0.2,0.0,0.0}
};

void setup(){
  img = loadImage("Shivaji.jpg");
  int h = c_matrix.length >> 1;
  size(375,657);
  loadPixels();
  img.loadPixels();
  for(int x=0;x<width;x++){
    for(int y=0;y<height;y++){
      
      //float rgb = 0.0;
      float r = 0, g = 0, b = 0;
            
      //This for loop is for Convolution Matrix
      for(int i=0;i<c_matrix.length;i++){
        for(int j=0;j<c_matrix[i].length;j++){
          int transformedX = x-h+j;
          int transformedY = y-h+i;
          if( transformedX >= 0 && transformedX < width &&
              transformedY >= 0 && transformedY < height){
                
                r += c_matrix[i][j]*red(img.pixels[transformedX+transformedY*width]);
                g += c_matrix[i][j]*green(img.pixels[transformedX+transformedY*width]);
                b += c_matrix[i][j]*blue(img.pixels[transformedX+transformedY*width]);
                
                //rgb += c_matrix[i][j]*img.pixels[transformedX+transformedY*width];
          }
        }
      }
 
     //pixels[x+y*width] = (rgb>=0)?color(0,0,255):color(255,0,0);  
      pixels[x+y*width] = color(r,g,b);           
    }
  }
  updatePixels();
  save("./IMG.png");
}
