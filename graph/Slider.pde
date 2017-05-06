class Slider {
  float defaultY;
  color areaColor;
  //SliderHandle Vars
  float timeWidth;
  float minHandleX;
  float maxHandleX;
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
  
  Slider(float width,float height,color graphColor,float leftHandleX,float rightHandleX) {
    screenWidth=width;
    screenHeight=height;
     
    //Default vars
    defaultY=height/1.15;
    areaColor=graphColor;
    
    //Init Container vars
    containerMinX=screenWidth/15;
    containerMaxX=screenWidth/1.07;
    
    //Init Handle vars
    minHandleX=leftHandleX;
    maxHandleX=rightHandleX;
    overMin=overHandle(minHandleX,defaultY,20);
    overMax=overHandle(maxHandleX,defaultY,20);
    
    //Call func to make whole slider
    
  }
  
  void draw(color gColor){
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
    stroke(areaColor);
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