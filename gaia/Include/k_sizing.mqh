//+------------------------------------------------------------------+
//|                                                     k_sizing.mqh |
//|                                                     kopitore.com |
//|                                            https://kopitore.com/ |
//+------------------------------------------------------------------+
#property copyright "kopitore.com"
#property link      "https://kopitore.com/"
#property strict

#include <Object.mqh>
#include <k_toolbox.mqh>
#include <k_display_price_volume.mqh>

enum VolumeSizingMode
{
   VolumeSizingMode_MS  =  0,    //VolumeSizingMode MS: MaSter
   VolumeSizingMode_FX  =  1,    //VolumeSizingMode FX: FiXed
   VolumeSizingMode_BP  =  2,    //VolumeSizingMode BP: Balance Percent
   VolumeSizingMode_EP  =  3,    //VolumeSizingMode EP: Equity Percent
   VolumeSizingMode_FMP =  4,    //VolumeSizingMode FMP: Free Margin Percent
   VolumeSizingMode_C   =  5,    //VolumeSizingMode C: custom
};

//ToDo: risk volume based (we need to know SL distance)

double getVolume(VolumeSizingMode volume_sizing, string symbol, double master_vol, double lotsize_usd, double lotsize_jpy, double lotsize_thb)
{
   double volume = g_FX_FixedVolume_setting;
   /*
   if (volume_sizing == VolumeSizingMode_MS) { // MS: Master
      volume = g_MS_VolumeRatio_setting * master_vol;  
   } else if (volume_sizing == VolumeSizingMode_FX) { // FX: fixed
      volume = g_FX_FixedVolume_setting;
   
   } else if (volume_sizing == VolumeSizingMode_C) { // C: custom
      volume = 0.02;
      return (volume);
   }
   */
   //double max_volume = MathMin(MarketInfo(symbol, MODE_MAXLOT), g_MaxVolume_setting);
   //double min_volume = MathMax(MarketInfo(symbol, MODE_MINLOT), g_MinVolume_setting);

   if(lot_mode == Copy){
      volume = master_vol;
   }else if(lot_mode == Copy_multiplier){
      volume = master_vol * lot_multiplier;
   }else if(lot_mode == Optimize){
      if(g_deposit_currency_setting == "USD"){
         volume = AccountBalance() * lotsize_usd / 100;
      }else if(g_deposit_currency_setting == "JPY"){
         volume = AccountBalance() * lotsize_jpy / 100;
      }else if(g_deposit_currency_setting == "THB"){
         volume = AccountBalance() * lotsize_thb / 100;
      }
   }
   
   double max_volume = MarketInfo(symbol, MODE_MAXLOT);
   double min_volume = MarketInfo(symbol, MODE_MINLOT);
   
   int lot_digits = VolumeDigits(symbol);
   volume = MathCeil(volume * 100) / 100;
   
   if (volume <= 0) volume = 0.01;
   if (volume < min_volume && min_volume > 0) volume = min_volume;
   if (volume > max_volume && max_volume > 0) volume = max_volume;
   
   return (volume);
}