class MathUnit {
  ArrayList<Integer> timeData;
  float runningTotal;
  double theDataPeriod;
  float sumOfSquares;
  float standardDeviation;
  
  MathUnit(){
    timeData = new ArrayList<Integer>();
    runningTotal = 0;
    theDataPeriod = 0;
    sumOfSquares = 0;
    standardDeviation = 0;
  }
  
//*************************** Adding a New Record and it's subroties. *****************************
  void addRecord(Integer newDataPoint){
    timeData.add(newDataPoint);
    int size = timeData.size();
    if( size > 1){
      int newDiff = abs( timeData.get(size - 2) - newDataPoint );
      runningTotal += newDiff;
      double temp = newAverage(theDataPeriod, (float)newDiff, size);
      theDataPeriod = runningTotal / size;      
      println(size + ": " + theDataPeriod + " -- " + temp);
    }      
  }
  
  double newAverage(double oldAverage,float newDataPoint, int dataSize){
    double output = oldAverage + ( newDataPoint - oldAverage) / dataSize;
    return output;      
  }
  
  Integer getRecord(int index){
    return timeData.get(index);
  }
  
  double getPeriod(){
    return theDataPeriod;
  }
  
  //  https://www.johndcook.com/blog/standard_deviation/
  //  https://www.embeddedrelated.com/showarticle/785.php
  
  String getPeriod(int percision){
    float periodInSec = (float)theDataPeriod / 1000;
    String output;
    switch (percision){
      case 0:
        output = String.format("%.0f", periodInSec);
        break;
      case 1:
        output = String.format("%.1f", periodInSec);
        break;
      case 3:
        output = String.format("%.3f", periodInSec);
        break;  
      case 2:
      default:
        output = String.format("%.2f", periodInSec);
        break;
    }
    output += "s ";
        
    return(output);    
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
