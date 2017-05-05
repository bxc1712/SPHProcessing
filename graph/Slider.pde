class Slider {
  boolean overHandle = false;
  float sliderWidth;
  float handleHeight;
  //Slider Container vars
  float containerWidth;
  float screenWidth;
  float screenHeight;
  
  Slider(float width,float height) {
    screenWidth=width;
    screenHeight=height;
    
    //Slider Container
    line(screenWidth/3,screenHeight/12,screenWidth/9,screenHeight/12);
  }
  
  void mousePressed(){
    if(overHandle){
      
    }
  }
}