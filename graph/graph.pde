PFont helvetica;

// - Grid Template -
// Y axis line
float yAxisX = 20;
float yAxisY1 = 10;
float yAxisY2 = 300;
//////////////////////////

// - Data Vars -
Table sauData;
int happiness;
int entryId;
String time;
float xVar;
float yVar;

String[] splitTime;

IntList happyList;
IntList entryList;
StringList timeList;

// - Data Point Spacing -
// Point Size
float pSize=4;
//Padding of Graph
float xPadding;
float yPadding;
//Padding of Points
float xPointPad=50;
float yPointPad=50;

// - Labels Class -
Label pointLabel;

void setup() {
  size(600, 900);
  xPadding=100;
  yPadding=height-500;
  helvetica = createFont("Helvetica-Bold", 14);
  textFont(helvetica);
  
  happyList = new IntList();
  timeList = new StringList();
  entryList = new IntList();
  sauData = loadTable("feeds.csv","header");
  
  // Store values into Lists
  for (TableRow row : sauData.rows()) {
    entryId = row.getInt("entry_id");
    happiness = row.getInt("field1");
    time = row.getString("created_at");
    entryList.append(entryId);
    happyList.append(happiness);
    timeList.append(time);
  }
}

void draw() {
  background(255);
  strokeWeight(2);
  // Draw Y axis line
  //line(yAxisX,yAxisY1,yAxisX,yAxisY2);

  // Plot Graph
  beginShape();
  for(int i=0;i<entryList.size();i++) {
    xVar=entryList.get(i)*xPointPad+xPadding;
    yVar=happyList.get(i)*yPointPad+yPadding;
    fill(0);
    ellipse(xVar,yVar,4,4);
    noFill();
    vertex(xVar,yVar);
  }
  endShape();
  
  for(int i=0;i<entryList.size();i++){
    xVar=entryList.get(i)*xPointPad+xPadding;
    yVar=happyList.get(i)*yPointPad+yPadding;
    // Check if mouse over
    // If so show response
    if (mouseOverPoint(xVar,yVar,pSize)){
      noFill();
      ellipse(xVar,yVar,10,10);
      // Show text box with info
      pointLabel = new Label("Test Text",xVar,yVar);
    }
  }
}

// Mouse over point response
boolean mouseOverPoint(float x, float y, float diameter){
  float disX = x - mouseX;
  float disY = y - mouseY;
  
  if (sqrt (sq(disX) +sq(disY)) < diameter) {
    return true;
  } else{
    return false;
  }
}

void sortByDate(){
  for(int i = 0; i<timeList.size(); i++){
    splitTime = splitTokens(timeList.get(i));
  }
}