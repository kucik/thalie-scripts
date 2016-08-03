//::///////////////////////////////////////////////
//:: Ray of Frost
//:: [ze_ozehnuti.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
/*
    If the caster succeeds at a ranged touch attack
    the target takes 1d4 damage.
*/

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "sh_classes_inc_e"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
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
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nDices = nCasterLvl > 10 ? 5 : nCasterLvl/2;
    if(nDices <=0)
      nDices = 1;
    int nDam = d4(nDices) + 1;
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
    effect eRay = EffectBeam(444, OBJECT_SELF, BODY_NODE_HAND);

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RAY_OF_FROST));
        eRay = EffectBeam(444, OBJECT_SELF, BODY_NODE_HAND);
        //Make SR Check
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
            //Enter Metamagic conditions
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                nDam = nDices * 5 ;//Damage is at max
            }
            else if (nMetaMagic == METAMAGIC_EMPOWER)
            {
                nDam = nDam + nDam/2; //Damage/Healing is +50%
            }
            //Set damage effect
            eDam = EffectDamage(nDam, DAMAGE_TYPE_FIRE);
            //Apply the VFX impact and damage effect
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
        }
    }
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
    RestoreCantripsSlots(OBJECT_SELF);
}
