//+------------------------------------------------------------------+
//|                                              k_logging_basic.mqh |
//|                                                     kopitore.com |
//|                                            https://kopitore.com/ |
//+------------------------------------------------------------------+
#property copyright "kopitore.com"
#property link      "https://kopitore.com/"
#property strict

const int CRITICAL_LEVEL = 4;
const int ERROR_LEVEL = 3;
const int WARNING_LEVEL = 2;
const int INFO_LEVEL = 1;
const int DEBUG_LEVEL = 0;

void logging(int msg_level, string message) {
   if (msg_level >= g_logging_level_setting) {
      Print(message);
   }
}