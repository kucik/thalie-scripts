//::///////////////////////////////////////////////
//:: Bless
//:: NW_S0_Bless.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All allies within 30ft of the caster gain a
    +1 attack bonus and a +1 save bonus vs fear
    effects

    also can be cast on crossbow bolts to bless them
    in order to slay rakshasa
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: July 24, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 20, 2001
//:: Added Bless item ability: Georg Z, On: June 20, 2001
#include "NW_I0_SPELLS"

#include "x2_inc_spellhook"
#include "sh_deity_inc"



void main()
{

    /*
      Spellcast Hook Code
      Added 2003-06-23 by GeorgZ
      If you want to make changes to all spells,
      check x2_inc_spellhook.nss to find out more

    */

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    // End of Spell Cast Hook


    //Declare major variables
    int iDamageBonus;
    object oTarget = GetSpellTargetObject();
    int iCasterLevel = GetCasterLevel(OBJECT_SELF);
    iCasterLevel = GetThalieCaster(OBJECT_SELF,oTarget,iCasterLevel,FALSE);
    int nDuration = iCasterLevel;
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    effect eAttack = EffectAttackIncrease(1);
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 1, SAVING_THROW_TYPE_FEAR);
    effect eLink = EffectLinkEffects(eAttack, eSave);



    if (GetThalieClericDeity(OBJECT_SELF)==DEITY_DEI_ANANG)
    {
        iDamageBonus = DAMAGE_BONUS_1d4;
        if (iCasterLevel == 30)
        {
            iDamageBonus = DAMAGE_BONUS_1d10;
        }
        else if (iCasterLevel >= 20)
        {
            iDamageBonus = DAMAGE_BONUS_1d8;
        }
        else if (iCasterLevel >= 10)
        {
            iDamageBonus = DAMAGE_BONUS_1d6;
        }
        effect eDei = EffectDamageIncrease(iDamageBonus,DAMAGE_TYPE_DIVINE);
        effect eDei2= VersusRacialTypeEffect(eDei,RACIAL_TYPE_UNDEAD);
        eLink = EffectLinkEffects(eLink, eDei2);
        eDei = EffectDamageIncrease(iDamageBonus,DAMAGE_TYPE_DIVINE);
        eDei2= VersusRacialTypeEffect(eDei,RACIAL_TYPE_OUTSIDER);
        eLink = EffectLinkEffects(eLink, eDei2);
    }
    else if (GetThalieClericDeity(OBJECT_SELF)==DEITY_NORD)
    {
        eLink = EffectLinkEffects(eLink, EffectUltravision());
    }
    else if (GetThalieClericDeity(OBJECT_SELF)==DEITY_LOTHIAN)
    {
        int iDamageBonus = (iCasterLevel / 10)+2;
        effect eLoth = EffectDamageIncrease(iDamageBonus,DAMAGE_TYPE_DIVINE);
        effect eLoth2= VersusRacialTypeEffect(eLoth,RACIAL_TYPE_ANIMAL);
        eLink = EffectLinkEffects(eLink, eLoth2);
    }
    else if (GetThalieClericDeity(OBJECT_SELF)==DEITY_AZHAR)
    {
        int iDamageBonus = (iCasterLevel / 15)+1;
        effect eAzhar = EffectRegenerate(iDamageBonus,3.0);
        eLink = EffectLinkEffects(eLink, eAzhar);
    }
    else if (GetThalieClericDeity(OBJECT_SELF)==DEITY_MORUS)
    {
        int iDamageBonus = (iCasterLevel / 10)+2;
        effect eMorus = EffectSkillIncrease(SKILL_ALL_SKILLS,iDamageBonus);
        eLink = EffectLinkEffects(eLink, eMorus);
    }
    else if (GetThalieClericDeity(OBJECT_SELF)==DEITY_LILITH)
    {
        iDamageBonus = 5;
        if (iCasterLevel == 30)
        {
            iDamageBonus = 20;
        }
        else if (iCasterLevel >= 20)
        {
            iDamageBonus = 15;
        }
        else if (iCasterLevel >= 10)
        {
            iDamageBonus = 10;
        }
        effect eLilith = EffectDamageResistance(iDamageBonus,DAMAGE_TYPE_FIRE,0);
        eLink = EffectLinkEffects(eLink, eLilith);
    }
    else if (GetThalieClericDeity(OBJECT_SELF)==DEITY_GORDUL)
    {
        int iDamageBonus = (iCasterLevel / 10)+2;
        eAttack = EffectAttackIncrease(iDamageBonus);
        eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, iDamageBonus, SAVING_THROW_TYPE_FEAR);
        eLink = EffectLinkEffects(eAttack, eSave);
    }
    else if (GetThalieClericDeity(OBJECT_SELF)==DEITY_HELGARON)
    {
        int iDamageBonus = (iCasterLevel / 10)+2;
        effect eHelg = EffectDamageIncrease(iDamageBonus,DAMAGE_TYPE_DIVINE);
        eLink = EffectLinkEffects(eLink, eHelg);
    }









    eLink = EffectLinkEffects(eLink, eDur);

    int nMetaMagic = GetMetaMagicFeat();
    float fDelay;
    //Metamagic duration check
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }

    //Apply Impact
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());

    //Get the first target in the radius around the caster
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsReactionTypeFriendly(oTarget) || GetFactionEqual(oTarget))
        {
            fDelay = GetRandomDelay(0.4, 1.1);
            //Fire spell cast at event for target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_BLESS, FALSE));
            //Apply VFX impact and bonus effects
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration)));

            if (GetThalieClericDeity(OBJECT_SELF)==DEITY_XIAN)
            {
                iDamageBonus = IP_CONST_FEAT_SNEAK_ATTACK_1D6;
                if (iCasterLevel == 30)
                {
                    iDamageBonus = IP_CONST_FEAT_SNEAK_ATTACK_5D6;
                }
                else if (iCasterLevel >= 20)
                {
                    iDamageBonus = IP_CONST_FEAT_SNEAK_ATTACK_3D6;
                }
                else if (iCasterLevel >= 10)
                {
                    iDamageBonus = IP_CONST_FEAT_SNEAK_ATTACK_2D6;
                }
                float fDuration = TurnsToSeconds(nDuration);
                object oMyWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oTarget);
                if(GetIsObjectValid(oMyWeapon) )
                {
                    IPSafeAddItemProperty(oMyWeapon,ItemPropertyBonusFeat(iDamageBonus), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
                }


                oMyWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oTarget);
                if(GetIsObjectValid(oMyWeapon))
                {
                    IPSafeAddItemProperty(oMyWeapon,ItemPropertyBonusFeat(iDamageBonus), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
                }


                oMyWeapon = GetItemInSlot(INVENTORY_SLOT_ARMS,oTarget);
                if(GetIsObjectValid(oMyWeapon))
                {
                    IPSafeAddItemProperty(oMyWeapon,ItemPropertyBonusFeat(iDamageBonus), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
                }
                oMyWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B,oTarget);
                if(GetIsObjectValid(oMyWeapon))
                {
                    IPSafeAddItemProperty(oMyWeapon,ItemPropertyBonusFeat(iDamageBonus), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
                }
                oMyWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L,oTarget);
                if(GetIsObjectValid(oMyWeapon))
                {
                    IPSafeAddItemProperty(oMyWeapon,ItemPropertyBonusFeat(iDamageBonus), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
                }
                oMyWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,oTarget);
                if(GetIsObjectValid(oMyWeapon))
                {
                    IPSafeAddItemProperty(oMyWeapon,ItemPropertyBonusFeat(iDamageBonus), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
                }
            }
        }
        //Get the next target in the specified area around the caster
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}

