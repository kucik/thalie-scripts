// ku_exp_time.nss
// Library handling PC time experiences
////////////////////////////////////

#include "ku_exp_inc"
#include "ku_libtime"


int KU_ACTIONS_LOGIN = 0;
int KU_ACTIONS_USE = 1;
int KU_ACTIONS_MOVE = 2;
int KU_ACTIONS_SPEAK = 3;
int KU_ACTIONS_COMBAT = 4;


int KU_XPPT_DEBUG = FALSE;

// Give experiences per time to PC
//
// Funkce pro pridelovani XPs casem
// Vola se jednou za minutu
// input : object oPC - Postava, ktere se maji XP pridelit
//////
void ku_GiveXPPerTime(object oPC);

///////////////////////////////////////////
// Funkce pro zjisteni, zda je v blizkosti jine PC
// input : object oPC - objekt v jehoz blizkosti zjistujeme PC
//         float distance - hranicni vzdalenost, po kterou se ma hledat
//         int IncludeHidden = 0 - nebrat v uvahu skryte PC
//                             1 - brat v uvahu vsechny PC
// output : int = 0 - nenalezeno
//                1 - nalezeno
///
int ku_IsPCNear(object oPC, float distance = 15.0, int IncludeHidden = 0);

/////////////////////////////////////
// Funkce pro kontrolu zda a kolik ma PC dostavat XP
// Vola se jednou za minutu pred "ku_GiveXPPerTime()"
// input : object oPC - Postava, ktere se maji XP pridelit
///
void ku_CheckXPStop(object oPC);

/////////////////////////////////////
// Funkce se vola pri kazdem pouziti predmetu a spousti pridelovani eXPu za cas na dalsi 4 minuty
// input : object oPC - hrac, ktery predmet aktivoval
//         object oItem - aktivovany item
///
void ku_ItemActivated(object oPC, object oItem);

/////////////////////////////////////////
// Inicializace eXPiciho systemu pri loginu hrace
// input : object oPC - postava hrace
///
void ku_OnClientEnter(object oPC);

////////////////////////////////////////
// Funkce pro ulozeni expu za cas a za potvory do DB
// input : object oPC - PC kteremu XP patri
///
void ku_StoreXPToDB(object oPC);

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////

int ku_IsPCNear(object oPC, float distance = 15.0, int IncludeHidden = 0)
{
 int n = 1;
 object oNearPC;
 if(IncludeHidden == 1) {
  oNearPC= GetNearestCreature( CREATURE_TYPE_PLAYER_CHAR,
                                PLAYER_CHAR_IS_PC,
                                oPC,
                                1);
  if((GetDistanceBetween(oPC,oNearPC) <= distance) && (GetIsObjectValid(oNearPC)))
   return 1;
 }
 oNearPC= GetNearestCreature(   CREATURE_TYPE_PLAYER_CHAR,
                                PLAYER_CHAR_IS_PC,
                                oPC,
                                1,
                                CREATURE_TYPE_PERCEPTION,
                                PERCEPTION_SEEN);
 if((GetDistanceBetween(oPC,oNearPC) <= distance) && (GetIsObjectValid(oNearPC)))
  return 1;
 oNearPC= GetNearestCreature(   CREATURE_TYPE_PLAYER_CHAR,
                                PLAYER_CHAR_IS_PC,
                                oPC,
                                1,
                                CREATURE_TYPE_PERCEPTION,
                                PERCEPTION_HEARD_AND_NOT_SEEN);
 if((GetDistanceBetween(oPC,oNearPC) <= distance) && (GetIsObjectValid(oNearPC)))
  return 1;

 return 0;
}

int ku_GetPCsNearbyCount(object oPC, float distance = 15.0, int IncludeHidden = 0)
{
    int i, iPCCounter;
    object oNearPC;

    if (IncludeHidden == 1)
    {
        for (i = 1; i < 5; i++)
        {
            oNearPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oPC, i);
            if (!GetIsObjectValid(oNearPC))
                break;
            if (GetDistanceBetween(oPC, oNearPC) <= distance)
                iPCCounter ++;
        }
    }
    else
    {
        for (i = 1; i < 5; i++)
        {
            oNearPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oPC, i, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
            if (!GetIsObjectValid(oNearPC))
                break;
            if (GetDistanceBetween(oPC, oNearPC) <= distance)
                iPCCounter ++;
        }
    }

    return iPCCounter;
}

