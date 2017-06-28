//::///////////////////////////////////////////////
//:: cl_bard_zelkuze
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

//:://////////////////////////////////////////////
#include "x0_i0_spells"
#include "nwnx_funcs"
void main()
{
    int iNumSong = GetHasFeat(FEAT_BARD_SONGS,OBJECT_SELF);
    if (iNumSong > 0)
    {


        if (GetHasEffect(EFFECT_TYPE_SILENCE,OBJECT_SELF))
        {
            FloatingTextStrRefOnCreature(85764,OBJECT_SELF); // not useable when silenced
            return;
        }
        DecrementRemainingFeatUses(OBJECT_SELF,FEAT_BARD_SONGS);
        //Declare major variables
        int nDuration = 10; //+ nChr;

        effect eR1 = EffectDamageResistance(DAMAGE_TYPE_SLASHING,5);
        effect eR2 = EffectDamageResistance(DAMAGE_TYPE_PIERCING,5);
        effect eR3 = EffectDamageResistance(DAMAGE_TYPE_BLUDGEONING,5);
        effect eLink = EffectLinkEffects(eR1,eR2);
        eLink = EffectLinkEffects(eLink,eR3);
        //Check to see if the caster has Lasting Impression and increase duration.
        if(GetHasFeat(870))
        {
            nDuration *= 10;
        }

        // lingering song
        if(GetHasFeat(424)) // lingering song
        {
            nDuration += 5;
        }
        effect eVis = EffectVisualEffect(VFX_DUR_BARD_SONG);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        eLink = EffectLinkEffects(eLink, eDur);
        effect eImpact = EffectVisualEffect(VFX_IMP_HEAD_SONIC);
        effect eFNF = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFNF, GetLocation(OBJECT_SELF));

        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));

        eLink = ExtraordinaryEffect(eLink);

        while(GetIsObjectValid(oTarget))
        {
            if(!GetHasFeatEffect(FEAT_BARD_SONGS, oTarget) && !GetHasSpellEffect(GetSpellId(),oTarget))
            {
                 // * GZ Oct 2003: If we are silenced, we can not benefit from bard song
                 if (!GetHasEffect(EFFECT_TYPE_SILENCE,oTarget) && !GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
                 {
                    if(oTarget == OBJECT_SELF)
                    {
                        effect eLinkBard = EffectLinkEffects(eLink, eVis);
                        eLinkBard = ExtraordinaryEffect(eLinkBard);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLinkBard, oTarget, RoundsToSeconds(nDuration));

                    }
                    else if(GetIsFriend(oTarget))
                    {
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));

                    }
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));

         }


    }
    else
    {
        SendMessageToPC(OBJECT_SELF,"Nemuzes zpivat.");
    }
}
