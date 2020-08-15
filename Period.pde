Display mainDisplay;
MathUnit mathUnit;

void setup(){
  size(280,607);
  //size(450,975);
  mathUnit = new MathUnit();
  
  mainDisplay = new Display();
  mainDisplay.drawBackGround();
  
  
  
  
}


void draw(){
  mainDisplay.drawBackGround();
  //mainDisplay.drawLayOutGrid();
  //println( mathUnit.toString() );
  //println( mathUnit.getPeriod(2) );
  
  
}


void keyReleased(){
  if( key == ' ' ){
    Integer timeStamp = millis();
    mathUnit.addRecord(timeStamp);
  }
}
   //<>// //<>//
