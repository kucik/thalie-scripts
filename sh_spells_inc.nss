#include "x2_inc_itemprop"
#include "sh_classes_const"
/*Nastavit bChange CL na FALSE, pokud nechceme omezovat podle caster level targetu*/
int GetThalieCaster(object oCaster,object oTarget,int iCasterLevel,int bChangeCL = TRUE,string params = "")
{
    int iLastSpellCastClass = GetLastSpellCastClass();
    int iModifiedCasterLevel =iCasterLevel;                                   //zustalo po zruseni dobrodruha kvuli proměnným
    object oItem = GetSpellCastItem();
    int iSpellId = GetSpellId();
    if (GetIsObjectValid(oItem))
    {
        //Seslano z predmetu
        return iCasterLevel;
    }
    if (GetLevelByClass(47,oCaster)>0)  //CLASS_TYPE_EXORCISTA
    {
        if (
        (iLastSpellCastClass==CLASS_TYPE_DRUID) ||
        (iLastSpellCastClass==CLASS_TYPE_CLERIC) ||
        (iLastSpellCastClass==CLASS_TYPE_RANGER) ||
        (iLastSpellCastClass==CLASS_TYPE_PALADIN)
        )
        {
            iModifiedCasterLevel+= GetLevelByClass(47,oCaster);
        }
    }
    /* Underdark penalty */
    /* UNDERDARK_SETTING == KU_AREA_UNDERDARK */
    if(GetLocalInt( oCaster, "UNDERDARK_SETTING") == 300 ) {
        iModifiedCasterLevel+= -5;
    }
    //Pan smrti
    int iPaleMasterLevel = GetLevelByClass(CLASS_TYPE_PALE_MASTER,oCaster);
    if ((iPaleMasterLevel>0) && (iLastSpellCastClass==CLASS_TYPE_WIZARD))
    {
        int iIsNecro = FALSE;
        string sSchool = Get2DAString("spells","School",GetSpellId());
        if (sSchool=="Necromancy")
        {
            iIsNecro = TRUE;
            iModifiedCasterLevel+= iPaleMasterLevel;
        }
        if (GetHasFeat(FEAT_TOUGH_AS_BONE,oCaster))
        {
            if (iIsNecro==FALSE)
            {
                iModifiedCasterLevel = 1; //Tvrdost kosti - u jinych nez nekromancie nastavi level sesilatele na 1
            }
        }
    }
    //Vazac magie
    int iVazacLevel = GetLevelByClass(CLASS_TYPE_CERNOKNEZNIK,oCaster);
    if (iVazacLevel > 0)
    {
        switch (iSpellId)
        {
            case SPELL_GREASE:
            case SPELL_CLOUD_OF_BEWILDERMENT:
            case SPELL_GUST_OF_WIND:
            case SPELL_MIND_FOG:
            case SPELL_CLOUDKILL:
            case SPELL_STINKING_CLOUD:
            case SPELL_ACID_FOG:
            case SPELL_INCENDIARY_CLOUD:
            case SPELL_STONEHOLD:
            iModifiedCasterLevel += iVazacLevel;
            break;

        }
    }
    /* For boost spells always reduce caster level. Cannot be higher than caster
       level*/
    if (bChangeCL)
    {
         int iHD = GetHitDice(oTarget);
         if (iModifiedCasterLevel>iHD) iModifiedCasterLevel=iHD;
    }

    return iModifiedCasterLevel;
}

