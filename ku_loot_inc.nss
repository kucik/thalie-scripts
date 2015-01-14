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

  string sBoxTag = GetLocalString(oBoss,"LOOT");

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
      tc_si_AddPropertyForStone(oNew,iStone1,iPower1,TRUE);
      tc_si_AddPropertyForStone(oNew,iStone2,iPower2,TRUE);
      break;
    case BASE_ITEM_AMULET:
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


void ku_InitTrofeje() {

object oModule = GetModule();

/* TODO rewrite - save this on different object. not module */

/* TROFEJE START - generovano exelem */ /*
SetLocalString(oModule, "thTrofejMisc_ry_sn_zmije", "ry_hadi_kuze");
SetLocalString(oModule, "thTrofejMisc_zep_medforest001", "ry_hadi_kuze");
SetLocalString(oModule, "thTrofejMisc_obrihad", "ry_hadi_kuze");
SetLocalString(oModule, "thTrofejMisc_zep_hugefores001", "ry_hadi_kuze");
SetLocalString(oModule, "thTrofejMisc_zep_hugejungl001", "ry_hadi_kuze");
SetLocalString(oModule, "thTrofejMisc_zep_medjungle001", "ry_hadi_kuze");
SetLocalString(oModule, "thTrofejMisc_zep_tinyjungl001", "ry_hadi_kuze");
SetLocalString(oModule, "thTrofejMisc_zep_hugedeser001", "ry_hadi_kuze");
SetLocalString(oModule, "thTrofejMisc_staryjezevec", "cnrskinbadger");
SetLocalString(oModule, "thTrofejMeat_staryjezevec", "1");
SetLocalString(oModule, "thTrofejMisc_cnrabadger", "cnrskinbadger");
SetLocalString(oModule, "thTrofejMeat_cnrabadger", "1");
SetLocalString(oModule, "thTrofejMisc_badger001", "cnrskinbadger");
SetLocalString(oModule, "thTrofejMeat_badger001", "1");
SetLocalString(oModule, "thTrofejMisc_badger_friendly", "cnrskinbadger");
SetLocalString(oModule, "thTrofejMeat_badger_friendly", "1");
SetLocalString(oModule, "thTrofejMisc_nw_badger", "cnrskinbadger");
SetLocalString(oModule, "thTrofejMeat_nw_badger", "1");
SetLocalString(oModule, "thTrofejMisc_nw_direbadg", "cnrskinbadger");
SetLocalString(oModule, "thTrofejMeat_nw_direbadg", "1");
SetLocalString(oModule, "thTrofejMisc_cnracragcat", "cnrskincragcat");
SetLocalInt(oModule, "thTrofejDiff_cnracragcat", 50);
SetLocalString(oModule, "thTrofejMisc_nw_cougar", "cnrskincragcat");
SetLocalInt(oModule, "thTrofejDiff_nw_cougar", 50);
SetLocalString(oModule, "thTrofejMisc_cnracougar", "cnrskincragcat");
SetLocalInt(oModule, "thTrofejDiff_cnracougar", 50);
SetLocalString(oModule, "thTrofejMisc_nw_rat001", "cnrskinrat");
SetLocalString(oModule, "thTrofejMisc_nw_rat002", "cnrskinrat");
SetLocalString(oModule, "thTrofejMisc_nw_ratdire001", "cnrskinrat");
SetLocalString(oModule, "thTrofejMisc_cnrskinpolarbear", "cnrskinpolarbear");
SetLocalString(oModule, "thTrofejMeat_cnrskinpolarbear", "2");
SetLocalInt(oModule, "thTrofejDiff_cnrskinpolarbear", 230);
SetLocalString(oModule, "thTrofejMisc_nw_bearpolar", "cnrskinpolarbear");
SetLocalString(oModule, "thTrofejMeat_nw_bearpolar", "2");
SetLocalInt(oModule, "thTrofejDiff_nw_bearpolar", 230);
SetLocalString(oModule, "thTrofejMisc_ry_sn_medved", "cnrskinpolarbear");
SetLocalString(oModule, "thTrofejMeat_ry_sn_medved", "2");
SetLocalInt(oModule, "thTrofejDiff_ry_sn_medved", 230);
SetLocalString(oModule, "thTrofejMisc_ry_pr_medved", "cnrskinblkbear");
SetLocalString(oModule, "thTrofejMeat_ry_pr_medved", "2");
SetLocalInt(oModule, "thTrofejDiff_ry_pr_medved", 100);
SetLocalString(oModule, "thTrofejMisc_cnrablkbear", "cnrskinblkbear");
SetLocalString(oModule, "thTrofejMeat_cnrablkbear", "2");
SetLocalInt(oModule, "thTrofejDiff_cnrablkbear", 100);
SetLocalString(oModule, "thTrofejMisc_nw_bearblck", "cnrskinblkbear");
SetLocalString(oModule, "thTrofejMeat_nw_bearblck", "2");
SetLocalInt(oModule, "thTrofejDiff_nw_bearblck", 100);
SetLocalString(oModule, "thTrofejMisc_bearblck001", "cnrskinblkbear");
SetLocalString(oModule, "thTrofejMeat_bearblck001", "2");
SetLocalInt(oModule, "thTrofejDiff_bearblck001", 150);
SetLocalString(oModule, "thTrofejMisc_cnrabrnbear", "cnrskinbrnbear");
SetLocalString(oModule, "thTrofejMeat_cnrabrnbear", "2");
SetLocalInt(oModule, "thTrofejDiff_cnrabrnbear", 150);
SetLocalString(oModule, "thTrofejMisc_bearbrwn001", "cnrskinbrnbear");
SetLocalString(oModule, "thTrofejMeat_bearbrwn001", "2");
SetLocalInt(oModule, "thTrofejDiff_bearbrwn001", 150);
SetLocalString(oModule, "thTrofejMisc_nw_bearbrwn", "cnrskinbrnbear");
SetLocalString(oModule, "thTrofejMeat_nw_bearbrwn", "2");
SetLocalInt(oModule, "thTrofejDiff_nw_bearbrwn", 150);
SetLocalString(oModule, "thTrofejMisc_bearbrwn002", "cnrskinbrnbear");
SetLocalString(oModule, "thTrofejMeat_bearbrwn002", "2");
SetLocalInt(oModule, "thTrofejDiff_bearbrwn002", 200);
SetLocalString(oModule, "thTrofejMisc_nw_bearkodiak", "cnrskingrizbear");
SetLocalString(oModule, "thTrofejMeat_nw_bearkodiak", "2");
SetLocalInt(oModule, "thTrofejDiff_nw_bearkodiak", 200);
SetLocalString(oModule, "thTrofejMisc_cnragrizbear", "cnrskingrizbear");
SetLocalString(oModule, "thTrofejMeat_cnragrizbear", "2");
SetLocalInt(oModule, "thTrofejDiff_cnragrizbear", 200);
SetLocalString(oModule, "thTrofejMisc_bearkodiak002", "cnrskingrizbear");
SetLocalString(oModule, "thTrofejMeat_bearkodiak002", "2");
SetLocalInt(oModule, "thTrofejDiff_bearkodiak002", 200);
SetLocalString(oModule, "thTrofejMisc_beardire001", "cnrskindb");
SetLocalString(oModule, "thTrofejMeat_beardire001", "3");
SetLocalInt(oModule, "thTrofejDiff_beardire001", 280);
SetLocalString(oModule, "thTrofejMisc_beardireboss001", "cnrskindb");
SetLocalString(oModule, "thTrofejMeat_beardireboss001", "3");
SetLocalInt(oModule, "thTrofejDiff_beardireboss001", 280);
SetLocalString(oModule, "thTrofejMisc_leopard", "cnrskinleopard");
SetLocalString(oModule, "thTrofejMeat_leopard", "1");
SetLocalInt(oModule, "thTrofejDiff_leopard", 100);
SetLocalString(oModule, "thTrofejMisc_zep_catcloudl001", "cnrskinleopard");
SetLocalString(oModule, "thTrofejMeat_zep_catcloudl001", "1");
SetLocalInt(oModule, "thTrofejDiff_zep_catcloudl001", 100);
SetLocalString(oModule, "thTrofejMisc_diretiger001", "cnrskintiger");
SetLocalString(oModule, "thTrofejMeat_diretiger001", "3");
SetLocalInt(oModule, "thTrofejDiff_diretiger001", 300);
SetLocalString(oModule, "thTrofejMisc_zep_cattiger001", "me_kuze_tygr");
SetLocalString(oModule, "thTrofejMeat_zep_cattiger001", "1");
SetLocalInt(oModule, "thTrofejDiff_zep_cattiger001", 200);
SetLocalString(oModule, "thTrofejMisc_zep_cattiger", "me_kuze_tygr");
SetLocalString(oModule, "thTrofejMeat_zep_cattiger", "1");
SetLocalInt(oModule, "thTrofejDiff_zep_cattiger", 200);
SetLocalString(oModule, "thTrofejMisc_cnralion", "cnrskinlion");
SetLocalString(oModule, "thTrofejMeat_cnralion", "1");
SetLocalInt(oModule, "thTrofejDiff_cnralion", 300);
SetLocalString(oModule, "thTrofejMisc_zep_bat_003", "cnrskinbat");
SetLocalString(oModule, "thTrofejMisc_zep_bat_004", "cnrskinbat");
SetLocalString(oModule, "thTrofejMisc_nw_bat", "cnrskinbat");
SetLocalString(oModule, "thTrofejMisc_ry_karnetop", "cnrskinbat");
SetLocalString(oModule, "thTrofejMisc_cnrapanther", "cnrskinpanther");
SetLocalString(oModule, "thTrofejMeat_cnrapanther", "1");
SetLocalInt(oModule, "thTrofejDiff_cnrapanther", 120);
SetLocalString(oModule, "thTrofejMisc_panther001", "cnrskinpanther");
SetLocalString(oModule, "thTrofejMeat_panther001", "1");
SetLocalInt(oModule, "thTrofejDiff_panther001", 120);
SetLocalString(oModule, "thTrofejMisc_panther2", "cnrskinpanther");
SetLocalString(oModule, "thTrofejMeat_panther2", "1");
SetLocalInt(oModule, "thTrofejDiff_panther2", 120);
SetLocalString(oModule, "thTrofejMisc_bearkodiak001", "cnrskinpanther");
SetLocalString(oModule, "thTrofejMeat_bearkodiak001", "1");
SetLocalInt(oModule, "thTrofejDiff_bearkodiak001", 120);
SetLocalString(oModule, "thTrofejMisc_boar001", "cnrskinboar");
SetLocalString(oModule, "thTrofejMeat_boar001", "1");
SetLocalInt(oModule, "thTrofejDiff_boar001", 20);
SetLocalString(oModule, "thTrofejMisc_cnraboar", "cnrskinboar");
SetLocalString(oModule, "thTrofejMeat_cnraboar", "1");
SetLocalInt(oModule, "thTrofejDiff_cnraboar", 20);
SetLocalString(oModule, "thTrofejMisc_boardire001", "cnrskinboar");
SetLocalString(oModule, "thTrofejMeat_boardire001", "1");
SetLocalInt(oModule, "thTrofejDiff_boardire001", 20);
SetLocalString(oModule, "thTrofejMisc_nw_boardire", "cnrskinboar");
SetLocalString(oModule, "thTrofejMeat_nw_boardire", "1");
SetLocalInt(oModule, "thTrofejDiff_nw_boardire", 20);
SetLocalString(oModule, "thTrofejMisc_nw_wolf", "cnrskinwolf");
SetLocalString(oModule, "thTrofejMeat_nw_wolf", "1");
SetLocalInt(oModule, "thTrofejDiff_nw_wolf", 15);
SetLocalString(oModule, "thTrofejMisc_direwolf002", "cnrskinwolf");
SetLocalString(oModule, "thTrofejMeat_direwolf002", "1");
SetLocalInt(oModule, "thTrofejDiff_direwolf002", 15);
SetLocalString(oModule, "thTrofejMisc_cnrawolf", "cnrskinwolf");
SetLocalString(oModule, "thTrofejMeat_cnrawolf", "1");
SetLocalInt(oModule, "thTrofejDiff_cnrawolf", 15);
SetLocalString(oModule, "thTrofejMisc_direbadg003", "cnrskinwolf");
SetLocalString(oModule, "thTrofejMeat_direbadg003", "1");
SetLocalInt(oModule, "thTrofejDiff_direbadg003", 15);
SetLocalString(oModule, "thTrofejMisc_vlkvudcesmecky", "cnrskinwolf");
SetLocalString(oModule, "thTrofejMeat_vlkvudcesmecky", "1");
SetLocalInt(oModule, "thTrofejDiff_vlkvudcesmecky", 15);
SetLocalString(oModule, "thTrofejMisc_wolfdireboss002", "cnrskinwolf");
SetLocalString(oModule, "thTrofejMeat_wolfdireboss002", "1");
SetLocalInt(oModule, "thTrofejDiff_wolfdireboss002", 15);
SetLocalString(oModule, "thTrofejMisc_nw_ox", "cnrskinox");
SetLocalString(oModule, "thTrofejMeat_nw_ox", "2");
SetLocalString(oModule, "thTrofejMisc_cnraox", "cnrskinox");
SetLocalString(oModule, "thTrofejMeat_cnraox", "2");
SetLocalString(oModule, "thTrofejMisc_nw_wolfwint", "cnrskinwinwolf");
SetLocalString(oModule, "thTrofejMeat_nw_wolfwint", "1");
SetLocalInt(oModule, "thTrofejDiff_nw_wolfwint", 200);
SetLocalString(oModule, "thTrofejMisc_ry_snez_tygr", "ry_snt_kuze");
SetLocalString(oModule, "thTrofejMeat_ry_snez_tygr", "2");
SetLocalInt(oModule, "thTrofejDiff_ry_snez_tygr", 300);
SetLocalString(oModule, "thTrofejMisc_ry_zur_gor_2", "ry_gor_kuze");
SetLocalString(oModule, "thTrofejMeat_ry_zur_gor_2", "2");
SetLocalInt(oModule, "thTrofejDiff_ry_zur_gor_2", 160);
SetLocalString(oModule, "thTrofejMisc_ry_koc_savl", "ry_szkoc_kuze");
SetLocalString(oModule, "thTrofejMeat_ry_koc_savl", "2");
SetLocalInt(oModule, "thTrofejDiff_ry_koc_savl", 150);
SetLocalString(oModule, "thTrofejMisc_ry_sn_leopard2", "ry_snl_kuze");
SetLocalString(oModule, "thTrofejMeat_ry_sn_leopard2", "1");
SetLocalInt(oModule, "thTrofejDiff_ry_sn_leopard2", 100);
SetLocalString(oModule, "thTrofejMisc_zep_catleopar001", "ry_snl_kuze");
SetLocalString(oModule, "thTrofejMeat_zep_catleopar001", "1");
SetLocalInt(oModule, "thTrofejDiff_zep_catleopar001", 100);
SetLocalString(oModule, "thTrofejMisc_ry_zraljes", "ry_zral_kuze");
SetLocalString(oModule, "thTrofejMeat_ry_zraljes", "1");
SetLocalInt(oModule, "thTrofejDiff_ry_zraljes", 150);
SetLocalString(oModule, "thTrofejMisc_ry_krab", "masokraba001");
SetLocalInt(oModule, "thTrofejDiff_ry_krab", 10);
SetLocalString(oModule, "thTrofejMisc_ry_poukrab", "masokraba001");
SetLocalInt(oModule, "thTrofejDiff_ry_poukrab", 10);
SetLocalString(oModule, "thTrofejMisc_ry_poukrab001", "masokraba001");
SetLocalInt(oModule, "thTrofejDiff_ry_poukrab001", 10);
SetLocalString(oModule, "thTrofejMisc_zep_crab002", "masokraba001");
SetLocalInt(oModule, "thTrofejDiff_zep_crab002", 10);
SetLocalString(oModule, "thTrofejMisc_zep_crab003", "masokraba001");
SetLocalInt(oModule, "thTrofejDiff_zep_crab003", 10);
SetLocalString(oModule, "thTrofejMisc_zep_crab004", "masokraba001");
SetLocalInt(oModule, "thTrofejDiff_zep_crab004", 250);
SetLocalString(oModule, "thTrofejMisc_beldskyorel", "it_amt_feath001");
SetLocalInt(oModule, "thTrofejDiff_beldskyorel", 250);
SetLocalString(oModule, "thTrofejMisc_zep_antelope", "kuze");
SetLocalString(oModule, "thTrofejMeat_zep_antelope", "1");
SetLocalString(oModule, "thTrofejMisc_zep_gazelle001", "kuze");
SetLocalString(oModule, "thTrofejMeat_zep_gazelle001", "1");
SetLocalString(oModule, "thTrofejMisc_ry_bila_opice", "kuze");
SetLocalString(oModule, "thTrofejMeat_ry_bila_opice", "1");
SetLocalString(oModule, "thTrofejMisc_direbadg001", "kuze");
SetLocalString(oModule, "thTrofejMeat_direbadg001", "1");
SetLocalString(oModule, "thTrofejMisc_direbadg002", "kuze");
SetLocalString(oModule, "thTrofejMeat_direbadg002", "1");
SetLocalString(oModule, "thTrofejMisc_zep_ferret001", "kuze");
SetLocalString(oModule, "thTrofejMeat_zep_ferret001", "1");
SetLocalString(oModule, "thTrofejMisc_zep_ferret001", "kuze");
SetLocalString(oModule, "thTrofejMeat_zep_ferret001", "1");
SetLocalString(oModule, "thTrofejMisc_zep_hyenaspot001", "kuze");
SetLocalString(oModule, "thTrofejMeat_zep_hyenaspot001", "1");
SetLocalString(oModule, "thTrofejMisc_ry_motak2", "kuze");
SetLocalString(oModule, "thTrofejMeat_ry_motak2", "1");
SetLocalString(oModule, "thTrofejMisc_ry_motak3", "kuze");
SetLocalString(oModule, "thTrofejMeat_ry_motak3", "1");
SetLocalString(oModule, "thTrofejMisc_zep_ringtail001", "kuze");
SetLocalString(oModule, "thTrofejMeat_zep_ringtail001", "1");
SetLocalString(oModule, "thTrofejMisc_zep_raccoon001", "kuze");
SetLocalString(oModule, "thTrofejMeat_zep_raccoon001", "1");
SetLocalString(oModule, "thTrofejMisc_zep_mink001", "kuze");
SetLocalString(oModule, "thTrofejMeat_zep_mink001", "1");
SetLocalString(oModule, "thTrofejMisc_ry_opice1", "kuze");
SetLocalString(oModule, "thTrofejMeat_ry_opice1", "1");
SetLocalString(oModule, "thTrofejMisc_zep_skunk", "kuze");
SetLocalString(oModule, "thTrofejMeat_zep_skunk", "1");
SetLocalString(oModule, "thTrofejMisc_zep_weasel001", "kuze");
SetLocalString(oModule, "thTrofejMeat_zep_weasel001", "1");
SetLocalString(oModule, "thTrofejMisc_nw_dog", "kuze");
SetLocalString(oModule, "thTrofejMeat_nw_dog", "1");
SetLocalString(oModule, "thTrofejMisc_ry_pr_pes", "kuze");
SetLocalString(oModule, "thTrofejMeat_ry_pr_pes", "1");
SetLocalString(oModule, "thTrofejMisc_nw_blinkdog", "kuze");
SetLocalString(oModule, "thTrofejMeat_nw_blinkdog", "1");
SetLocalString(oModule, "thTrofejMisc_boar001", "kuze");
SetLocalString(oModule, "thTrofejMeat_boar001", "1");
SetLocalString(oModule, "thTrofejMisc_legwolf001", "ry_prvl_kuze");
SetLocalString(oModule, "thTrofejMeat_legwolf001", "2");
SetLocalInt(oModule, "thTrofejDiff_legwolf001", 200);
SetLocalString(oModule, "thTrofejMisc_ry_rosomak", "ry_ros_kuze");
SetLocalString(oModule, "thTrofejMeat_ry_rosomak", "1");
SetLocalInt(oModule, "thTrofejDiff_ry_rosomak", 200);
SetLocalString(oModule, "thTrofejMisc_wolverine001", "ry_ros_kuze");
SetLocalString(oModule, "thTrofejMeat_wolverine001", "1");
SetLocalInt(oModule, "thTrofejDiff_wolverine001", 200);
SetLocalString(oModule, "thTrofejMisc_nw_parrot", "ry_pap_peri");
SetLocalInt(oModule, "thTrofejDiff_nw_parrot", 50);
SetLocalString(oModule, "thTrofejMisc_zep_bird_017", "ry_pap_peri");
SetLocalInt(oModule, "thTrofejDiff_zep_bird_017", 50);
SetLocalString(oModule, "thTrofejMisc_zep_bird_018", "ry_pap_peri");
SetLocalInt(oModule, "thTrofejDiff_zep_bird_018", 50);
SetLocalString(oModule, "thTrofejMisc_zep_bird_019", "ry_pap_peri");
SetLocalInt(oModule, "thTrofejDiff_zep_bird_019", 50);
SetLocalString(oModule, "thTrofejMisc_zep_bird_016", "ry_pap_peri");
SetLocalInt(oModule, "thTrofejDiff_zep_bird_016", 50);
SetLocalString(oModule, "thTrofejMisc_zep_bird_020", "ry_pap_peri");
SetLocalInt(oModule, "thTrofejDiff_zep_bird_020", 50);
SetLocalString(oModule, "thTrofejMisc_zep_bird_024", "ry_pap_peri");
SetLocalInt(oModule, "thTrofejDiff_zep_bird_024", 50);
SetLocalString(oModule, "thTrofejMisc_zep_bird_025", "ry_pap_peri");
SetLocalInt(oModule, "thTrofejDiff_zep_bird_025", 50);
SetLocalString(oModule, "thTrofejMisc_zep_bird_023", "ry_peri");
SetLocalInt(oModule, "thTrofejDiff_zep_bird_023", 10);
SetLocalString(oModule, "thTrofejMisc_zep_bird_022", "ry_peri");
SetLocalInt(oModule, "thTrofejDiff_zep_bird_022", 10);
SetLocalString(oModule, "thTrofejMisc_zep_antelope001", "cnrleathdeer");
SetLocalString(oModule, "thTrofejMeat_zep_antelope001", "ry_parozi");
SetLocalInt(oModule, "thTrofejDiff_zep_antelope001", 200);
SetLocalString(oModule, "thTrofejMisc_zep_antelopeb001", "cnrleathdeer");
SetLocalString(oModule, "thTrofejMeat_zep_antelopeb001", "ry_parozi");
SetLocalInt(oModule, "thTrofejDiff_zep_antelopeb001", 200);
SetLocalString(oModule, "thTrofejMisc_zep_gazelle001", "cnrleathdeer");
SetLocalString(oModule, "thTrofejMeat_zep_gazelle001", "ry_parozi");
SetLocalInt(oModule, "thTrofejDiff_zep_gazelle001", 200);
SetLocalString(oModule, "thTrofejMisc_cnrawhitestag", "cnrleathdeer");
SetLocalString(oModule, "thTrofejMeat_cnrawhitestag", "ry_parozi");
SetLocalInt(oModule, "thTrofejDiff_cnrawhitestag", 200);
SetLocalString(oModule, "thTrofejMisc_cnradeer", "cnrleathdeer");
SetLocalString(oModule, "thTrofejMeat_cnradeer", "ry_parozi");
SetLocalInt(oModule, "thTrofejDiff_cnradeer", 200);
SetLocalString(oModule, "thTrofejMisc_nw_deer", "cnrleathdeer");
SetLocalString(oModule, "thTrofejMeat_nw_deer", "ry_parozi");
SetLocalInt(oModule, "thTrofejDiff_nw_deer", 200);
SetLocalString(oModule, "thTrofejMisc_nw_deerstag", "cnrleathdeer");
SetLocalString(oModule, "thTrofejMeat_nw_deerstag", "ry_parozi");
SetLocalInt(oModule, "thTrofejDiff_nw_deerstag", 200);
SetLocalString(oModule, "thTrofejMisc_cnraraven", "cnrfeatherraven");
SetLocalInt(oModule, "thTrofejDiff_cnraraven", 50);
SetLocalString(oModule, "thTrofejMisc_nw_raven", "cnrfeatherraven");
SetLocalInt(oModule, "thTrofejDiff_nw_raven", 50);
SetLocalString(oModule, "thTrofejMisc_zep_owl_007", "cnrfeatherowl");
SetLocalInt(oModule, "thTrofejDiff_zep_owl_007", 50);
SetLocalString(oModule, "thTrofejMisc_cnraowl", "cnrfeatherowl");
SetLocalInt(oModule, "thTrofejDiff_cnraowl", 50);
SetLocalString(oModule, "thTrofejMisc_cnrafalcon", "cnrfeatherfalcon");
SetLocalInt(oModule, "thTrofejDiff_cnrafalcon", 80);
SetLocalString(oModule, "thTrofejMisc_nw_raptor001", "cnrfeatherfalcon");
SetLocalInt(oModule, "thTrofejDiff_nw_raptor001", 80);
SetLocalString(oModule, "thTrofejMisc_tagry_fertox", "ry_kuz_fertox");
SetLocalInt(oModule, "thTrofejDiff_tagry_fertox", 5);
SetLocalString(oModule, "thTrofejMisc_tagry_krysa", "cnrskinrat");
SetLocalInt(oModule, "thTrofejDiff_tagry_krysa", 1);
SetLocalString(oModule, "thTrofejMisc_tagry_jezevec", "cnrskinbadger");
SetLocalString(oModule, "thTrofejMeat_tagry_jezevec", "1");
SetLocalInt(oModule, "thTrofejDiff_tagry_jezevec", 30);
SetLocalString(oModule, "thTrofejMisc_tagry_divocak", "cnrskinboar");
SetLocalString(oModule, "thTrofejMeat_tagry_divocak", "1");
SetLocalInt(oModule, "thTrofejDiff_tagry_divocak", 30);
SetLocalString(oModule, "thTrofejMisc_tagME_MED_JES", "ry_skalm_kuze");
SetLocalString(oModule, "thTrofejMeat_tagME_MED_JES", "1");
SetLocalInt(oModule, "thTrofejDiff_tagME_MED_JES", 50);
SetLocalString(oModule, "thTrofejMisc_tagNW_DIREWOLF", "ry_litvlk_kuze");
SetLocalString(oModule, "thTrofejMeat_tagNW_DIREWOLF", "1");
SetLocalInt(oModule, "thTrofejDiff_tagNW_DIREWOLF", 100);
SetLocalString(oModule, "thTrofejMisc_zep_owlbear_up", "kuzeowlbeara");
SetLocalString(oModule, "thTrofejMeat_zep_owlbear_up", "1");
SetLocalInt(oModule, "thTrofejDiff_zep_owlbear_up", 150);
SetLocalString(oModule, "thTrofejMisc_alansijskytygr", "kuzealansijskeho");
SetLocalString(oModule, "thTrofejMeat_alansijskytygr", "2");
SetLocalInt(oModule, "thTrofejDiff_alansijskytygr", 600);
SetLocalString(oModule, "thTrofejMisc_ry_grifon", "ry_grif_peri");
SetLocalInt(oModule, "thTrofejDiff_ry_grifon", 340);
SetLocalString(oModule, "thTrofejMisc_zep_razorboar001", "ry_kel_prase");
SetLocalInt(oModule, "thTrofejDiff_zep_razorboar001", 260);
SetLocalString(oModule, "thTrofejMisc_nw_bulette", "supinybuleta");
SetLocalInt(oModule, "thTrofejDiff_nw_bulette", 200);
SetLocalString(oModule, "thTrofejMisc_grayrend001", "ry_sedtr_kuze");
SetLocalInt(oModule, "thTrofejDiff_grayrend001", 200);
SetLocalString(oModule, "thTrofejMisc_tagry_stirga", "ry_vykstirga");
SetLocalInt(oModule, "thTrofejDiff_tagry_stirga", 20);
SetLocalString(oModule, "thTrofejMisc_tagry_wefr", "ry_sup_wefr");
SetLocalInt(oModule, "thTrofejDiff_tagry_wefr", 200);
SetLocalString(oModule, "thTrofejMisc_tagry_drapatec", "ry_drap_maso");
SetLocalInt(oModule, "thTrofejDiff_tagry_drapatec", 80);
SetLocalString(oModule, "thTrofejMisc_netopyrodlak", "ry_netdl_kridlo");
SetLocalInt(oModule, "thTrofejDiff_netopyrodlak", 160);
SetLocalString(oModule, "thTrofejMisc_nw_beastmalar001", "cnrskinmalar");
SetLocalInt(oModule, "thTrofejDiff_nw_beastmalar001", 150);
SetLocalString(oModule, "thTrofejMisc_cnramalar", "cnrskinmalar");
SetLocalInt(oModule, "thTrofejDiff_cnramalar", 150);
SetLocalString(oModule, "thTrofejMisc_tagry_tygrodlak", "ry_tygrodl_kuze");
SetLocalInt(oModule, "thTrofejDiff_tagry_tygrodlak", 300);
SetLocalString(oModule, "thTrofejMisc_ry_yetti_boj", "ry_kuz_yetti");
SetLocalInt(oModule, "thTrofejDiff_ry_yetti_boj", 320);
SetLocalString(oModule, "thTrofejMisc_ry_yetti_hum", "ry_kuz_yetti");
SetLocalInt(oModule, "thTrofejDiff_ry_yetti_hum", 320);
SetLocalString(oModule, "thTrofejMisc_ry_yetti_obri", "ry_kuz_yetti");
SetLocalInt(oModule, "thTrofejDiff_ry_yetti_obri", 320);
SetLocalString(oModule, "thTrofejMisc_nw_trollboss", "me_misc_srdtrch");
SetLocalString(oModule, "thTrofejMisc_nw_skelwarr01", "me_kloubk");
SetLocalString(oModule, "thTrofejMisc_nw_skeleton", "me_kloubk");
SetLocalString(oModule, "thTrofejMisc_nw_skelwarr02", "me_kloubk");
SetLocalString(oModule, "thTrofejMisc_nw_skelchief", "me_kloubk");
SetLocalString(oModule, "thTrofejMisc_nw_skelpriest", "me_kloubk");
SetLocalString(oModule, "thTrofejMisc_nw_skelmage", "me_kloubk");
SetLocalString(oModule, "thTrofejMisc_kostlivecbojovni", "me_kloubk");
SetLocalString(oModule, "thTrofejMisc_kostliveclucistn", "me_kloubk");
SetLocalString(oModule, "thTrofejMisc_kostlivecmag", "me_kloubk");
SetLocalString(oModule, "thTrofejMisc_kostvlivecbojovn", "me_kloubk");
SetLocalString(oModule, "thTrofejMisc_skelchief001", "me_kloubk");
SetLocalString(oModule, "thTrofejMisc_skeleton001", "me_kloubk");
SetLocalString(oModule, "thTrofejMisc_tagry_kostlivec", "me_kloubk");
SetLocalString(oModule, "thTrofejMisc_bodak001", "me_kloubk");
SetLocalInt(oModule, "thTrofejDiff_bodak001", 250);
SetLocalString(oModule, "thTrofejMisc_nw_lich001", "kh_zublicha");
SetLocalInt(oModule, "thTrofejDiff_nw_lich001", 320);
SetLocalString(oModule, "thTrofejMisc_nw_lich003", "kh_zublicha");
SetLocalInt(oModule, "thTrofejDiff_nw_lich003", 320);
SetLocalString(oModule, "thTrofejMisc_nw_lichboss", "kh_zublicha");
SetLocalInt(oModule, "thTrofejDiff_nw_lichboss", 320);
SetLocalString(oModule, "thTrofejMisc_tagry_ghoul", "ry_ghoul_jatra");
SetLocalString(oModule, "thTrofejMisc_barghest2", "ry_bargh_kuze");
SetLocalInt(oModule, "thTrofejDiff_barghest2", 200);
SetLocalString(oModule, "thTrofejMisc_zep_barghest", "ry_bargh_kuze");
SetLocalInt(oModule, "thTrofejDiff_zep_barghest", 200);
SetLocalString(oModule, "thTrofejMisc_nw_slaadred", "nw_it_msmlmisc10");
SetLocalInt(oModule, "thTrofejDiff_nw_slaadred", 120);
SetLocalString(oModule, "thTrofejMisc_nw_slaadbl", "nw_it_msmlmisc10");
SetLocalInt(oModule, "thTrofejDiff_nw_slaadbl", 120);
SetLocalString(oModule, "thTrofejMisc_nw_slaaddthboss", "nw_it_msmlmisc10");
SetLocalInt(oModule, "thTrofejDiff_nw_slaaddthboss", 120);
SetLocalString(oModule, "thTrofejMisc_nw_slaadgryboss", "nw_it_msmlmisc10");
SetLocalInt(oModule, "thTrofejDiff_nw_slaadgryboss", 120);
SetLocalString(oModule, "thTrofejMisc_nw_slaaddeth", "nw_it_msmlmisc10");
SetLocalInt(oModule, "thTrofejDiff_nw_slaaddeth", 120);
SetLocalString(oModule, "thTrofejMisc_nw_slaadgray", "nw_it_msmlmisc10");
SetLocalInt(oModule, "thTrofejDiff_nw_slaadgray", 120);
SetLocalString(oModule, "thTrofejMisc_nw_slaadgrn", "nw_it_msmlmisc10");
SetLocalInt(oModule, "thTrofejDiff_nw_slaadgrn", 120);
SetLocalString(oModule, "thTrofejMisc_nw_rakshasa", "nw_it_msmlmisc09");
SetLocalInt(oModule, "thTrofejDiff_nw_rakshasa", 150);
SetLocalString(oModule, "thTrofejMisc_tagry_mephit", "ry_srdce_meph");
SetLocalInt(oModule, "thTrofejDiff_tagry_mephit", 80);
SetLocalString(oModule, "thTrofejMisc_krenshar2", "kuzekrenshara001");
SetLocalString(oModule, "thTrofejMeat_krenshar2", "1");
SetLocalInt(oModule, "thTrofejDiff_krenshar2", 150);
SetLocalString(oModule, "thTrofejMisc_nw_krenshar", "kuzekrenshara001");
SetLocalString(oModule, "thTrofejMeat_nw_krenshar", "1");
SetLocalInt(oModule, "thTrofejDiff_nw_krenshar", 150);
SetLocalString(oModule, "thTrofejMisc_mantikora1", "ry_mant_osten");
SetLocalInt(oModule, "thTrofejDiff_mantikora1", 230);
SetLocalString(oModule, "thTrofejMisc_zep_manticore", "ry_mant_osten");
SetLocalInt(oModule, "thTrofejDiff_zep_manticore", 230);
SetLocalString(oModule, "thTrofejMisc_x0_manticore", "ry_mant_osten");
SetLocalInt(oModule, "thTrofejDiff_x0_manticore", 230);
SetLocalString(oModule, "thTrofejMisc_diretiger002", "ry_baz_oko");
SetLocalInt(oModule, "thTrofejDiff_diretiger002", 400);
SetLocalString(oModule, "thTrofejMisc_ja_cockatrice", "peri_plivnika");
SetLocalInt(oModule, "thTrofejDiff_ja_cockatrice", 200);
SetLocalString(oModule, "thTrofejMisc_x0_gorgon", "me_misc_srdgorg");
SetLocalInt(oModule, "thTrofejDiff_x0_gorgon", 290);
SetLocalString(oModule, "thTrofejMisc_cnraworg", "cnrskinworg");
SetLocalInt(oModule, "thTrofejDiff_cnraworg", 160);
SetLocalString(oModule, "thTrofejMisc_nw_worg", "cnrskinworg");
SetLocalInt(oModule, "thTrofejDiff_nw_worg", 160);
SetLocalString(oModule, "thTrofejMisc_worgh", "cnrskinworg");
SetLocalInt(oModule, "thTrofejDiff_worgh", 160);
SetLocalString(oModule, "thTrofejMisc_tagry_vraz_vino", "ry_popsl_vyh");
SetLocalInt(oModule, "thTrofejDiff_tagry_vraz_vino", 200);
SetLocalString(oModule, "thTrofejMisc_tagry_zimni_vlk", "cnrskinwinwolf");
SetLocalInt(oModule, "thTrofejDiff_tagry_zimni_vlk", 200);
SetLocalString(oModule, "thTrofejMisc_ettercap001", "me_ethetzl");
SetLocalInt(oModule, "thTrofejDiff_ettercap001", 100);
SetLocalString(oModule, "thTrofejMisc_umberhulk001", "ry_klep_klep");
SetLocalInt(oModule, "thTrofejDiff_umberhulk001", 160);
SetLocalString(oModule, "thTrofejMisc_zabijackevino", "ry_vino_spory");
SetLocalInt(oModule, "thTrofejDiff_zabijackevino", 200);
SetLocalString(oModule, "thTrofejMisc_willowisp001", "ry_blud_esence");
SetLocalInt(oModule, "thTrofejDiff_willowisp001", 100);
SetLocalString(oModule, "thTrofejMisc_tagry_hak_das", "ry_hak_krunyr");
SetLocalInt(oModule, "thTrofejDiff_tagry_hak_das", 100);
SetLocalString(oModule, "thTrofejMisc_tagry_mutant", "ry_mut_sliz");
SetLocalInt(oModule, "thTrofejDiff_tagry_mutant", 50);
SetLocalString(oModule, "thTrofejMisc_tagry_beholder", "ry_behold_oko");
SetLocalInt(oModule, "thTrofejDiff_tagry_beholder", 200);
SetLocalString(oModule, "thTrofejMisc_tagry_klepetnatci", "ry_srdce_klepet");
SetLocalInt(oModule, "thTrofejDiff_tagry_klepetnatci", 200);
SetLocalString(oModule, "thTrofejMisc_tagry_klep_psyonik", "ry_klpsyon_moz");
SetLocalInt(oModule, "thTrofejDiff_tagry_klep_psyonik", 300);
SetLocalString(oModule, "thTrofejMisc_tagry_kolonie_spor", "ry_zrspor_myk");
SetLocalInt(oModule, "thTrofejDiff_tagry_kolonie_spor", 200);
SetLocalString(oModule, "thTrofejMisc_nw_btlfire", "nw_it_msmlmisc08");
SetLocalInt(oModule, "thTrofejDiff_nw_btlfire", 20);
SetLocalString(oModule, "thTrofejMisc_ry_btlfire003", "nw_it_msmlmisc08");
SetLocalInt(oModule, "thTrofejDiff_ry_btlfire003", 20);
SetLocalString(oModule, "thTrofejMisc_zep_beetlefir001", "nw_it_msmlmisc08");
SetLocalInt(oModule, "thTrofejDiff_zep_beetlefir001", 20);
SetLocalString(oModule, "thTrofejMisc_broukohnivak", "it_cmat_elmw001");
SetLocalInt(oModule, "thTrofejDiff_broukohnivak", 360);
SetLocalString(oModule, "thTrofejMisc_kralovnabroukuoh", "kh_krovohnivkral");
SetLocalInt(oModule, "thTrofejDiff_kralovnabroukuoh", 400);
SetLocalString(oModule, "thTrofejMisc_broukkyselac", "it_cmat_elmw003");
SetLocalInt(oModule, "thTrofejDiff_broukkyselac", 360);
SetLocalString(oModule, "thTrofejMisc_zep_scorp004", "bodakstira");
SetLocalInt(oModule, "thTrofejDiff_zep_scorp004", 10);
SetLocalString(oModule, "thTrofejMisc_zep_scorph005", "bodakstira");
SetLocalInt(oModule, "thTrofejDiff_zep_scorph005", 10);
SetLocalString(oModule, "thTrofejMisc_zep_scorpg005", "bodakstira");
SetLocalInt(oModule, "thTrofejDiff_zep_scorpg005", 10);
SetLocalString(oModule, "thTrofejMisc_zep_scorph006", "bodakstira");
SetLocalInt(oModule, "thTrofejDiff_zep_scorph006", 10);
SetLocalString(oModule, "thTrofejMisc_zep_scorpg004", "bodakstira");
SetLocalInt(oModule, "thTrofejDiff_zep_scorpg004", 10);
SetLocalString(oModule, "thTrofejMisc_zep_scorph004", "bodakstira");
SetLocalInt(oModule, "thTrofejDiff_zep_scorph004", 10);
SetLocalString(oModule, "thTrofejMisc_zep_scorp005", "bodakstira");
SetLocalInt(oModule, "thTrofejDiff_zep_scorp005", 10);
SetLocalString(oModule, "thTrofejMisc_zep_scorpg005", "bodakstira");
SetLocalInt(oModule, "thTrofejDiff_zep_scorpg005", 10);
SetLocalString(oModule, "thTrofejMisc_zep_scorph006", "bodakstira");
SetLocalInt(oModule, "thTrofejDiff_zep_scorph006", 10);
SetLocalString(oModule, "thTrofejMisc_zep_scorp006", "bodakstira");
SetLocalInt(oModule, "thTrofejDiff_zep_scorp006", 10);
SetLocalString(oModule, "thTrofejMisc_ry_stir_maly", "bodakstira");
SetLocalInt(oModule, "thTrofejDiff_ry_stir_maly", 10);
SetLocalString(oModule, "thTrofejMisc_nw_btlbomb", "cnrbellbomb");
SetLocalInt(oModule, "thTrofejDiff_nw_btlbomb", 200);
SetLocalString(oModule, "thTrofejMisc_obrivosa", "zihadlo_vosy");
SetLocalInt(oModule, "thTrofejDiff_obrivosa", 10);
SetLocalString(oModule, "thTrofejMisc_nw_btlstink", "cnrstinkgland");
SetLocalInt(oModule, "thTrofejDiff_nw_btlstink", 12);
SetLocalString(oModule, "thTrofejMisc_btlstag001", "ry_kr_rohac");
SetLocalInt(oModule, "thTrofejDiff_btlstag001", 200);
SetLocalString(oModule, "thTrofejMisc_tagry_brouk", "ry_br_krovky");
SetLocalInt(oModule, "thTrofejDiff_tagry_brouk", 50);
SetLocalString(oModule, "thTrofejMisc_tagry_brouk_2", "ry_br_krovky_2");
SetLocalInt(oModule, "thTrofejDiff_tagry_brouk_2", 70);
SetLocalString(oModule, "thTrofejMisc_tagry_krab", "masokraba001");
SetLocalInt(oModule, "thTrofejDiff_tagry_krab", 30);
SetLocalString(oModule, "thTrofejMisc_tagry_krab_obr", "ry_mas_obrkr");
SetLocalInt(oModule, "thTrofejDiff_tagry_krab_obr", 100);
SetLocalString(oModule, "thTrofejMisc_tagry_ohn_brouk", "me_ohnbro");
SetLocalInt(oModule, "thTrofejDiff_tagry_ohn_brouk", 50);
SetLocalString(oModule, "thTrofejMisc_tagry_ant_larva", "ry_stav_larva");
SetLocalInt(oModule, "thTrofejDiff_tagry_ant_larva", 50);
SetLocalString(oModule, "thTrofejMisc_tagry_ant_kral", "ry_mrkral_kridl");
SetLocalInt(oModule, "thTrofejDiff_tagry_ant_kral", 250);
SetLocalString(oModule, "thTrofejMisc_tagry_mrchozrout", "ry_mrchzr_krev");
SetLocalInt(oModule, "thTrofejDiff_tagry_mrchozrout", 60);
SetLocalString(oModule, "thTrofejMisc_tagry_rudstir", "ry_rudst_krun");
SetLocalInt(oModule, "thTrofejDiff_tagry_rudstir", 80);
SetLocalString(oModule, "thTrofejMisc_tagry_cerstir", "ry_cerst_krun");
SetLocalInt(oModule, "thTrofejDiff_tagry_cerstir", 80);
SetLocalString(oModule, "thTrofejMisc_zep_blackpudd001", "ry_sliz_ichor");
SetLocalInt(oModule, "thTrofejDiff_zep_blackpudd001", 50);
SetLocalString(oModule, "thTrofejMisc_zep_brownpudd001", "ry_sliz_ichor");
SetLocalInt(oModule, "thTrofejDiff_zep_brownpudd001", 50);
SetLocalString(oModule, "thTrofejMisc_zep_crystaloo001", "ry_sliz_ichor");
SetLocalInt(oModule, "thTrofejDiff_zep_crystaloo001", 50);
SetLocalString(oModule, "thTrofejMisc_zep_greenslim001", "ry_sliz_ichor");
SetLocalInt(oModule, "thTrofejDiff_zep_greenslim001", 50);
SetLocalString(oModule, "thTrofejMisc_grayooze001", "ry_sliz_ichor");
SetLocalInt(oModule, "thTrofejDiff_grayooze001", 50);
SetLocalString(oModule, "thTrofejMisc_ochrejellylrg001", "ry_sliz_ichor");
SetLocalInt(oModule, "thTrofejDiff_ochrejellylrg001", 50);
SetLocalString(oModule, "thTrofejMisc_ochrejellymed001", "ry_sliz_ichor");
SetLocalInt(oModule, "thTrofejDiff_ochrejellymed001", 50);
SetLocalString(oModule, "thTrofejMisc_ochrejellysml001", "ry_sliz_ichor");
SetLocalInt(oModule, "thTrofejDiff_ochrejellysml001", 50);
SetLocalString(oModule, "thTrofejMisc_tagnw_ochrejellylrg", "ry_sliz_ichor");
SetLocalInt(oModule, "thTrofejDiff_tagnw_ochrejellylrg", 30);
SetLocalString(oModule, "thTrofejMisc_gypsy004", "it_cmat_elmw004");
SetLocalInt(oModule, "thTrofejDiff_gypsy004", 160);
SetLocalString(oModule, "thTrofejMisc_gypsy005", "it_cmat_elmw004");
SetLocalInt(oModule, "thTrofejDiff_gypsy005", 160);
SetLocalString(oModule, "thTrofejMisc_gypsy006", "it_cmat_elmw004");
SetLocalInt(oModule, "thTrofejDiff_gypsy006", 160);
SetLocalString(oModule, "thTrofejMisc_bandit007", "it_cmat_elmw005");
SetLocalInt(oModule, "thTrofejDiff_bandit007", 160);
SetLocalString(oModule, "thTrofejMisc_dwarfmerc005", "it_cmat_elmw005");
SetLocalInt(oModule, "thTrofejDiff_dwarfmerc005", 161);
SetLocalString(oModule, "thTrofejMisc_gypsy008", "it_cmat_elmw005");
SetLocalInt(oModule, "thTrofejDiff_gypsy008", 160);
SetLocalString(oModule, "thTrofejMisc_halfmerc005", "it_cmat_elmw005");
SetLocalInt(oModule, "thTrofejDiff_halfmerc005", 160);
SetLocalString(oModule, "thTrofejMisc_humanmerc005", "it_cmat_elmw005");
SetLocalInt(oModule, "thTrofejDiff_humanmerc005", 160);
SetLocalString(oModule, "thTrofejMisc_ry_krokodyl", "ry_krok_kuze");
SetLocalInt(oModule, "thTrofejDiff_ry_krokodyl", 120);
SetLocalString(oModule, "thTrofejMisc_tagry_harpy_hag", "ry_hag_srdce");
SetLocalInt(oModule, "thTrofejDiff_tagry_harpy_hag", 220);
SetLocalString(oModule, "thTrofejMisc_tagry_drapatec", "ry_drap_maso");
SetLocalInt(oModule, "thTrofejDiff_tagry_drapatec", 80);
SetLocalString(oModule, "thTrofejMisc_sirena", "kh_hlassireny");
SetLocalInt(oModule, "thTrofejDiff_sirena", 100);
SetLocalString(oModule, "thTrofejMisc_tagry_aboleth", "ry_abol_chap");
SetLocalInt(oModule, "thTrofejDiff_tagry_aboleth", 100);
SetLocalString(oModule, "thTrofejMisc_tagry_kortix", "ry_sup_kortix");
SetLocalInt(oModule, "thTrofejDiff_tagry_kortix", 200);
SetLocalString(oModule, "thTrofejMisc_tagry_krivilie", "ry_krev_kriv");
SetLocalInt(oModule, "thTrofejDiff_tagry_krivilie", 200);
SetLocalString(oModule, "thTrofejMisc_ry_rytirzkazy_1", "tc_troproryt");
SetLocalInt(oModule, "thTrofejDiff_ry_rytirzkazy_1", 100);
SetLocalString(oModule, "thTrofejMisc_ry_rytirzkazy_2", "tc_troproryt");
SetLocalInt(oModule, "thTrofejDiff_ry_rytirzkazy_2", 100);
SetLocalString(oModule, "thTrofejMisc_ry_rytirzkazy_bs", "tc_troproryt");
SetLocalInt(oModule, "thTrofejDiff_ry_rytirzkazy_bs", 100);
SetLocalString(oModule, "thTrofejMisc_bodak001", "nw_it_msmlmisc06");
SetLocalInt(oModule, "thTrofejDiff_bodak001", 100);
SetLocalString(oModule, "thTrofejMisc_tagry_pavouk_m", "tc_alcjedvak1");
SetLocalInt(oModule, "thTrofejDiff_tagry_pavouk_m", 100);
SetLocalString(oModule, "thTrofejMisc_tagry_pavouk_s", "tc_alcjedvak2");
SetLocalInt(oModule, "thTrofejDiff_tagry_pavouk_s", 300);
SetLocalString(oModule, "thTrofejMisc_tagry_pavuk_v", "tc_alcjedvak3");
SetLocalInt(oModule,    "thTrofejDiff_tagry_pavuk_v", 600);
SetLocalString(oModule, "thTrofejMisc_tagry_had_m", "tc_alcjedvak1");
SetLocalInt(oModule, "thTrofejDiff_tagry_had_m", 100);
SetLocalString(oModule, "thTrofejMisc_tagry_had_s", "tc_alcjedvak2");
SetLocalInt(oModule, "thTrofejDiff_tagry_had_s", 300);
SetLocalString(oModule, "thTrofejMisc_tagry_had_v", "tc_alcjedvak3");
SetLocalInt(oModule, "thTrofejDiff_tagry_had_v", 600);
SetLocalString(oModule, "thTrofejMisc_tagry_ettercap_str", "me_ethetzl");
SetLocalInt(oModule, "thTrofejDiff_tagry_ettercap_str", 300);
SetLocalString(oModule, "thTrofejMisc_tagcnrarat", "cnrskinrat");
SetLocalInt(oModule, "thTrofejDiff_tagcnrarat", 300);
SetLocalString(oModule, "thTrofejMisc_tagNW_WILLOWISP", "ry_blud_esence");
SetLocalInt(oModule, "thTrofejDiff_tagNW_WILLOWISP", 300);
SetLocalString(oModule, "thTrofejMisc_tagry_kys_kostka_1", "ry_kys_esence");
SetLocalInt(oModule,    "thTrofejDiff_tagry_kys_kostka_1", 300);
SetLocalString(oModule, "thTrofejMisc_tagry_ozivla_kys_1", "ry_kys_esence");
SetLocalInt(oModule,    "thTrofejDiff_tagry_ozivla_kys_1", 300);
SetLocalString(oModule, "thTrofejMisc_tagry_mykanoid", "sporymykoida");
SetLocalInt(oModule,    "thTrofejDiff_tagry_mykanoid", 500);
SetLocalString(oModule, "thTrofejMisc_tagry_prast_tygr", "ry_pr_tygr_kuze");
SetLocalInt(oModule,    "thTrofejDiff_tagry_prast_tygr", 600);
SetLocalString(oModule, "thTrofejMisc_tagry_prast_medved", "ry_pr_medv_kuze");
SetLocalInt(oModule,    "thTrofejDiff_tagry_prast_medved", 600);
SetLocalString(oModule, "thTrofejMisc_tagry_pral_op", "ry_pr_op_kuze");
SetLocalInt(oModule,    "thTrofejDiff_tagry_pral_op", 300);
SetLocalString(oModule, "thTrofejMisc_tagry_prales_prase", "ry_pr_div_kuze");
SetLocalInt(oModule,    "thTrofejDiff_tagry_prales_prase", 300);
SetLocalString(oModule, "thTrofejMisc_tagry_prast_orel", "ry_pr_orel_peri");
SetLocalInt(oModule,    "thTrofejDiff_tagry_prast_orel", 600);
SetLocalString(oModule, "thTrofejMisc_tagry_reaver", "ry_rud_gh_jatra");
SetLocalInt(oModule,    "thTrofejDiff_tagry_reaver", 600);
SetLocalString(oModule, "thTrofejMisc_tagry_pr_komar", "ry_pr_kom_kridlo");
SetLocalInt(oModule,    "thTrofejDiff_tagry_pr_komar", 200);
SetLocalString(oModule, "thTrofejMisc_tagry_pr_kostl", "ry_st_kostl_kost");
SetLocalInt(oModule,    "thTrofejDiff_tagry_pr_kostl", 300);
SetLocalString(oModule, "thTrofejMisc_tagry_kys_zploz_1", "ry_srdce_splkys");
SetLocalInt(oModule,    "thTrofejDiff_tagry_kys_zploz_1", 600);
SetLocalString(oModule, "thTrofejMisc_tagry_kys_zploz_2", "ry_srdce_splkys");
SetLocalInt(oModule,    "thTrofejDiff_tagry_kys_zploz_2", 600);
SetLocalString(oModule, "thTrofejMisc_tagry_ml_slaad", "ry_jaz_ml_slaad");
SetLocalInt(oModule,    "thTrofejDiff_tagry_ml_slaad", 200);
SetLocalString(oModule, "thTrofejMisc_tagry_slaad", "ry_jaz_slaad");
SetLocalInt(oModule,    "thTrofejDiff_tagry_slaad", 400);
SetLocalString(oModule, "thTrofejMisc_tagnetopyrodlak", "ry_netdl_kridlo");
SetLocalInt(oModule,    "thTrofejDiff_tagnetopyrodlak", 400);
SetLocalString(oModule, "thTrofejMisc_tagNetopyrodlak", "ry_netdl_kridlo");
SetLocalInt(oModule,    "thTrofejDiff_tagNetopyrodlak", 400);
SetLocalString(oModule, "thTrofejMisc_tagry_salamandr", "ry_srdce_salam");
SetLocalInt(oModule,    "thTrofejDiff_tagry_salamandr", 350);
SetLocalString(oModule, "thTrofejMisc_tagry_ohn_zploz", "ry_srdce_sploh");
SetLocalInt(oModule,    "thTrofejDiff_tagry_ohn_zploz", 350);
SetLocalString(oModule, "thTrofejMisc_tagry_kostlivec_v", "ry_kloub_stkost");
SetLocalInt(oModule,    "thTrofejDiff_tagry_kostlivec_v", 400);
SetLocalString(oModule, "thTrofejMisc_tagry_bodak", "ry_zub_bodak");
SetLocalInt(oModule,    "thTrofejDiff_tagry_bodak", 350);
SetLocalString(oModule, "thTrofejMisc_tagZEP_BARGHEST", "ry_m_barg_kuz");
SetLocalInt(oModule,    "thTrofejDiff_tagZEP_BARGHEST", 200);
*/
}
