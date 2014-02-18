//no_post_rictco.nss Tell quest


void main()
{
  object oPC = GetPCSpeaker();
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

  SpeakString("Mam tady balik pro " + sTo + " vazici " + IntToString(GetWeight(oItem)/10) + " liber. Kdyz ho stihnes dorucit za " +IntToString(GetLocalInt(OBEJCT_SELF,"sq_balik_timelimit")) + " hodin, daji ti za nej " + IntToString(iPrice) + " gresli. Kdyz to nestihnes, daji ti jen petinu gresli. Jako zalohu si od tebe vezmu desetinu ceny baliku. ");

  if  (GetGold(oPC) < (iPrice/10)) {
SendMessageToPC(oPC, "-------------------------------------" );
SendMessageToPC(oPC, " Nemas dostatek penez na odkup baliku " );
SendMessageToPC(oPC, "-------------------------------------" );
  }
}