int GetThalieSpellDCBonus(object oPCNPC)
{
    int iBonus = 0;
    //Epic DC bonus - +1 za kazde 2 lvly nad epic
    int iClass = GetLastSpellCastClass();
    switch(iClass) {
      case CLASS_TYPE_SORCERER: //CLASS_TYPE_SORCERER
      case CLASS_TYPE_WIZARD:  //CLASS_TYPE_WIZARD
      case CLASS_TYPE_CLERIC: //CLASS_TYPE_CLERIC
      case CLASS_TYPE_DRUID: //CLASS_TYPE_DRUID
      case CLASS_TYPE_BARD: //CLASS_TYPE_BARD
        if(GetLevelByClass(iClass,oPCNPC) >= 21)
          iBonus += (GetLevelByClass(iClass,oPCNPC)-19)/2;
        break;
      default: //nothing
        break;
    }


    return iBonus;
}
// nCasterLevel = GetThalieCaster(OBJECT_SELF,oTarget,nCasterLevel);
//+GetThalieSpellDCBonus(OBJECT_SELF)
// nCasterLevel = GetThalieCaster(OBJECT_SELF,oTarget,nCasterLevel,FALSE);

int GetThalieEpicSpellDCBonus(object oPC)
{
    int iHD = GetHitDice(oPC);
    return iHD / 3 +1;
}


void PolymorphWihtMerge(int nPoly, effect eVis, int nDuration)
{
    int bWeapon = StringToInt(Get2DAString("polymorph","MergeW",nPoly)) == 1;
    int bArmor  = StringToInt(Get2DAString("polymorph","MergeA",nPoly)) == 1;
    int bItems  = StringToInt(Get2DAString("polymorph","MergeI",nPoly)) == 1;

    object oWeaponOld = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
    object oArmorOld = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
    object oRing1Old = GetItemInSlot(INVENTORY_SLOT_LEFTRING,OBJECT_SELF);
    object oRing2Old = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,OBJECT_SELF);
    object oAmuletOld = GetItemInSlot(INVENTORY_SLOT_NECK,OBJECT_SELF);
    object oCloakOld  = GetItemInSlot(INVENTORY_SLOT_CLOAK,OBJECT_SELF);
    object oBootsOld  = GetItemInSlot(INVENTORY_SLOT_BOOTS,OBJECT_SELF);
    object oBeltOld = GetItemInSlot(INVENTORY_SLOT_BELT,OBJECT_SELF);
    object oHelmetOld = GetItemInSlot(INVENTORY_SLOT_HEAD,OBJECT_SELF);
    object oShield    = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
    object oGloves    = GetItemInSlot(INVENTORY_SLOT_ARMS,OBJECT_SELF);
    if (GetIsObjectValid(oShield))
    {
        if (GetBaseItemType(oShield) !=BASE_ITEM_LARGESHIELD &&
            GetBaseItemType(oShield) !=BASE_ITEM_SMALLSHIELD &&
            GetBaseItemType(oShield) !=BASE_ITEM_TOWERSHIELD)
        {
            oShield = OBJECT_INVALID;
        }
    }
    effect ePoly = EffectPolymorph(nPoly);
    //Apply the VFX impact and effects
    ClearAllActions(); // prevents an exploit
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, OBJECT_SELF, HoursToSeconds(nDuration));

    object oWeaponNew = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
    object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);

    if (bWeapon)
    {
            IPWildShapeCopyItemProperties(oWeaponOld,oWeaponNew, TRUE);
    }
    if (bArmor)
    {
        IPWildShapeCopyItemProperties(oHelmetOld,oArmorNew);
        IPWildShapeCopyItemProperties(oArmorOld,oArmorNew);
        IPWildShapeCopyItemProperties(oShield,oArmorNew);
        IPWildShapeCopyItemProperties(oArmorOld,oArmorNew);
    }
    if (bItems)
    {
        IPWildShapeCopyItemProperties(oRing1Old,oArmorNew);
        IPWildShapeCopyItemProperties(oRing2Old,oArmorNew);
        IPWildShapeCopyItemProperties(oAmuletOld,oArmorNew);
        IPWildShapeCopyItemProperties(oCloakOld,oArmorNew);
        IPWildShapeCopyItemProperties(oBootsOld,oArmorNew);
        IPWildShapeCopyItemProperties(oBeltOld,oArmorNew);
    }

}
