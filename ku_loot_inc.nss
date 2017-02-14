/* Kucik Loot functions Library
 * release 11.08.2008
 *
 */


#include "ku_libtime"
#include "ja_lib"

// used to create unique craft items
#include "tc_si_prop_funcs"
#include "tc_zl_funcs"
#include "tc_oc_prop_funcs"
#include "tc_dr_prop_funcs"

/*
 * melvik upava na novy zpusob nacitani soulstone 16.5.2009
 */

   // Turns on debug mode
   int LOOT_DEBUG = FALSE;

// * Kontrola lootu
// Den ma 86400 skutecnych i hernich sekund
    const int KU_LOOT_LIMIT_PER_LVL = 14000; // To by melo byt tak na tyden

    // za den (86400 sekund) by se melo odbourat 2000 / lvl
    // 86400s / 2000gp = 43,2 vterin na zlatak
    const float KU_LOOT_TIME_PER_GP = 43.2; // Pokud chcete menit nastaveni, mente tuhle konstantu
    // KU_LOOT_LIMIT_PER_LVL ovlivnuje jen za jak dlouho se limit projevi.
    const float KU_LOOT_PARTY_DISTANCE = 30.0; // vzdalenost, do jake se hleda parta


//
// Create Boss unique loot item
object ku_LootCreateBossUniqueItem(object oBoss, string sBoxTag);

int ku_lootTryToEnchant(object oItem, int iPower, int iTry);
int ku_loot_GetIsWeapon(object oItem);

//
// Spawn unique boss loot on boss corpse
int ku_LootCreateBossUniqueLootItems(object oBoss);

int __LootCreateBossUniqueLootItems(object oBoss, string sBoxTag);

//
// Init unique boss loot
// Run this on module load script
void ku_InitBossUniqueLoot();


/* /////////////////////////////////////////////////////
 * KUCIK anti-loot functions
 * ////////////////////////////////////////////////////
 */

/*
 * Funkce zjisti a podle casu upresni, kolik maji nalootovany PC v okoli truhly
 * Upravi jim hodnoty podle aktualniho casu a ulozi jim je zpatky.
 * Ulozi stavy do promennych na truhle a vrati TRUE, pokud se ma generovat poklad
 */
int KU_LootFunctions_CheckLimitInGroup()
{
 object oPC = GetFirstPC();
 int i=0;
 object oSoul;
 float fDistance;
 float fLootGP;
 float fPartyGPToLoot = 0.0;
 int iLastCheck;
 int iTime;
 int iHD;
 int iTimeNow = ku_GetTimeStamp();
 int iPCCount = 0;
 int bIsDM=FALSE;

 while( (GetIsObjectValid(oPC)) ) {
    if (GetIsDM(oPC))
      bIsDM=TRUE;

   // Zkontrolujem vzdalenost
   fDistance = GetDistanceToObject(oPC);
   if( (fDistance != -1.0f ) && (fDistance <= KU_LOOT_PARTY_DISTANCE) && (!GetIsDM(oPC)) ){
     iPCCount++;
     // Ted postave upravime loot gp podle casu
     iHD = GetHitDice(oPC);
     oSoul = GetSoulStone(oPC);
     iLastCheck = GetLocalInt(oSoul,"KU_LOOT_LAST_CHECK");
     iTime = iTimeNow - iLastCheck;
     fLootGP = GetLocalFloat(oSoul,"KU_LOOT_GP") - ((iTime * iHD) / KU_LOOT_TIME_PER_GP);
     if( (fLootGP < 0.0) || (iTime < 0) )
       fLootGP = 0.0;
     SetLocalInt(oSoul,"KU_LOOT_LAST_CHECK",iTimeNow);
     SetLocalFloat(oSoul,"KU_LOOT_GP",fLootGP);

     // A ted samotna kontrola
     fLootGP = (iHD * KU_LOOT_LIMIT_PER_LVL) - fLootGP; // ted jsme sice otocily vyznam promenne, ale co je komu po tom?
     if(fLootGP > 0.0) { // Pokud muze jeste hrabat, muzem s postavou pocitat
       i++;
       fPartyGPToLoot = fPartyGPToLoot + fLootGP;

       //Poukladame si do truhly vsechno info o parte.
       SetLocalFloat(OBJECT_SELF,"KU_LOOT_TL"+ IntToString(i),fLootGP);
       SetLocalObject(OBJECT_SELF,"KU_LOOT_PC"+ IntToString(i),oPC);
     }

   }
   oPC = GetNextPC();
 }
 SetLocalFloat(OBJECT_SELF,"KU_LOOT_PARTY_TL",fPartyGPToLoot);
 SetLocalInt(OBJECT_SELF,"KU_LOOT_PARTY_CNT",i);
 if(fPartyGPToLoot > 0.0)
   return TRUE;
 else {
   if(bIsDM)
     return TRUE;
   else
     return FALSE;
 }
}


