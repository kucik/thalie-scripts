//::///////////////////////////////////////////////
//:: Acid Fog: On Exit
//:: NW_S0_AcidFogB.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    nw_s0_acidfog.nss
    Vsechny potvory v oblasti pusobeni jsou zranovany za 1k6
    kyseliny za 4 urovne sesilatele a jejich rychlost pohybu
    je polovicni.
    Jedna se o Area effect - ten je resen pomoci specialni
    skriptu pro OnEnter, OnExit a OnHeartBeat.
    Konkretne: nw_s0_acidfoga,nw_s0_acidfogb,nw_s0_acidfogc
    Nelze v AOE skriptu zjistit caster lvl.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 17, 2001
//:://////////////////////////////////////////////
//:: Update Pass By: Preston W, On: July 20, 2001


void main()
{


    //Declare major variables
    //Get the object that is exiting the AOE
    object oTarget = GetExitingObject();
    int bValid = FALSE;
    effect eAOE;
    if(GetHasSpellEffect(SPELL_ACID_FOG, oTarget))
    {
        //Search through the valid effects on the target.
        eAOE = GetFirstEffect(oTarget);
        while (GetIsEffectValid(eAOE) && bValid == FALSE)
        {
            if (GetEffectCreator(eAOE) == GetAreaOfEffectCreator())
            {
                if(GetEffectType(eAOE) == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE)
                {
                    //If the effect was created by the Acid_Fog then remove it
                    if(GetEffectSpellId(eAOE) == SPELL_ACID_FOG)
                    {
                        RemoveEffect(oTarget, eAOE);
                        bValid = TRUE;
                    }
                }
            }
            //Get next effect on the target
            eAOE = GetNextEffect(oTarget);
        }
    }
}

