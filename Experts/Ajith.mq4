
input int      tradeVolume = 0.01;         // Trading volume
input double   stopLoss    = 50.0;      // Stop loss in points
input double   takeProfit  = 100.0;     // Take profit in points
double param1 = 1.0; // define value for param1
double param2 = 2.0; // define value for param2

   // Define the custom indicator parameters
   string indicatorName = "Nadaraya-Watsan-estimator";
int OnInit()
{
    int chartPeriod = Period();
    printf("Period %f",chartPeriod);
    EventSetTimer(chartPeriod*5);
    return(INIT_SUCCEEDED);
}

void OnTimer() {
   Print("--------------new Line------------------");
   Print("OnNewBar");
   startMethod();
}

void PrintIn(){
   double indicatorValue = iCustom(_Symbol, PERIOD_CURRENT,indicatorName, 1,2,0);
   printf("indicatorValue %d",indicatorValue);
   
   color myColor;

   if (indicatorValue > 0) {
       myColor = Green;
       Print("color is green");
   } else {
       myColor = Red;
       Print("color is red");
   }

}

int startMethod() {
  PrintIn();
  //printIndicator();
   //printf("red: %f",Red);
   //printf("green: %f",Green);
   // Check if the color is red (0) and there are no open sell trades
   /**if (indicatorColor == 0 && OrdersTotal() == 0) {
      // Open a sell trade
      double lotSize = 0.1;
      double stopLoss = Bid + 50 * Point;
      double takeProfit = Bid - 100 * Point;
      int magicNumber = 12345;
      int ticket = OrderSend(_Symbol, OP_SELL, lotSize, Bid, 5, stopLoss, takeProfit, "Sell order", magicNumber);
      
      if (ticket > 0) {
         // Order opened successfully
         Print("Sell order opened: ", OrderTicket());
      } else {
         // Order failed to open
         Print("Error opening sell order: ", GetLastError());
      }
   }
   
   // Check if the color is green (1) and there is an open sell trade
   if (indicatorColor == 1 && OrdersTotal() > 0) {
      // Close all open sell trades
      for (int i = OrdersTotal() - 1; i >= 0; i--) {
         if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
            if (OrderType() == OP_SELL) {
               bool result = OrderClose(OrderTicket(), OrderLots(), Bid, 5);
               
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
   }*/
   
   return 0;
}
