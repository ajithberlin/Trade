//+------------------------------------------------------------------+
//|                                                ColorStrategy.mq4 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include <stderror.mqh>
#include <stdlib.mqh>

input color upColor=clrGreen;
input color dropColor=clrRed;
input color neutralColor=clrYellow;

input string indicatorName="Nadaraya-Watsan-estimator.ex4";
//input int candlePeriod = _Period;
input int colorGapPeriod =1;
int colorTimeFrame = 60* _Period * colorGapPeriod;


double lotSize = 0.1;
double stopLoss = Bid + 50 * Point;
double takeProfit = Bid - 100 * Point;
int magicNumber = 12345;
color perviousColor=NULL;

extern double dStepSize = .0004;
input double dExpectedProfit = 100;
input double dExpectedLoss = -100;
extern double dInitialLots = 0.1;
input double iMultiplier = 2;

int iPips = 1;
double dSellStopLoss = 0;
double dBuyStopLoss = 0;
double dSellTakeProfit = 0;
double dBuyTakeProfit = 0;
double dAvgSellClosePrice = 0;
double dAvgBuyClosePrice = 0;
double dLastExecutedPrice = 0.00;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   printf(_Period);
   EventSetTimer(_Period*60);
   
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
//---
   printf("inside onTimer....");
   color indicatorColor = getCurrentColor();
   if(perviousColor !=NULL && indicatorColor!=perviousColor){
      closeAllTrade();
   }
   if (indicatorColor == upColor && OrdersTotal() == 0) {
      placeBuyOrder(dInitialLots);
   }else if (indicatorColor == dropColor && OrdersTotal() == 0) {
      placeSellOrder(dInitialLots);
   }
   perviousColor = indicatorColor;
  }

void closeAllTrade(){
   for (int i = OrdersTotal() - 1; i >= 0; i--) {
         if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
            if (OrderType() == OP_SELL) {
               bool result = OrderClose(OrderTicket(), OrderLots(), Bid, iPips,clrCoral);
               if (result) {
                  // Order closed successfully
                  Print("Sell order closed: ", OrderTicket());
               } else {
                  // Order failed to close
                  Print("Error closing sell order: ", GetLastError());
               }
            }else {
               bool result = OrderClose(OrderTicket(), OrderLots(), Ask, iPips,clrLightGreen);
               if (result) {
                  // Order closed successfully
                  Print("Sell order closed: ", OrderTicket());
               } else {
                  // Order failed to close
                  Print("Error closing sell order: ", GetLastError());
               }
            }
         }
      }
    dLastExecutedPrice = 0.00;
}
color getCurrentColor(){
      // get the current color of theMoving Average indicator
      double current = iCustom(_Symbol, colorTimeFrame, indicatorName, 4.0, 0,500,0,1);
      double previous = iCustom(_Symbol, colorTimeFrame, indicatorName, 4.0, 0,500,0,2);
      double beforePrevious = iCustom(_Symbol, colorTimeFrame, indicatorName, 4.0, 0,500,0,3);
      
      // Determine the indicator color
      color indicatorColor;
      if (current > previous && previous > beforePrevious) {
          indicatorColor = upColor;
          Print("upColour set");
      } else if (current < previous && previous < beforePrevious) {
          indicatorColor = dropColor;
          Print("dropColour set");
      } else {
          indicatorColor = neutralColor;
          Print("neutralColor set");
      }
      
      // Output the indicator color
      Print("Indicator Color: ", ColorToString(indicatorColor));
      return indicatorColor;
}
int placeSellOrder(double sellLotSize)
{
   int iOrderNumber = 0;
   //printf("Sell Price: %f; Lot Size: %f;  Close Price: %f",Bid,sellLotSize, dAvgSellClosePrice);
   iOrderNumber = OrderSend(Symbol(),OP_SELL,sellLotSize,Bid,iPips,dSellStopLoss,dAvgSellClosePrice,"",0,TimeCurrent()+700);
   if (iOrderNumber > 0){
     // printf("Order Number: %d",iOrderNumber);
     dLastExecutedPrice = Bid;
   }else{
      printf("Error: %s", ErrorDescription(GetLastError()));
   }
   return iOrderNumber;
}

int placeBuyOrder(double buyLotSize)
{
   int iOrderNumber = 0;
   printf("Buy Price: %f; Lot Size: %f; Lot: %f",Ask,buyLotSize);
   //calculateAvgBuyPrice(buyLotSize,Ask);
   iOrderNumber = OrderSend(Symbol(),OP_BUY,buyLotSize,Ask,iPips,dBuyStopLoss,dAvgBuyClosePrice,"",0,TimeCurrent()+700);
   
   if (iOrderNumber > 0){
      //printf("Order Number: %d",iOrderNumber);
      dLastExecutedPrice = Ask;
   }else{
   
      printf("Error: %s", ErrorDescription(GetLastError()));
   }
   
   return iOrderNumber;
}