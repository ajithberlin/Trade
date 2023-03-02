//+------------------------------------------------------------------+
//|                                                    Beast 1.0.mq4 |
//|                                                     Hawk Trading |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#include <stderror.mqh>
#include <stdlib.mqh>

#property copyright "Hawk Trading"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

extern double dStepSize = .0004;
input double dExpectedProfit = 100;
input double dExpectedLoss = -100;
extern double dInitialLots = 0.01;
input double iMultiplier = 2;

int iPips = 1;
double dSellStopLoss = 0;
double dBuyStopLoss = 0;
double dSellTakeProfit = 0;
double dBuyTakeProfit = 0;
double dAvgSellClosePrice = 0;
double dAvgBuyClosePrice = 0;
double dMinBuyPrice = 0;
double dMaxBuyPrice = 9999;
double dMinSellPrice = 0;
double dMaxSellPrice = 9999;
double dAccumulatedBuyLotSize = 0.00;
double dAccumulatedSellLotSize = 0.00;
double dLastBuyLots = 0.00;
double dLastSellLots = 0.00;
double dLastOrderLots = 0.00;
double dLastBuyPrice = 0.00;
double dLastSellPrice = 0.00;
double avgSellPrice = 0;
double avgBuyPrice = 0;
double dLastExecutedPrice = 0.00;

int OnInit()
{
   EventSetTimer(1);
   return(INIT_SUCCEEDED);
   
}
  
  
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   EventKillTimer();
}

void initVariable()
{
   
   iPips = 1;
   dSellStopLoss = 0;
   dBuyStopLoss = 0;
   dSellTakeProfit = 0;
   dBuyTakeProfit = 0;
   dAvgSellClosePrice = 0;
   dAvgBuyClosePrice = 0;
   dMinBuyPrice = 0;
   dMaxBuyPrice = 9999;
   dMinSellPrice = 0;
   dMaxSellPrice = 9999;
   dAccumulatedBuyLotSize = 0.00;
   dAccumulatedSellLotSize = 0.00;
   dLastBuyLots = 0.00;
   dLastSellLots = 0.00;
   dLastBuyPrice = 0.00;
   dLastSellPrice = 0.00;
   avgSellPrice = 0;
   avgBuyPrice = 0;
   dLastOrderLots = 0.00;

}
  
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
   //printf("--------------Begin---------------");
   double profit=0;
   calcMinMaxPrice();
   if((Ask-Bid) >= dStepSize)
   {
      dStepSize = dStepSize + Point;
   }
   printf("step: %f",dStepSize);
   if (dAccumulatedBuyLotSize > 0)
   {
      //if(Ask >= (dMaxBuyPrice + dStepSize))
      if(Ask >= (dLastExecutedPrice + dStepSize) )
      {
         //printf("Buy Order Number: %d",placeBuyOrder((dAccumulatedBuyLotSize+dAccumulatedSellLotSize)));
         //placeBuyOrder(((dAccumulatedBuyLotSize+dAccumulatedSellLotSize)*iMultiplier)/(2*dInitialLots));
         placeBuyOrder(dLastOrderLots*iMultiplier);
      }
      if(Ask <= (dMinBuyPrice - dStepSize))
      {
       //  printf("Buy Order Number: %d",placeBuyOrder(dLastBuyLots*iMultiplier));
      }
   }
   else
   {
      printf("Buy Order Number: %d",placeBuyOrder(dInitialLots));
   }
   if (dAccumulatedSellLotSize > 0)
   {
      //if(Bid >= (dMaxSellPrice + dStepSize))
      if(Bid >= (dLastExecutedPrice + dStepSize))
      {
        // printf("Sell Order Number: %d",placeSellOrder(dLastSellLots*iMultiplier));
      }
      //if(Bid <= (dMinSellPrice - dStepSize))
      if(Bid <= (dLastExecutedPrice - dStepSize))
      {
         //printf("Sell Order Number: %d",placeSellOrder(dAccumulatedBuyLotSize+dAccumulatedSellLotSize));
         //placeSellOrder(((dAccumulatedBuyLotSize+dAccumulatedSellLotSize)*iMultiplier)/(2*dInitialLots));
         placeSellOrder(dLastOrderLots*iMultiplier);
      }
   }
   else
   {
      printf("Sell Order Number: %d",placeSellOrder(dInitialLots));
   }
   
   calcMinMaxPrice();
   
   //printf("Accumulated Buy: %f; Max Buy Price: %f; Min Buy Price: %f ",dAccumulatedBuyLotSize,dMaxBuyPrice,dMinBuyPrice);
   //printf("Accumulated Sell: %f; Max Sell Price: %f; Min Sell Price: %f ",dAccumulatedSellLotSize,dMaxSellPrice,dMinSellPrice);
   //printf("Total Profit: %f; Expected Profit: %f ",totalProfit(),((dInitialLots* dExpectedProfit ) + (Ask - Bid)));
   if (dAccumulatedBuyLotSize > 0 || dAccumulatedSellLotSize > 0)
   {
   //printf("%f",totalProfit());
      //if(Ask >= dMaxBuyPrice || Bid <= dMinSellPrice)
      //{
      profit = totalProfit(); 
      if(profit >  dExpectedProfit   )
      {
    //     printf("Total Profit: %f", totalProfit());
         //printf("Total Profit: %f; Expected Profit: %f ",totalProfit(),dExpectedProfit);
           printf("Total Proft: %f, Expected Profit: %f", profit, dExpectedProfit  );
           closeOpenOrders();
      }
      //}
   }
   
   if (dAccumulatedBuyLotSize > 0 || dAccumulatedSellLotSize > 0)
   {
   //printf("%f",totalProfit());
      //if(Ask >= dMaxBuyPrice || Bid <= dMinSellPrice)
      //{
      profit = totalProfit(); 
      if(profit <=  dExpectedLoss   )
      {
    //     printf("Total Profit: %f", totalProfit());
         //printf("Total Profit: %f; Expected Profit: %f ",totalProfit(),dExpectedProfit);
           printf("Total Loss: %f, Expected Loss: %f", profit, dExpectedLoss  );
           closeOpenOrders();
      }
      //}
   }
  // printf("--------------End---------------");
}

