class MathUnit {
  ArrayList<Integer> timeData;
  float runningTotal;
  float theDataPeriod;
  
  MathUnit(){
    timeData = new ArrayList<Integer>();
    runningTotal = 0;
    theDataPeriod = -1;
  }
  
  void addRecord(Integer newDataPoint){
    timeData.add(newDataPoint);
    int size = timeData.size();
    if( size > 1){
      int newDiff = abs( timeData.get(size - 2) - newDataPoint );
      runningTotal += newDiff;
      theDataPeriod = runningTotal / size;
    }
      
  }
  
  Integer getRecord(int index){
    return timeData.get(index);
  }
  
  float getPeriod(){
    return theDataPeriod;
  }
  
  String toString(){
    String output = "";
    
    for(int i = 0; i < timeData.size(); i++){
      String formatedSubString = String.format("%d, ",timeData.get(i));
      output += formatedSubString;
    }
    output += "End";
     
    return output;
  }
  
  
}
