void setup() {
  size(500,650);
  surface.setTitle("Barnsley Fern");
  background(0);
}

void draw() {
  for (int i = 0; i < 10000; i++) {
    barnsley();
  }
}
