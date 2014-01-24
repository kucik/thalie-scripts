/* ku_items_inc
 * Knihovna pro vytvareni a cteni Itemu
 * ver. 1.1
 * 03. 03 2009 Kucik
 * 09. 06. 2009 Kucik Upraveno generovani pri resrefu v palete
 * 2010-05-15 Kucik Pridany charges predmetu.
 */

#include "nwnx_structs"
#include "nwnx_funcs"
#include "ku_libtime"
#include "strings_inc"

const string PERSISTANCE_BASE_DELIMITER = "~";
const string PERSISTANCE_SECONDARY_DELIMITER = "|";
const string PROPERTIES_DELIMITER = "#";
const string PERSISTANCE_TEMP_CONTAINER = "ku_pers_temp_cont";

// Create Item properties on Item
int ParseItemPropertiesString(object oItem, string sIP, int bNodup = 0);

int ApplyItemPropertyFromString(object oItem, string sIP);

// Get ItemProperties String
string GetItemPropertiesString(object oItem);

string Persist_GetResRefByBaseType(int iBase);
string Persist_GetArmorACResref(int iAC);
int Persist_GetItemBaseACValue(object oItem);

// Get Temporary container used for persistance
object Persist_GetTempContainer();

// Create Item desribed by sAttr attributes string
object Persist_CreateItemFromAttributesString(string sAttr, object oInv = OBJECT_INVALID);

// Get Item Attributes string describing item.
string Persist_GetItemAttributesString(object oItem);

itemproperty ku_ItemPropertyOnMonsterHitProperties(int a1, int a5);

string itoa(int i) {
  return IntToString(i);
}

object Persist_GetTempContainer() {
  object oMod = GetModule();
  if(GetLocalInt(oMod,"KU_PERSISTANCE_INIT"))
    return GetLocalObject(oMod,"KU_PERSISTANCE_TEMP_CONTAINER");
  else {
    object oPers = GetObjectByTag(PERSISTANCE_TEMP_CONTAINER);
    SetLocalObject(oMod,"KU_PERSISTANCE_TEMP_CONTAINER",oPers);
    return oPers;
  }
}

int GetIsValidItemResref(string sResRef) {
  object oPers = Persist_GetTempContainer();
  object oItem = CreateItemOnObject(sResRef,oPers);
  int bValid = GetIsObjectValid(oItem);
  DestroyObject(oItem);

  return bValid;
}

/*********************************************************************
 * * * * * * * * * * * * Item Properties * * * * * * * * * * * * * * *
 *********************************************************************/

