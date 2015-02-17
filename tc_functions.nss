#include "x2_inc_itemprop"
#include "ku_libtime"
#include "nwnx_structs"


/* Function declaration */
int TC_GetIsMeleeWeapon(object oWeap);
int TC_GetIsRangedWeapon(object oWeap);
int TC_GetIsAmmo(object oWeap);
int TC_GetBaseAbility(object oPC, int iAbility);

//Mark target is affected by alchemy potion
void TC_MarkAlchEffectApplied(object oTarget, int id, int duration);

//Get if Target is affected by alchemy potion
int TC_GetHasAlchEffect(object oTarget, int id);

void TC_AlchRemoveConflictEffects(object oTarget, int alcheff);

void TC_AlchRemoveConflictProperties(object oTarget, int alcheff);

/////////////////
// Decrement stack size of passed item.
// Destroy item if stack would be 0
//
// Do nothing when no_mazani == FALSE
void TC_SnizStack(object oItem, int no_mazani);

////////////////
// Reopen craft device
void TC_Reopen(object no_oPC);

///////////////
// Destroy buttons in PC inventory
void TC_DestroyButtons(object no_oPC);


/* end declaration */


string TC_IntToString(int num, int lenght=0)
{
  string number = IntToString(num);
  while(GetStringLength(number) < lenght)
    number = "0"+number;
  return number;
}

string TC_SetNumStringLength(string number, int lenght=0)
{
  while(GetStringLength(number) < lenght)
    number = "0"+number;
  return number;
}


/*
 * 1: Self/na sebe
 * 8: creature
 * 3: location
 * 4: meal
 * 5: melee weapon
 * 6: ranged weapon
 * 7: ammo
 * 2: summon/familiar/companion
 * 9: other item
 * 10: other object (placeable etc.)
 */
int TC_GetUsedToType()
{
  object oPC = GetItemActivator();
  object oTarget = GetItemActivatedTarget();
  object oItem = GetItemActivated();

  if( (GetStringLeft(GetTag(oItem), 6) == "tc_als") || (oPC == oTarget) )
    return 1;
  if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
    if(GetMaster(oTarget) == oPC)
      return 2;
    else
      return 8;
  if(!GetIsObjectValid(oTarget))
    return 3;
  if( (GetStringLeft(GetTag(oTarget),4) == "food" ) || (GetStringLeft(GetTag(oTarget),5) == "water" ) )
    return 4;
  if(TC_GetIsMeleeWeapon(oTarget))
    return 5;
  if(TC_GetIsRangedWeapon(oTarget))
    return 6;
  if(TC_GetIsAmmo(oTarget))
    return 7;
  if(GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
    return 9;


  return 10;
}

int TC_GetIsMeleeWeapon(object oWeap)
{
  int nType = GetBaseItemType(oWeap);

  switch(nType) {
    case BASE_ITEM_BASTARDSWORD: return TRUE;
    case BASE_ITEM_BATTLEAXE: return TRUE;
    case BASE_ITEM_CLUB: return TRUE;
    case BASE_ITEM_DAGGER: return TRUE;
    case BASE_ITEM_DIREMACE: return TRUE;
    case BASE_ITEM_DOUBLEAXE: return TRUE;
    case BASE_ITEM_DWARVENWARAXE: return TRUE;
    case BASE_ITEM_GREATAXE: return TRUE;
    case BASE_ITEM_GREATSWORD: return TRUE;
    case BASE_ITEM_HALBERD: return TRUE;
    case BASE_ITEM_HANDAXE: return TRUE;
    case BASE_ITEM_HEAVYFLAIL: return TRUE;
    case BASE_ITEM_KAMA: return TRUE;
    case BASE_ITEM_KATANA: return TRUE;
    case BASE_ITEM_KUKRI: return TRUE;
    case BASE_ITEM_LIGHTFLAIL: return TRUE;
    case BASE_ITEM_LIGHTHAMMER: return TRUE;
    case BASE_ITEM_LIGHTMACE: return TRUE;
    case BASE_ITEM_LONGSWORD: return TRUE;
    case BASE_ITEM_MORNINGSTAR: return TRUE;
    case BASE_ITEM_QUARTERSTAFF: return TRUE;
    case BASE_ITEM_RAPIER: return TRUE;
    case BASE_ITEM_SCIMITAR: return TRUE;
    case BASE_ITEM_SCYTHE: return TRUE;
    case BASE_ITEM_SHORTSPEAR: return TRUE;
    case BASE_ITEM_SHORTSWORD: return TRUE;
    case BASE_ITEM_SICKLE: return TRUE;
    case BASE_ITEM_TRIDENT: return TRUE;
    case BASE_ITEM_TWOBLADEDSWORD: return TRUE;
    case BASE_ITEM_WARHAMMER: return TRUE;
    case BASE_ITEM_WHIP: return TRUE;

  }
  return FALSE;
}

int TC_GetIsRangedWeapon(object oWeap)
{
  int nType = GetBaseItemType(oWeap);

  switch(nType) {
    case BASE_ITEM_HEAVYCROSSBOW: return TRUE;
    case BASE_ITEM_LIGHTCROSSBOW: return TRUE;
    case BASE_ITEM_LONGBOW: return TRUE;
    case BASE_ITEM_SHORTSPEAR: return TRUE;
    case BASE_ITEM_SLING: return TRUE;
  }
  return FALSE;
}

int TC_GetIsAmmo(object oWeap)
{
  int nType = GetBaseItemType(oWeap);

  switch(nType) {
    case BASE_ITEM_ARROW: return TRUE;
    case BASE_ITEM_BOLT: return TRUE;
    case BASE_ITEM_BULLET: return TRUE;
    case BASE_ITEM_DART: return TRUE;
    case BASE_ITEM_SHURIKEN: return TRUE;
    case BASE_ITEM_THROWINGAXE: return TRUE;
  }
  return FALSE;

}

int TC_GetBaseAbility(object oPC, int iAbility)
{
    int iPCBaseAbility = GetAbilityScore(oPC,iAbility,TRUE);
    iPCBaseAbility = iPCBaseAbility;// + GetLocalInt(oPC,"KU_SUBRACES_ABILITY" + IntToString(iAbility));
    return iPCBaseAbility;
}

void TC_MakeRangedEffect(effect eEff, location lTarget, object oCaster)
{
  ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_MIRV),lTarget);
  ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eEff,lTarget);
  FloatingTextStringOnCreature("*Hazi flakon*",oCaster);
}

