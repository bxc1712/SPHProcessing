PWindow win1;
PWindow win2;

public void settings() {
  size(320, 240);
}

void setup() { 
  int[] colors = new int[3];
  int num = 1;
  colors[0] = 255;
  colors[1] = 0;
  colors[2] = 0;
  win1 = new PWindow(colors, num);
  
  num++;
  colors[0] = 0;
  colors[1] = 0;
  colors[2] = 255;
  win2 = new PWindow(colors, num);
}

void draw() {
  background(255, 0, 0);
  fill(255);
  rect(10, 10, frameCount, 10);
}

void mousePressed() {
  println("mousePressed in primary window");
}  

void keyPressed(){
  if(key == 27){
    exit();
  }
}