itemproperty CreateItemProperty(int ip, int a1=0, int a3=0, int a5=0) {
//itemproperty CreateItemProperty(int ip, int a1=0, int a3=0, int a5=0, int a2, int a4, int a6) {

//SpeakString("C|"+itoa(ip)+"|"+itoa(a1)+"|"+itoa(a3)+"|"+itoa(a5)+"|");

switch(ip) {
  case  0: return ItemPropertyAbilityBonus                (a1,a3);
  case  1: return ItemPropertyACBonus                     (a3);
  case  2: return ItemPropertyACBonusVsAlign              (a1,a3);
  case  3: return ItemPropertyACBonusVsDmgType            (a1,a3);
  case  4: return ItemPropertyACBonusVsRace               (a1,a3);
  case  5: return ItemPropertyACBonusVsSAlign             (a1,a3);
  case  6: return ItemPropertyEnhancementBonus            (a3);
  case  7: return ItemPropertyEnhancementBonusVsAlign     (a1,a3);
  case  8: return ItemPropertyEnhancementBonusVsRace      (a1,a3);
  case  9: return ItemPropertyEnhancementBonusVsSAlign    (a1,a3);
  case 10: return ItemPropertyAttackPenalty               (a3);
  case 11: return ItemPropertyWeightReduction             (a3);
  case 12: return ItemPropertyBonusFeat                   (a1);
  case 13: return ItemPropertyBonusLevelSpell             (a1,a3);
//  case 14: /// Boomerang
  case 15: return ItemPropertyCastSpell                   (a1,a3);
  case 16: return ItemPropertyDamageBonus                 (a1,a3);
  case 17: return ItemPropertyDamageBonusVsAlign          (a1,a5,a3);
  case 18: return ItemPropertyDamageBonusVsRace           (a1,a5,a3);
  case 19: return ItemPropertyDamageBonusVsSAlign         (a1,a5,a3);
  case 20: return ItemPropertyDamageImmunity              (a3,a1);
  case 21: return ItemPropertyDamagePenalty               (a3);
  case 22: return ItemPropertyDamageReduction             (a1,a3);
  case 23: return ItemPropertyDamageResistance            (a1,a3);
  case 24: return ItemPropertyDamageVulnerability         (a1,a3);
//  case 25: /// Dancing
  case 26: return ItemPropertyDarkvision                  ();
  case 27: return ItemPropertyDecreaseAbility             (a1,a3);
  case 28: return ItemPropertyDecreaseAC                  (a1,a3);
  case 29: return ItemPropertyDecreaseSkill               (a1,a3);
//  case 30: /// Double_stack
//  case 31: /// Enhanced_Container:_Bonus_Slots
  case 32: return ItemPropertyContainerReducedWeight      (a3);
  case 33: return ItemPropertyExtraMeleeDamageType        (a1);
  case 34: return ItemPropertyExtraRangeDamageType        (a1);
  case 35: return ItemPropertyHaste                       ();
  case 36: return ItemPropertyHolyAvenger                 ();
  case 37: return ItemPropertyImmunityMisc                (a1);
  case 38: return ItemPropertyImprovedEvasion             ();
  case 39: return ItemPropertyBonusSpellResistance        (a3);
  case 40: return ItemPropertyBonusSavingThrowVsX         (a1,a3);
  case 41: return ItemPropertyBonusSavingThrow            (a1,a3);
//  case 42: // ****
  case 43: return ItemPropertyKeen                        ();
  case 44: return ItemPropertyLight                       (a3,a5);
  case 45: return ItemPropertyMaxRangeStrengthMod         (a3);
//  case 46: // Mind Blank
  case 47: return ItemPropertyNoDamage                    ();
  case 48: return ItemPropertyOnHitProps               (a1,a3 + (a1 == IP_CONST_ONHIT_LEVELDRAIN),a5);
  case 49: return ItemPropertyReducedSavingThrowVsX       (a1,a3);
  case 50: return ItemPropertyReducedSavingThrow          (a1,a3);
  case 51: return ItemPropertyRegeneration                (a3);
  case 52: return ItemPropertySkillBonus                  (a1,a3);
  case 53: return ItemPropertySpellImmunitySpecific       (a3);
  case 54: return ItemPropertySpellImmunitySchool         (a1);
  case 55: return ItemPropertyThievesTools                (a3);
  case 56: return ItemPropertyAttackBonus                 (a3);
  case 57: return ItemPropertyAttackBonusVsAlign          (a1,a3);
  case 58: return ItemPropertyAttackBonusVsRace           (a1,a3);
  case 59: return ItemPropertyAttackBonusVsSAlign         (a1,a3);
  case 60: return ItemPropertyAttackPenalty               (a3);
  case 61: return ItemPropertyUnlimitedAmmo               (a3);
  case 62: return ItemPropertyLimitUseByAlign             (a1);
  case 63: return ItemPropertyLimitUseByClass             (a1);
  case 64: return ItemPropertyLimitUseByRace              (a1);
  case 65: return ItemPropertyLimitUseBySAlign            (a1);
//  case 66: //--- Use_Limitation_Tileset
  case 67: return ItemPropertyVampiricRegeneration        (a3);
//  case 68: return 68 !!! Vorpal_Blade no function                  !!!
//  case 69: return 69 !!! Wounding no function                      !!!
  case 70: return ItemPropertyTrap                        (a1,a3);
  case 71: return ItemPropertyTrueSeeing                  ();
  case 72: return ku_ItemPropertyOnMonsterHitProperties   (a1,a5);     //  ???(a1,a5) //BUGS
  case 73: return ItemPropertyTurnResistance              (a3);
  case 74: return ItemPropertyMassiveCritical             (a3);
  case 75: return ItemPropertyFreeAction                  ();
//  case 76: return 76 --- Poison                                    !!!
  case 77: return ItemPropertyMonsterDamage               (a3);
  case 78: return ItemPropertyImmunityToSpellLevel        (a3);
  case 79: return ItemPropertySpecialWalk                 (a3);         // ???
  case 80: return ItemPropertyHealersKit                  (a3);
  case 81: return ItemPropertyWeightIncrease              (a5);
  case 82: return ItemPropertyOnHitCastSpell              (a1,a3+1);
  case 83: return ItemPropertyVisualEffect                (a1);
  case 84: return ItemPropertyArcaneSpellFailure          (a3);
  case 85: return ItemPropertyMaterial                    (a3);
  case 86: return ItemPropertyQuality                     (a3);
  case 87: return ItemPropertyAdditional                  (a3);
 }
 itemproperty ipNoIP;
 return ipNoIP;
}

