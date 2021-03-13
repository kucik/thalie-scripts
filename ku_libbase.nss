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
 //Test validity equipu
 //Zda se jedna o testvane base_items
 switch (iItemType)
 {
    case BASE_ITEM_AMULET:
    case BASE_ITEM_ARMOR:
    case BASE_ITEM_BASTARDSWORD:
    case BASE_ITEM_BATTLEAXE:
    case BASE_ITEM_BELT:
    case BASE_ITEM_BOOTS:
    case BASE_ITEM_BRACER:
    case BASE_ITEM_CLOAK:
    case BASE_ITEM_CLUB:
    case BASE_ITEM_DAGGER:
    case BASE_ITEM_DART:
    case BASE_ITEM_DIREMACE:
    case BASE_ITEM_DOUBLEAXE:
    case BASE_ITEM_DWARVENWARAXE:
    case BASE_ITEM_GLOVES:
    case BASE_ITEM_GREATAXE:
    case BASE_ITEM_GREATSWORD:
    case BASE_ITEM_HALBERD:
    case BASE_ITEM_HANDAXE:
    case BASE_ITEM_HEAVYCROSSBOW:
    case BASE_ITEM_HEAVYFLAIL:
    case BASE_ITEM_HELMET:
    case BASE_ITEM_KAMA:
    case BASE_ITEM_KATANA:
    case BASE_ITEM_KUKRI:
    case BASE_ITEM_LARGESHIELD:
    case BASE_ITEM_LIGHTCROSSBOW:
    case BASE_ITEM_LIGHTFLAIL:
    case BASE_ITEM_LIGHTHAMMER:
    case BASE_ITEM_LIGHTMACE:
    case BASE_ITEM_LONGBOW:
    case BASE_ITEM_LONGSWORD:
    case BASE_ITEM_MAGICSTAFF:
    case BASE_ITEM_MORNINGSTAR:
    case BASE_ITEM_QUARTERSTAFF:
    case BASE_ITEM_RAPIER:
    case BASE_ITEM_RING:
    case BASE_ITEM_SCIMITAR:
    case BASE_ITEM_SCYTHE:
    case BASE_ITEM_SHORTBOW:
    case BASE_ITEM_SHORTSPEAR:
    case BASE_ITEM_SHORTSWORD:
    case BASE_ITEM_SHURIKEN:
    case BASE_ITEM_SICKLE:
    case BASE_ITEM_SLING:
    case BASE_ITEM_SMALLSHIELD:
    case BASE_ITEM_THROWINGAXE:
    case BASE_ITEM_TOWERSHIELD:
    case BASE_ITEM_TRIDENT:
    case BASE_ITEM_TWOBLADEDSWORD:
    case BASE_ITEM_WARHAMMER:
    case BASE_ITEM_WHIP:
        int bHasLimitation = FALSE;
        itemproperty ip = GetFirstItemProperty(oItem);
        while (GetIsItemPropertyValid(ip))
        {
            if (GetItemPropertyType(ip)==ITEM_PROPERTY_USE_LIMITATION_CLASS)
            {
                bHasLimitation = TRUE;
                int iLimitationClass =  GetItemPropertySubType(ip);
                if (GetLevelByClass(iLimitationClass,oPC)>0)
                {
                    return TRUE;
                }
            }
            ip = GetNextItemProperty(oItem);
        }
        if (bHasLimitation)
        {
            return FALSE;
        }
    break;
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


void ku_GetMunitionFromPack(object oPC, string sPack,int iBaseItem,int count) {
  int i;

  int iSlot = 4;
  int iPack = 250;
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
    default: iPack = 99;
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
    SetLocalInt(oToulec,"ku_contain",5002);
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
    SetPlotFlag(oItem,TRUE);
    SetStolenFlag(oItem,TRUE);
    count = count - iPack;
  }
  SetPlotFlag(oToulec,TRUE);
//  SetStolenFlag(oToulec,TRUE);
  SetLocalInt(oToulec,"ku_contain",iObsah);
  SetLocalString(oSoul,"ku_ammo_"+sBase,"");

  AssignCommand(oPC,ActionEquipItem(oItem,iSlot));
  SetLocalString(oSoul,"ku_ammo_pack_"+sBase,sPack);
  if(iObsah > 0)
    DelayCommand(2.0,SetLocalString(oSoul,"ku_ammo_"+sBase,sTemplate));
  else
    SetLocalString(oSoul,"ku_ammo_pack_"+sBase,"");

  SetName(oToulec,GetLocalString(oToulec,"name")+" - zbyva "+IntToString(iObsah)+" munice");
  if(iObsah <= 0) {
    DestroyObject(oToulec,3.0);
  }

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

