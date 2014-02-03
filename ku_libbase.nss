/* #######################################################
 * # Kucik Base library
 * # release: 26.12.2007
 * #######################################################
 *
 * rev. Kucik 05.01.2008 pridany funkce pro zbrane
 * rev. Kucik 06.01.2008 zakaz stredni zbroje druidum a helmy
 *                       pridana funkce pro prehozy pres zbroj
 * rev. Kucik 07.01.2008 Paveza - sila zmenena ze 16ti na 18
 *                       Script ted funguje jen na PC
 * rev. Kucik 13.01.2008 Upravy prehozu pro konkretni prehozy
 * rev. Kucik 24.01.2008 Zbrane nyni jdou vybavit, ale davaji postihy
 * rev. Kucik 26.01.2008 Zmenen zpusob rozpoznavani kapuce
 * rev. Kucik 19.10.2008 Reducexp... uz xp neupravuje, jen pocita. Do xp za cas
                         bylo pridany cteni player chatu. Na casovy xp se
                         nevztahuje ECL.
 * rev. Kucik 05.01.2008 Pridana dynamicka munice
 */

//libtime je potreba kvuli casovym razitkum
#include "ku_libtime"
//#include "aps_include"
#include "subraces"
#include "ja_lib"


int ku_GetLevelForXP(int XP);

int ku_ReduceXPGainForDeath(object oPC, int iXP, int bTimeXP = FALSE);

int KU_XPPT_DEBUG = FALSE;

int KU_ACTIONS_LOGIN = 0;
int KU_ACTIONS_USE = 1;
int KU_ACTIONS_MOVE = 2;
int KU_ACTIONS_SPEAK = 3;
int KU_ACTIONS_COMBAT = 4;


int KU_GetIsFavouredClass(int race,int class)
{
  if(race==RACIAL_TYPE_HUMAN)
    return TRUE;
  if( (race==RACIAL_TYPE_DWARF) && (class==CLASS_TYPE_FIGHTER) )
    return TRUE;
  if( (race==RACIAL_TYPE_ELF) && (class==CLASS_TYPE_WIZARD) )
    return TRUE;
  if( (race==RACIAL_TYPE_GNOME) && (class==CLASS_TYPE_WIZARD) )
    return TRUE;
  if( (race==RACIAL_TYPE_HALFELF) )
    return TRUE;
  if( (race==RACIAL_TYPE_HALFORC) && (class==CLASS_TYPE_BARBARIAN) )
    return TRUE;
  if( (race==RACIAL_TYPE_HALFLING) && (class==CLASS_TYPE_ROGUE) )
    return TRUE;

  return FALSE;
}

int KU_GetIsMultiClass(object oPC)
{
  if(GetLevelByPosition(2,oPC)<1)
    return FALSE;

  int lvldiff = GetLevelByPosition(1,oPC) - GetLevelByPosition(2,oPC);

  if( (lvldiff<=1) && (lvldiff>=-1) )
    return FALSE;

  if(KU_GetIsFavouredClass(GetRacialType(oPC),GetClassByPosition(1,oPC)))
    return FALSE;

  if(KU_GetIsFavouredClass(GetRacialType(oPC),GetClassByPosition(2,oPC)))
    return FALSE;

  return TRUE;
}

/*
 * Funkce pro zjisteni, zda je v blizkosti jine PC
 * input : object oPC - objekt v jehoz blizkosti zjistujeme PC
 *         float distance - hranicni vzdalenost, po kterou se ma hledat
 *         int IncludeHidden = 0 - nebrat v uvahu skryte PC
 *                             1 - brat v uvahu vsechny PC
 * output : int = 0 - nenalezeno
 *                1 - nalezeno
 */
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

int ku_GetLevelForXP(int XP) {
  return FloatToInt(0.5 + sqrt(0.25 + ( IntToFloat(XP) / 2500.0 ))); //5000xp per level
}