int ku_GetPartyXPBonus(int iPCCounter = 0)
{
    if (iPCCounter < 1)
        return 0;

    switch (iPCCounter)
    {
        case 1: return 5;
        case 2: return 7;
        case 3: return 9;
    }
    return 10;
}

void ku_GiveXPPerTime(object oPC)
{

  int xp_limit = FALSE;
  // if(GetXP(oPC) > 525000) return; //15. level
  if(GetXP(oPC) > NT_PC_MAX_XP)
    xp_limit = TRUE;; //30 level

 object oArea = GetArea(oPC);
 int StopXP = GetLocalInt(oPC,"ku_StopXP");
 int bDungeon = GetLocalString(oArea, "REST_ZONE") == "nosleep" ? TRUE : FALSE;
// int IsPCNear = GetLocalInt(oPC,"ku_PCNear");

// int ECL = Subrace_GetECLClass(oPC);
// int ECL = GetLocalInt(oPC,"ku_ECLClass");

 if(StopXP == 0 && !bDungeon) {
  //int IsPCNear = ku_IsPCNear(oPC);

//  if(KU_XPPT_DEBUG)
//MessageToPC(oPC,"XP_DEBUG IsPCNear=" + IntToString(IsPCNear));

  object oSoul = GetSoulStone(oPC);
  int XPbyXPPT = GetLocalInt(oSoul,"ku_XPbyXPPT");
  // int XP = 30;         //6


//  int HitDice = GetHitDice(oPC) - 10; //redukce XP
//  int HitDice =  FloatToInt(0.5 + sqrt(0.25 + ( IntToFloat(GetXP(oPC)) / 500 ))) - 10; //1000xp per level
//  int HitDice =  FloatToInt(1.0 + sqrt(1.0 + 8.0 *( IntToFloat(GetXP(oPC)) / 5000.0 )))/2; //5000xp per level
  int HitDice =  ku_GetLevelForXP(GetXP(oPC)); //5000xp per level
  //int HPPenalty = HitDice;// / 5;
  //if(HPPenalty <= 0) {
    //HPPenalty = 0;
  //}
  //XP = XP - HPPenalty;

  // (m-lvl*s)*(1+(p-1)*a)*k
  int p = ku_GetPCsNearbyCount(oPC);
  int XP = FloatToInt((50.0f - IntToFloat(HitDice) * 0.6f) * (1.0f + (IntToFloat(p) - 1.0f) * 0.25f) * 0.75f);

  //if(IsPCNear == 1)
    //XP = XP + 5; //+2

  // Bonus za PC postavy kolem
  // XP += ku_GetPartyXPBonus(ku_GetPCsNearbyCount(oPC));

  // Specificky bonus/postih lokace
  int iLocationBonus = GetLocalInt(oArea, "XP_BONUS");
  XP += iLocationBonus;

  // Bonus za prevod stare postavy
  int iBonusLevel = GetLocalInt(oSoul,"NT_XP_BONUS_LEVEL");
  // Error check ;)
  if(iBonusLevel > 40)
    iBonusLevel = 0;

  float fModifier = 1.0;
  if(iBonusLevel > HitDice) {
    fModifier = sqrt(IntToFloat(iBonusLevel - HitDice)) / 3.13 + 1.0;
  }
  XP = FloatToInt(IntToFloat(XP) * fModifier);
  //kontrola na bugery
  if (GetLocalInt(oPC,"JE_POSTAVA_ZABUGOVANA"))
  {
    return;
  }
  if(XP > 0) {//zaporny XP by se asi nelibil
    if(!xp_limit) {
      //SendMessageToPC(oPC, "Mìl bych dostat: "+IntToString(XP)+" xp");
      SetXP(oPC,GetXP(oPC) + XP);
      SetLocalInt(oSoul,"ku_XPbyXPPT",XPbyXPPT + XP);
    }
  }
 }
}

