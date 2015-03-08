#include "tc_constants"
#include "aps_include"
#include "me_soul_inc"
/*
    TC(Thalia craft) - XP system

    31.3.2008 Melvik


    promenne z xp craftu na postave
    TC_XP_PREFIX + IDCraftu

    pro udelovani zkusenosti pouzit nejlepe
    ---------------------------------------------------------------------
    int getXPbyDifficulty(object oPC, int iCraftID, int iChanceOfSucces);
    ---------------------------------------------------------------------
    kde iChanceOfSucces je pravdepodobnost uspechu vyrobku (pocitame ze se vyrobek se nakonec podaril)

*/



// vrati level postavy v craftu iCraftID
int  TC_getLevel(object oPC, int iCraftID);

// vrati xp postavy v craftu iCraftID
int  TC_getXP(object oPC, int iCraftID);

// nastavy xp postavy v craftu iCraftID
void TC_setXP(object oPC, int iCraftID ,int nXP);

// vrati mnozstvi xp pro dany craft, postavu a slozitost vyrobku
int TC_getXPbyDifficulty(object oPC, int iCraftID, int iChanceOfSucces, int iCraftAbility = 10);

// pricte mnozstvi xp pro dany craft, postavu a slozitost vyrobku , vrati prideleny pocet xp
// - navisi se o tuto hodnotu XP postavy
int TC_setXPbyDifficulty(object oPC, int iCraftID, int iChanceOfSucces, int iCraftAbility = 10);

// funkce pro ulozeni a nahrani xp z databaze
//!! dodelat :o)
void TC_saveCraftXPpersistent(object oPC, int iCraftID);
void TC_loadCraftXPpersistent(object oPC);



// vrati level postavy v craftu iCraftID
int  TC_getLevel(object oPC, int iCraftID)
{
    int nXP =TC_getXP( oPC,  iCraftID);

    int i;
    int neededXPForLVL = 0;

    // To get rid off division by zero
    if(nXP <= 0)
      nXP=1;

    if  (GetIsDM(oPC)== TRUE) 
      return 20;

    int iLevel = FloatToInt(0.5 + sqrt(0.25 + (nXP / 500.0)));
    if(iLevel > 20)
      return 20;
   
    return iLevel;

/*    for (i = 1; i < 21; i++)
    {
        neededXPForLVL = i*(i-1)*500; // potrebne xp na i lvl
        if(nXP < neededXPForLVL) return (i-1);
    }

//////nomis 15.3.09 oprava max 20lvl, ze nebude hazet error/////////////////
if (nXP>189999) {
    return 20;
}
//////////////////////////////////////////////////////////////////////
else
   return 0;
*/
}


// vrati xp postavy v craftu iCraftID
int  TC_getXP(object oPC, int iCraftID)
{
object oSoulStone = GetSoulStone(oPC);
int i_pocet_xpu = GetLocalInt(oSoulStone, TC_XP_PREFIX  + IntToString(iCraftID));

    ///////////6.duben - zkouska perzistence craft xpu.///////////////////////////////////
// Set oObject's persistent integer variable sVarName to iValue
// Optional parameters:
//   iExpiration: Number of days the persistent variable should be kept in database (default: 0=forever)
//   sTable: Name of the table where variable should be stored (default: pwdata)
//int i_pocet_xpu2 =  GetPersistentInt(oPC,"tcXPSystem","tcXPSystem" + IntToString(iCraftID));

/* melvik int i_pocet_xpu2 =  GetPersistentInt(oPC,"tcXPSystem" + IntToString(iCraftID));
if ( i_pocet_xpu2 > i_pocet_xpu )
{
TC_setXP( oPC,  iCraftID ,i_pocet_xpu2);
SendMessageToPC(oPC ,"Ziskano " + IntToString(i_pocet_xpu2-i_pocet_xpu) + " craftovych xp nahranim z databaze");
i_pocet_xpu = i_pocet_xpu2;
}
*/

    return i_pocet_xpu;
}

// nastavy xp postavy v craftu iCraftID
void TC_setXP(object oPC, int iCraftID ,int nXP)
{
    object oSoulStone = GetSoulStone(oPC);
    SetLocalInt(oSoulStone, TC_XP_PREFIX  + IntToString(iCraftID), nXP);

///////////6.duben - zkouska perzistence craft xpu.///////////////////////////////////

// Set oObject's persistent integer variable sVarName to iValue
// Optional parameters:
//   iExpiration: Number of days the persistent variable should be kept in database (default: 0=forever)
//   sTable: Name of the table where variable should be stored (default: pwdata)
//SetPersistentInt(oPC,"tcXPSystem",nXP,0,"tcXPSystem" + IntToString(iCraftID));

 // SetPersistentInt(oPC,"tcXPSystem" + IntToString(iCraftID),nXP,0);
}