/*
 * Funkce pro pridelovani XPs casem
 * Vola se jednou za minutu
 * input : object oPC - Postava, ktere se maji XP pridelit
 */
void ku_GiveXPPerTime(object oPC)
{
 int StopXP = GetLocalInt(oPC,"ku_StopXP");
// int IsPCNear = GetLocalInt(oPC,"ku_PCNear");

 int ECL = Subrace_GetECLClass(oPC);
// int ECL = GetLocalInt(oPC,"ku_ECLClass");

 if(StopXP == 0) {
  int IsPCNear = ku_IsPCNear(oPC);

//  if(KU_XPPT_DEBUG)
//MessageToPC(oPC,"XP_DEBUG IsPCNear=" + IntToString(IsPCNear));

  object oSoul = GetSoulStone(oPC);
  int XPbyXPPT = GetLocalInt(oSoul,"ku_XPbyXPPT");
  int XP=30;         //6


//  int HitDice = GetHitDice(oPC) - 10; //redukce XP
//  int HitDice =  FloatToInt(0.5 + sqrt(0.25 + ( IntToFloat(GetXP(oPC)) / 500 ))) - 10; //1000xp per level
//  int HitDice =  FloatToInt(1.0 + sqrt(1.0 + 8.0 *( IntToFloat(GetXP(oPC)) / 5000.0 )))/2; //5000xp per level
  int HitDice =  ku_GetLevelForXP(GetXP(oPC)); //5000xp per level
  int HPPenalty = HitDice;// / 5;
  if(HPPenalty <= 0) {
    HPPenalty = 0;
  }
  XP = XP - HPPenalty;

  if(IsPCNear == 1)
    XP = XP + 5; //+2

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
    XP = ku_ReduceXPGainForDeath(oPC, XP, TRUE);
   
//    if(GetXP(oPC) > 525000) return; //15. level
    if(GetXP(oPC) > 2175000) return; //30 level
   
    SetXP(oPC,GetXP(oPC) + XP);
    SetLocalInt(oSoul,"ku_XPbyXPPT",XPbyXPPT + XP);
  }
 }
}


/*
 * Funkce pro kontrolu zda a kolik ma PC dostavat XP
 * Vola se jednou za minutu pred "ku_GiveXPPerTime()"
 * input : object oPC - Postava, ktere se maji XP pridelit
 */
