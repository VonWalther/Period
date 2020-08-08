//This is a demo of a peridicity tracking application.

ArrayList<Integer> tData;
float diffAverage;

int dataDisplayMode = 2; //Changes how the data is displayed by this global varable.
int frameCountMod = 60; //Used to change the rate of blinking. 
//Global Color Values
color cursorColor = color(100, 100, 255);

PFont axisLablesFont;
PFont instructionFont;

//Postioning Constants
int textPostion;
int linePostion;
int lineMargin;
int diffOffset;


//**************************************** SETUP *******************************************/
void setup() {
  size(1000, 300);
  tData = new ArrayList<Integer>();
  
  //Set the Postions
  textPostion = height * 5 / 6;
  lineMargin = 50;
  linePostion = height / 3;
  
  //Set up the Fonts
  axisLablesFont = loadFont("data/BellMTBold-12.vlw");
  instructionFont = loadFont("data/BellMT-32.vlw");
}

// *************** THE MAIN FUNCTION, WHAT MAKES ALL THE FUN HAPPEN! ************************/
void draw() {
  background(45);
  drawGraphAxies();
  displayData(dataDisplayMode);
  textAlign(CENTER);
  fill(230);
  textFont(instructionFont);
  text("Hit the space bar to record each event.", width / 2, textPostion);

}
// ******************** KEYPRESSED **********************************************************/
void keyReleased() {
  if (key == ' ') {
    Integer timeStamp = millis();
    tData.add(timeStamp);
    if( tData.size() > 2){
      //Find the new average of time differates.
    }
  }
}

// *********************** Mode Switch Switch **********************************************/
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

//************************************************************************************************/
//**************************** Dispaly Modes *****************************************************/
//************************************************************************************************/

/***************************** Dispaly Mode Two ****************************************/
void displayModeTwo(){
  // n = 0
  if( tData.isEmpty() ){
    blinkingCursor(width / 2);  
  }else {
      if( tData.size() == 1 ){   // n = 1
      fill(cursorColor);
      int cursorXPos = findCurrentPostion( tData.get(0), tData.get(0), lineMargin, width);
      drawElement(cursorXPos, linePostion);  
     } else {  // n = 2+
       
     }
     int cursorXPos = findCurrentPostion( millis(), tData.get(0), lineMargin, width);
     blinkingCursor(cursorXPos);
  }
  displayXAxis();    
   

  
}

//***************************** Find Current Postion ************************************/
int findCurrentPostion(int timeStamp, float dataLowerBound, float dispLowerBound, float dispUpperBound){
  //This array holds the break points for the ranging of the x axies. From the largest to the smallest.
  //
  int[] tBreakPoints = new int[6];
  tBreakPoints[0] = 4320000; // Largest Vaule -- 12 Hrs [0]
  tBreakPoints[1] = 3600000; // 1  hour                 [1]
  tBreakPoints[2] =  600000; // 10 minutes              [2]
  tBreakPoints[3] =  300000; // 5  minutes              [3]
  tBreakPoints[4] =  120000; // 2  minutes              [4]
  tBreakPoints[5] =   30000; // 30 seconds              [5]                   
                           
  
  float dataUpperBound;
  float currentTime = millis();
  //Will need to come back later and add some trastional effects between each break point to smooth it out and make less ruff.
  if( currentTime > tBreakPoints[1]){
    dataUpperBound = tBreakPoints[0];
  } else if(currentTime > tBreakPoints[2]) {
    dataUpperBound = tBreakPoints[1];
  } else if(currentTime > tBreakPoints[3]) {
    dataUpperBound = tBreakPoints[2];
  } else if(currentTime > tBreakPoints[4]) {
    dataUpperBound = tBreakPoints[3];
  } else if(currentTime > tBreakPoints[5]) {
    dataUpperBound = tBreakPoints[4];
  } else {
    dataUpperBound = tBreakPoints[5];
  }

  int calcualtedXPos = floor( map (timeStamp, dataLowerBound, dataUpperBound, dispLowerBound, dispUpperBound) );
 
  return calcualtedXPos; 
}

//*************************** Find Data Average *****************************************/
float findDataAverage(float newDataPoint, float oldAverage, int nOfData){
  float lastTotal = (oldAverage * nOfData - 1);
    
  float newAverage =  ( lastTotal + newDataPoint ) / nOfData;
  
  return newAverage;
}

//**************************** Display X Axis *******************************************/
void displayXAxis(){
  String dispAvg = String.format("%5.2f", diffAverage /1000);
  
  stroke(200);
  fill(200);
  textFont(axisLablesFont);
  textAlign(LEFT);
  text(dispAvg, 5, linePostion);
  
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
 //<>//

//***************************** DRAW ELEMENT ********************************************/
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