//72
itemproperty ku_ItemPropertyOnMonsterHitProperties(int a1, int a5) {
  itemproperty ip;
  //POISON OK
  //ABILITYDRAIN OK
  //DISEASE OK
  //POISON OK
  switch(a1) {
    case 5:
      ip = ItemPropertyOnMonsterHitProperties(2,1);
      SetItemPropertyInteger(ip,1,a1);
      SetItemPropertyInteger(ip,3,0);
      SetItemPropertyInteger(ip,4,7);
      SetItemPropertyInteger(ip,5,a5);
      return ip;
    case 9:
      ip = ItemPropertyOnMonsterHitProperties(2,1);
      SetItemPropertyInteger(ip,1,a1);
      SetItemPropertyInteger(ip,3,0);
      SetItemPropertyInteger(ip,4,7);
      SetItemPropertyInteger(ip,5,a5);
      return ip;
  }

  ip = ItemPropertyOnMonsterHitProperties(a1,a5 + (a1 == IP_CONST_ONMONSTERHIT_LEVELDRAIN));
  SetItemPropertyInteger(ip,1,a1);
  SetItemPropertyInteger(ip,5,a5);
  return ip;
}

void RemoveAllProperties(object oItem) {

//  SpeakString(GetName(oItem));

 itemproperty ip = GetFirstItemProperty(oItem);
 while(GetIsItemPropertyValid(ip)) {
//   SpeakString("Removing "+IntToString(GetItemPropertyType(ip)));
   RemoveItemProperty(oItem,ip);
   ip = GetNextItemProperty(oItem);
 }

}

/* Itemproperty to String */

string ItemPropertyToString(itemproperty ip) {
  int a0 = GetItemPropertyType(ip);
  int a1 = GetItemPropertyInteger(ip,1);
  int a3 = GetItemPropertyInteger(ip,3);
  int a5 = GetItemPropertyInteger(ip,5);
  int iDur = GetItemPropertyDurationType(ip);
  int iSpell = GetItemPropertySpellId(ip);
  int iDurTo = 0;
  if(iDur == DURATION_TYPE_TEMPORARY)
    iDur = ku_GetTimeStamp(FloatToInt(GetItemPropertyDurationRemaining(ip)));

  string sIP = IntToString(a0)+PERSISTANCE_SECONDARY_DELIMITER+
               IntToString(a1)+PERSISTANCE_SECONDARY_DELIMITER+
               IntToString(a3)+PERSISTANCE_SECONDARY_DELIMITER+
               IntToString(a5)+PERSISTANCE_SECONDARY_DELIMITER+
               IntToString(iDur)+PERSISTANCE_SECONDARY_DELIMITER+
               IntToString(iSpell)+PERSISTANCE_SECONDARY_DELIMITER+
               IntToString(iDurTo)+PROPERTIES_DELIMITER;
  return sIP;
}

string GetItemPropertiesString(object oItem) {
  string sIPs = "";
  itemproperty ip;

  ip = GetFirstItemProperty(oItem);
  while(GetIsItemPropertyValid(ip)) {
    sIPs = sIPs + ItemPropertyToString(ip);
    ip = GetNextItemProperty(oItem);
  }

  return sIPs;

}


/* String To ItemProperties */

