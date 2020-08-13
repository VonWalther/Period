class Display {

  //Set Up Colors
  color warmBase = color(#8627d8);
  color baseColor = color(#2e27d8);
  color coldBase = color(#2779d8);
  color backgroundColor = color(45); 
  /*
  color warmBase = color(#c42ec7);
  color warmShadow = color(#8e50d1);
  color baseColor = color(#8db8ea);
  color coldShadow = color(#5c97d1);
  color coldBase = color(#48c5c7);
  */

  //Set Up Margins and Postions
  int numOfColumns = 27;
  float columnSpacing = width / numOfColumns;
  
  int numOfRows = 60;
  float rowSpacing = height / numOfRows;
    
  float graphMargin = 1 * columnSpacing;
  float graphWidth = 26 *  columnSpacing;
  float graphYPos = graphMargin;
  float graphHeight = graphWidth;
  
  float buttonMargin = 4 * columnSpacing;
  float buttonWidth = 20 * columnSpacing;
  float buttonYPos = graphHeight + (5 * graphMargin);
  float buttonHeight = 5 * rowSpacing;
  
  PFont instructionFont = loadFont("data/BellMTBold-12.vlw");
  
  float fieldMargin = 2 * graphMargin;
  float fieldWidth = 24 * columnSpacing;
  float fieldYPos = height - rowSpacing * 20;
  float fieldHeight = 18 * rowSpacing;
  
  void drawBackGround() {


    fill(200);

    background(backgroundColor);
    //Graph back ground
    fill(baseColor);   
    rect(graphMargin, graphYPos, graphWidth, graphWidth);
    //Button
    fill(warmBase);
    rect(buttonMargin, buttonYPos, buttonWidth, buttonHeight);
    //Text in field
    fill(200);
    textAlign(CENTER);
    textFont(instructionFont);
    text("Hit the space bar to record each event.", width / 2, buttonYPos + (buttonHeight / 2));
    //Data Field
    fill(baseColor);
    rect(fieldMargin, fieldYPos, fieldWidth, fieldHeight);


    //Data Field
  }

  void drawLayOutGrid() {
    //For Layout and debuging
    stroke(240);
    strokeWeight(2);
    for ( int i = 0; i <= numOfColumns + 1; i++) {
      for ( int j = 0; j <= numOfRows + 1; j++) {
        float xPos = i * columnSpacing;
        float yPos = j * rowSpacing;
        point(xPos, yPos);
      }
    }
  }
}
