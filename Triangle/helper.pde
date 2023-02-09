float w1 = 0.0;
float w2 = 0.0;

float cay = 0.0;
float cax = 0.0;
float bax = 0.0;
float bay = 0.0;

float den = bay * cax - bax * cay;

void isInsideTriangle(){
  w1 = (p1.x * cay + (p.y - p1.y) * cax - p.x * cay) / den;
  w2 = (p.y - p1.y - w1 * bay) / cay;
  
  isInside = (w1 + w2) <= 1.0 && w1 >= 0.0 && w2 >= 0.0;
}
