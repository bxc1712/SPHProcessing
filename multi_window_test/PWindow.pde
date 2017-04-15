
class PWindow extends PApplet {
  int[] colors = new int[3];
  int num;
  PWindow(int[] Colors, int Num) {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
    colors = Colors;
    println(colors);
    num = Num;
  }

  void settings() {
    fullScreen(num);
  }

  void setup() {
    background(colors[0], colors[1], colors[2]);
    
  }

  void draw() {
    textSize(32);
    text(num, 10, 30); 
    textAlign(CENTER, CENTER);
    fill(0, 102, 153);
  }

  void mousePressed() {
    background(random(255));
    println("mousePressed in secondary window");
  }
}