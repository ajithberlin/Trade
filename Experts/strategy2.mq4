//+------------------------------------------------------------------+
//|                                                         demo.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#include <stderror.mqh>
#include <stdlib.mqh>
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
input double dExpectedProfit = .0004;
extern double dInitialLots = 0.01;
extern int iPips = 1;
input int iMultiplier = 2;
double dStopLoss = 0;
double dTakeProfit = 0;
double dBuyPrice ;
double dAccumulatedLotSize = 0.00;
double dSellPrice;// = Ask + dExpectedProfit;
double dBuyLotSize = dInitialLots;
double dLastBuyPrice = 0.00;
double dLastBuyLots = 0.00;
int lastBuyOrder;
double lastOrderProfit;


//Threshold limts
double safeThresholdLotSize = 0.3; //if safthreshold reached not buy lots until level1 thresholdlots
double level1ThresholdLotSize = 0.5;
double maxThresholdLotSize = 0.9; //if max thresholde reached will not buy any lots

bool isSafeLevelReached = false;
bool isLevel1Reached = false;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit(){   
   if(dBuyPrice <= 0)
   {
      dBuyPrice = Ask;
   }
      determineOpenLots();
      determineBuyPrice();
      determineSellPrice();   
        EventSetTimer(1);

   return(INIT_SUCCEEDED);
  }
  
  double calculateLotSize(){
   return dLastBuyLots * iMultiplier;
  }
  
  void calculateBuyLotSize(){
      if(dBuyLotSize <=0){
        dBuyLotSize = dInitialLots;
      }else{
        dBuyLotSize = dBuyLotSize*iMultiplier;
      }
  }

  void determineSellPrice(){
   dSellPrice = dLastBuyPrice + dExpectedProfit;
  }
  
  void determineBuyPrice(){
      if(dLastBuyPrice != 0.00){
        dBuyPrice = dLastBuyPrice - dExpectedProfit;
      }
      if(dBuyPrice<= 0.00){
        dBuyPrice = Ask;
      }
  }
  
  void determineOpenLots(){
  
    double dTotalOpenLots = 0;
    for(int iPos = OrdersTotal()-1; iPos >= 0 ; iPos--) 
    {
        if (
            OrderSelect(iPos, SELECT_BY_POS, MODE_TRADES)                    // Only my orders w/
            &&  OrderSymbol()       == Symbol()                 // and my pair.
        ){
            dTotalOpenLots += OrderLots();
            
            if (lastBuyOrder <= OrderTicket()){
                lastBuyOrder = OrderTicket();
                dLastBuyLots = OrderLots();
                lastOrderProfit = OrderProfit();
                dLastBuyPrice = OrderOpenPrice();
            }
        
        }
    }
    printf("Last Buy Price: %f , Last Buy Order#: %i",dLastBuyPrice,lastBuyOrder);
    dAccumulatedLotSize = dTotalOpenLots;
  }
 
 void modifyOrder(double price)
 {
   for(int iPos = OrdersTotal()-1; iPos >= 0 ; iPos--)
   {
      //if(OrderSelect(iPos, SELECT_BY_POS, MODE_TRADES) &&  OrderSymbol() == Symbol() && ((OrderProfit()>0.00) || (OrderProfit() < 0.00)))
      if(OrderSelect(iPos, SELECT_BY_POS, MODE_TRADES) &&  OrderSymbol() == Symbol())
      {
         printf("Modify TP/SL %f; Order price: %f; Ask: %f; Bid: %f",(price + dExpectedProfit) , OrderOpenPrice(),Ask,Bid);
         if(price + dExpectedProfit < OrderOpenPrice()) //stop loss
         {
            if(price + dExpectedProfit < Ask)
            {
               printf("1. Order# %d Modifing; Stop loss: %f ",OrderTicket(),price+dExpectedProfit);
               if(!OrderModify(OrderTicket(),OrderOpenPrice(),price + dExpectedProfit,OrderTakeProfit(),OrderExpiration()))
               {
                  printf("1. Order# %d Not Modified; Stop loss: %f ",OrderTicket(),price+dExpectedProfit);
               }
            }else
            {
               printf("2. Order# %d Modifying; Stop loss: %f ",OrderTicket(),price+dExpectedProfit);
               if(!OrderModify(OrderTicket(),OrderOpenPrice(),Ask-0.00001,OrderTakeProfit(),OrderExpiration()))
               {
                  printf("2. Order# %d Not Modified; Stop loss: %f ",OrderTicket(),Ask-0.00001);
               }
            }
      
         }else{
               printf("3. Order# %d Modifying; Take profit: %f ",OrderTicket(),price+dExpectedProfit);
               if(!OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),price + dExpectedProfit,OrderExpiration()))
               {
                  printf("3. Order# %d Not Modified; Take Profit: %f ",OrderTicket(),price+dExpectedProfit);
               }
              }
      }
   }
 
 }
 //+------------------------------------------------------------------+
 //| Place sell order                                                  |            
 //+------------------------------------------------------------------+ 
 int placeSellOrder(double dPrice, double orderLots)
  {
   
    int iOrderNumber = 0;

    if(orderLots <= dAccumulatedLotSize){
                
        for(int iPos = OrdersTotal()-1; iPos >= 0 ; iPos--) 
        {
            if (
                OrderSelect(iPos, SELECT_BY_POS, MODE_TRADES)                    // Only my orders w/
                &&  OrderSymbol()       == Symbol()                 // and my pair.
            ){  
                if((OrderProfit()>0.00) || (OrderProfit() < 0.00)){
                    printf("Order# %d Lots: %f Sell Price: %f",OrderTicket(),OrderLots(), dPrice);
                    bool bStatus = OrderClose(OrderTicket(),OrderLots(),dPrice,iPips);
                    
                    if(!bStatus){
                        printf("Failed to close the order %d with price %f. Lot Size: %f. Order Close Price %f" , OrderTicket(), Ask , OrderLots(),OrderProfit() );
                    }
                }
            }
        }
    }else{
        printf("Sell Price: %f; Bid Price: %f; Lot: %f",dPrice,Bid, orderLots);

        iOrderNumber = OrderSend(Symbol(),OP_SELL,orderLots,dPrice,iPips,dStopLoss,dPrice+dExpectedProfit,"",0,TimeCurrent()+700);
        printf("Order# %d Sell Price: %f; Lot: %f",iOrderNumber, dPrice, orderLots);
        dBuyLotSize = dBuyLotSize - orderLots;

    }    
    determineOpenLots();
    determineSellPrice();

    return iOrderNumber;
  }

 void calculateAccumulateLotSize(){
      dAccumulatedLotSize = dAccumulatedLotSize + dBuyLotSize;
    if(dAccumulatedLotSize >= level1ThresholdLotSize){
        isLevel1Reached = true;
    }else if(dAccumulatedLotSize >=safeThresholdLotSize){
        isSafeLevelReached = true;
        isLevel1Reached = false;
    }else{
        isSafeLevelReached = false;
        isLevel1Reached = false;
    }
 }
 //+------------------------------------------------------------------+
 //| Place buy order                                                  |            
 //+------------------------------------------------------------------+
 int placeBuyOrder(double buyLotSize, double price)
  {
   int iOrderNumber = 0;
   
   printf("Buy Price: %f; Bid Price: %f; Lot: %f",price,Bid, buyLotSize);
   
   iOrderNumber = OrderSend(Symbol(),OP_BUY,buyLotSize,price,iPips,dStopLoss,price+dExpectedProfit,"",0,TimeCurrent()+700);
    
    
   
   printf("Order# %d Buy Price: %f; Lot: %f",iOrderNumber, price, buyLotSize);
   if(iOrderNumber > 0)
   {
      printf("Order # %f; OrderPrice: %f", OrderTicket(),OrderOpenPrice());
      modifyOrder(price);
      calculateAccumulateLotSize()
      dLastBuyPrice = price;
      dLastBuyLots = buyLotSize;
   }
   determineBuyPrice();
   printf("Accumulated Lot Size: %f",dAccumulatedLotSize);
   return iOrderNumber;
   
   }
   
  
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
    EventKillTimer();
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{}

