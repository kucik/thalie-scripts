//::///////////////////////////////////////////////
//:: Purple Dragon Knight - FEAR
//:: cl_pdk_rally.nss
//:://////////////////////////////////////////////
//::
//::
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On: 25.6.2011
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

    /* -----------------------------------------------------------------
    Spellcast Hook Code
    Added 2003-06-20 by Georg
    If you want to make changes to all spells,
    check x2_inc_spellhook.nss to find out more */

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD)
    // reports FALSE, do not run this spell
        return;
    }
    // End - Spell Cast Hook -------------------------------------------


    // Declare/assign major variables
    int nDamage;// Will hold damage value
    float fDelay;// For delay value
    object oTarget;// Target object
    //pridano Shaman88
    int iCHA = GetAbilityModifier(ABILITY_CHARISMA,OBJECT_SELF);
    int iLvl =  GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,OBJECT_SELF);
    int iDuration = iLvl;
    int iDC =  15 + iLvl/2 + iCHA;
    //--------------
    float fDuration = IntToFloat(iDuration);
    int nMetaMagic = GetMetaMagicFeat();// Determine the meta magic used on last spell cast

    effect eVis = EffectVisualEffect(VFX_IMP_FEAR_S);// Get VFX
    effect eFear = EffectFrightened();// Get Frightened effect
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);// Get VFX
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);// Get VFX
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);// Get VFX

    // Link the fear and mind effects
    effect eLink = EffectLinkEffects(eFear, eMind);
    eLink = EffectLinkEffects(eLink, eDur);

    // Apply Impact
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());

    // Get first target in the spell cone
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation(), TRUE);

    // Keep processing targets until no valid ones left
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            fDelay = GetRandomDelay();
            if ((oTarget==OBJECT_SELF) || GetMaster(oTarget)==OBJECT_SELF )
            {
                oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation(), TRUE);
                continue;
            }
            // Cause the SpellCastAt event to be triggered on oTarget
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FEAR));

            // Make SR Check
            if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {
                //Make a will save
                if(!MySavingThrow(SAVING_THROW_WILL, oTarget,iDC, SAVING_THROW_TYPE_FEAR, OBJECT_SELF, fDelay))
                {
                    //Apply the linked effects and the VFX impact
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration));
                }
            }
        }
        //Get next target in the spell cone
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation(), TRUE);
    }
}
