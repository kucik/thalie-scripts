//::///////////////////////////////////////////////
//:: Aid
//:: sp_Aid.nss

//:://////////////////////////////////////////////
/*
    Cil ziska +1 do AB a bonusu proti strachu a + 8 hp na tahy pro jeden target
    Pokud je v knize u stranky AID hodnota na 1 ziska +1 ab na kola, ovsem pro vsechny pratelske creatury v oblasti.
    Target creature gains +1 to attack rolls and
    saves vs fear. Also gain +1d8 temporary HP.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Sept 6, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 20, 2001

#include "x2_inc_spellhook"
#include "x0_i0_spells"

#include "sh_classes_inc_e"

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
    int iCasterLevel = GetCasterLevel(OBJECT_SELF)+1;
    object oTarget = GetSpellTargetObject();
    int nBonus = d8(1);
    int nMetaMagic = GetMetaMagicFeat();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    object oSoulStone = GetSoulStone(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_IMP_HOLY_AID);
    effect eAttack = EffectAttackIncrease(1);
        int iDuration = GetThalieCaster(OBJECT_SELF,oTarget,iCasterLevel);
        //Enter Metamagic conditions
        if (nMetaMagic == METAMAGIC_MAXIMIZE)
        {
            nBonus = 8;//Damage is at max
        }
        else if (nMetaMagic == METAMAGIC_EMPOWER)
        {
            nBonus = nBonus + (nBonus/2); //Damage/Healing is +50%
        }
        else if (nMetaMagic == METAMAGIC_EXTEND)
        {
            iDuration = iDuration *2; //Duration is +100%
        }


        effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 1, SAVING_THROW_TYPE_FEAR);

        effect eHP = EffectTemporaryHitpoints(nBonus);




        effect eLink = EffectLinkEffects(eAttack, eSave);
        eLink = EffectLinkEffects(eLink, eDur);

        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_AID, FALSE));

        //Apply the VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(iDuration));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, TurnsToSeconds(iDuration));

}

