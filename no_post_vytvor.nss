
// predam balik od NPC cka hraci a balik u NPC znicim, cimz umoznim generovani dalsich Q
#include "ku_libtime"

void main()
{
  object oPC = GetPCSpeaker();
  object oNPC = OBJECT_SELF;
  int iID = GetLocalInt(oNPC,"SQ_BALIKY_ID");

  if(iID <= 0) {
    SpeakString("Chyba! Nemam nastavene ID pro postovni baliky!");
    return;
  }

  /* There s already generated quest */
  if(!GetLocalInt(oNPC,"sq_balik_waiting")) {
    SpeakString( " Nemam tu pro tebe zadne baliky " );
    return;
  }

  object oItem = GetLocalObject(OBJECT_SELF,"sq_balik_item");
  if(!GetIsObjectValid(oItem)) {
    SpeakString("Chyba! Ztratil se nam balicek!");
    return;
  }

  string sTo = GetLocalString(OBJECT_SELF,"sq_balik_to");
  int iPrice = GetLocalInt(oItem,"sq_balik_price");

  if  (GetGold(oPC) < (iPrice/10)) {
    SpeakString("Nemas u sebe dost zlata na zalohu. Takhle ti balicek nedam.");
  }
  
  int iTime = GetLocalInt(oNPC, "sq_balik_timelimit");
  int iTimelimit = ku_GetTimeStamp(0,10 * iTime); //Ma cas iTime hodin
  SetLocalInt(oItem,"sq_balik_time",iTimelimit);

  if  (GetGold(oPC) < iPrice/10 ) {
    SpeakString(" Nesnaz se me podvadet ! ");
    SendMessageToAllDMs("postava " + ObjectToString(oPC) + "podvadi pri postovnim Q. Dava pravdepodobne zalohu na zem");
    return;
  }

  TakeGoldFromCreature(iPrice/10 ,oPC,TRUE);
  CopyItem(oItem,oPC,TRUE);

  //cleanup
  DeleteLocalInt(oNPC,"sq_balik_waiting");
  DeleteLocalObject(oNPC,"sq_balik_item");
  SetLocalInt(OBJECT_SELF,"sq_balik_lastquest",ku_GetTimeStamp(0,160));
  

  DestroyObject(oItem);

}