int ApplyItemPropertyFromString(object oItem, string sIP) {
    int iStart = 0;
    int iEnd;
    int a0,a1,a3,a5,iDur,iDurTo;
    float fDur = 0.0f;
    itemproperty ip;
    int iDLen = GetStringLength(PERSISTANCE_SECONDARY_DELIMITER);

//    SendMessageToPC(GetFirstPC(),sIP);

    iEnd = FindSubString(sIP,PERSISTANCE_SECONDARY_DELIMITER,iStart);
    a0 = StringToInt(GetSubString(sIP,iStart,iEnd - iStart));

    iStart = iEnd + iDLen;
    iEnd = FindSubString(sIP,PERSISTANCE_SECONDARY_DELIMITER,iStart);
    a1 = StringToInt(GetSubString(sIP,iStart,iEnd - iStart));

    iStart = iEnd + iDLen;
    iEnd = FindSubString(sIP,PERSISTANCE_SECONDARY_DELIMITER,iStart);
    a3 = StringToInt(GetSubString(sIP,iStart,iEnd - iStart));

    iStart = iEnd + iDLen;
    iEnd = FindSubString(sIP,PERSISTANCE_SECONDARY_DELIMITER,iStart);
    a5 = StringToInt(GetSubString(sIP,iStart,iEnd - iStart));

    iStart = iEnd + iDLen;
    iEnd = FindSubString(sIP,PERSISTANCE_SECONDARY_DELIMITER,iStart);
    iDur = StringToInt(GetSubString(sIP,iStart,iEnd - iStart));

    iStart = iEnd + iDLen;
    iEnd = FindSubString(sIP,PERSISTANCE_SECONDARY_DELIMITER,iStart);
    int iSpell = StringToInt(GetSubString(sIP,iStart,iEnd - iStart));

    iStart = iEnd + iDLen;
//    iEnd = FindSubString(sIP,PERSISTANCE_SECONDARY_DELIMITER,iStart);
    iDurTo = StringToInt(GetSubString(sIP,iStart,GetStringLength(sIP) - iStart));

    if(iDur == DURATION_TYPE_TEMPORARY)
      fDur = IntToFloat(iDurTo - ku_GetTimeStamp());
    ip = CreateItemProperty(a0,a1,a3,a5);
    SetItemPropertySpellId(ip,iSpell);

    AddItemProperty(iDur,ip,oItem,fDur);


  return 0;
}

int ParseItemPropertiesString(object oItem, string sIP, int bNodup = 0) {
   int iNum = 0;
   int iStart = 0;
   int DLen = GetStringLength(PROPERTIES_DELIMITER);
   int iEnd = FindSubString(sIP,PROPERTIES_DELIMITER,iStart);
   string sOldProps = "";
   string sProp = GetSubString(sIP,iStart,iEnd - iStart);
   if(bNodup) {
     sOldProps = GetItemPropertiesString(oItem);
   }
   while(iEnd > -1) {
//     SpeakString("Properties compare: '"+sProp+"' in '"+sOldProps+"'");
     if( (bNodup == 0) ||
         (FindSubString(sOldProps,sProp) < 0) ) {
       ApplyItemPropertyFromString(oItem,sProp);
//       SpeakString("Not found - creating");
     }
/*     else {
       SpeakString("Property found");
     }*/
     iStart = iEnd + DLen;
     iEnd = FindSubString(sIP,PROPERTIES_DELIMITER,iStart);
     sProp = GetSubString(sIP,iStart,iEnd - iStart);
   }

   return 0;
}

/*******************************************************
**   Item Description
***********************************************************/

// Get item identified description
// Reads primary description from local variable "DESCRIPTION" then from real description
string ku_GetItemDescription(object oItem);

// Set item identified description and set local variable "DESCRIPTION"
void ku_SetItemDescription(object oItem, string sDescription);

string ku_GetItemDescription(object oItem) {
  string sDesc;
  sDesc = GetLocalString(oItem,"DESCRIPTION");
  if(GetStringLength(sDesc) > 0) {
    return sDesc;
  }

  sDesc = GetDescription(oItem,FALSE,TRUE);
  if(sDesc == GetDescription(oItem,TRUE,TRUE))
    sDesc = GetDescription(oItem,TRUE,FALSE);

  return sDesc;
}

void ku_SetItemDescription(object oItem, string sDescription) {
  SetDescription(oItem,sDescription);
  SetLocalString(oItem,"DESCRIPTION",sDescription);
}

/*********************************************************
**  Item Description and Creation
******************************************************************/

