//script sa aktivuje na OnExit evente trigeru vody

void main()
{
    object oPC = GetExitingObject();
    if (GetLocalInt(oPC,"sy_swimer")==1) return; //tato premenna na prisere znaci, ze nebude spomalena vodou
    if (GetLocalInt(oPC,"sy_plava")==0) return;

    DeleteLocalInt(oPC,"sy_plava");
    effect eFX = GetFirstEffect(oPC);
    while (GetIsEffectValid(eFX))
    {
        if ((GetEffectType(eFX)==EFFECT_TYPE_MOVEMENT_SPEED_DECREASE) &&
            (GetEffectDurationType(eFX)==DURATION_TYPE_PERMANENT))
        {
            RemoveEffect(oPC,eFX);
            if (GetIsPC(oPC)) SendMessageToPC(oPC,"Vysiel si z vody");
            return;
        }
        eFX = GetNextEffect(oPC);
    }
}