void TC_ApplyPotionAtMeal(object oMeal, object oPotion, object oPC)
{
 string sTag = GetTag(oPotion);
 string sPrefix = GetStringLeft(sTag,8);
 int ilvl = StringToInt(GetSubString(sTag,8,2));
 string sPostfix = GetStringRight(sTag,GetStringLength(sTag)-10);

 if (GetStringLeft(GetTag(oMeal),5)=="water")
    sPostfix = sPostfix + "093";

 if (GetStringLeft(GetTag(oMeal),4)=="food")
    sPostfix = sPostfix + "092";



 ilvl = ilvl/3; // snizeni ucinnosti
 sTag = sPrefix + TC_IntToString(ilvl,2) + sPostfix;

 if(GetItemStackSize(oMeal) > 1)
    SetItemStackSize(oMeal,GetItemStackSize(oMeal) - 1);
 else
    DestroyObject(oMeal,0.3);


 //FloatingTextStrRefOnCreature("*Neco dela s jidlem*",Activator);
 if (!GetHasFeat(FEAT_USE_POISON, oPC)) // without handle poison feat, do ability check
     {

       int nDex = GetAbilityModifier(ABILITY_DEXTERITY,oPC) ;
       int nCheck = d10(1)+nDex;
       if (nCheck >= 10)
       {
           SendMessageToPC(oPC,"Obsah flakonu se rozlil vsude okolo, jen ne na jidlo.");               //"Failed"
           return;
       }
       else
       {
          SendMessageToPC(oPC,"Podarilo se nalit obsah lahvicky do jidla.");               //"Success"
       }
     }
 oMeal = CopyObject(oMeal,GetLocation(oPC),oPC,sTag);
 SetItemStackSize(oMeal,1);
}

