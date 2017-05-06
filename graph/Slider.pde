class Slider {
  float defaultY;
  color areaColor;
  //SliderHandle Vars
  float timeWidth;
  float minHandleX;
  float maxHandleX;
  float minOffSetX;
  float maxOffSetX;
  float defaultMinX;
  float defaultMaxX;
  boolean overMin;
  boolean overMax;
  //Slider Container vars
  float containerMinX;
  float containerMinY;
  float containerMaxX;
  float containerMaxY;
  float screenWidth;
  float screenHeight;
  
  Slider(float width,float height,color graphColor) {
    screenWidth=width;
    screenHeight=height;
     
    //Default vars
    defaultY=height/1.15;
    areaColor=graphColor;
    
    //Init Container vars
    containerMinX=100;
    containerMaxX=1000;
    
    //Init Handle vars
    maxHandleX=containerMaxX;
    minHandleX=containerMinX;
    
    //Slider Init
    minOffSetX=0;
    maxOffSetX=0;
  }
  
  void draw(color gColor){
    overMin=overHandle(minHandleX,defaultY,20);
    overMax=overHandle(maxHandleX,defaultY,20);
    sliderContainer();
    slider(gColor);
    sliderHandles(minHandleX,maxHandleX);
  }
  
  //Slider Container
  void sliderContainer(){
    strokeWeight(10);
    stroke(200,200);
    line(containerMinX,defaultY,containerMaxX,defaultY);
  }
  //Slider
  void slider(color sliderColor){
    strokeWeight(10);
    stroke(sliderColor);
    line(minHandleX,defaultY,maxHandleX,defaultY);
  }
  //Slider Handles
  void sliderHandles(float minX,float maxX){
    //Handles
    //Left Handle
    stroke(100);
    strokeWeight(1);
    fill(255);
    ellipseMode(CENTER);
    ellipse(minX,defaultY,20,20);
    //Right Handle
    ellipse(maxX,defaultY,20,20);
  }
  
  boolean overHandle(float x, float y, float diameter){
    float disX = x - mouseX;
    float disY = y - mouseY;
    
    if (sqrt (sq(disX) +sq(disY)) < diameter) {
      return true;
    } else{
      return false;
    }
 }
}