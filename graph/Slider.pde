class Slider {
  boolean overButton = false;
  float bWidth;
  float bHeight;
  
  Slider(float x, float y, float width, float height) {
  }
  
  boolean overButton(int x, int y, float width, float height)  {
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }
  
  void mousePressed(){
    if(overButton){
      
    }
  }
}