class pointLabel {
  
  pointLabel(String day,String hr,float x, float y) {
    
    // get text width
    float labelW;
    float labelH;
    
    
    textSize(14);
    labelW = textWidth(hr);
    labelH = textAscent()+textDescent();
    
    //Container
    fill(255);
    rectMode(CENTER);
    rect(x, y-30, labelW+10, labelH*2); 
    
    // Text
    fill(0);
    textAlign(CENTER);
    text(day, x, y-labelH*2);
    text(hr, x, y-labelH);
  }
}