void ku_CheckXPStop(object oPC)
{

 int InCombat = GetIsInCombat(oPC);
 int ActTimeStamp = ku_GetTimeStamp();
 KU_XPPT_DEBUG = FALSE;

 int iStopArea = GetLocalInt(GetArea(oPC),"STOP_XP");
 if(GetLocalInt(SEI_GetSoul(oPC),"STOP_XP") > 0) {
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

/*
 if(LastActionTime < ActTimeStamp) {
  location lPCLastPoss = GetLocalLocation(oPC,"ku_LastPossition");
  location lPCActPoss = GetLocation(oPC);
  int ActionCount = 0;

  if(lPCLastPoss != lPCActPoss ){           //pokud se od posledni kontroly pohnul

   SetLocalLocation(oPC,"ku_LastPossition",lPCActPoss);
   if(GetLocalInt(oPC,"ku_LastActionType") == KU_ACTIONS_MOVE)  //pokud byla posledni akce take jen pohyb
    ActionCount = GetLocalInt(oPC,"ku_SameActionsCounter");
   ActionCount++;
   SetLocalInt(oPC,"ku_SameActionsCounter",ActionCount);        //pocitadlo akci stejneho druhu - v tomto pripade pohyb
   SetLocalInt(oPC,"ku_LastActionType",KU_ACTIONS_MOVE);
   if( (KU_XPPT_DEBUG)  )
     SendMessageToPC(oPC,"XP : spusteno pohybem");
   if(ActionCount <= 4 ) {                                       // !!! DULEZITE - NASTAVENI NEJVYSSIHO PRIPUSTNEHO POCTU PO SOBE JDOUCICH AKCI TYPU POHYB !!!
    SetLocalInt(oPC,"ku_LastActionStamp",ku_GetTimeStamp(0,4)); // !!! DULEZITE - NASTAVENI "DOBY TRVANI AKCE" - jak dlouho po akci se jeste prideluji XP
//    SetLocalInt(oPC,"ku_PCNear",ku_IsPCNear(oPC));
    SetLocalInt(oPC,"ku_StopXP",0);
    if( (KU_XPPT_DEBUG)  )
     SendMessageToPC(oPC,"XP : pocet pohybu " + IntToString(ActionCount));
    return;
   }
  }

 }
 */
 if( (KU_XPPT_DEBUG)  )
     SendMessageToPC(oPC,"XP : Stop xp");
 SetLocalInt(oPC,"ku_StopXP",1);
}


/*
 * Funkce se vola pri kazdem pouziti predmetu a spousti pridelovani eXPu za cas na dalsi 4 minuty
 * input : object oPC - hrac, ktery predmet aktivoval
 *         object oItem - aktivovany item
 */
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

/*
 * Inicializace eXPiciho systemu pri loginu hrace
 * input : object oPC - postava hrace
 */
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


/*
 * Funkce pro prepocet expu za bestie v zavislosti na pomeru expu za cas a za bestie
 * input : object oPC - PC o ktere se jedna
 *         int xp - eXPy, ktere se mely puvodne pridelit
 * output : int - expy k prideleni
 * !!! Zmena Funkce uz xp neupravuje, jenom si uklada hodnoty
 */
int ku_ReduceXPForPlayer(object oPC, int xp)
{
 object oSoul = GetSoulStone(oPC);
 float xpt = IntToFloat(GetLocalInt(oSoul,"ku_XPbyXPPT"));
 float xpk = IntToFloat(GetLocalInt(oSoul,"ku_XPbyKill"));
 float fxp = IntToFloat(xp);
 float fborder = 2.0/3.0;
 float fkoef = 1.6;
 float pomer = ((xpk)/(xpt + xpk));
 int ECL = Subrace_GetECLClass(oPC);

 if(xp == 0)
  return 0;

/*
 if( pomer <= fborder ) {                                  // 100%xp
  SetLocalInt(oSoul,"ku_XPbyKill",FloatToInt(xpk) + xp);   //ukladani expu ze zabitych NPC
  return xp;
 }
*/

 //xp = FloatToInt((1- ( pomer - fborder)/(1-fborder)*fkoef ) * fxp); //min xp

 if(xp<1)                                                 //1xp
   xp=1;

// SendMessageToPC(oPC,"pomer: "+FloatToString((1- ( pomer - fborder)/(1-fborder)*fkoef ) * 100)+"%");
 SetLocalInt(oSoul,"ku_XPbyKill",FloatToInt(xpk) + xp);   //ukladani expu ze zabitych NPC
 return xp;

}


/*
 * Funkce kontroluje, zdalipak postava zvladne item
 */
int ku_CheckItemRestrictions(object oPC, object oItem)
{
 int iItemType = GetBaseItemType(oItem);
 int iPCStrength = GetAbilityScore(oPC,ABILITY_STRENGTH,TRUE);
// iPCStrength = iPCStrength + GetLocalInt(oPC,"KU_SUBRACES_ABILITY_0");

// SetLocalObject(oItem,"KU_OWNER",oPC);
// ExecuteScript("ku_weapon_equip",oItem);

 if(GetIsDM(oPC))
   return TRUE;
 if(!GetIsPC(oPC))
   return FALSE;

 // Stity
 if(iItemType == BASE_ITEM_TOWERSHIELD) {
   if(iPCStrength < 18 )
     return FALSE;
 }
 if(iItemType == BASE_ITEM_LARGESHIELD) {
   if(iPCStrength < 12 )
     return FALSE;
 }
 if(iItemType == BASE_ITEM_SMALLSHIELD) {
   if(iPCStrength < 8 )
     return FALSE;
 }

 // Jdem rozpoznavat zbroj
 if(iItemType == BASE_ITEM_ARMOR) {

   int iArmorWeight = GetWeight(oItem);
   int iClass1 = GetClassByPosition(1,oPC);
   int iClass2 = GetClassByPosition(2,oPC);
   int iClass3 = GetClassByPosition(3,oPC);

   // Pokud je druid, tak nesmi zbroj nad 30 liber vcetne.
   if( ( (iClass1 == CLASS_TYPE_DRUID) ||
         (iClass2 == CLASS_TYPE_DRUID) ||
         (iClass3 == CLASS_TYPE_DRUID) ) &&
       ( iArmorWeight >= 300           ) )
    return FALSE;

   // Budem porovnavat podle vahy zbroje
   if( ( iArmorWeight >= 50) && (iPCStrength < 7 ) )
     return FALSE;
   if( ( iArmorWeight >= 100) && (iPCStrength < 8 ) )
     return FALSE;
   if( ( iArmorWeight >= 150) && (iPCStrength < 9 ) )
     return FALSE;
   if( ( iArmorWeight >= 300) && (iPCStrength < 12 ) )
     return FALSE;
   if( ( iArmorWeight >= 400) && (iPCStrength < 14 ) )
     return FALSE;
   if( ( iArmorWeight >= 450) && (iPCStrength < 16 ) )
     return FALSE;
   if( ( iArmorWeight >= 500) && (iPCStrength < 17 ) )
     return FALSE;

   return TRUE;
 }

 int iWPenalty = 0;
 // Ted zbrane;
 object oMod = GetModule();
 int iRestrict = GetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(iItemType));
 if(iPCStrength < iRestrict)
   iWPenalty = iRestrict - iPCStrength;


 if(iWPenalty>0) {
   SetLocalObject(oItem,"KU_OWNER",oPC);
   SetLocalInt(oItem,"KU_WPENALTY",iWPenalty);
   ExecuteScript("ku_weapon_equip",oItem);
   return TRUE;
 }


  // A ted helmu
 if( (iItemType == BASE_ITEM_HELMET                     ) &&
     ( (iPCStrength < 10                              ) ||
       (!GetHasFeat(FEAT_ARMOR_PROFICIENCY_MEDIUM,oPC)) ) ) {
   if(GetLocalInt(oItem,"ku_kapuce"))
     return TRUE;

//   SendMessageToPC(oPC,"helmet appearance = "+IntToString(GetItemAppearance(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL,0)));
   switch(GetItemAppearance(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL,0)) {
     case 33: return TRUE; break;
     case 47: return TRUE; break;
     case 26: return TRUE; break;
     case 40: return TRUE; break;
     case 83: return TRUE; break;
     default : return -1; break;
   }
 }
 return TRUE;
}

