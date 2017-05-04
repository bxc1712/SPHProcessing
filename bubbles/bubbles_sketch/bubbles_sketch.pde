import processing.video.*;

Movie dorm1;
Movie dorm2;
Movie dorm3;
Movie dorm4;
Movie dorm5;
//Movie dorm6;
//Movie dorm7;
//Movie dorm8;
//Movie dorm9;
//Movie dorm10;
//Movie dorm11;
//Movie dorm12;
//Movie dorm13;
//Movie dorm14;
//Movie dorm15;

//Movie magic1;
//Movie magic2;
//Movie magic3;
//Movie magic4;
//Movie magic5;
//Movie magic6;
//Movie magic7;
//Movie magic8;
//Movie magic9;
//Movie magic10;
//Movie magic11;
//Movie magic12;
//Movie magic13;
//Movie magic14;
//Movie magic15;

//Movie sau1;
//Movie sau2;
//Movie sau3;
//Movie sau4;
//Movie sau5;
//Movie sau6;
//Movie sau7;
//Movie sau8;
//Movie sau9;
//Movie sau10;
//Movie sau11;
//Movie sau12;
//Movie sau13;
//Movie sau14;
//Movie sau15;

int pTime;
int dTime;
int videoWidth;
boolean createdBubble;

ArrayList<Bubble> bubbles = new ArrayList<Bubble>();
ArrayList<Movie> movies = new ArrayList<Movie>();

void settings(){
  size(1600, 1000); 
}

void setup(){

  videoWidth = 500;
  createdBubble = false;
  
  dorm1 = new Movie(this,"Dorm_Event_Happiest.mov");
  dorm2 = new Movie(this,"Dorm_Event_Happy.mov");
  dorm3 = new Movie(this,"Dorm_Event_Neutral.mov");
  dorm4 = new Movie(this,"Dorm_Event_Sad.mov");
  dorm5 = new Movie(this,"Dorm_Event_Saddest.mov"); 
  //dorm6 = new Movie(this,"Dorm_Face_Happiest.mov"); 
  //dorm7 = new Movie(this,"Dorm_Face_Happy.mov");
  //dorm8 = new Movie(this,"Dorm_Face_Neutral.mov");
  //dorm9 = new Movie(this,"Dorm_Face_Sad.mov");
  //dorm10 = new Movie(this, "Dorm_Face_Saddest.mov");
  //dorm11 = new Movie(this,"Dorm_Location.mov");
  //dorm12 = new Movie(this,"Dorm_Weather_Cloudy.mov");
  //dorm13 = new Movie(this,"Dorm_Weather_Rain.mov");
  //dorm14 = new Movie(this,"Dorm_Weather_Snowy.mov");
  //dorm15 = new Movie(this,"Dorm_Weather_Sunny.mov");
  
  //magic1 = new Movie(this,"Magic_Event_Happiest.mov");
  //magic2 = new Movie(this,"Magic_Event_Happy.mov");
  //magic3 = new Movie(this,"Magic_Event_Neutral.mov");
  //magic4 = new Movie(this,"Magic_Event_Sad.mov");
  //magic5 = new Movie(this,"Magic_Event_Saddest.mov");
  //magic6 = new Movie(this,"Magic_Face_Happiest.mov");
  //magic7 = new Movie(this,"Magic_Face_Happy.mov");
  //magic8 = new Movie(this,"Magic_Face_Neutral.mov");
  //magic9 = new Movie(this,"Magic_Face_Sad.mov");
  //magic10 = new Movie(this,"Magic_Face_Saddest.mov");
  //magic11 = new Movie(this,"Magic_Location.mov");
  //magic12 = new Movie(this,"Magic_Weather_Cloudy.mov");
  //magic13 = new Movie(this,"Magic_Weather_Rain.mov");
  //magic14 = new Movie(this,"Magic_Weather_Snowy.mov");
  //magic15 = new Movie(this,"Magic_Weather_Sunny.mov");
   
  //sau1 = new Movie(this,"SAU_Event_Happiest.mov");
  //sau2 = new Movie(this,"SAU_Event_Happy.mov");
  //sau3 = new Movie(this,"SAU_Event_Neutral.mov");
  //sau4 = new Movie(this,"SAU_Event_Sad.mov");
  //sau5 = new Movie(this,"SAU_Event_Saddest.mov");
  //sau6 = new Movie(this,"SAU_Face_Happiest.mov");
  //sau7 = new Movie(this,"SAU_Face_Happy.mov");
  //sau8 = new Movie(this,"SAU_Face_Neutral.mov");
  //sau9 = new Movie(this,"SAU_Face_Sad.mov");
  //sau10 = new Movie(this,"SAU_Face_Saddest.mov");
  //sau11 = new Movie(this,"SAU_Location.mov");
  //sau12 = new Movie(this,"SAU_Weather_Cloudy.mov");
  //sau13 = new Movie(this,"SAU_Weather_Rain.mov");
  //sau14 = new Movie(this,"SAU_Weather_Snowy.mov");
  //sau15 = new Movie(this,"SAU_Weather_Sunny.mov");

  movies.add(dorm1);
  movies.add(dorm2);
  movies.add(dorm3);
  movies.add(dorm4);
  movies.add(dorm5);
  //movies.add(dorm6);
  //movies.add(dorm7);
  //movies.add(dorm8);
  //movies.add(dorm9);
  //movies.add(dorm10);
  //movies.add(dorm11);
  //movies.add(dorm12);
  //movies.add(dorm13);
  //movies.add(dorm14);
  //movies.add(dorm15);
  
  //movies.add(magic1);
  //movies.add(magic2);
  //movies.add(magic3);
  //movies.add(magic4);
  //movies.add(magic5);
  //movies.add(magic6);
  //movies.add(magic7);
  //movies.add(magic8);
  //movies.add(magic9);
  //movies.add(magic10);
  //movies.add(magic11);
  //movies.add(magic12);
  //movies.add(magic13);
  //movies.add(magic14);
  //movies.add(magic15);
  
  //movies.add(sau1);
  //movies.add(sau2);
  //movies.add(sau3);
  //movies.add(sau4);
  //movies.add(sau5);
  //movies.add(sau6);
  //movies.add(sau7);
  //movies.add(sau8);
  //movies.add(sau9);
  //movies.add(sau10);
  //movies.add(sau11);
  //movies.add(sau12);
  //movies.add(sau13);
  //movies.add(sau14);
  //movies.add(sau15);
  
  dorm1.loop();
  dorm2.loop();
  dorm3.loop();
  dorm4.loop();
  dorm5.loop();
  //dorm6.loop();
  //dorm7.loop();
  //dorm8.loop();
  //dorm9.loop();
  //dorm10.loop();
  //dorm11.loop();
  //dorm12.loop();
  //dorm13.loop();
  //dorm14.loop();
  //dorm15.loop();
  
  //magic1.loop();
  //magic2.loop();
  //magic3.loop();
  //magic4.loop();
  //magic5.loop();
  //magic6.loop();
  //magic7.loop();
  //magic8.loop();
  //magic9.loop();
  //magic10.loop();
  //magic11.loop();
  //magic12.loop();
  //magic13.loop();
  //magic14.loop();
  //magic15.loop();
  
  //sau1.loop();
  //sau2.loop();
  //sau3.loop();
  //sau4.loop();
  //sau5.loop();
  //sau6.loop();
  //sau7.loop();
  //sau8.loop();
  //sau9.loop();
  //sau10.loop();
  //sau11.loop();
  //sau12.loop();
  //sau13.loop();
  //sau14.loop();
  //sau15.loop();
  
  //for(int i = 1; i < movies.size(); i++){
  //  movies.get(i).loop();
  //}
  
}

