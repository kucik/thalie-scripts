//::///////////////////////////////////////////////
//:: SD - Temnota
//:: cl_sd_darkness.nss
//:: Vytvoril Shaman88
//:://////////////////////////////////////////////


//:://////////////////////////////////////////////
//:: Vytvoril Shaman88
//:: Vytvoreno 30.10.2011
//:://////////////////////////////////////////////



void main()
{

    effect eAOE = EffectAreaOfEffect(AOE_PER_DARKNESS);
    location lTarget = GetSpellTargetLocation();
    int nDuration = 10+ GetLevelByClass(CLASS_TYPE_SHADOWDANCER,OBJECT_SELF);
    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
}
