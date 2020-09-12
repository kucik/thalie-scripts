//#include "nw_i0_spells"
//#include "x2_i0_spells"
#include "sh_deity_inc"
#include "x2_inc_spellhook"
#include "sh_classes_inc_e"
#include "sh_deity_inc"
//#include "nwnx_funcs"
//#include "nwnx_functions"






void main()
{


    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook



    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_IMP_GLOBE_USE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    object oTarget = GetSpellTargetObject();
    itemproperty ip;
    int iCasterLevel  = GetCasterLevel(OBJECT_SELF);
    iCasterLevel = GetThalieCaster(OBJECT_SELF,OBJECT_SELF,iCasterLevel);
    int nDuration  = iCasterLevel;
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2; //Duration is +100%
    }
    object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,oTarget);
    if(   (GetIsObjectValid(oArmor)))
    {
        DelayCommand(1.3f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_ONHIT_CHAOSSHIELD,5);
        IPSafeAddItemProperty(oArmor,ip, TurnsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING ,FALSE,TRUE);
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    }

}