// vrati mnozstvi xp pro dany craft, postavu a slozitost vyrobku
int TC_getXPbyDifficulty(object oPC, int iCraftID, int iChanceOfSucces, int iCraftAbility = 10)
{
    int iLVL = TC_getLevel( oPC,  iCraftID) + 1;
    int iAverageNumberOfProducts = (iLVL*(iLVL-1)*20)-((iLVL - 1)*(iLVL -2)*20);
    int iXPbyThisLVL = (iLVL*(iLVL-1)*1000)-((iLVL - 1)*(iLVL -2)*1000);
    //základní xp za uspech = [ (100 - šance na uspìch) /100] * [(pocet vyrobku na akt. level remesla) / (celkem xp za akt levl)]
//    int no_iXPReward = FloatToInt((IntToFloat(100 - iChanceOfSucces)/100.0) * (IntToFloat(iXPbyThisLVL)/IntToFloat(iAverageNumberOfProducts)));

    // uprava o modifikator vlastnosti
    //(1 + modifikator vlastnosti * dulezitost vlastnosti) * základní xp za uspech
//    no_iXPReward = FloatToInt((1.0 + (0.1*IntToFloat(iCraftAbility)))*no_iXPReward);


//NOMIS UPDATE (6cervenec) - moc lidi drbalo, ze je tam spatna progrese na vlastnosti. no hlavne de grasse no :D
//  int iXPReward = FloatToInt((1.0 + (0.12*(IntToFloat(iCraftAbility)-6)))*(IntToFloat(100 - iChanceOfSucces)/100.0) * (IntToFloat(iXPbyThisLVL)/IntToFloat(iAverageNumberOfProducts)));

// NOMIS update- zmirneni minulych veci na : nad 13 vlatnost bez omezeni, a u zakladnich remesel jako pri star


// reward = (( 1.0 + (0.1 * ( ( ability )))) * ( (100 - chance)/100) * ( (LXP) / (ANOP))) 
//int iXPReward = FloatToInt((1.0 + (0.1*(IntToFloat(iCraftAbility))))*(IntToFloat(100 - iChanceOfSucces)/100.0) * (IntToFloat(iXPbyThisLVL)/IntToFloat(iAverageNumberOfProducts)));
  int iXPReward = FloatToInt( (1.0 + (0.1 * iCraftAbility)) * 
                  ((100.0 - iChanceOfSucces)/100.0) * 
                  (IntToFloat(iXPbyThisLVL)/IntToFloat(iAverageNumberOfProducts)));

  if(iCraftAbility<14) {
    switch(iCraftID) {
      case TC_zlatnik:
      case TC_siti:
      case TC_truhlar:
      case TC_kovar:
      case TC_platner:
      case TC_ocarovavac:
      case TC_ALCHEMY:
        iXPReward = FloatToInt( (1.0 + (0.12 * (iCraftAbility-6))) * 
                                ((100.0 - iChanceOfSucces)/100.0) * 
                                (IntToFloat(iXPbyThisLVL)/IntToFloat(iAverageNumberOfProducts)));
        break;
    }
  }

//    SendMessageToPC(oPC ,"Puvodne by si mel: " + IntToString(no_iXPReward) + " XP" );
//    SendMessageToPC(oPC ,"Ted si ziskal: " + IntToString(iXPReward) + " XP" );

    if (ALCHEMY_DEBUG)
    {

        SendMessageToPC(oPC, "iXPReward " + IntToString(iXPReward));
        SendMessageToPC(oPC, "iXPbyThisLVL " + IntToString(iXPbyThisLVL));
        SendMessageToPC(oPC, "iAverageNumberOfProducts " + IntToString(iAverageNumberOfProducts));
        SendMessageToPC(oPC, "iLVL " + IntToString(iLVL));
    }

    return iXPReward;
}