/*
 * Funkce rozdeli cenu lootu mezi PC, ktere najde zapsane na truhle;
 * Musi  se volat po KU_LootFunctions_CheckLimitInGroup()
 */
int KU_LootFunctions_SetLootToGroup(int LootCost)
{
  float fPartyToLoot = GetLocalFloat(OBJECT_SELF,"KU_LOOT_PARTY_TL");
  int cnt = GetLocalInt(OBJECT_SELF,"KU_LOOT_PARTY_CNT");
  int i;
  object oPC;
  float fToLoot;
  object oSoul;


  for(i=1; i <= cnt ; i++) {
    fToLoot = GetLocalFloat(OBJECT_SELF,"KU_LOOT_TL"+ IntToString(i));
    oPC = GetLocalObject(OBJECT_SELF,"KU_LOOT_PC"+ IntToString(i));
    oSoul = GetSoulStone(oPC);

    if(LOOT_DEBUG)
      SendMessageToPC(oPC,"you've looted " + FloatToString(fToLoot * LootCost / fPartyToLoot));
    SetLocalFloat(oSoul,"KU_LOOT_GP",(GetLocalFloat(oSoul,"KU_LOOT_GP") + (fToLoot * LootCost / fPartyToLoot) ));

  }
 return 0;
}


/**************************
 **************************
 ****** BOSS LOOT *********
 **************************
 **************************/

void ku_InitContainer(object oMod, object oCont) {

  string sContName = GetTag(oCont);
  int iItems = GetLocalInt(oCont,"LOOT_TOTAL_ITEMS");
  if(iItems > 0) {
    return;
  }

  int i=0;
  object oItem = GetFirstItemInInventory(oCont);
  while(GetIsObjectValid(oItem)) {
    i++;
    SetLocalObject(oCont,"KU_LOOT_ITEM_"+IntToString(i),oItem);
    oItem = GetNextItemInInventory(oCont);
  }

  SetLocalInt(oCont,"LOOT_TOTAL_ITEMS",i);
  SetLocalObject(oMod,"BOSS_LOOT_CONT_"+sContName,oCont);

}

void ku_InitBossUniqueLoot() {

  WriteTimestampedLogEntry("Preparing boss Uniwue loot...");

  object oMod = GetModule();
  object oWaypoint = GetObjectByTag("ku_thalie_loot_area");

  int i=1;
  object oBox = GetNearestObject(OBJECT_TYPE_STORE,oWaypoint,i);

  while(GetIsObjectValid(oBox)) {
    DelayCommand(i*2.0,ku_InitContainer(oMod,oBox));
    i++;
    oBox = GetNearestObject(OBJECT_TYPE_STORE,oWaypoint,i);
  }

  DelayCommand(i*2.0,WriteTimestampedLogEntry("Boss loot should be prepared."));
}

int ku_LootCreateBossUniqueLootItems(object oBoss) {

  string sBoxTag;
  int iCount = 0;
  sBoxTag = GetLocalString(oBoss,"LOOT");
  if(GetStringLength(sBoxTag) > 0)
    iCount += __LootCreateBossUniqueLootItems(oBoss, sBoxTag);
  sBoxTag = GetLocalString(oBoss,"LOOT2");
  if(GetStringLength(sBoxTag) > 0)
    Count += __LootCreateBossUniqueLootItems(oBoss, sBoxTag);
  sBoxTag = GetLocalString(oBoss,"LOOT3");
  if(GetStringLength(sBoxTag) > 0)
    iCount += __LootCreateBossUniqueLootItems(oBoss, sBoxTag);
  sBoxTag = GetLocalString(oBoss,"LOOT4");
  if(GetStringLength(sBoxTag) > 0)
    iCount += __LootCreateBossUniqueLootItems(oBoss, sBoxTag);

  return iCount;
}

int __LootCreateBossUniqueLootItems(object oBoss, string sBoxTag) {

  WriteTimestampedLogEntry("BOSS '"+GetName(oBoss)+"' has lootbag '"+sBoxTag+"'");

  if(GetStringLength(sBoxTag) == 0) {
    return -1;
  }

  int iRand = Random(100);
  int iItems = 0;
  if(iRand < 25) {
    iItems++;
  }
  if(iRand < 10) {
    iItems++;
  }
  if(iRand <  2) {
    iItems++;
  }
  int i;
  object oItem;

  WriteTimestampedLogEntry("BOSS '"+GetName(oBoss)+"' has lootbag '"+sBoxTag+"' creating "+IntToString(iItems)+" items.");

  for(i=0;i < iItems;i++) {
    oItem = ku_LootCreateBossUniqueItem(oBoss,sBoxTag);
    WriteTimestampedLogEntry("BOSS '"+GetName(oBoss)+"' with '"+sBoxTag+"' created "+GetName(oItem)+".");
  }

  return iItems;
}

