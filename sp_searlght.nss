//::///////////////////////////////////////////////
//:: Searing Light
//:: s_SearLght.nss
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Focusing holy power like a ray of the sun, you project
//:: a blast of light from your open palm. You must succeed
//:: at a ranged touch attack to strike your target. A creature
//:: struck by this ray of light suffers 1d8 points of damage
//:: per two caster levels (maximum 5d8). Undead creatures suffer
//:: 1d6 points of damage per caster level (maximum 10d6), and
//:: undead creatures particularly vulnerable to sunlight, such
//:: as vampires, suffer 1d8 points of damage per caster level
//:: (maximum 10d8). Constructs and inanimate objects suffer only
//:: 1d6 points of damage per two caster levels (maximum 5d6).
//:://////////////////////////////////////////////
//:: Created By: Keith Soleski
//:: Created On: 02/05/2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 25, 2001

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

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
    object oCaster = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(oCaster);
    int nDamage;
    int nMax;
    int iResistSpellResult;
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eRay = EffectBeam(VFX_BEAM_HOLY, OBJECT_SELF, BODY_NODE_HAND);
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SEARING_LIGHT));
        eRay = EffectBeam(VFX_BEAM_HOLY, OBJECT_SELF, BODY_NODE_HAND);
        // check spell/magic immunities and/or spell absorbtion and/or spell resistance
        // 0 = no immunity/absorbtion at all
        // 1 = spell resistance
        // 2 = magic immunity
        // 3 = spell absobtion
        iResistSpellResult = ResistSpell(oCaster, oTarget);  // !!! don't use this function outside of spell scripts defined by spells.2da file!!!
        if ((iResistSpellResult == 2) || (iResistSpellResult == 3))
        {
          // spell resisted via magic immunity (2) or via spell absorption (3)
          // do nothing
        }
        else  // either spell resistance (which should be ignored) or no spell resistance at all
        //Make an SR Check
        if (!MyResistSpell(oCaster, oTarget))
        {   // do dmg to oTarget
            //Limit caster level
            if (nCasterLevel > 10)
            {
                nCasterLevel = 10;
            }
            //Check for racial type undead
            if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
            {
                nDamage = d6(nCasterLevel);
                nMax = 6;
            }
            //Check for racial type construct
            else if (GetRacialType(oTarget) == RACIAL_TYPE_CONSTRUCT)
            {
                nCasterLevel /= 2;
                if(nCasterLevel == 0)
                {
                    nCasterLevel = 1;
                }
                nDamage = d6(nCasterLevel);
                nMax = 6;
            }
            else
            {
                nCasterLevel = nCasterLevel/2;
                if(nCasterLevel == 0)
                {
                    nCasterLevel = 1;
                }
                nDamage = d8(nCasterLevel);
                nMax = 8;
            }

            //Make metamagic checks
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                nDamage = nMax * nCasterLevel;
            }
            if (nMetaMagic == METAMAGIC_EMPOWER)
            {
                nDamage = nDamage + (nDamage/2);
            }
            //Set the damage effect
            eDam = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);
            //Apply the damage effect and VFX impact
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            //ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.0);
        }
    }
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
}

