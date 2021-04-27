/*
Skript pro prepnuti bojoveho stylu
*/
void main()
{
    object oPC = GetPCSpeaker();
    if (GetHasFeat(FEAT_WEAPON_FOCUS_UNARMED_STRIKE,oPC))
    {
        SetPhenoType(59,oPC);
        SendMessageToPC(oPC,"Aktivovan styl draciho paratu.");
    }
    else
    {
        SendMessageToPC(oPC,"Pouze postavy zamerene na neozbrojeny boj mohou pouzivat styly pro boj beze zbrane.");
    }

}