void OnTimer(){
   determineOpenLots();
   determineBuyPrice();
   determineSellPrice();

   double askPrice = Ask;
   double bidPrice = Bid;
   
   if (dAccumulatedLotSize > 0){
     if(bidPrice>=dSellPrice){
        if(isLevel1Reached || dLastBuyLots<=0){
            placeSellOrder(dSellPrice, dAccumulatedLotSize);
        }else if{
            placeSellOrder(dSellPrice, dLastBuyLots);
            dLastBuyLots = dLastBuyLots / iMultiplier;
        }
    }else if(askPrice <= dBuyPrice && dLastBuyPrice > dBuyPrice){
      calculateBuyLotSize();
      if(dAccumulatedLotSize<=safeThresholdLotSize){
        placeBuyOrder(dBuyLotSize,dBuyPrice);
      }else if(dAccumulatedLotSize>=level1ThresholdLotSize && dAccumulatedLotSize<=maxThresholdLotSize){
        placeBuyOrder(dBuyLotSize,dBuyPrice);
      }else{
          if(isSafeLevelReached){
            printf("not buying lot coz safe threshold reached");
          }else{
            printf("not buying lot coz max threshold reached");
          }
      }
    }
   }else if(){
      dBuyLotSize = dInitialLots;
      placeBuyOrder(dBuyLotSize, dBuyPrice);
   }
   
}
//+------------------------------------------------------------------+