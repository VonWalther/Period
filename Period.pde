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
  debug();

  
  
}


void keyReleased(){
  if( key == ' ' ){
    Integer timeStamp = millis();
    mathUnit.addRecord(timeStamp);
  }
}

//**********************DEBUG**********************************************

void debug(){
  //mainDisplay.drawLayOutGrid();
  //println( mathUnit.toString() );
  //println( mathUnit.getPeriod(2) );
  String output = String.format("The Period:%8s and Std. Dev.:%8s", mathUnit.getPeriod(3), mathUnit.getStdDeviation(3));
  println(output);
}
  
  