void TC_UsePoisonToWeapon(object Activator, int lvl, object oTarget, int poison, int alcheff)
{

     if (IPGetIsBludgeoningWeapon(oTarget))
     {
       FloatingTextStrRefOnCreature(83367,Activator);         //"Weapon does not do slashing or piercing damage "
       return;
     }
     if (GetBaseItemType(oTarget) == BASE_ITEM_BULLET) {
       FloatingTextStrRefOnCreature(83367,Activator);         //"Weapon does not do slashing or piercing damage "
       return;
     }

     if (IPGetItemHasItemOnHitPropertySubType(oTarget, 19)) // 19 == itempoison
     {
        FloatingTextStrRefOnCreature(83407,Activator); // weapon already poisoned
        return;
     }
     if (!GetHasFeat(FEAT_USE_POISON, Activator)) // without handle poison feat, do ability check
     {
       // * Force attacks of opportunity
       AssignCommand(Activator,ClearAllActions(TRUE));

       int nDex = GetAbilityModifier(ABILITY_DEXTERITY,Activator) ;
       int nCheck = d10(1)+nDex;
       if (nCheck < lvl/2)
       {
           FloatingTextStrRefOnCreature(83368,Activator);               //"Failed"
           return;
       }
       else
       {
          FloatingTextStrRefOnCreature(83370,Activator);               //"Success"
       }
     }

     int DC = lvl/3;
     if(DC >6 )
       DC=6;

     TC_AlchRemoveConflictProperties(oTarget,alcheff);
     TC_AlchRemoveConflictEffects(oTarget,alcheff);
     itemproperty ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,DC,poison);
     SetItemPropertySpellId(ip,10000+alcheff);

//     IPSafeAddItemProperty(oTarget, ip,RoundsToSeconds(lvl),X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE,TRUE);
     IPSafeAddItemProperty(oTarget, ip,RoundsToSeconds(50 + 2*lvl),X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE,TRUE);
     ip = ItemPropertyVisualEffect(ITEM_VISUAL_ACID);
     SetItemPropertySpellId(ip,10000+alcheff);
     IPSafeAddItemProperty(oTarget, ip,RoundsToSeconds(lvl),X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE,FALSE);

     effect eff = EffectVisualEffect(VFX_IMP_PULSE_NATURE);
     SetEffectSpellId(eff,10000+alcheff);
     ApplyEffectToObject(DURATION_TYPE_INSTANT, eff, Activator);


}

int TC_SafeApplyAbilityIncrease(object oTarget, int nAbility, int nModify, float fDur, int bApply = TRUE)
{
  int nDur = FloatToInt(fDur);
  string sAbility = IntToString(nAbility);

  int iPrevDur = GetLocalInt(oTarget,"TC_ABILITY_BOOST_DUR"+sAbility);
  // Effect uz neni
  if(iPrevDur < ku_GetTimeStamp() ) {
     SetLocalInt(oTarget,"TC_ABILITY_BOOST_DUR"+sAbility,ku_GetTimeStamp(nDur));
     SetLocalInt(oTarget,"TC_ABILITY_BOOST_POWER"+sAbility,nModify);
     if(!bApply)
       return TRUE;
     effect eMod = EffectAbilityIncrease(nAbility,nModify);
     ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMod, oTarget, fDur);
     return TRUE;
  }

  return FALSE;


}

void TC_MarkAlchEffectApplied(object oTarget, int id, int duration) {
    int endtime = ku_GetTimeStamp(duration);
    SetLocalInt(oTarget,"ALCH_EFFECT_"+IntToString(id),endtime);
}

int TC_GetHasAlchEffect(object oTarget, int id) {
    int efftime = GetLocalInt(oTarget,"ALCH_EFFECT_"+IntToString(id));
    int act = ku_GetTimeStamp();
    if(efftime > act)
      return TRUE;
    else
      return FALSE;
}

void TC_AlchRemoveConflictEffects(object oTarget, int alcheff) {

  object oMod = GetModule();
  string sAlcheff = IntToString(alcheff);
  string conf = " "+GetLocalString(oMod,"TC_ALCH_CONTRAS_"+sAlcheff)+" "+sAlcheff+" ";
  string sSpellId;
  int iSpellId;

  SendMessageToPC(oTarget,"Conflicts: "+conf);

  effect eff = GetFirstEffect(oTarget);
  while(GetIsEffectValid(eff)) {
    iSpellId = GetEffectSpellId(eff);
    if(iSpellId > 10000) {
      sSpellId = " "+IntToString(iSpellId - 10000)+" ";
//      SendMessageToPC(oTarget,"SpellID="+sSpellId);
      if(FindSubString(conf,sSpellId) > 0) {
//        SendMessageToPC(oTarget,"Removing");
        RemoveEffect(oTarget,eff);
      }
    }
    eff = GetNextEffect(oTarget);
  }
}

