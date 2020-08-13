class MathUnit {
  ArrayList<Integer> timeData;
  
  MathUnit(){
    timeData = new ArrayList<Integer>();
  }
  
  void addRecord(Integer newDataPoint){
    timeData.add(newDataPoint);
  }
  
  Integer getRecord(int index){
    return timeData.get(index);
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