string Persist_GetItemAttributesString(object oItem) {
  string sAttr = "";
  string sTag = GetTag(oItem);
  string sResRef = GetResRef(oItem);
  string sName = GetName(oItem);
  string sModel = GetEntireItemAppearance(oItem);
  int iFlags = 0;
  iFlags = GetDroppableFlag(oItem);
  iFlags = iFlags*2 + GetItemCursedFlag(oItem);
  iFlags = iFlags*2 + GetPickpocketableFlag(oItem);
  iFlags = iFlags*2 + GetPlotFlag(oItem);
  iFlags = iFlags*2 + GetStolenFlag(oItem);
  iFlags = iFlags*2 + GetIdentified(oItem);
  iFlags = iFlags*2 + GetInfiniteFlag(oItem);
  string sFlags = IntToString(iFlags);
  int iBase = GetBaseItemType(oItem);
  string sBase = IntToString(iBase);
  int iAC = 0;
  if(iBase == 16 ) // ARMOR
    iAC = Persist_GetItemBaseACValue(oItem);


//  SpeakString("AC = "+GetItemACValue(oItem));
  int iStack = GetItemStackSize(oItem);
  if(iStack < 1) {
    iStack = 1;
  }
  int iWeight = GetWeight(oItem) / iStack;
  /* BaseItemType|Weight|GoldPieceValue|StackSize|Flags|AC|Decay|charges|*/
  string sNums = IntToString(iBase)+PERSISTANCE_SECONDARY_DELIMITER+
                 IntToString(iWeight)+PERSISTANCE_SECONDARY_DELIMITER+
                 IntToString(GetGoldPieceValue(oItem))+PERSISTANCE_SECONDARY_DELIMITER+
                 IntToString(GetItemStackSize(oItem))+PERSISTANCE_SECONDARY_DELIMITER+
                 IntToString(iFlags)+PERSISTANCE_SECONDARY_DELIMITER+
                 IntToString(iAC)+PERSISTANCE_SECONDARY_DELIMITER+
                 IntToString(GetLocalInt(oItem,"sy_dur"))+PERSISTANCE_SECONDARY_DELIMITER+
                 IntToString(GetItemCharges(oItem))+PERSISTANCE_SECONDARY_DELIMITER;
  string sProps = GetItemPropertiesString(oItem);


  /* Clear item name */
  sName = StrTrim(sName,"'");
//  sName = StrTrim(sName,"~");

  /* Check if resref valid */
//  if(!GetIsValidItemResref(sResRef))
//    sResRef = Persist_GetResRefByBaseType(iBase);

  sAttr = sResRef+PERSISTANCE_BASE_DELIMITER+
          sTag+PERSISTANCE_BASE_DELIMITER+
          sModel+PERSISTANCE_BASE_DELIMITER+  //osetrit model
          sNums+PERSISTANCE_BASE_DELIMITER+
          sProps+PERSISTANCE_BASE_DELIMITER+

          sName;

  return sAttr;
}

object Persist_CreateItemFromAttributesString(string sAttr, object oInv = OBJECT_INVALID) {
    int iStart = 0;
    int iEnd;
    int iDlen = GetStringLength(PERSISTANCE_BASE_DELIMITER)  ;

    /* Get Substrings */
    /* Resref~Tag~Model~Nums~Properties~Name*/
    iEnd = FindSubString(sAttr,PERSISTANCE_BASE_DELIMITER,iStart);
    string sResref = GetSubString(sAttr,iStart,iEnd - iStart);
    iStart = iEnd + iDlen;
    iEnd = FindSubString(sAttr,PERSISTANCE_BASE_DELIMITER,iStart);
    string sTag = GetSubString(sAttr,iStart,iEnd - iStart);
    iStart = iEnd + iDlen;
    iEnd = FindSubString(sAttr,PERSISTANCE_BASE_DELIMITER,iStart);
    string sModel = GetSubString(sAttr,iStart,iEnd - iStart);
    iStart = iEnd + iDlen;
    iEnd = FindSubString(sAttr,PERSISTANCE_BASE_DELIMITER,iStart);
    string sNums = GetSubString(sAttr,iStart,iEnd - iStart);
    iStart = iEnd + iDlen;
    iEnd = FindSubString(sAttr,PERSISTANCE_BASE_DELIMITER,iStart);
    string sProps = GetSubString(sAttr,iStart,iEnd - iStart);
    iStart = iEnd + iDlen;
    string sName = GetSubString(sAttr,iStart,GetStringLength(sAttr) - iStart);


