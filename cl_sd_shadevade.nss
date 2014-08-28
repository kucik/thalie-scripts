//::///////////////////////////////////////////////
//:: cl_sd_shadevade
//:://////////////////////////////////////////////
/*
    Gives the caster the following bonuses:
    Level 1:
      20% concealment
      5/- DR
      +2 AC
    Level 5
      25% concealment
      5/- DR
      +3 AC

    Level 10
      30% concealment
      10/- DR
      +4 AC

    Level 15
      35% concealment
      10/- DR
      +5 AC

    Level 20
      40% concealment
      15/- DR
      +6 AC

    Level 25
      45% concealment
      15/- DR
      +7 AC

    Level 30
      50% concealment
      20/- DR
      +8 AC

    Lasts: 5 + (level/2) rounds




*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:://////////////////////////////////////////////


void main()
{
    //Declare major variables
    int nLevel = GetLevelByClass(CLASS_TYPE_SHADOWDANCER);
    int nConceal, nDRAmount,nAC;
    int nDuration = 5+nLevel;
    nConceal = ((nLevel / 5) +4)*5;
    nAC = ((nLevel / 5) +2);
    if (nLevel == 30)
    {
        nDRAmount = 20;
    }
    else if (nLevel >= 20)
    {
        nDRAmount = 15;
    }
    else if (nLevel == 10)
    {
    nDRAmount = 10;
    }
    else
    {
    nDRAmount = 5;
    }

    //Declare effects
    effect eConceal = EffectConcealment(nConceal);
    effect eDR1 = EffectDamageResistance(DAMAGE_TYPE_BLUDGEONING,nDRAmount);
    effect eDR2 = EffectDamageResistance(DAMAGE_TYPE_PIERCING,nDRAmount);
    effect eDR3 = EffectDamageResistance(DAMAGE_TYPE_SLASHING,nDRAmount);
    effect eAC = EffectACIncrease(nAC);
    effect eDur= EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eVis2 = EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR);
    effect eSpell = EffectSpellLevelAbsorption(9, 0, SPELL_SCHOOL_NECROMANCY);
    effect eImmDeath = EffectImmunity(IMMUNITY_TYPE_DEATH);
    effect eImmNeg = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, 100);

    //Link effects
    effect eLink = EffectLinkEffects(eConceal, eDR1);

    eLink = EffectLinkEffects(eLink, eDR2);
    eLink = EffectLinkEffects(eLink, eDR3);
    eLink = EffectLinkEffects(eLink, eAC);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eVis2);
    eLink = EffectLinkEffects(eLink, eSpell);
    eLink = EffectLinkEffects(eLink, eImmDeath);
    eLink = EffectLinkEffects(eLink, eImmNeg);

    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    //Signal Spell Event
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, 477, FALSE));

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nDuration));
}


