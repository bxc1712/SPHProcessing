PFont helvetica;
import controlP5.*;

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
int logoWidth;
int logoHeight;
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
float xPointPad=50;
float yPointPad=60;
float faceIconPad=-10;

// - Labels Class -
pointLabel label;
// - Slider Class -
Slider timeSlider;

// - ControlP5 Stuff -
ControlP5 cp5;
int buttonHeight;
int buttonWidth;
int selectedButton = 0;
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
  
  magicXPos=width/3-(buttonWidth/2);
  artesanoXPos=width/2-(buttonWidth/2);
  dormsXpos=width/1.5-(buttonWidth/2);
  buttonYPos=height/2.25;
  
  buttonWidth=width/7;
  buttonHeight=height/20;
  
  //Title position values
  titleX=width/2;
  titleY=height/3;
  
  //Logo values
  logoWidth=width/5;
  logoHeight=height/5;
  
  logoX=width/2;
  logoY=height/8;
  
  helvetica = createFont("Helvetica-Bold", 20);
  imageName=reverse(imageName); //Reverse 
  textFont(helvetica);
  
  storedRows = new IntDict();
  
  happyList = new IntList();
  timeList = new StringList();
  entryList = new IntList();
  
  artesanoData = loadTable("artesano.csv","header");
  dormsData = loadTable("dorms.csv","header");
  magicData = loadTable("magic.csv","header");
  
  //storeData(magicData);
  
  cp5 = new ControlP5(this);
  
  cp5.addButton("magic")
     .setValue(3)
     .setPosition(magicXPos,buttonYPos)
     .setSize(buttonWidth,buttonHeight)
     .setColorBackground(magicColor)
     .setColorForeground(#d87f00)
     .setColorActive(#ffa100)
     .setFont(helvetica)
     .getCaptionLabel().align(CENTER,CENTER)
     ;
  cp5.addButton("artesano")
     .setValue(2)
     .setPosition(artesanoXPos,buttonYPos)
     .setSize(buttonWidth,buttonHeight)
     .setColorBackground(artesanoColor)
     .setColorForeground(#ba217e)
     .setColorActive(#ff4cb4)
     .setFont(helvetica)
     .getCaptionLabel().align(CENTER,CENTER)
     ;
  cp5.addButton("dorms")
     .setValue(1)
     .setPosition(dormsXpos,buttonYPos)
     .setSize(buttonWidth,buttonHeight)
     .setColorBackground(dormsColor)
     .setFont(helvetica)
     .getCaptionLabel().align(CENTER,CENTER)
     ;
}

void draw() {
  background(255);
  strokeWeight(2);
  // Switch cases to check what button is pressed
  switch(selectedButton){
    case 1:
      stroke(dormsColor);
      pointColor = dormsColor;
      storeData(dormsData);
      selectedButton = 0;
      break;
    case 2:
      stroke(artesanoColor);
      pointColor = artesanoColor;
      storeData(artesanoData);
      selectedButton = 0;
      break;
    case 3:
      stroke(magicColor);
      pointColor = magicColor;
      storeData(magicData);
      selectedButton = 0;
      break;
    default:
      break;
  }
  frame();
  activeButton();
  plotGraph(pointColor);
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
  text("HOW HAPPY IS RIT?",titleX,titleY);
  
  //Lines
  stroke(200,102);
  xVar=entryList.get(0)*faceIconPad+xPadding;
  for(int i=0; i<5; i++){
    yVar=i*yPointPad+yPadding;
    line(xVar,yVar,entryList.size(),yVar);
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
  println("Switched to: "+theEvent.getController().getName());
}

void artesano(){
  selectedButton = 2;
  println("Artesano Test");
}
void dorms(){
  selectedButton = 1;
  println("Dorms Test");
}
void magic(){
  selectedButton = 3;
  println("Magic Test");
}

//Selected button is active
void activeButton(){
  boolean isMagicOn=cp5.getController("magic").isMousePressed();
  boolean isArtesanoOn=cp5.getController("artesano").isMousePressed();
  boolean isDormsOn=cp5.getController("dorms").isMousePressed();
  
  color selected = color(#ffffff);
  
  if(isMagicOn){
    rectMode(CENTER);
    fill(255);
    rect(magicXPos,buttonYPos,buttonWidth,buttonHeight);
  }
}


//Some Sorting?
//void sortByDate(){
//  for(int i = 0; i<timeList.size(); i++){
//    splitTime = splitTokens(timeList.get(i));
//  }
//}