void TC_AlchRemoveConflictProperties(object oTarget, int alcheff) {

  object oMod = GetModule();
  string sAlcheff = IntToString(alcheff);
  string conf = " "+GetLocalString(oMod,"TC_ALCH_CONTRAS_"+sAlcheff)+" "+sAlcheff+" ";
  string sSpellId;
  int iSpellId;

  itemproperty ipProp = GetFirstItemProperty(oTarget);
  while(GetIsItemPropertyValid(ipProp)) {
    iSpellId = GetItemPropertySpellId(ipProp);
    if(iSpellId > 10000) {
      sSpellId = " "+IntToString(iSpellId - 10000)+" ";

      if(FindSubString(conf,sSpellId) > 0) {
        RemoveItemProperty(oTarget,ipProp);
      }
    }
    ipProp = GetNextItemProperty(oTarget);
  }
}

//////////////////////////////////////////////////////
/// Craft common functions

//////////////////////////////////////////////////////

void TC_SnizStack(object oItem, int no_mazani)
{
  if(!no_mazani)
    return;

  int no_stacksize = GetItemStackSize(oItem);      //zjisti kolik je toho ve stacku
  if (no_stacksize == 1)  {                     // kdyz je posledni znici objekt
    DestroyObject(oItem);
  }
  else {
      //FloatingTextStringOnCreature(" Tolikati prisad nebylo zapotrebi ",no_oPC,FALSE );
      SetItemStackSize(oItem,no_stacksize-1);
  }
}

void TC_Reopen(object no_oPC) {
  AssignCommand(no_oPC,DoPlaceableObjectAction(OBJECT_SELF,PLACEABLE_ACTION_USE));
  //   AssignCommand(oPC,DelayCommand(1.0,DoPlaceableObjectAction(GetNearestObjectByTag(GetTag(oSelf),oPC,1),PLACEABLE_ACTION_USE)));
}


////////Znici tlacitka z inventare ///////////////////////
void TC_DestroyButtons(object no_oPC)
{
  object no_Item = GetFirstItemInInventory(no_oPC);

  while (GetIsObjectValid(no_Item)) {

    if( (GetResRef(no_Item) != "prepinac001") &&
        (GetResRef(no_Item) != "prepinac003") ){
      no_Item = GetNextItemInInventory(no_oPC);
      continue;     //znicim vsechny prepinace 001
    }
    DestroyObject(no_Item);

    no_Item = GetNextItemInInventory(no_oPC);
  }

}

void TC_MakeButton(string sTag, string sName, int iButton = 1, object oContainer = OBJECT_SELF) {
  SetName(CreateItemOnObject("prepinac00"+IntToString(iButton),oContainer,1,sTag),sName);
}

int TC_getProgressByDifficulty(int no_obtiznost_vyrobku) {

  // result is returned value / 10

  if(no_obtiznost_vyrobku > 190)
    no_obtiznost_vyrobku = 190;

  if (no_obtiznost_vyrobku >= 180 )
    return (200 - no_obtiznost_vyrobku) / 10;
  if (no_obtiznost_vyrobku >= 170)
    return Random(4);
  if (no_obtiznost_vyrobku >= 160)
    return Random(6);
  if (no_obtiznost_vyrobku >= 130)
    return Random(20)  + (160 - no_obtiznost_vyrobku) / 10;
  if (no_obtiznost_vyrobku >= 10)
    return Random(20)  + (130 - no_obtiznost_vyrobku) / 2;
  // < 10
  return Random(20) + 100;
}

int TC_getDestroyingByDifficulty(int no_obtiznost_vyrobku) {
  // result is returned value / 10

  if(no_obtiznost_vyrobku > 190)
    no_obtiznost_vyrobku = 190;

  if (no_obtiznost_vyrobku>=180)
    return (210 - no_obtiznost_vyrobku) / 10;
  if (no_obtiznost_vyrobku>=170)
    return Random(6);
  if (no_obtiznost_vyrobku>=160)
    return Random(8);
  if (no_obtiznost_vyrobku>=130)
    return Random(20) + (180 - no_obtiznost_vyrobku) / 10;
  if(no_obtiznost_vyrobku>=10)
    return Random(20) - FloatToInt(no_obtiznost_vyrobku * 0.7) + 93; // !!! To check
  // < 10
  return Random(20) + 150;
}
