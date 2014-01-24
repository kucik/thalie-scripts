//::///////////////////////////////////////////////
//:: cl_shin_utis
//:://////////////////////////////////////////////
/*
   Shinobiho utisujici utok
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

//:://////////////////////////////////////////////

void main()
{
    object oTarget = GetSpellTargetObject();
    if (GetIsObjectValid(oTarget) == TRUE)
    {
        SetLocalInt(oTarget,"SHINOBI_UTISUJICI_UTOK",1);
        ClearAllActions(TRUE);
        AssignCommand (OBJECT_SELF, ActionAttack(oTarget));
    }
}
