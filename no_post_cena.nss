// no_post_cena.nss - Tell quest result price
#include "ku_libtime"

void main()
{
  object oPC = GetPCSpeaker();
  int iID = GetLocalInt(oNPC,"SQ_BALIKY_ID");
  
  if(iID <= 0) {
    SpeakString("Chyba! Nemam nastavene ID pro postovni baliky!");
    return;
  }

  object oItem = GetFirstItemInInventory(oPC);
  while(GetIsObjectValid(oItem)) {
    if((GetTag(oItem)=="no_balik") &&
       (GetLocalInt(oItem,"sq_balik_to") == iID) )
      break;
    oItem = GetNextItemInInventory(oPC); 
  }

  if(!GetIsObjectValid(oItem)) {
    DelayCommand(0.3,SpeakString( " Nemas u sebe zadny balik pro mne." ));
    return;
  }

  int iPrice = GetLocalInt(oItem,"sq_balik_price");
  if(GetLocalInt(oItem, "sq_balik_time") < ku_GetTimeStamp()) {
    DelayCommand(no_delay,SpeakString(" *prohlidne si balik* Tenhle balik uz tu davno mel byt. Dostanes za nej jen petinu ceny, coz dela " + IntToString(iPrice/5) + " gresli"));
    return;
  }
  DelayCommand(no_delay,SpeakString(" *prohlidne si balik* Tak, tenhleten balik je tu vcas, coz dela " + IntToString(iPrice)  + " gresli"));
  
  
}
