void setup() {
  fullScreen();
  p1 = new PVector(random(offSetX, width), random(0, height));
  p2 = new PVector(random(offSetX, width), random(0, height));
  p3 = new PVector(random(offSetX, width), random(0, height));
  centroid = new PVector((p1.x + p2.x + p3.x) / 3, (p1.y + p2.y + p3.y) / 3);
}

void draw() {
  clear();
  background(0);
  fill(255);
  textSize(25);

  // draw the points
  fill(255);
  ellipse(p1.x, p1.y, radius, radius);
  ellipse(p2.x, p2.y, radius, radius);
  ellipse(p3.x, p3.y, radius, radius);
  ellipse(centroid.x, centroid.y, radius, radius);

  float AB = PixelToCm(p1.dist(p2)),
    AC = PixelToCm(p1.dist(p3)),
    BC = PixelToCm(p2.dist(p3));

  float angle1 = PVector.angleBetween(new PVector(p2.x - p1.x, p2.y - p1.y), new PVector(p3.x - p1.x, p3.y - p1.y));
  float angle2 = PVector.angleBetween(new PVector(p1.x - p2.x, p1.y - p2.y), new PVector(p3.x - p2.x, p3.y - p2.y));
  float angle3 = PVector.angleBetween(new PVector(p1.x - p3.x, p1.y - p3.y), new PVector(p2.x - p3.x, p2.y - p3.y));

  fill(255);
  rect(0, 0, offSetX, height);
  fill(0);
  // angle sum property
  text("Sum of angles = " + roundOff(degrees(angle1 + angle2 + angle3), 0), 10, 25 + offSetY);
  // sides
  text("AB = " + roundOff(AB, 2) + " cm\nBC = " + roundOff(BC, 2) + " cm\nCA = " + roundOff(AC, 2)+" cm", 10, 60 + offSetY);

  // sine law
  textSize(20);
  text("Sine Law", 10, 200 + offSetY);
  textSize(25);
  text("sin(A)/BC = " + roundOff(sin(angle1) / BC, 3) + "\nsin(B)/CA = " + roundOff(sin(angle2) / AC, 3) + "\nsin(C)/AB = " + roundOff(sin(angle3) / AB, 3), 10, 230 + offSetY);

  // cosine law
  textSize(20);
  text("Cosine Law", 10, 400 + offSetY);
  textSize(25);
  text("(AB)² = " + roundOff(AB * AB, 2) + "\n(BC)² + (CA)² - 2*BC*CA*cos(C) = " + roundOff(BC * BC + AC * AC - 2 * BC * AC * cos(angle3), 3), 10, 430 + offSetY);
  text("(BC)² = " + roundOff(BC * BC, 2) + "\n(AB)² + (CA)² - 2*AB*CA*cos(A) = " + roundOff(AB * AB + AC * AC - 2 * AB * AC * cos(angle1), 3), 10, 530 + offSetY);
  text("(CA)² = " + roundOff(AC * AC, 2) + "\n(AB)² + (BC)² - 2*AB*BC*cos(B) = " + roundOff(AB * AB + BC * BC - 2 * AB * BC * cos(angle2), 3), 10, 630 + offSetY);

  // marking the points
  fill(255, 0, 0);
  text("A = " + roundOff(degrees(angle1), 3) + "°", p1.x + 3, p1.y - 3);
  text("B = " + roundOff(degrees(angle2), 3) + "°", p2.x + 3, p2.y - 3);
  text("C = " + roundOff(degrees(angle3), 3) + "°", p3.x + 3, p3.y - 3);

  // draw the triangle
  stroke(255);
  line(p1.x, p1.y, p2.x, p2.y);
  line(p2.x, p2.y, p3.x, p3.y);
  line(p3.x, p3.y, p1.x, p1.y);
}

char selectedPoint = '0';

void mousePressed() {
  float d = dist(p1.x, p1.y, mouseX, mouseY);
  if (d <= radius) selectedPoint = '1';

  d = dist(p2.x, p2.y, mouseX, mouseY);
  if (d <= radius) selectedPoint = '2';

  d = dist(p3.x, p3.y, mouseX, mouseY);
  if (d <= radius) selectedPoint = '3';

  d = dist(centroid.x, centroid.y, mouseX, mouseY);
  if (d <= radius) selectedPoint = 'g';
}

void mouseReleased() {
  selectedPoint = '0';
  if (p1.x < offSetX) p1.x = offSetX;
  if (p2.x < offSetX) p2.x = offSetX;
  if (p3.x < offSetX) p3.x = offSetX;
  if (centroid.x < offSetX) centroid.x = offSetX;
}

void mouseDragged() {
  if (p1.x >= offSetX && p2.x >= offSetX && p3.x >= offSetX) {
    switch (selectedPoint) {
      case '1': {
        p1.x = mouseX;
        p1.y = mouseY;
        break;
      }
      case '2': {
        p2.x = mouseX;
        p2.y = mouseY;
        break;
      }
      case '3': {
        p3.x = mouseX;
        p3.y = mouseY;
        break;
      }
      case 'g': {
        p1.x += (mouseX - pmouseX);
        p1.y += (mouseY - pmouseY);

        p2.x += (mouseX - pmouseX);
        p2.y += (mouseY - pmouseY);

        p3.x += (mouseX - pmouseX);
        p3.y += (mouseY - pmouseY);

        centroid.x = mouseX;
        centroid.y = mouseY;

        break;
      }
    }
    if (selectedPoint == '1' || selectedPoint == '2' || selectedPoint == '3') {
      centroid.x = (p1.x + p2.x + p3.x) / 3;
      centroid.y = (p1.y + p2.y + p3.y) / 3;
    }
  }
}