void calcMinMaxPrice()
{
   double dTotalOpenSellLots = 0;
   double dTotalOpenBuyLots = 0;
   int lastSellOrder = 0;
   int lastBuyOrder = 0;
   initVariable();
   for(int iPos = OrdersTotal()-1; iPos >= 0 ; iPos--) 
    {
      if (OrderSelect(iPos, SELECT_BY_POS, MODE_TRADES) &&  OrderSymbol() == Symbol())
      {
         if(dLastOrderLots < OrderLots())
         {
            dLastOrderLots = OrderLots();
         }
         if(OrderType() == OP_SELL)
         {
            dTotalOpenSellLots += OrderLots();
            if (lastSellOrder <= OrderTicket())
            {
               lastSellOrder = OrderTicket();
               dLastSellLots = OrderLots();
               dLastSellPrice = OrderOpenPrice();
            }
            if(dMinSellPrice == 0 || OrderOpenPrice() < dMinSellPrice)
            {
               dMinSellPrice = OrderOpenPrice();
            }
            if(dMaxSellPrice == 9999 || OrderOpenPrice() > dMaxSellPrice)
            {
               dMaxSellPrice = OrderOpenPrice();
            }
         }else
         {
            dTotalOpenBuyLots += OrderLots();
            if (lastBuyOrder <= OrderTicket())
            {
               lastBuyOrder = OrderTicket();
               dLastBuyLots = OrderLots();
               dLastBuyPrice = OrderOpenPrice();
            }
            if(dMinBuyPrice == 0 || OrderOpenPrice() < dMinBuyPrice)
            {
               dMinBuyPrice = OrderOpenPrice();
            }
            if(dMaxBuyPrice == 9999 || OrderOpenPrice() > dMaxBuyPrice)
            {
               dMaxBuyPrice = OrderOpenPrice();
            }
         }
      }
     
    }
    dAccumulatedSellLotSize = dTotalOpenSellLots;
    dAccumulatedBuyLotSize = dTotalOpenBuyLots;
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

double totalProfit()
{
   //double totalSellCost = 0;
   //double totalBuyCost = 0;
   //double slippage = Point * 10;
   //double slippage = 0;
   //double totalSellCost_temp = 0;
   //double totalBuyCost_temp = 0;
   //string baseCurrency = StringSubstr(Symbol(),3);
   double profit = 0;
   
   for(int iPos = OrdersTotal()-1; iPos >= 0 ; iPos--) 
    {
      if (OrderSelect(iPos, SELECT_BY_POS, MODE_TRADES) &&  OrderSymbol() == Symbol())
      {
         profit += OrderProfit(); 
         //if(OrderType() == OP_SELL)
         //{
            //totalSellCost +=  (OrderLots() * (OrderOpenPrice() - slippage ) );
          //  totalSellCost_temp += (OrderLots() * (OrderOpenPrice()  ) );
            
         //}
         //if(OrderType() == OP_BUY)
         //{
            //totalBuyCost +=  (OrderLots() * (OrderOpenPrice() + slippage));
          //  totalBuyCost_temp += (OrderLots() * OrderOpenPrice() );
         //}
      }
    }
    
    //if (baseCurrency != "USD")
    //{
      //printf("Total Sell Cost: %f; Total Buy Cost: %f; Profit: %f",totalSellCost_temp,totalBuyCost_temp,(((totalSellCost_temp - (dAccumulatedSellLotSize * Ask))/Ask) + (((dAccumulatedBuyLotSize * Bid) - totalBuyCost_temp)/Bid)) * 100000);
      //profit = (((totalSellCost_temp - (dAccumulatedSellLotSize * Ask))/Ask) + (((dAccumulatedBuyLotSize * Bid) - totalBuyCost_temp)/Bid)) * 100000;
      
    //}else{
      //printf("Total Sell Cost: %f; Total Buy Cost: %f; Profit: %f",totalSellCost_temp,totalBuyCost_temp,((totalSellCost_temp - (dAccumulatedSellLotSize * Ask)) + ((dAccumulatedBuyLotSize * Bid) - totalBuyCost_temp)) * 100000);
      //return ((totalSellCost_temp - (dAccumulatedSellLotSize * Ask)) + ((dAccumulatedBuyLotSize * Bid) - totalBuyCost_temp)) * 100000;
      //profit = ((totalSellCost_temp - (dAccumulatedSellLotSize * Ask)) + ((dAccumulatedBuyLotSize * Bid) - totalBuyCost_temp)) * 100000;
    //}
    //printf("Order Profit: %f ",profit);
         
    return profit;
    
}

void closeOpenOrders()
{
   printf("closing orders");
   for(int iPos = OrdersTotal()-1; iPos >= 0 ; iPos--) 
   {
      if (OrderSelect(iPos, SELECT_BY_POS, MODE_TRADES) && OrderSymbol() == Symbol())
      {
         if(OrderType() == OP_SELL){
            bool res = OrderClose(OrderTicket(),OrderLots(),Bid,iPips); 
         }else{
            bool res = OrderClose(OrderTicket(),OrderLots(),Ask,iPips); 
         }
      }
   }
   dLastExecutedPrice = 0.00;
   
}

