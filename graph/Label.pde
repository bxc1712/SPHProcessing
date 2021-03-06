class Label {
  
  Label(String txt,float x, float y) {
    
    // get text width
    float labelW;
    float labelH;
    
    labelW = textWidth(txt);
    labelH = textAscent()+textDescent();
    
    //Container
    fill(255);
    rectMode(CENTER);
    rect(x, y-50, labelW+10, labelH); 
    
    // Text
    fill(0);
    textAlign(CENTER);
    text(txt, x, y-25);

    text(txt, x, y-100);
  }
}