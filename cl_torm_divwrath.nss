//::///////////////////////////////////////////////
//:: Divine Wrath u Boziho bojovnika
//:: cl_torm_divwrath
//:: //:://////////////////////////////////////////////
/*



*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On: 21.6.2011
//:://////////////////////////////////////////////

#include "nw_i0_spells"


void main()
{
    //Declare major variables
    object oTarget = OBJECT_SELF;
    int nDuration = GetAbilityModifier(ABILITY_CHARISMA, OBJECT_SELF)+5;// DODANO
    //Check that if nDuration is not above 0, make it 1.
    if(nDuration <= 0)
    {
        FloatingTextStrRefOnCreature(100967,OBJECT_SELF);
        return;
    }
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    eVis = EffectLinkEffects(EffectVisualEffect(VFX_IMP_GOOD_HELP),eVis);
     effect eAttack, eDamage, eSaving,eResBlud, eResPierc,eResSlash;
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 621, FALSE));
    int nLevel = GetLevelByClass(CLASS_TYPE_DIVINECHAMPION,oTarget);
    int iBonus = 0;
    int iResistance = 0;
    //Dodal Shaman88
    if (nLevel == 30)
    {
       iBonus = 8;
       iResistance = 20;
    }
    else if (nLevel >= 25)
    {
       iBonus = 7;
       iResistance = 15;
    }
    else if (nLevel >= 20)
    {
       iBonus = 6;
       iResistance = 15;
    }
    else if (nLevel >= 15)
    {
       iBonus = 5;
       iResistance = 10;
    }
    else if (nLevel >= 10)
    {
       iBonus = 4;
       iResistance = 10;
    }
    else if (nLevel >= 5)
    {
       iBonus = 3;
       iResistance= 5;
    }
    //--------------------------------------------------------------
    //
    //--------------------------------------------------------------
    eAttack = EffectAttackIncrease(iBonus,ATTACK_BONUS_MISC);
    eDamage = EffectDamageIncrease(iBonus, DAMAGE_TYPE_DIVINE);
    eSaving = EffectSavingThrowIncrease(SAVING_THROW_ALL,iBonus, SAVING_THROW_TYPE_ALL);
    eResBlud  = EffectDamageResistance(DAMAGE_TYPE_BLUDGEONING,iResistance);
    eResPierc = EffectDamageResistance(DAMAGE_TYPE_PIERCING,iResistance);
    eResSlash = EffectDamageResistance(DAMAGE_TYPE_SLASHING,iResistance);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    effect eLink = EffectLinkEffects(eAttack, eDamage);
    eLink = EffectLinkEffects(eSaving,eLink);
    eLink = EffectLinkEffects(eResBlud,eLink);
    eLink = EffectLinkEffects(eResPierc,eLink);
    eLink = EffectLinkEffects(eResSlash,eLink);
    eLink = EffectLinkEffects(eDur,eLink);
    eLink = SupernaturalEffect(eLink);

    // prevent stacking with self
    RemoveEffectsFromSpell(oTarget, GetSpellId());


    //Apply the armor bonuses and the VFX impact
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}