int KU_Dust_DustToNum(int num) {
   switch(num) {
     case 164: return 19;
     case 165: return 20;
     case 121: return 27;
     case 110: return 29;
     case 112: return 31;
     case 114: return 33;
     case 128: return 52;
     case 129: return 53;
     case 130: return 54;
     case 131: return 55;
     case 132: return 56;
     case 133: return 57;
     case 183: return 40;
     case 184: return 41;
   }
   return 0;
}
int KU_Dust_NumToDust(int num) {
   switch(num) {
     case 19: return 164;
     case 20: return 165;
     case 27: return 121;
     case 29: return 110;
     case 31: return 112;
     case 33: return 114;
     case 52: return 128;
     case 53: return 129;
     case 54: return 130;
     case 55: return 131;
     case 56: return 132;
     case 57: return 133;
     case 40: return 183;
     case 41: return 184;
   }
   return 0;
}
/*
 * Meni prehoz (robu) na zbroji
 */
void KU_ChangeArmorDust(object oPC,object oArmor,object oDust = OBJECT_INVALID, int bEquip=TRUE)
{
 int bDust = FALSE;
 // Pokud se prehoz pouzije na neco jineho nez zbroj
 if(GetBaseItemType(oArmor) != BASE_ITEM_ARMOR ) {
   SendMessageToPC(oPC,"Prehoz muze byt pouzit jen na zbroj.");
   return;
 }
 if(GetStringLeft(GetTag(oArmor),8) == "ku_shop_") {
   return;
 }
 // Pokud to neni zbroj ale saty. Rozpoznavam podle vahy.
 if(GetWeight(oArmor) < 50 ) {
   SendMessageToPC(oPC,"Prehoz muze byt pouzit jen na zbroj. Nikoliv na saty.");
   return;
 }

 int nOldDust = GetItemAppearance(oArmor,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_ROBE);

 // Nasleduje seznam povolenych a zakazanych prehozu
 if(nOldDust == 110)
  bDust = TRUE;
 if(nOldDust == 112)
  bDust = TRUE;
 if(nOldDust == 114)
  bDust = TRUE;
 if(nOldDust == 121)
  bDust = TRUE;
 if( (nOldDust >= 127) && (nOldDust <= 133) )
  bDust = TRUE;
 if( (nOldDust >= 162) && (nOldDust <= 165) )
  bDust = TRUE;
 if( (nOldDust >= 183) && (nOldDust <= 184) )
  bDust = TRUE;
 if(!bDust) {
   if( (nOldDust==0)  && (!GetIsObjectValid(oDust)) ) {
     SendMessageToPC(oPC,"Na teto zbroji neni prehoz.");
     return;
   }
   else if(!GetIsObjectValid(oDust)) {
     SendMessageToPC(oPC,"Z teto zbroje neni mozne sundat prehoz.");
     return;
   }
 }

 int nDust = 0;
 if(GetIsObjectValid(oDust))
    nDust = StringToInt(GetSubString(GetTag(oDust),13,3));

// int nOldDust = GetItemAppearance(oArmor,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_ROBE);
// SendMessageToPC(oPC,"nOldDust=" + IntToString(nOldDust));
// SendMessageToPC(oPC,"nDust=" + IntToString(nDust));
 object oNewArmor = CopyItemAndModify(oArmor,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_ROBE,KU_Dust_NumToDust(nDust),TRUE);
// SetLocalInt(oNewArmor,"KU_OLD_DUST",nOldDust);
 DestroyObject(oArmor);
 if(nOldDust != 0) {
   string sOldDust = IntToString(KU_Dust_DustToNum(nOldDust));
   while(GetStringLength(sOldDust) < 3)
     sOldDust = "0" + sOldDust;
//   SendMessageToPC(oPC,"ku_armordust_" + sOldDust);
/*
   Removed creating dusts while taylor works
   CreateItemOnObject("ku_armordust_" + sOldDust,oPC);

*/
 }
 if(oDust != OBJECT_INVALID) {
   DestroyObject(oDust);
 }
 if(bEquip) {
   AssignCommand(oPC,ActionEquipItem(oNewArmor,INVENTORY_SLOT_CHEST));
 }

}