void ku_CheckXPStop(object oPC)
{

 int InCombat = GetIsInCombat(oPC);
 int ActTimeStamp = ku_GetTimeStamp();
 KU_XPPT_DEBUG = FALSE;

 int iStopArea = GetLocalInt(GetArea(oPC),"STOP_XP");
 if(GetLocalInt(GetSoulStone(oPC),"STOP_XP") > 0) {
   SetLocalInt(oPC,"ku_StopXP",1);
   return;
 }

 if(InCombat == TRUE || iStopArea > 0) {
  SetLocalInt(oPC,"ku_StopXP",1);
  SetLocalInt(oPC,"ku_LastActionType",KU_ACTIONS_COMBAT);
  SetLocalInt(oPC,"ku_LastActionStamp",ku_GetTimeStamp(0,4)); // !!! DULEZITE - NASTAVENI "DOBY TRVANI AKCE" - jak dlouho po boji se neprideluji XP
  if( (KU_XPPT_DEBUG)  )
     SendMessageToPC(oPC,"XP : player is in combat");

  return;
 }
 int LastActionTime = GetLocalInt(oPC,"ku_LastActionStamp");

 if(LastActionTime >= ActTimeStamp) {
  if(GetLocalInt(oPC,"ku_LastActionType") != KU_ACTIONS_COMBAT) {
//   SetLocalInt(oPC,"ku_PCNear",ku_IsPCNear(oPC));
   SetLocalInt(oPC,"ku_StopXP",0);
  }
  else {
   SetLocalInt(oPC,"ku_StopXP",1);
   if( (KU_XPPT_DEBUG)  )
     SendMessageToPC(oPC,"XP : predchozi akce: boj");
  }
  if( (KU_XPPT_DEBUG)  )
     SendMessageToPC(oPC,"XP : trva cas z predchozi akce");
  return;
 }

 if( (KU_XPPT_DEBUG)  )
     SendMessageToPC(oPC,"XP : Stop xp");
 SetLocalInt(oPC,"ku_StopXP",1);
}

void ku_ItemActivated(object oPC, object oItem)
{
 int ActionCount = 0;

 /* disable function */
 return;

 if(GetLocalInt(oPC,"ku_LastActionType") == KU_ACTIONS_USE)
  ActionCount = GetLocalInt(oPC,"ku_SameActionsCounter");

 if( (KU_XPPT_DEBUG)  )
     SendMessageToPC(oPC,"XP : aktivovan item; pocet aktivaci: " + IntToString(ActionCount));

 if(GetLocalInt(oPC,"ku_LastActionType") != KU_ACTIONS_COMBAT) {
  ActionCount++;
  SetLocalInt(oPC,"ku_SameActionsCounter",ActionCount);
  SetLocalInt(oPC,"ku_LastActionType",KU_ACTIONS_USE);

  if(ActionCount <= 4 ) {                                       // !!! DULEZITE - NASTAVENI NEJVYSSIHO PRIPUSTNEHO POCTU PO SOBE JDOUCICH AKCI TYPU POUZITI ITEMU !!!
   SetLocalInt(oPC,"ku_LastActionStamp",ku_GetTimeStamp(0,4)); // !!! DULEZITE - NASTAVENI "DOBY TRVANI AKCE" - jak dlouho po akci se jeste prideluji XP
   if( (KU_XPPT_DEBUG)  )
     SendMessageToPC(oPC,"XP : spoustim xp aktivaci itemu.");
  }
 }
}

void ku_OnClientEnter(object oPC)
{
 SetLocalInt(oPC,"ku_SameActionsCounter",1);
 SetLocalInt(oPC,"ku_LastActionType",KU_ACTIONS_LOGIN);
 SetLocalInt(oPC,"ku_LastActionStamp",ku_GetTimeStamp(5,1));
/*
 //jeste se sem musi pridat nacteni expu z databaze.
 SetLocalInt(oPC,"ku_XPbyXPPT",GetPersistentInt(oPC,"ku_XPbyXPPT"));
 SetLocalInt(oPC,"ku_XPbyKill",GetPersistentInt(oPC,"ku_XPbyKill"));
*/

 //jeste se sem musi pridat nacteni expu z databaze.
 object oSoul = GetSoulStone(oPC);
 SetLocalInt(oPC,"ku_XPbyXPPT",GetLocalInt(oSoul,"ku_XPbyXPPT"));
 SetLocalInt(oPC,"ku_XPbyKill",GetLocalInt(oSoul,"ku_XPbyKill"));
}

/*
 * Funkce pro ulozeni expu za cas a za potvory do DB
 * input : object oPC - PC kteremu XP patri
 */
void ku_StoreXPToDB(object oPC)
{
 object oSoul = GetSoulStone(oPC);
 SetLocalInt(oSoul,"ku_XPbyXPPT",GetLocalInt(oPC,"ku_XPbyXPPT"));
 SetLocalInt(oSoul,"ku_XPbyKill",GetLocalInt(oPC,"ku_XPbyKill"));
}
