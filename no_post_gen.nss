//no_post_gen.nss - Vygenerovani postovnio ukolu

//#include "no_post_inc"
#include "ku_libtime"
#include "ku_baliky_inc"

void main() {
  object oNPC = OBJECT_SELF;
  int iID = GetLocalInt(oNPC,"SQ_BALIKY_ID");

  if(iID <= 0) {
    SpeakString("Chyba! Nemam nastavene ID pro postovni baliky!");
    return;
  }

  /* There s already generated quest */
  if(GetLocalInt(oNPC,"sq_balik_waiting")) 
    return;



  //pokud nema nic k odeslani, tak se pokusi vygenerovat novou

  // If last quest was not long ago
  if (GetLocalInt(OBJECT_SELF,"sq_balik_lastquest") > ku_GetTimeStamp())
    return;

  if(Random(100) > 79) { //  Vygeneruj quest s tricetiprocentni sanci
    SetLocalInt(OBJECT_SELF,"sq_balik_lastquest",ku_GetTimeStamp(0,140));
    //140 minut v pripade ze zadny quest neni
    return;
  }



  //generate quest
  struct q_balik route;
  route = ku_bal_GetRandomRoute(iID);
  if(route.iTo == 0) {
    SpeakString("Chyba! Nemuzu vytvorit zadnou zasilku!");
    return;
  }

  //Create item
  string sResref;
  switch(Random(7)) {
    case 0: sResref = "no_balik007"; break;
    case 1: sResref = "no_balik001"; break;
    case 2: sResref = "no_balik002"; break;
    case 3: sResref = "no_balik003"; break;
    case 4: sResref = "no_balik004"; break;
    case 5: sResref = "no_balik005"; break;
    case 6: sResref = "no_balik006"; break;
  }
  // We need to create item now to know the weight
  object oItem = CreateItemOnObject(sResref, oNPC, 1);
  SetName(oItem,"Zasilka pro "+route.sTo);

  SetLocalInt(oNPC,"sq_balik_waiting",TRUE);
  SetLocalInt(oNPC,"sq_balik_to",route.iTo);
 // SetLocalInt(oNPC,"sq_balik_diff",route.iDifficulty);
  SetLocalString(oNPC,"sq_balik_to",route.sTo);
  SetLocalObject(oNPC,"sq_balik_item",oItem);


  //Compute price
  float fRandomBonus = 1.0 + IntToFloat(Random(6)) / 10.0; // 1.0 - 1.5
  int iPrice = FloatToInt(10.0 * IntToFloat(5 + route.iDifficulty) * fRandomBonus * sqrt(IntToFloat(GetWeight(oItem)/10)));
  SetLocalInt(oNPC,"sq_balik_price", iPrice); 
  SetLocalInt(oItem,"sq_balik_price", iPrice);
  SetLocalInt(oItem,"sq_balik_to",route.iTo);
  
  int iTime = 2 +  Random(10);
  SetLocalInt(oNPC,"sq_balik_timelimit",iTime);
  

}