// pricte mnozstvi xp pro dany craft, postavu a slozitost vyrobku, vrati prideleny pocet xp
// - navisi se o tuto hodnotu XP postavy
int TC_setXPbyDifficulty(object oPC, int iCraftID, int iChanceOfSucces, int iCraftAbility = 10)
{
   int iOldXP = TC_getXP( oPC,  iCraftID);

    int iNewXP = TC_getXPbyDifficulty(oPC, iCraftID, iChanceOfSucces, iCraftAbility);


//NOMIS UPDATE (6cervenec) - moc lidi drbalo, ze je tam spatna progrese na vlastnosti. no hlavne de grasse no :D
//    if (iNewXP<5) iNewXP = 3;
    if (iNewXP<1) iNewXP = 1;
    if ((iNewXP<2)&(iCraftAbility>12)) iNewXP = 2;
    if ((iNewXP<3)&(iCraftAbility>17)) iNewXP = 3;

    if (iCraftID == TC_ALCHEMY)
    {
        if ((iNewXP<15)&(iCraftAbility<=10)) iNewXP = 15;
        if ((iNewXP<20)&(iCraftAbility>10)) iNewXP = 20;
        if ((iNewXP<25)&(iCraftAbility>15)) iNewXP = 25;
        if ((iNewXP<25)&(iCraftAbility>20)) iNewXP = 30;
    }

//////nomis 15.3.09 oprava max 20lvl, ze nebude hazet error/////////////////
if ( TC_getLevel(oPC,iCraftID) == 20) {
    iNewXP = 0;
}
//////////////////////////////////////////////////////////////////////


    TC_setXP( oPC,  iCraftID , iNewXP + iOldXP);
/////////////////////////////////////////////////////////////////////////////////////////
////////////////////nomis update //7.leden//////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
        string no_nazev;
        switch (iCraftID)  {
          case 1:   no_nazev = "V alchymii" ;
            break;
          case 20:  no_nazev = "Ve slevarenstvi" ;
            break;
          case 21:  no_nazev = "Ve drevarine" ;
            break;
          case 22:  no_nazev = "V keramice" ;
            break;
          case 23:  no_nazev = "Ve brusicstvi" ;
            break;
          case 24:  no_nazev = "V kozesnictvi" ;
            break;
          case 30:  no_nazev = "Ve sperkarstvi" ;
            break;
          case 31:  no_nazev = "V krejcovine" ;
            break;
          case 32:  no_nazev = "V truhlarine" ;
            break;
          case 33:  no_nazev = "V kovarine" ;
            break;
          case 2:   no_nazev = "V platnerine" ;
            break;
          case 35:  no_nazev = "V ocarovavani" ;
            break;
          default:  no_nazev = "Chyba!" ;
        }

////////////////////////////////////////////////////////////////////////////////////////



    SendMessageToPC(oPC ,"Ziskano " + IntToString(iNewXP) + " craftovych xp");
    SendMessageToPC(oPC , no_nazev + " si na " + IntToString( TC_getLevel(oPC,iCraftID)) + "urovni.");
    SendMessageToPC(oPC ,"Celkem jsi ziskal " + IntToString(TC_getXP( oPC,  iCraftID)) + " XP" );
    return iNewXP;
///////////6.duben - zkouska perzistence craft xpu.///////////////////////////////////

// Set oObject's persistent integer variable sVarName to iValue
// Optional parameters:
//   iExpiration: Number of days the persistent variable should be kept in database (default: 0=forever)
//   sTable: Name of the table where variable should be stored (default: pwdata)
//SetPersistentInt(oPC,"tcXPSystem",TC_getXP( oPC,  iCraftID),0,"tcXPSystem" + IntToString(iCraftID));



}

void TC_saveCraftXPpersistent(object oPC, int iCraftID)
{

//nomis 6 cervenec - znovuzavedeni ukladani xpu
object oSoulStone = GetSoulStone(oPC);
int i_pocet_xpu = GetLocalInt(oSoulStone, TC_XP_PREFIX  + IntToString(iCraftID));

int i_pocet_xpu2 =  GetPersistentInt(oPC,"tcXPSystem" + IntToString(iCraftID));

if ( i_pocet_xpu2 > i_pocet_xpu )
{
TC_setXP( oPC,  iCraftID ,i_pocet_xpu2);
SendMessageToPC(oPC ,"Ziskano " + IntToString(i_pocet_xpu2-i_pocet_xpu) + " craftovych xp nahranim z databaze");
}

SetPersistentInt(oPC,"tcXPSystem" + IntToString(iCraftID),TC_getXP( oPC,  iCraftID),0);
SendMessageToPC(oPC ,"Craft xp ulozeny do databaze");
}


