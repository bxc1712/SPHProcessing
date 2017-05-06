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

float happiness;
float happyValue;
int entryId;
String time;
// Coordinates
float xVar;
float xVar2;
float yVar;


String[] splitTime;

//Lists for storage
FloatList happyList;
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
float pSize=7;
//Padding of Graph
float xPadding;
float yPadding;
//Padding of Points
float xPointPad=width*.034;
float yPointPad=60;
float faceIconPad=-50;
//Lines
float minX;
float maxX;

// - Labels Class -
pointLabel label;

// - Slider Class -
Slider timeSlider;

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
  //size(1280,720);
  xPadding=width-(width-100);
  yPadding=height-500;
  
  buttonWidth=width/7;
  buttonHeight=height/20;
  whichButtonOn=0;
  
  magicXPos=width/3-(buttonWidth/2);
  artesanoXPos=width/2-(buttonWidth/2);
  dormsXpos=width/1.5-(buttonWidth/2);
  buttonYPos=height/2.5;
  
  //Title position values
  titleX=width/2;
  titleY=height/3.2;
  
  //Logo values
  logoWidth=width/3.1;
  logoHeight=height/3.5;
  
  logoX=width/2;
  logoY=height/8;
  
  font = createFont("Lato-Bold.ttf", 20);
  titleFont = createFont("Lato-Bold.ttf", 100);
  imageName=reverse(imageName); //Reverse 
  
  
  storedRows = new IntDict();
  
  happyList = new FloatList();
  timeList = new StringList();
  entryList = new IntList();
    
  //artesanoData = loadTable("artesano.csv","header");
  //dormsData = loadTable("dorms.csv","header");
  //magicData = loadTable("magic.csv","header");
  artesanoData = loadTable("artesanoNew.csv","header");
  dormsData = loadTable("dormNew.csv","header");
  magicData = loadTable("magicNew.csv","header");
  
    
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
  timeSlider= new Slider(width,height,pointColor);
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
  
  //////FIX
  pushMatrix();
  fill(pointColor);
  textSize(20);
  text("Interact with Slider to Change Physical Graph",width/2,height/1.05);
  popMatrix();
  timeSlider.draw(pointColor);
  frame();
  activeButton();
  plotGraph(pointColor);
}

void mapSlider(){
  float start= round(map(timeSlider.minHandleX,timeSlider.containerMinX,timeSlider.containerMaxX,0,705));
  float end= round(map(timeSlider.maxHandleX,timeSlider.containerMinX,timeSlider.containerMaxX,0,705));
  println(start+" "+end);
}

void mousePressed(){
  timeSlider.minOffSetX=mouseX-timeSlider.minHandleX;
  timeSlider.maxOffSetX=mouseX-timeSlider.maxHandleX;
}
void mouseDragged(){
  if(timeSlider.overMin == true){
    timeSlider.minHandleX = mouseX-timeSlider.minOffSetX;
    if(timeSlider.minHandleX < timeSlider.containerMinX){
      timeSlider.minHandleX = timeSlider.containerMinX;
    }
  }
  if(timeSlider.overMax == true){
    timeSlider.maxHandleX = mouseX-timeSlider.maxOffSetX;
    if(timeSlider.maxHandleX > timeSlider.containerMaxX){
      timeSlider.maxHandleX = timeSlider.containerMaxX;
    }
  }
}

void mouseReleased(){
  float dist= timeSlider.maxHandleX-timeSlider.minHandleX;
  float bump;
  if(dist<50){
    bump=50/2;
    timeSlider.maxHandleX=timeSlider.maxHandleX+bump;
    timeSlider.minHandleX=timeSlider.minHandleX-bump;
    println();
  }
  mapSlider();
}

// Store values into Lists
void storeData(Table locationData){
  for (TableRow row : locationData.rows()) {
    entryId = row.getInt("entry_id");
    happiness = row.getFloat("field1");
    //time = row.getString("created_at");
    
    entryList.append(entryId);
    happyList.append(happiness);
    timeList.append(time);
    
    //storedRows.set(row.getString("created_at"),row.getInt("field1"));
  }
  
  //Since the pulled recorded happiness is flipped,
  //We will reverse the values with this
  for(int i=0;i<happyList.size();i++) {
    happyValue = happyList.get(i);
    if(happyValue==0){
      happyList.set(i,4);
    }
    if(happyValue==1){
      happyList.set(i,3);
    }
    if(happyValue==3){
      happyList.set(i,1);
    }
    if(happyValue==4){
      happyList.set(i,0);
    }
  }
}

// Plot Graph
void plotGraph(color pColor){
  int getDay;
  int getHr;
  
  beginShape();
  for(int i=0;i<entryList.size();i++) {
    xVar=entryList.get(i)*xPointPad+xPadding-10;
    yVar=happyList.get(i)*yPointPad+yPadding;
    fill(pColor);
    stroke(pColor);
    ellipse(xVar,yVar,pSize,pSize);
    noFill();
    strokeWeight(1);
    vertex(xVar,yVar);
  }
  endShape();
  
  // Mouse over point response
  for(int i=0;i<entryList.size();i++){
    xVar=entryList.get(i)*xPointPad+xPadding-10;
    yVar=happyList.get(i)*yPointPad+yPadding;
    getDay=floor(entryList.get(i)/24)+1;
    getHr=entryList.get(i);
    // Check if mouse over
    // If so show response
    if (mouseOverPoint(xVar,yVar,pSize)){
      noFill();
      stroke(pColor);
      ellipse(xVar,yVar,pSize+10,pSize+10);
      // Show text box with info
      label = new pointLabel("Day: "+getDay,getHr+"th Hour",xVar,yVar);
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