class Slider {
  float defaultY;
  color areaColor;
  //SliderHandle Vars
  float timeWidth;
  float minHandleX;
  float minHandleY;
  float maxHandleX;
  float maxHandleY;
  //SliderHandle Default Positions
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
    defaultMinX=width/3;
    defaultMaxX=width/1.5;
    defaultY=height/1.15;
    areaColor=graphColor;
    
    //Init Container vars
    containerMinX=screenWidth/15;
    containerMaxX=screenWidth/1.07;
    
    //Init Handle vars
    minHandleX=defaultMinX;
    maxHandleX=defaultMaxX;
    overMin=overHandle(minHandleX,defaultY,20);
    overMax=overHandle(maxHandleX,defaultY,20);
    
    sliderContainer();
    slider();
    sliderHandles(minHandleX,maxHandleX);
  }
  
  //Slider Container
  void sliderContainer(){
    strokeWeight(10);
    stroke(200,200);
    line(containerMinX,defaultY,containerMaxX,defaultY);
  }
  
  //Slider
  void slider(){
    strokeWeight(10);
    stroke(areaColor);
    line(minHandleX,defaultY,maxHandleX,defaultY);
  }
  void sliderHandles(float minX, float maxX){
    //Handles
    //Left Handle
    stroke(100);
    strokeWeight(1);
    fill(255);
    ellipseMode(CENTER);
    ellipse(minX,defaultY,20,20);
    //Right Handle
    ellipse(maxX,defaultY,20,20);
    
    
    println(overMin);
    println(overMax);
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
 
 void mouseDragged(){
   if(overMin){
   }
 }
}