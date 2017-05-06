import controlP5.*;
PFont font;
PFont titleFont;
// - Grid Template -
// Y axis line
float yAxisX = 20;
float yAxisY1 = 10;
float yAxisY2 = 300;
//////////////////////////

// - Data Vars -
Table artesanoData;
Table dormsData;
Table magicData;

int happiness;
int happyValue;
int entryId;
String time;
// Coordinates
float xVar;
float xVar2;
float yVar;


String[] splitTime;

//Lists for storage
IntList happyList;
IntList entryList;
StringList timeList;

//Arrays for smile icons
String[] imageName={"1.png","2.png","3.png","4.png","5.png"};
PImage[] smileList=new PImage[imageName.length];
//Title Text
float titleX;
float titleY;
//Logo Image
PImage logo;
float logoWidth;
float logoHeight;
float logoX;
float logoY;
//Dictionary storage
IntDict storedRows;

// - Data Point Spacing -
// Point Size
float pSize=10;
//Padding of Graph
float xPadding;
float yPadding;
//Padding of Points
float xPointPad=width*.1;
float yPointPad=60;
float faceIconPad=-50;

// - Labels Class -
pointLabel label;

// - Slider Class -
Slider timeSlider;
//Slider Stuff
float defaultMinX;
float defaultMaxX;
float minX;
float maxX;
float minOffSetX;
float maxOffSetX;

// - ControlP5 Stuff -
ControlP5 cp5;
int buttonHeight;
int buttonWidth;
int selectedButton;
int whichButtonOn;
float buttonYPos;

float magicXPos;
float artesanoXPos;
float dormsXpos;

//Button colors
color artesanoColor = #f62da8;
color dormsColor = #00a8f5;
color magicColor = #ff9600;
color pointColor;