void KU_DefineWeaponPrereq() {

 object oMod = GetModule();

 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_BASTARDSWORD),16);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_BATTLEAXE),12);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_CLUB),6);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_DAGGER),4);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_DART),4);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_DIREMACE),16);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_DOUBLEAXE),18);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_DWARVENWARAXE),16);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_GREATAXE),18);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_GREATSWORD),18);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_HALBERD),14);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_HANDAXE),6);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_HEAVYCROSSBOW),10);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_HEAVYFLAIL),17);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_KAMA),8);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_KATANA),16);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_KUKRI),6);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_LIGHTCROSSBOW),6);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_LIGHTFLAIL),11);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_LIGHTHAMMER),5);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_LIGHTMACE),9);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_LONGBOW),11);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_LONGSWORD),11);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_MORNINGSTAR),12);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_QUARTERSTAFF),6);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_RAPIER),6);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_SCIMITAR),8);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_SCYTHE),15);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_SHORTBOW),8);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_SHORTSPEAR),11);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_SHORTSWORD),6);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_SHURIKEN),4);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_SICKLE),6);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_SLING),4);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_THROWINGAXE),4);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_TRIDENT),11);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_TWOBLADEDSWORD),14);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_WARHAMMER),12);
 SetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(BASE_ITEM_WHIP),4);

}