void draw(){
  background(0);

  //***DRAW BUBBLES LOOP***//
  for(int i = 0; i < bubbles.size(); i++){
    image(bubbles.get(i).m,bubbles.get(i).xPos, bubbles.get(i).yPos);
    bubbles.get(i).yPos--;
  }
  
  createBubble();
  deleteBubbles();
}

void movieEvent(Movie m){
    m.read();
}

//***CREATE BUBBLE USING 'N' KEY***//
void keyReleased(){
    if(key == 'n'){
     int rand = int(random(0,movies.size()));
     int randx =int(random(width));
     Bubble b = new Bubble(randx, movies.get(rand));  
     bubbles.add(b);
     //println("new ball");
    }
  }

//***CREATE BUBBLES RANDOMLY EVERY 5s***//
void createBubble(){
  Boolean contact = true;
  Bubble b;
  if(second() % 5 == 0 && createdBubble == false){
    while(contact){
      Boolean tempContact = false;
      int rand = int(random(0,movies.size()));
      int randx =int(random(width));
      b = new Bubble(randx, movies.get(rand));
      for(int i = 0; i < bubbles.size(); i++){   
          if(bubbleBounds(b, bubbles.get(i))){
            tempContact = true;
          }
        }
        if(tempContact == false){
          contact = false;
          createdBubble = true;
        } else {
          bubbles.remove(b);
        }   
      } 
    }
  
  if(second() % 5 != 0){
    createdBubble = false;
  }
}

//***DELETE BUBBLES BASED ON Y POS***//
void deleteBubbles(){
  for(int i = 0; i < bubbles.size(); i++){
    if(bubbles.get(i).yPos < 0){
      bubbles.remove(i);
    }
  }
}

//***KEEP BUBBLES FROM TOUCHING***//
Boolean bubbleBounds(Bubble b1, Bubble b2){
  if(b1.xPos > b2.xPos && b1.xPos < b2.xPos + videoWidth){
    if(b1.yPos > b2.yPos && b1.yPos < b2.yPos + videoWidth){
      return true;
    }
  }
  return false;
}