object ku_LootCreateBossUniqueItem(object oBoss, string sBoxTag) {
  object oMod = GetModule();

  object oBox = GetLocalObject(oMod,"BOSS_LOOT_CONT_"+sBoxTag);
  if(!GetIsObjectValid(oBox)) {
    SpeakString("Error! Cannot get loot container "+sBoxTag);
    return OBJECT_INVALID;
  }

  int iRand = Random(GetLocalInt(oBox,"LOOT_TOTAL_ITEMS"))+1;
  object oItem = GetLocalObject(oBox,"KU_LOOT_ITEM_"+IntToString(iRand));
  if(!GetIsObjectValid(oItem)) {
    SpeakString("Error! Cannot get item "+IntToString(iRand)+" from container "+sBoxTag);
    return OBJECT_INVALID;
  }
  object oNew = CopyItem(oItem,oBoss);
  SetPlotFlag(oNew,0);
  SetStolenFlag(oNew,0);
  SetDroppableFlag(oNew,TRUE);
  SetIdentified(oNew,0);

  /* Item properties power = 2 * loot_power(1-6) = 2-12 */
  int iPower = StringToInt(GetStringRight(sBoxTag,1)) * 2;
  /* choose stones and define stone power */
  int iStone1 = Random(15)+1;
  int iStone2 = Random(15)+1;
  if(iStone1 == iStone2) {
    iStone2 = (iStone2 + 1)%15 + 1;
  }
  int iPower1 = Random(iPower+1);
  int iPower2 = iPower - iPower1;
  int iBaseItem = GetBaseItemType(oNew);

  switch(iBaseItem) {
    //Cloth
    case BASE_ITEM_ARMOR:
      if(GetWeight(oNew) > 11) {
        break;
      }
    case BASE_ITEM_BOOTS:
    case BASE_ITEM_GLOVES:
    case BASE_ITEM_BRACER:
    case BASE_ITEM_HELMET:
    case BASE_ITEM_BELT:
    case BASE_ITEM_CLOAK:
      /* apply taylor properties */
      if(GetLocalInt(OBJECT_SELF,"DEBUG") > 0) {
        SpeakString("DEBUG: "+GetName(oNew)+" + vlastnosti siti o sile kamenu "+IntToString(iPower1*20)+"% a "+IntToString(iPower1*20)+"%");
      }
      if(iPower1 > 0)
        tc_si_AddPropertyForStone(oNew,iStone1,iPower1,TRUE);
      if(iPower2 > 0)
        tc_si_AddPropertyForStone(oNew,iStone2,iPower2,TRUE);
      break;
    case BASE_ITEM_AMULET:
      /* Block natural AC bonus */
      if(iStone1 == 8)
        iStone1 = 15;
      if(iStone2 == 8)
        iStone2 = 15;
    case BASE_ITEM_RING:
      /* Apply jewelery properties */
      if(GetLocalInt(OBJECT_SELF,"DEBUG") > 0) {
        SpeakString("DEBUG: "+GetName(oNew)+" + vlastnosti zlatnictvi o sile kamenu "+IntToString(iPower1*20)+"% a "+IntToString(iPower1*20)+"%");
      }
      ku_zl_AddPropertiesForStone(oNew,iPower1,iStone1);
      ku_zl_AddPropertiesForStone(oNew,iPower2,iStone2);
      break;
    case BASE_ITEM_BOLT:
    case BASE_ITEM_ARROW:
    case BASE_ITEM_BULLET:
      /* apply amunition properties */
      ku_lootTryToEnchant(oNew,iPower,6);
      break;
    default:
      break;
  }

  if(ku_loot_GetIsWeapon(oNew)) {
    if(iBaseItem == BASE_ITEM_MAGICSTAFF) {
      tc_dr_StaffAddPropertyForStone(oNew,iStone1,iPower,TRUE);
      return oNew;
    }
    ku_lootTryToEnchant(oNew,iPower,3);
  }

  return oNew;
}

int ku_loot_GetIsWeapon(object oItem) {


  int iBaseItem = GetBaseItemType(oItem);
  if(iBaseItem == BASE_ITEM_GLOVES) {
    return FALSE;
  }

  string sret = Get2DAString("baseitems","WeaponType",iBaseItem);
//  SendMessageToPC(GetFirstPC(),"Getisweapon returned '"+sret+"' for item "+GetName(oItem));

  if(GetStringLength(sret) == 1 && sret != "0" ) {
    return TRUE;
  }
  return FALSE;
}

int ku_lootTryToEnchant(object oItem, int iPower, int iTry) {

 int iret = FALSE;
 int i;
 for(i=0;i<iTry;i++) {
   int iType = Random(TC_OC_TOTALENCHANT_TYPES)+1;
   iret = tc_EnchantmentAddEnchantment(oItem,iType,iPower);
   if(iret) {
     return TRUE;
   }
 }

 return FALSE;
}


