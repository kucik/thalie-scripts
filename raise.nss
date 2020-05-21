//EDIT Sylm : osetrenie cheatovania uniku z podsvetia cez Thaala

//#include "aps_include"
#include "raiseinc"
//#include "sy_main_lib"
//#include "ku_libbase"
#include "ku_exp_inc"

void ApplyPenalty(object oDead)
{
    int nXP = GetXP(oDead);
    int nHD = GetHitDice(oDead);
    int nPenalty = nHD*500;

    object oSoul = GetSoulStone(oDead);

    int xpk = GetLocalInt(oSoul,"ku_XPLost");
    SetLocalInt(oSoul,"ku_XPLost",xpk + nPenalty);

    int nNewXP;
    if (nXP > nPenalty)
    {
        nNewXP = nXP - nPenalty;
    }
    else
    {
        nNewXP = 0;
    }

    SetXP(oDead, nNewXP);
    int nGoldToTake = 0;
    if(nHD > 5)
    nGoldToTake = FloatToInt(0.5 * GetGold(oDead));
    if(nHD > 10)
    nGoldToTake = GetGold(oDead);
    AssignCommand(oDead, TakeGoldFromCreature(nGoldToTake, oDead, TRUE));
}

void main()
{
   object oPC = GetPCSpeaker();

   if(GetLocalInt(oPC,"RELEVELING")) {
     SendMessageToAllDMs("BUG!!! Postava"+GetName(oPC)+" hrac "+GetPCPlayerName(oPC)+" pokus o bug - revelup pri oziveni.");
     WriteTimestampedLogEntry("BUG!!! Postava"+GetName(oPC)+" hrac "+GetPCPlayerName(oPC)+" pokus o bug - revelup pri oziveni.");
     return;
   }

   DeleteLocalInt(oPC, "LastHourRest");
   DeleteLocalInt(oPC, "LastDayRest");
   DeleteLocalInt(oPC, "LastYearRest");
   DeleteLocalInt(oPC, "LastMonthRest");


   string sCorpseTag = GetLocalString(oPC, "CORPSETAG");
   object oCorpse = GetObjectByTag(sCorpseTag);

   DestroyObject(oCorpse, 1.0f);
   object wpRaise = GetWaypointByTag(GetLocalString(oPC, "CHRAM"));
   if(!GetIsObjectValid(wpRaise)){
    SendMessageToPC(oPC, "Tohle je konecna pro vsechny bugery.");
    SendMessageToAllDMs("Hrac "+GetName(oPC)+" je buger, proto ho nevytahujte z podsveti.");
    return;
   }
   SetLocalLocation(oPC, "LOCATION", GetLocation(wpRaise));
   //string ID = GetLocalString(oPC, "ID");
   SetPersistentLocation(oPC, "LOCATION", GetLocation(wpRaise));

   Raise(oPC);
   ApplyPenalty(oPC);

   //edit Sylm : pri uspesnom oziveni cez Astarotha odstranim priznak smrti z duse bytosti
   object oSoulItem = GetSoulStone(oPC);
   DeleteLocalInt(oSoulItem,"isDead");
   //end Sylm

   AssignCommand(oPC, ClearAllActions(TRUE));
   AssignCommand(oPC, JumpToObject(wpRaise));
}
