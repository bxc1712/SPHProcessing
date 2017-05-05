import processing.video.*;

Movie dorm1;
Movie dorm2;
Movie dorm3;
Movie dorm4;
Movie dorm5;

int second;
int videoWidth;
boolean createdBubble;

ArrayList<Bubble> bubbles = new ArrayList<Bubble>();
ArrayList<Movie> movies = new ArrayList<Movie>();
ArrayList<Column> freeCols = new ArrayList<Column>();
ArrayList<Column> usedCols = new ArrayList<Column>();
//ArrayList<Integer> freeCols = new ArrayList<Integer>();
//ArrayList<Integer> usedCols = new ArrayList<Integer>();

void settings(){
  size(1600, 1000); 
}

void setup(){
  videoWidth = 500;
  createdBubble = false;
  
  //***POPULATE AVAILABLE COLS***//
  //for(int i = 0; i < 25; i++){
  //  freeCols.add(i);
  //}
  second = 0;
  createMovies();
  createColumns();
}

void draw(){
  background(0);

  //***DRAW BUBBLES LOOP***//
  for(int i = 0; i < bubbles.size(); i++){
    image(bubbles.get(i).m,bubbles.get(i).xPos, bubbles.get(i).yPos);
    bubbles.get(i).yPos--;
  }
  //println(second()+ " second");
  
  calcDelay();
  
  randomBubbles();
  deleteBubbles();
}

//***REMOVES 1 FROM DELAY FOR NEW BUBBLES***//
void calcDelay(){
  if(second != second()){
    second = second();
    for(int i = 0; i < usedCols.size(); i++){
        Column c = usedCols.get(i);
        c.delay--;
        print(c.col + ": " + c.delay);
        if(c.delay <= 0){
           usedCols.remove(c);
           freeCols.add(c);
        }
    }
  }   
}


//***KEY HELPER FUNCTIONS***//
void keyReleased(){
   if(key == 'n'){
     createBubble();
     //println("Bubbles = "+bubbles.size());
     //println("Created bubble with N ");
   }
   
   if(key == 'f'){
     println("Free cols count = " + freeCols.size());
     for(int i = 0; i < freeCols.size(); i++){
        print("Free cols: " + freeCols.get(i).col + ", ");
      }
   }
   
   if(key == 'u'){
     //println("Used Columns count = "+usedCols.size());
     for(int i = 0; i < usedCols.size(); i++){
        print("Used cols: " + usedCols.get(i).col + ", ");
      }
   }
   
   if(key == 'c'){
     println("Free cols count = " + freeCols.size());
     println("Used Columns count = "+usedCols.size()); 
   }
   
   if(key == 'r'){
     int randCol =int(random(freeCols.size()));
     println("randCol = " + randCol);
   }
}
  
//***CREATE BUBBLE FUNCTION***//
void createBubble(){
  Bubble b;
  Boolean inCols = false;
  int rand = int(random(0,movies.size()));
  int randCol =int(random(freeCols.size()));
  //int randCol = 0;
  //println(freeCols.get(randCol));
  b = new Bubble(movies.get(rand), freeCols.get(randCol).col);
  
  for(int i = 0; i < usedCols.size(); i++){
    if(freeCols.get(randCol) == usedCols.get(i)){
      inCols = true;
    }
  }
  
  if(!inCols){
    bubbles.add(b);
    usedCols.add(freeCols.get(randCol));
    usedCols.get(usedCols.size() - 1).delay = 10;
    freeCols.remove(randCol);
  }  
}

//***CREATE BUBBLES RANDOMLY EVERY 5s***//
void randomBubbles(){
  if(second() % 5 == 0 && createdBubble == false){
      createBubble();
      createdBubble = true;
    }
  
  if(second() % 5 != 0){
    createdBubble = false;
  }
  //createBubble();
}

//***DELETE BUBBLES BASED ON Y POS***//
void deleteBubbles(){
  for(int i = 0; i < bubbles.size(); i++){
    if(bubbles.get(i).yPos < 0){
      bubbles.remove(i);
    }
  }
}

void movieEvent(Movie m){
    m.read();
}

void createMovies(){
  //***POPULATE ALL MOVIES***//
  dorm1 = new Movie(this,"Dorm_Event_Happiest.mp4");
  dorm2 = new Movie(this,"Dorm_Event_Happy.mp4");
  dorm3 = new Movie(this,"Dorm_Event_Neutral.mp4");
  dorm4 = new Movie(this,"Dorm_Event_Sad.mp4");
  dorm5 = new Movie(this,"Dorm_Event_Saddest.mp4"); 

  movies.add(dorm1);
  movies.add(dorm2);
  movies.add(dorm3);
  movies.add(dorm4);
  movies.add(dorm5);
  
  dorm1.loop();
  dorm2.loop();
  dorm3.loop();
  dorm4.loop();
  dorm5.loop();
}

void createColumns(){
  Column col0 = new Column(0);
  Column col1 = new Column(1);
  Column col2 = new Column(2);
  Column col3 = new Column(3);
  Column col4 = new Column(4);
  //Column col5 = new Column(5);
  //Column col6 = new Column(6);
  //Column col7 = new Column(7);
  //Column col8 = new Column(8);
  //Column col9 = new Column(9);
  //Column col10 = new Column(10);
  //Column col11 = new Column(11);
  //Column col12 = new Column(12);
  //Column col13 = new Column(13);
  //Column col14 = new Column(14);
  //Column col15 = new Column(15);
  //Column col16 = new Column(16);
  //Column col17 = new Column(17);
  //Column col18 = new Column(18);
  //Column col19 = new Column(19);
  //Column col20 = new Column(20);
  //Column col21 = new Column(21);
  //Column col22 = new Column(22);
  //Column col23 = new Column(23);
  //Column col24 = new Column(24);
  
  freeCols.add(col0);
  freeCols.add(col1);
  freeCols.add(col2);
  freeCols.add(col3);
  freeCols.add(col4);
  //freeCols.add(col5);
  //freeCols.add(col6);
  //freeCols.add(col7);
  //freeCols.add(col8);
  //freeCols.add(col9);
  //freeCols.add(col10);
  //freeCols.add(col11);
  //freeCols.add(col12);
  //freeCols.add(col13);
  //freeCols.add(col14);
  //freeCols.add(col15);
  //freeCols.add(col16);
  //freeCols.add(col17);
  //freeCols.add(col18);
  //freeCols.add(col19);
  //freeCols.add(col20);
  //freeCols.add(col21);
  //freeCols.add(col22);
  //freeCols.add(col23);
  //freeCols.add(col24);
}