    /* Get Numbers */
    /* BaseItemType|Weight|GoldPieceValue|StackSize|Flags|AC|Decay[|charges|]*/
    iStart = 0;
    iDlen = GetStringLength(PERSISTANCE_SECONDARY_DELIMITER);
    iEnd = FindSubString(sNums,PERSISTANCE_SECONDARY_DELIMITER,iStart);
    int iBase = StringToInt(GetSubString(sNums,iStart,iEnd - iStart));
    iStart = iEnd + iDlen;
    iEnd = FindSubString(sNums,PERSISTANCE_SECONDARY_DELIMITER,iStart);
    int iWeight = StringToInt(GetSubString(sNums,iStart,iEnd - iStart));
    iStart = iEnd + iDlen;
    iEnd = FindSubString(sNums,PERSISTANCE_SECONDARY_DELIMITER,iStart);
    int iGold = StringToInt(GetSubString(sNums,iStart,iEnd - iStart));
    iStart = iEnd + iDlen;
    iEnd = FindSubString(sNums,PERSISTANCE_SECONDARY_DELIMITER,iStart);
    int iStack = StringToInt(GetSubString(sNums,iStart,iEnd - iStart));
    iStart = iEnd + iDlen;
    iEnd = FindSubString(sNums,PERSISTANCE_SECONDARY_DELIMITER,iStart);
    int iFlags = StringToInt(GetSubString(sNums,iStart,iEnd - iStart));
    iStart = iEnd + iDlen;
    iEnd = FindSubString(sNums,PERSISTANCE_SECONDARY_DELIMITER,iStart);
    int iAC = StringToInt(GetSubString(sNums,iStart,iEnd - iStart));
    iStart = iEnd + iDlen;
    int iDecay;
    int iCharges = -1;
    iEnd = FindSubString(sNums,PERSISTANCE_SECONDARY_DELIMITER,iStart);
    if(iEnd < iStart) {
      iDecay = StringToInt(GetSubString(sAttr,iStart,GetStringLength(sAttr) - iStart));
    }
    else {
      iDecay = StringToInt(GetSubString(sAttr,iStart,iEnd - iStart));
      iStart = iEnd + iDlen;
      iEnd = FindSubString(sNums,PERSISTANCE_SECONDARY_DELIMITER,iStart);
      iCharges = StringToInt(GetSubString(sNums,iStart,iEnd - iStart));
//      SpeakString("Setting Charges to "+IntToString(iCharges));
    }


    /* GetContainer */
    object oCont;
    if(oInv == OBJECT_INVALID)
      oCont = Persist_GetTempContainer();
    else
      oCont = oInv;

    /* Create Object */
    object oItem = OBJECT_INVALID;
//    SpeakString("Resref change "+sResref+" >> ");
//    SpeakString("Creating "+sName+" stack="+IntToString(iStack));
    oItem = CreateItemOnObject(sResref,oCont,iStack,sTag);
    /* If object is not in Pallete, or if is replaced with somthing other, or if has some properties */
    if( (!GetIsObjectValid(oItem)) ||
        (GetBaseItemType(oItem) != iBase) ) {/*||
        (GetIsItemPropertyValid(GetFirstItemProperty(oItem))) ) {*/
      DestroyObject(oItem);
      if(iBase == 16) {//ARMOR
        sResref = Persist_GetArmorACResref(iAC);
      }
      else {
        sResref = Persist_GetResRefByBaseType(iBase);
      }
      oItem = CreateItemOnObject(sResref,oCont,iStack,sTag);
      RemoveAllProperties(oItem);
    }
//    SpeakString("Resref change >> "+sResref);
//    RemoveAllProperties(oItem);


    /* Change look */
    RestoreItemAppearance(oItem,sModel);
    SetName(oItem,sName);
    SetLocalInt(oItem,"sy_dur",iDecay);

    /* Set Flags */
    SetInfiniteFlag(oItem,iFlags % 2);
    iFlags = iFlags / 2;
    SetIdentified(oItem,iFlags % 2);
    iFlags = iFlags / 2;
    SetStolenFlag(oItem,iFlags % 2);
    iFlags = iFlags / 2;
    SetPlotFlag(oItem,iFlags % 2);
    iFlags = iFlags / 2;
    SetPickpocketableFlag(oItem,iFlags % 2);
    iFlags = iFlags / 2;
    SetItemCursedFlag(oItem,iFlags % 2);
    iFlags = iFlags / 2;
    SetDroppableFlag(oItem,iFlags % 2);