void ku_GetMunitionFromPack(object oPC, string sPack,int iBaseItem,int count) {
  int i;

  int iSlot = 4;
  int iPack = 99;
  string sTemplate = "ry_vrh_"+GetSubString(sPack,7,GetStringLength(sPack)-7);
  switch(iBaseItem) {
    case 20: iSlot = 11;
             sTemplate = "ry_mun_"+GetSubString(sPack,7,GetStringLength(sPack)-7);
             break;
    case 25: iSlot = 13;
             sTemplate = "ry_mun_"+GetSubString(sPack,7,GetStringLength(sPack)-7);
             break;
    case 27: iSlot = 12;
             sTemplate = "ry_mun_"+GetSubString(sPack,7,GetStringLength(sPack)-7);
             break;
    default: iPack = 50;
             break;
  }

  string sBase = IntToString(iBaseItem);
  object oSoul=GetSoulStone(oPC);

  object oItem=GetItemPossessedBy(oPC,sTemplate);
  if(oItem==OBJECT_INVALID)
    count++;

  object oToulec = GetItemPossessedBy(oPC,sPack);
  if(oToulec==OBJECT_INVALID) {
     SetLocalString(oSoul,"ku_ammo_"+sBase,"");
     SetLocalString(oSoul,"ku_ammo_pack_"+sBase,"");
     return;
  }

  /* Init toulce */
  if(!GetLocalInt(oToulec,"ku_used")) {
    SetLocalInt(oToulec,"ku_used",TRUE);
    SetLocalInt(oToulec,"ku_contain",10000);
    SetLocalString(oToulec,"name",GetName(oToulec));
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpell(IP_CONST_CASTSPELL_UNIQUE_POWER,IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE),oToulec);
  }

  count = count * iPack;
  int iObsah = GetLocalInt(oToulec,"ku_contain");
  if(iObsah < count)
    count = iObsah;

  iObsah = iObsah - count;

  while(count > 0) {
    if(count >= iPack)
      oItem = CreateItemOnObject(sTemplate,oPC,iPack);
    else
      oItem = CreateItemOnObject(sTemplate,oPC,count);

//    SendMessageToPC(oPC,"Vytvoreno "+GetName(oItem)+" stack "+IntToString(iPack));
    SetPlotFlag(oItem,1);
    SetStolenFlag(oItem,1);
    count = count - iPack;
  }
  SetLocalInt(oToulec,"ku_contain",iObsah);
  SetLocalString(oSoul,"ku_ammo_"+sBase,"");

  AssignCommand(oPC,ActionEquipItem(oItem,iSlot));
  SetLocalString(oSoul,"ku_ammo_pack_"+sBase,sPack);
  if(iObsah > 0)
    DelayCommand(2.0,SetLocalString(oSoul,"ku_ammo_"+sBase,sTemplate));
  else
    SetLocalString(oSoul,"ku_ammo_pack_"+sBase,"");

  SetName(oToulec,GetLocalString(oToulec,"name")+" - zbyva "+IntToString(iObsah)+" munice");

}

object ku_CopyNPCWithEquipedItems(object oSource, location locLocation, object oOwner = OBJECT_INVALID, string sNewTag = "", int bDroppable = FALSE) {
   object oNew;

