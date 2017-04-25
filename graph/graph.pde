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

IntList happyList;
IntList entryList;
StringList timeList;

// - Data Point Spacing -
//Padding of Graph
float xPadding=100;
float yPadding=100;
//Padding of Points
float xPointPad=15;
float yPointPad=50;

void setup() {
  size(600, 480);
  helvetica = createFont("Helvetica-Bold", 14);
  textFont(helvetica);
  
  happyList = new IntList();
  timeList = new StringList();
  entryList = new IntList();
  sauData = loadTable("feeds.csv","header");
  
  for (TableRow row : sauData.rows()) {
    entryId = row.getInt("entry_id");
    happiness = row.getInt("field1");
    time = row.getString("created_at");
    entryList.append(entryId);
    happyList.append(happiness);
    timeList.append(time);
  }
   //println(entryList.get(0));
   //println(happyList.get(0));
   //point(entryId,happiness);
}

void draw() {
  background(255);
  // Draw Y axis line
  //line(yAxisX,yAxisY1,yAxisX,yAxisY2);
  
  // Plot Graph
  strokeWeight(4);
  for(int i=0;i<entryList.size();i++) {
    float xVar=entryList.get(i)*xPointPad+xPadding;
    float yVar=happyList.get(i)*yPointPad+yPadding;
    point(xVar,yVar);
    
    if (mouseOverPoint(xVar,yVar)){
      strokeWeight(2);
      fill(255);
      ellipse(xVar,yVar,8,8);
    }
  }
}

boolean mouseOverPoint(float x, float y){
  if (mouseX==x && mouseY==y){
    return true;
  } else{
    return false;
  }
}