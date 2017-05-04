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
float yPointPad=50;
float faceIconPad=-10;

// - Labels Class -
pointLabel label;

// - ControlP5 Stuff -
ControlP5 cp5;
int buttonHeight;
int buttonWidth;
int selectedButton = 0;
int buttonYPos;

//Button colors
color artesanoColor = #f62da8;
color dormsColor = #00a8f5;
color magicColor = #ff9600;
color pointColor;

void setup() {
  fullScreen();
  xPadding=width-(width-100);
  yPadding=height-500;
  buttonYPos=height/3;
  buttonWidth=width/15;
  buttonHeight=height/25;
  helvetica = createFont("Helvetica-Bold", 20);
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
  
  cp5.addButton("artesano")
     .setValue(2)
     .setPosition(width/2,buttonYPos)
     .setSize(buttonWidth,buttonHeight)
     .setColorBackground(artesanoColor)
     .setColorForeground(#ba217e)
     .setFont(helvetica)
     ;
  cp5.addButton("dorms")
     .setValue(1)
     .setPosition(width/1.5,buttonYPos)
     .setSize(buttonWidth,buttonHeight)
     .setColorBackground(dormsColor)
     .setFont(helvetica)
     ;
  cp5.addButton("magic")
     .setValue(3)
     .setPosition(width/3,buttonYPos)
     .setSize(buttonWidth,buttonHeight)
     .setColorBackground(magicColor)
     .setColorForeground(#d87f00)
     .setFont(helvetica)
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
}

//

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


//Some Sorting?
//void sortByDate(){
//  for(int i = 0; i<timeList.size(); i++){
//    splitTime = splitTokens(timeList.get(i));
//  }
//}