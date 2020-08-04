
ArrayList<Integer> tData;

int dataDisplayMode = 1; //Changes how the data is displayed by this global varable.
int frameCountMod = 60; //Used to change the rate of blinking. 
color cursorColor = color(255,0,0);

void setup(){
  size(1000,300);
  tData = new ArrayList<Integer>();
  
}


void draw(){
  background(45);
  
  displayData(dataDisplayMode);
  
}

void keyPressed(){
  if (key == ' '){
    Integer timeStamp = millis();
    tData.add(timeStamp);
  }
}

void displayData(int mode){
    switch(mode){
     case 1:
       displayModeOne();
       break;
     case 0:
     default:
       displayModeZero();
    }

  
}


//********************Dispaly Modes******************************/*
void displayModeOne(){
  int rangeMult = 5; //When mutplied by the last data point in the data sets the range vaule of the display
  //Place a blinking curser at the start point.
  if ( tData.isEmpty() ){
    blinkingCursor(0);
  } else {
  //Draw the data from the array.
  for(int i = 0; i < tData.size(); i++){
    fill(cursorColor);  
    int cursorXPos =  floor( map( tData.get(i), tData.get(0), tData.get( tData.size() - 1 ) * rangeMult, 0, width));
    rect(cursorXPos, width / 3, 15, 15);
  }
  //Draw the blinking currser at the current time postion
    int cursorXPos = floor( map( millis(), 0, tData.get( tData.size() - 1 )* 10, 0, width));
    blinkingCursor(cursorXPos);
  }
}

//***************************** BLINKING CURSOR******************************/
void blinkingCursor(int xPos){
  color altCursorColor = color(255);
  if (frameCount%frameCountMod > (frameCountMod / 2)){
      fill(cursorColor);
  } else {
      fill(altCursorColor);
  }
  rect(xPos, height / 3, 15,15);
  }

void displayModeZero()
{
    for(int i = 0; i < tData.size(); i++){
    fill(255);
    text(tData.get(i).toString(), i*50, height * 2 / 3);
    fill(255,0,0);
    rect(i*20, height / 3, 15, 15);
  }
}
