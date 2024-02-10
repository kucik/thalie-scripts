//script sa aktivuje na OnEnter evente trigeru
//varianta pro brozeni bahnem (zobrazi se jine info "Vysel jsi z bahna")
//puvodni verze z sy_wat_slow_ex skriptu
//upraveno Frynem 10.2. 2024

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
            if (GetIsPC(oPC)) SendMessageToPC(oPC,"Vysel jsi z bahna");
            return;
        }
        eFX = GetNextEffect(oPC);
    }
}
