//+------------------------------------------------------------------+
//|                                             IndicatorPrinter.mq4 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetTimer(5);
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
      // get the current color of the Moving Average indicator
      double current = iCustom(_Symbol, Period(), "Nadaraya-Watsan-estimator.ex4", 4.0, 0,500,0,1);
      double previous = iCustom(_Symbol, Period(), "Nadaraya-Watsan-estimator.ex4", 4.0, 0,500,0,2);
      double beforePrevious = iCustom(_Symbol, Period(), "Nadaraya-Watsan-estimator.ex4", 4.0, 0,500,0,3);
      
      // Determine the indicator color
      color indicatorColor;
      if (current > previous && previous > beforePrevious) {
          indicatorColor = clrLime;
          Print("color Lime");
      } else if (current < previous && previous < beforePrevious) {
          indicatorColor = clrRed;
          Print("color Red");
      } else {
          indicatorColor = clrYellow;
          Print("color Yellow");
      }
      
      // Output the indicator color
      Print("Indicator Color: ", ColorToString(indicatorColor));

   
  }
//+------------------------------------------------------------------+
