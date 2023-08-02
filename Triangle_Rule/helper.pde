final float radius = 10.0;
PVector p1, p2, p3;
PVector centroid;

final float offSetY = 20;
final float offSetX = 500;

final float pixelCm = 0.0264583333;

float roundOff(float x,int n){
  float a = pow(10,n);
  float b = round(x*a);
  return b/a;
}

float PixelToCm(float x){
  return x*pixelCm;
}

float Area(float[][] matrix){
  float sum = 0.0;
  sum += (matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0]);
  sum += (matrix[1][0] * matrix[2][1] - matrix[1][1] * matrix[2][0]);
  sum -= (matrix[0][0] * matrix[2][1] - matrix[2][0] * matrix[0][1]);
  sum *= pixelCm;
  sum *= pixelCm;
  return abs(sum)/2;
}