void setup() {
  fullScreen();
  
  xPadding=width-(width-100);
  yPadding=height-500;
  
  buttonWidth=width/7;
  buttonHeight=height/20;
  whichButtonOn=0;
  
  magicXPos=width/3-(buttonWidth/2);
  artesanoXPos=width/2-(buttonWidth/2);
  dormsXpos=width/1.5-(buttonWidth/2);
  buttonYPos=height/2.5;
  
  //Slider Init
  defaultMinX=width/3;
  defaultMaxX=width/1.5;
  minX=defaultMinX;
  maxX=defaultMaxX;
  minOffSetX=0;
  maxOffSetX=0;
  
  //Title position values
  titleX=width/2;
  titleY=height/3.5;
  
  //Logo values
  logoWidth=width/3.5;
  logoHeight=height/4;
  
  logoX=width/2;
  logoY=height/8;
  
  font = createFont("Lato-Bold.ttf", 20);
  titleFont = createFont("Lato-Bold.ttf", 64);
  imageName=reverse(imageName); //Reverse 
  
  
  storedRows = new IntDict();
  
  happyList = new IntList();
  timeList = new StringList();
  entryList = new IntList();
  
  artesanoData = loadTable("artesano.csv","header");
  dormsData = loadTable("dorms.csv","header");
  magicData = loadTable("magic.csv","header");
    
  cp5 = new ControlP5(this);
  
  cp5.addButton("magic")
     .setValue(3)
     .activateBy(ControlP5.PRESSED)
     .setPosition(magicXPos,buttonYPos)
     .setSize(buttonWidth,buttonHeight)
     .setColorBackground(magicColor)
     .setColorForeground(#d87f00)
     .setColorActive(#ffa100)
     .setFont(font)
     .getCaptionLabel().align(CENTER,CENTER)
     ;
  cp5.addButton("artesano")
     .setValue(2)
     .activateBy(ControlP5.PRESSED)
     .setPosition(artesanoXPos,buttonYPos)
     .setSize(buttonWidth,buttonHeight)
     .setColorBackground(artesanoColor)
     .setColorForeground(#ba217e)
     .setColorActive(#ff4cb4)
     .setFont(font)
     .getCaptionLabel().align(CENTER,CENTER)
     ;
  cp5.addButton("dorms")
     .setValue(1)
     .activateBy(ControlP5.PRESSED)
     .setPosition(dormsXpos,buttonYPos)
     .setSize(buttonWidth,buttonHeight)
     .setColorBackground(dormsColor)
     .setFont(font)
     .getCaptionLabel().align(CENTER,CENTER)
     ;
  selectedButton=1;
}

void draw() {
  background(255);
  strokeWeight(2);
  // Switch cases to check what button is pressed
  switch(selectedButton){
    case 1:
      stroke(magicColor);
      pointColor = magicColor;
      storeData(magicData);
      selectedButton = 0;
    break;
    case 2:
      stroke(artesanoColor);
      pointColor = artesanoColor;
      storeData(artesanoData);
      selectedButton = 0;
    break;
    case 3:
      stroke(dormsColor);
      pointColor = dormsColor;
      storeData(dormsData);
      selectedButton = 0;
    break;
  }
  timeSlider= new Slider(width,height,pointColor,minX,maxX);
  frame();
  activeButton();
  plotGraph(pointColor);
}

void mousePressed(){
  minOffSetX=mouseX-minX;
  maxOffSetX=mouseX-maxX;
}
void mouseDragged(){
  if(timeSlider.overMin==true){
    minX=mouseX-minOffSetX;
    if(minX<timeSlider.containerMinX){
      minX=timeSlider.containerMinX;
    }
  }
  if(timeSlider.overMax==true){
    maxX=mouseX-maxOffSetX;
    if(maxX>timeSlider.containerMaxX){
      maxX=timeSlider.containerMaxX;
    }
  }
}

// Store values into Lists
void storeData(Table locationData){
  for (TableRow row : locationData.rows()) {
    entryId = row.getInt("entry_id");
    happiness = row.getInt("field1");
    time = row.getString("created_at");
    
    entryList.append(entryId);
    happyList.append(happiness);
    timeList.append(time);
    
    //storedRows.set(row.getString("created_at"),row.getInt("field1"));
  }
  
  //Since the pulled recorded happiness is flipped,
  //We will reverse the values with this
  for(int i=0;i<happyList.size();i++) {
    happyValue = happyList.get(i);
    switch(happyValue){
      case 0:
        happyList.set(i,4);
        break;
      case 1:
        happyList.set(i,3);
        break;
      case 3:
        happyList.set(i,1);
        break;
      case 4:
        happyList.set(i,0);
        break;
      default:
        break;
    }
  }
}

// Plot Graph
void plotGraph(color pColor){
  beginShape();
  for(int i=0;i<entryList.size();i++) {
    xVar=entryList.get(i)*xPointPad+xPadding;
    yVar=happyList.get(i)*yPointPad+yPadding;
    fill(pColor);
    stroke(pColor);
    ellipse(xVar,yVar,pSize,pSize);
    noFill();
    strokeWeight(2);
    vertex(xVar,yVar);
  }
  endShape();
  
  // Mouse over point response
  for(int i=0;i<entryList.size();i++){
    xVar=entryList.get(i)*xPointPad+xPadding;
    yVar=happyList.get(i)*yPointPad+yPadding;
    // Check if mouse over
    // If so show response
    if (mouseOverPoint(xVar,yVar,pSize)){
      noFill();
      stroke(pColor);
      ellipse(xVar,yVar,pSize+10,pSize+10);
      // Show text box with info
      label = new pointLabel("Test Text",xVar,yVar);
    }
  }
}

//Draw stuff for graph
//EX: lines, smilies
void frame(){
  //Title Text
  textSize(width/25);
  textAlign(CENTER);
  fill(dormsColor);
  textFont(titleFont);
  text("HOW HAPPY IS RIT?",titleX,titleY);
  
  //Lines
  stroke(200,102);
  strokeWeight(2);
  xVar=entryList.get(0)*faceIconPad+xPadding;
  for(int i=0; i<5; i++){
    yVar=i*yPointPad+yPadding;
    line(xVar,yVar,width/1.02,yVar);
  }
  
  //Smilies
  imageMode(CENTER);
  xVar=entryList.get(0)*faceIconPad+xPadding;
  for(int i=0; i<imageName.length; i++){
    yVar=i*yPointPad+yPadding;
    String imgName=imageName[i];
    smileList[i]=loadImage(imgName);
    image(smileList[i],xVar,yVar,pSize+30,pSize+30);
  }
  
  //Title Logo
  logo = loadImage("logo.png");
  image(logo,logoX,logoY,logoWidth,logoHeight);
}

// Mouse over point check
boolean mouseOverPoint(float x, float y, float diameter){
  float disX = x - mouseX;
  float disY = y - mouseY;
  
  if (sqrt (sq(disX) +sq(disY)) < diameter) {
    return true;
  } else{
    return false;
  }
}

// - ControlP5 -
//Button Stuff
void controlEvent(ControlEvent theEvent){
  entryList.clear();
  happyList.clear();
  timeList.clear();
  //println("Switched to: "+theEvent.getController().getName());
}


void magic(){
  selectedButton = 1;
  //println("Magic Test");
}
void artesano(){
  selectedButton = 2;
  //println("Artesano Test");
}
void dorms(){
  selectedButton = 3;
  //println("Dorms Test");
}

//Selected button is active
void activeButton(){
  boolean isMagicOn=cp5.getController("magic").isMousePressed();
  boolean isArtesanoOn=cp5.getController("artesano").isMousePressed();
  boolean isDormsOn=cp5.getController("dorms").isMousePressed();
  
  color selected = color(#ffffff);
  float selectedWidth=buttonWidth+20;
  float selectedHeight=buttonHeight+20;
  
  if(isMagicOn){
    whichButtonOn=0;
  }
  if(isArtesanoOn){
    whichButtonOn=1;
  }
  if(isDormsOn){
    whichButtonOn=2;
  }
  rectMode(CORNER);
  noFill();
  switch(whichButtonOn){
    case 0:
      stroke(magicColor);
      pushMatrix();
      translate(-10,-10);
      rect(magicXPos,buttonYPos,selectedWidth,selectedHeight);
      popMatrix();
    break;
    case 1:
      stroke(artesanoColor);
      pushMatrix();
      translate(-10,-10);
      rect(artesanoXPos,buttonYPos,selectedWidth,selectedHeight);
      popMatrix();
    break;
    case 2:
      stroke(dormsColor);
      pushMatrix();
      translate(-10,-10);
      rect(dormsXpos,buttonYPos,selectedWidth,selectedHeight);
      popMatrix();
    break;
    default:
    break;
  }
}

//Some Sorting?
//void sortByDate(){
//  for(int i = 0; i<timeList.size(); i++){
//    splitTime = splitTokens(timeList.get(i));
//  }
//}