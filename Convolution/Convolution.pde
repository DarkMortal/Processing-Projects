PImage img;

// Convolution Matrix
float[][] c_matrix = {
  {0.25,0.00,-0.25},
  {0.50,0.00,-0.50},
  {0.25,0.00,-0.25}
};
/*float[][] c_matrix = {
  {1.0/9.0,1.0/9.0,1.0/9.0},
  {1.0/9.0,1.0/9.0,1.0/9.0},
  {1.0/9.0,1.0/9.0,1.0/9.0}
};*/

void setup(){
  img = loadImage("Face.jpg");
  //colorMode(RGB);
  //img = loadImage("Might Guy.jpg");
  int h = c_matrix.length >> 1;
  size(504,360);
  //size(400,322);
  loadPixels();
  img.loadPixels();
  for(int x=0;x<width;x++){
    for(int y=0;y<height;y++){
      
      float r = 0, g = 0, b = 0;
      //float rgb = 0.0;
      
      //This for loop is for Convolution Matrix
      for(int i=0;i<c_matrix.length;i++){
        for(int j=0;j<c_matrix[i].length;j++){
          int transformedX = x-h+j;
          int transformedY = y-h+i;
          if( transformedX >= 0 && transformedX < width &&
              transformedY >= 0 && transformedY < height){
                
                //if(x==0 && y==1) println(i,j);
                r += c_matrix[i][j]*red(img.pixels[transformedX+transformedY*width]);
                g += c_matrix[i][j]*green(img.pixels[transformedX+transformedY*width]);
                b += c_matrix[i][j]*blue(img.pixels[transformedX+transformedY*width]);
                //float t = c_matrix[i][j];
                //println(t);
                //rgb += c_matrix[i][j]*img.pixels[transformedX+transformedY*width];
                //println(rgb);
          }
        }
      }
      //println(rgb);     
      
      pixels[x+y*width] = color(r,g,b);
            
    }
  }
  updatePixels();
}
