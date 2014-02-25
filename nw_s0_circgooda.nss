//::///////////////////////////////////////////////
//:: Magic Cirle Against Good
//:: NW_S0_CircGoodA
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Add basic protection from good effects to
    entering allies.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 20, 2001
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"

#include "x2_inc_spellhook"
//#include "nwnx_funcs"
#include "ku_libtime"

void main()
{




    object oTarget = GetEnteringObject();
    object oCreator = GetAreaOfEffectCreator();

/*    SendMessageToPC(GetFirstPC(),"object is "+GetName(OBJECT_SELF));

    if(oTarget == oCreator) {
       if(!GetHasSpellEffect(SPELL_MAGIC_CIRCLE_AGAINST_GOOD, oTarget)) {

       }
       return;
    }
*/
    int iTime =  ku_GetTimeStamp();
    int iSpellTime = GetLocalInt(oTarget,"SPELL_DURATION_"+IntToString(SPELL_MAGIC_CIRCLE_AGAINST_GOOD));
    if(iSpellTime > iTime) {
      return;
    }

    if(GetIsFriend(oTarget, GetAreaOfEffectCreator()))
    {
        //Declare major variables
        int nDuration = GetCasterLevel(OBJECT_SELF);
        //effect eVis = EffectVisualEffect(VFX_IMP_EVIL_HELP);
        effect eLink = CreateProtectionFromAlignmentLink(ALIGNMENT_GOOD);

        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MAGIC_CIRCLE_AGAINST_GOOD, FALSE));

        //Apply the VFX impact and effects
        //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
     }
}
