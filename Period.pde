
ArrayList<Integer> tData;
float tAverage;

int dataDisplayMode = 2; //Changes how the data is displayed by this global varable.
int frameCountMod = 60; //Used to change the rate of blinking. 
//Global Color Values
color cursorColor = color(100, 100, 255);

//Postioning Constants
int textPostion;
int linePostion;
int lineMargin;
int diffOffset;



void setup() {
  size(1000, 300);
  tData = new ArrayList<Integer>();
  
  //Set the Postions
  textPostion = height * 5 / 6;
  lineMargin = 50;
  linePostion = height / 3;
}


void draw() {
  background(45);
  drawGraphAxies();
  displayData(dataDisplayMode);
  textAlign(CENTER);
  fill(230);
  text("Hit the space bar to record each event.", width / 2, textPostion);

}

void keyPressed() {
  if (key == ' ') {
    Integer timeStamp = millis();
    tData.add(timeStamp);
  }
}

void displayData(int mode) {
  switch(mode) {
  case 2:
    displayModeTwo();
    break;
  case 1:
    displayModeOne();
    break;
  case 0:
  default:
    displayModeZero();
  }
}

//***************************** Draw Graph Axies *********************************************/
void drawGraphAxies(){
  int numOfHashMarks = 20;
  float hashSpaceing = (linePostion * 2) / numOfHashMarks;
  float arrowLengthFact = 0.8 * hashSpaceing;
  stroke(250);
  //Draw The X Axies
  line(lineMargin, linePostion, width, linePostion);
  //Draw The Y Axies
  line(lineMargin, 0, lineMargin, linePostion * 2);
  //Add the arrows
    //Up Arrow
    line(lineMargin,               0, lineMargin - arrowLengthFact,                   arrowLengthFact);
    line(lineMargin,               0, lineMargin + arrowLengthFact,                   arrowLengthFact);
    //Down Arrow
    line(lineMargin, linePostion * 2, lineMargin - arrowLengthFact, linePostion * 2 - arrowLengthFact);
    line(lineMargin, linePostion * 2, lineMargin + arrowLengthFact, linePostion * 2 - arrowLengthFact);
}


//********************Dispaly Modes******************************/*

/***************************** Dispaly Mode Two ****************************************/
void displayModeTwo(){
  // n = 0
  if( tData.isEmpty() ){
    blinkingCursor(width / 2);  
  }
  
  // n = 1
  
  // n = 2+ 
  
  
}

//*************************** Find Data Average *****************************************/
float findDataAverage(float newDataPoint, float oldAverage, int nOfData){
  float newAverage = 0;
  
  return newAverage;
}

//**************************** Dispaly Mode One *****************************************/
/*                                                                                      *
/*  This Disaply mode places each event on a line space appart porpotuial to the amount *
/* time between each event.  In addtion each new event incress teh length of the x axis *
/*                                                                                      *
/****************************************************************************************/
void displayModeOne() {
  int rangeMult = 2; //When mutplied by the last data point in the data sets the range vaule of the display
  //Place a blinking curser at the start point.
  if ( tData.isEmpty() ) {
    blinkingCursor(0);
  } else {
    //Draw the data from the array.
    for (int i = 0; i < tData.size(); i++) {
      fill(cursorColor);  
      int cursorXPos =  floor( map( tData.get(i), tData.get(0), tData.get( tData.size() - 1 ) * rangeMult, 0, width));
      drawElement(cursorXPos, linePostion);
    }
    //Draw the blinking currser at the current time postion
    int cursorXPos = floor( map( millis(), tData.get(0), tData.get( tData.size() - 1 )* rangeMult, 0, width));
    blinkingCursor(cursorXPos);
  }
}
//***************************** DRAW ELEMENT ********************************/
void drawElement(int xPos, int yPos){
  rectMode(CENTER);
  stroke(10);
  int size = 15;
  rect(xPos, yPos, size, size);
}

//***************************** BLINKING CURSOR******************************/
void blinkingCursor(int xPos) {
  color mainCursorColor = color(255,0,0);
  color altCursorColor = color(255);
  if (frameCount%frameCountMod > (frameCountMod / 2)) {
    fill(mainCursorColor);
  } else {
    fill(altCursorColor);
  }
  drawElement(xPos, linePostion);
}

//**************************** Display Mode Zero ******************************************/
void displayModeZero()
{
  for (int i = 0; i < tData.size(); i++) {
    fill(255);
    text(tData.get(i).toString(), i*50, linePostion + 40);
    fill(255, 0, 0);
    rect(i*20, linePostion, 15, 15);
  }
}