   if (GetObjectType(oSource) == OBJECT_TYPE_PLACEABLE) {
     oNew = CreateObject(OBJECT_TYPE_PLACEABLE,GetResRef(oSource),locLocation,FALSE,sNewTag);
     SetPlaceableAppearance(oNew,GetAppearanceType(oSource));
     return oNew;
   }

   oNew = CopyObject(oSource,locLocation,oOwner,sNewTag);
   if (GetObjectType(oSource) != OBJECT_TYPE_CREATURE)
     return oNew;

   /* For creatures .... */
   int i=0;
   if(GetAppearanceType(oSource) !=  GetAppearanceType(oNew)) {
     SetCreatureAppearanceType(oNew,GetAppearanceType(oSource));
//     AssignCommand(oNew,SpeakString("Setting Appearance"));
   }
   if(GetPhenoType(oSource) != GetPhenoType(oNew)) {
     SetPhenoType(GetPhenoType(oSource),oNew);
//     AssignCommand(oNew,SpeakString("Setting Pheno"));
   }
   if(GetGender(oSource) != GetGender(oNew)) {
     SetGender(oNew,GetGender(oSource));
//     AssignCommand(oNew,SpeakString("Setting Gender"));
   }

   for(i=0;i<=17;i++) {
     if(GetCreatureBodyPart(i,oSource) != GetCreatureBodyPart(i,oNew)) {
       SetCreatureBodyPart(i,GetCreatureBodyPart(i,oSource),oNew);
     }
   }
   for(i=0;i<=3;i++) {
     SetColor(oNew,i,GetColor(oSource,i));
   }


   object oItem;
   object oNewItem;

   if(GetIsPC(oSource)) {
     object otmp = CopyObject(oNew,locLocation,oOwner,sNewTag);
     DestroyObject(oNew,0.1);
     oNew = otmp;
   }

   /* For all inventorty slots */
   for(i=0; i<=18; i++) {
    oItem = GetItemInSlot(i,oNew);
    DestroyObject(oItem,0.1);
    oItem = GetItemInSlot(i,oSource);
    oNewItem = CopyItem(oItem,oNew,FALSE);
    AssignCommand(oNew,ActionEquipItem(oNewItem,i));
    SetDroppableFlag(oNewItem,bDroppable);
   }

   object item = GetFirstItemInInventory(oNew);
   while (GetIsObjectValid(item)) {
      SetDroppableFlag(item, FALSE);
     item = GetNextItemInInventory(oNew);
   }


/*    SetIsTemporaryEnemy( oSource, oNew );

    SetAILevel(oNew, AI_LEVEL_HIGH);*/

   return oNew;

}

int ku_ReduceXPGainForDeath(object oPC, int iXP, int bTimeXP = FALSE) {
  object oSoul = GetSoulStone(oPC);
  int iXPDebt = GetLocalInt(oSoul,"KU_XP_DEBT");
  if(iXPDebt <= 0)
    return iXP;

  // smaller half of xp
  int GiveXP;
  if( ( 100 * iXPDebt) / GetXP(oPC) >= 15)
    GiveXP = iXP / 10;
  else
    GiveXP = iXP / 2;

  // Update debt
  if(bTimeXP)
    SetLocalInt(oSoul,"KU_XP_DEBT",iXPDebt - (2*(iXP - GiveXP)));
  else
    SetLocalInt(oSoul,"KU_XP_DEBT",iXPDebt - (iXP - GiveXP));

  return GiveXP;

}

void ku_GiveXPDebt(object oPC, int iXP) {
  object oSoul = GetSoulStone(oPC);
  int iXPDebt = GetLocalInt(oSoul,"KU_XP_DEBT");
  // in case of bug
  if(iXPDebt < 0)
    iXPDebt = 0;

  SetLocalInt(oSoul,"KU_XP_DEBT",iXPDebt + iXP);

}