    /* CreateProperties */
//    RemoveAllProperties(oItem);
    ParseItemPropertiesString(oItem,sProps,TRUE);

    SetItemWeight(oItem,iWeight);
    SetGoldPieceValue(oItem,iGold);

    if( (iCharges > -1) &&
        (iCharges != GetItemCharges(oItem) ) ) {
      SetItemCharges(oItem,iCharges);
    }

//    SpeakString("Creatted "+GetName(oItem)+" stack="+IntToString(GetItemStackSize(oItem)));
    return oItem;
}

string Persist_GetResRefByBaseType(int iBase) {

  switch(iBase) {
    case 0: return "nw_wswss001";
    case 1: return "nw_wswls001";
    case 2: return "nw_waxbt001";
    case 3: return "nw_wswbs001";
    case 4: return "nw_wblfl001";
    case 5: return "nw_wblhw001";
    case 6: return "nw_wbwxh001";
    case 7: return "nw_wbwxl001";
    case 8: return "nw_wbwln001";
    case 9: return "nw_wblml001"; //?? mace or lightmace
    case 10: return "nw_wplhb001";
    case 11: return "nw_wbwsh001";
    case 12: return "nw_wdbsw001";
    case 13: return "nw_wswgs001";
    case 14: return "nw_ashsw001";
    case 15: return "ku_pers_torch";
    case 16: return "nw_aarcl001"; //?? armor
//    case 17: return "nw_arhe001";  //helmet
    case 17: return "ku_pers_helmet";  //helmet
    case 18: return "nw_waxgr001";
    case 19: return "nw_it_mneck020";
    case 20: return "nw_wamar001";
//    case 21: return "nw_it_mbelt001";
    case 21: return "ku_pers_mbelt";
    case 22: return "nw_wswdg001";
//    case 23: return "DELETED";
    case 24: return "nw_it_msmlmisc25";
    case 25: return "nw_wambo001";
//    case 26: return "nw_it_mboots001";
    case 26: return "ku_pers_boots";
    case 27: return "nw_wambu001";
    case 28: return "nw_wblcl001";
    case 29: return "nw_it_msmlmisc20";
//    case 30: return "DELETED";
    case 31: return "nw_wthdt001";
    case 32: return "nw_wdbma001";
    case 33: return "nw_wdbax001";
    case 34: return "ku_pers_miscl";
    case 35: return "nw_wblfh001";
//    case 36: return "nw_it_mglove001";
    case 36: return "ku_pers_gloves";
    case 37: return "nw_wblhl001";
    case 38: return "nw_waxhn001";
//    case 39: return "nw_it_medkit001";
    case 39: return "ku_pers_heal";
    case 40: return "nw_wspka001";
    case 41: return "nw_wswka001";
    case 42: return "nw_wspku001";
//    case 43: return "DELETED";
//    case 44: return "nw_wmgrd002";
    case 44: return "ku_pers_mgcrod";
//    case 45: return "nw_wmgst002";
    case 45: return "ku_pers_mgcstaff";
    case 46: return "nw_mwgwn003";
    case 47: return "nw_wblms001";
//    case 48: return "DELETED";
//    case 49: return "nw_it_mpotion001";
    case 49: return "ku_pers_potion";
    case 50: return "nw_wdbqs001";
    case 51: return "nw_wswrp001";
    case 52: return "nw_it_mring021";
    case 53: return "nw_wswsc001";
//    case 54: return "DELETED";
    case 55: return "nw_wplsc001";
    case 56: return "nw_ashlw001";
    case 57: return "nw_ashto001";
    case 58: return "nw_wplss001";
    case 59: return "nw_wthsh001";
    case 60: return "nw_wspsc001";
    case 61: return "nw_wbwsl001";
//    case 62: return "nw_it_picks001";
    case 62: return "ku_pers_picks";
    case 63: return "nw_wthax001";
//    case 64: return "nw_it_trap001";
    case 64: return "ku_pers_trapkit";
    case 65: return "ku_pers_key";
    case 66: return "nw_it_contain001";
//    case 67: return "DELETED";
//    case 68: return "DELETED";

//    case 69: return "nw_it_crewps001";
//    case 70: return "nw_it_crewpp001";
//    case 71: return "nw_it_crewpb001";
//    case 72: return "nw_it_crewpsp001";
//    case 73: return "nw_it_creitem057";
    case 69: return "ku_pers_crslash";
    case 70: return "ku_pers_crpierc";
    case 71: return "ku_pers_crbludg";
    case 72: return "ku_pers_crslashp";
    case 73: return "ku_pers_crskin";
    case 74: return "nw_it_book001";
//    case 75: return "nw_it_sparscr001";
    case 75: return "ku_pers_scroll";
    case 76: return "nw_it_gold001";
    case 77: return "nw_it_gem001";
//    case 78: return "nw_it_mbracer001";
    case 78: return "ku_pers_bracer";
    case 79: return "nw_it_thnmisc001";
//    case 80: return "nw_maarcl101";
    case 80: return "ku_pers_cloak";
    case 81: return "x1_wm_grenade001";
    case 82: return "ku_pers_encamp";
//    case ....
    case 92: return "ku_pers_lance";
    case 93: return "ku_pers_trumpet";
    case 94: return "ku_pers_monstck";
    case 95: return "nw_wpltr001";
//    case ...
    case 101: return "ku_pers_b_potion";
    case 102: return "x2_it_cfm_bscrl";
    case 103: return "x2_it_cfm_wand";
    case 104: return "ku_pers_crpotion";
    case 105: return "ku_pers_cr_scr";
    case 106: return "ku_pers_cr_mwnd";
//    case ...
    case 108: return "x2_wdwraxe001";
    case 109: return "x2_it_bmt_cloth";
//    case 110: return "x2_it_amt_spikes";
//    case 111: return "x2_it_wpwhip";
//    case 112: return "x2_it_cmat_iron";
    case 110: return "ku_pers_crcomps";
    case 111: return "ku_pers_whip";
    case 112: return "ku_pers_crbase";
//    case ...
    case 202: return "ku_pers_beermug";
    case 203: return "ku_pers_wplss";
//    case ...
    case 300: return "ku_pers_wpltr1h";
    case 301: return "ku_pers_hvpick";
    case 302: return "ku_pers_ltpick";
    case 303: return "ku_pers_sai";
    case 304: return "ku_pers_nunchaku";
    case 305: return "ku_pers_falch";
    case 306: return "ku_pers_smallbox";
    case 307: return "ku_pers_mmisc2";
    case 308: return "ku_pers_wspsp";
    case 309: return "ku_pers_wswda";
    case 310: return "ku_pers_wswdp";
    case 311: return "ku_pers_smisc2";
    case 312: return "ku_pers_wblmc2"; //?? mace = lightmace ??
    case 313: return "ku_pers_wspkk2";
    case 314: return "ku_pers_fashion";
//    case ...
    case 316: return "ku_pers_wxswfa2";
    case 317: return "ku_pers_wxblmh";
    case 318: return "ku_pers_wxblma";
    case 319: return "ku_pers_wswlsm";
    case 320: return "ku_pers_wswgsm";
    case 321: return "ku_pers_wxdbsc";
    case 322: return "ku_pers_wspgd";
    case 323: return "ku_pers_wspwf";
    case 324: return "ku_pers_wmads";
    case 325: return "ku_pers_flower";
//    case ...
    case 327: return "ku_pers_cflower";
//    case ...
    case 330: return "ku_pers_wswlz";
//    case ...
    case 349: return "ku_pers_cloak2";
    case 350: return "ku_pers_ring2";
  }

  return "";
}

/********************
 * Armor and Cloths *
 ********************/

string Persist_GetArmorACResref(int iAC) {
  switch(iAC) {
    case 0: return "nw_cloth001";
    case 1: return "nw_aarcl009";
    case 2: return "nw_aarcl001";
    case 3: return "nw_aarcl002";
    case 4: return "nw_aarcl003";
    case 5: return "nw_aarcl004";
    case 6: return "nw_aarcl005";
    case 7: return "nw_aarcl006";
    case 8: return "nw_aarcl007";
  }

  return "nw_cloth001";
}

int Persist_GetItemBaseACValue(object oItem) {

  int iModel = GetItemAppearance(oItem,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_TORSO);
  string sAC = Get2DAString("parts_chest","ACBONUS",iModel);

  return StringToInt(sAC);
}

