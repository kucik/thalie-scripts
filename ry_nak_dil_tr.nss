#include "nw_i0_plot"

void main() {
  int iPrice = 50000;
  object oPC = GetPCSpeaker();
  if(GetGold(oPC) >= iPrice) {
    TakeGold(iPrice,oPC);
    CreateItemOnObject("ry_kl_dil_trezor",oPC,1);
  }
  else {
   SpeakString("Nemáš dost zlata.");
  }
}
