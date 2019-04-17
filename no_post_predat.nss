//no_post_predat.nss Predej postovni balik
#include "ku_libtime"


int __reduceXpByLevel(int iXP, object oPC)
{
  int iHD = GetHitDice(oPC);
  if(iHD > 15)
    return 0;
  if(iHD > 10)
    return iXP/2;
  return iXP;
}

void main()
{

  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;
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
    DelayCommand(0.2,SpeakString(" *prohlidne si balik* Tenhle balik uz tu davno mel byt. Dostanes za nej jen petinu ceny, coz dela " + IntToString(iPrice/5) + " gresli"));
    DestroyObject(oItem,0.1);
    GiveGoldToCreature(oPC,iPrice/5);
    return;
  }
  DelayCommand(0.2,SpeakString(" *prohlidne si balik* Tak, tenhleten balik je tu vcas, coz dela " + IntToString(iPrice)  + " gresli"));
  DestroyObject(oItem,0.1);
  GiveGoldToCreature(oPC,iPrice);

  /* Give XP */
  int iXP = iPrice;
  if(iXP > 1000)
    iXP = 1000;

  /* Reduce XP by PC level */
  iXP = __reduceXpByLevel(iXP, oPC);

  if(iXP > 0)
    SetXP(oPC, GetXP(oPC) + iXP);


}
