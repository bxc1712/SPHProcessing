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
    containerMinX=width/50;
    containerMaxX=width/1.02;
    
    //Init Handle vars
    maxHandleX=containerMaxX;
    minHandleX=containerMinX;
    
    //Slider Init
    defaultMinX=width/3;
    defaultMaxX=width/1.5;
    minOffSetX=0;
    maxOffSetX=0;
  }
  
  void draw(color gColor){
    overMin=overHandle(minHandleX,defaultY,20);
    overMax=overHandle(maxHandleX,defaultY,20);
    sliderContainer();
    slider(gColor);
    sliderHandles(minHandleX,maxHandleX,gColor);
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
  void sliderHandles(float minX,float maxX, color area){
    //Handles
    //Left Handle
    noStroke();
    rectMode(CORNERS);
    fill(area,25);
    rect(minX,defaultY,maxX,height/1.75);
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