class MathUnit {
  ArrayList<Integer> timeData;
  float runningTotal;
  double theDataPeriod;
  double theVariance;
  double theStdDeviation;
  
  MathUnit(){
    timeData = new ArrayList<Integer>();
    runningTotal = 0;
    theDataPeriod = 0;
    theVariance = 0;
    theStdDeviation = 0;
  }
  
//*************************** Adding a New Record and it's subroties. *****************************
  void addRecord(Integer newDataPoint){
    timeData.add(newDataPoint);
    int size = timeData.size();
    if( size > 1){
      int newDiff = abs( timeData.get(size - 2) - newDataPoint );
      runningTotal += newDiff; 
      if( size > 2){
        double oldAverage = theDataPeriod;
        theDataPeriod = getNewAverage( (float)newDiff, theDataPeriod, size - 1);  
        theVariance = getNewVariance( (float)newDiff, theVariance, theDataPeriod, oldAverage); 
        theStdDeviation = findStandardDeviation(theVariance);
      }else if( size == 1){
        theDataPeriod = newDiff;
        theVariance = 0;
      }
    }
  }
  
// Use the Welford's Method to find to find the variance.
  //  https://www.johndcook.com/blog/standard_deviation/
  //  https://www.embeddedrelated.com/showarticle/785.php
  //  https://jonisalonen.com/2013/deriving-welfords-method-for-computing-variance/

  double getNewAverage(float newDataPoint, double oldAverage, int dataSize){
    // Mn = Mn-1 + (Xn - Mn-1) / n
    double output = oldAverage + ( newDataPoint - oldAverage) / dataSize;
    return output;      
  }
  
  double getNewVariance(float newDataPoint, double oldVariance, double newAverage, double oldAverage){
    //Sn = Sn-1 + (Xn - Mn-1)(Xn - Mn)
    double output = oldVariance + (newDataPoint - oldAverage) * (newDataPoint - newAverage);
    return output;
  }
  
  double findStandardDeviation(double variance){
    double output = Math.sqrt(variance);
    return output;
  }
  
  double getNewStdDeviation(float newDataPoint, double oldVariance, double newAverage, double oldAverage){
    double variance = getNewVariance(newDataPoint, oldVariance, newAverage, oldAverage);
    double output = findStandardDeviation(variance);
    return output;  
  }
  
  Integer getRecord(int index){
    return timeData.get(index);
  }
  
  double getPeriod(){
    return theDataPeriod;
  }
  
  double getVariance(){
    return theVariance;
  }
  
  double getStdDeviation(){
    return theStdDeviation;
  }
  
  String getStdDeviation(int percision){
    float stdDevInSec = (float)theStdDeviation / 1000.0;
    String output;
    switch (percision){
      case 0:
        output = String.format("%.0f", stdDevInSec);
        break;
      case 1:
        output = String.format("%.1f", stdDevInSec);
        break;
      case 3:
        output = String.format("%.3f", stdDevInSec);
        break;  
      case 2:
      default:
        output = String.format("%.2f", stdDevInSec);
        break;
    }
    output += "s ";   
    return output;
  }
    

  
  String getPeriod(int percision){
    float periodInSec = (float)theDataPeriod / 1000.0;
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
