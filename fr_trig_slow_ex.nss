// OnExit skript pro odstraneni zpomaleni podle typu prostredi

/* Nastavitelne promenne na triggeru:
sy_env_type int =    typ postredi (1 voa,2 ostatni)
sy_slow_const int = procento zpomaleni
sy_text_enter string = vlastni text pri vstupu
sy_text_exit string = vlastni text pri vystupu

Nastavitelne promenne na NPC:
sy_swimmer int 1 = ignoruje vodni zpomaleni
sy_crawler int 1 = ignoruje zpomaleni pro ostatni tereny
*/

void RemoveEnvSlow(object oPC)
{
    effect e = GetFirstEffect(oPC);
    while (GetIsEffectValid(e))
    {
        if (GetEffectType(e) == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE &&
            GetEffectDurationType(e) == DURATION_TYPE_PERMANENT)
        {
            RemoveEffect(oPC, e);
        }

        e = GetNextEffect(oPC);
    }
}

void main()
{
    object oPC = GetExitingObject();
    if (!GetIsObjectValid(oPC)) return;

    if (!GetIsPC(oPC) && !GetIsObjectValid(GetMaster(oPC)))
        return;

    int iEnv = GetLocalInt(OBJECT_SELF, "sy_env_type");
    if (iEnv < 1 || iEnv > 2) iEnv = 1;

    if (iEnv == 1 && GetLocalInt(oPC, "sy_swimmer") == 1)
        return;

    if (iEnv == 2 && GetLocalInt(oPC, "sy_crawler") == 1)
        return;

    string sFlag = "sy_env_flag_" + IntToString(iEnv);
    if (GetLocalInt(oPC, sFlag) == 0)
        return;

    DeleteLocalInt(oPC, sFlag);

    // Odstranime pouze PERMANENT slow efekty (tj. ty z triggeru)
    RemoveEnvSlow(oPC);

    string sCustom = GetLocalString(OBJECT_SELF, "sy_text_exit");

    if (GetIsPC(oPC))
    {
        if (sCustom != "")
            SendMessageToPC(oPC, sCustom);
        else
        {
            if (iEnv == 1)
                SendMessageToPC(oPC, "Vysel jsi z vody.");
            else
                SendMessageToPC(oPC, "Opustil jsi narocny teren.");
        }
    }
}
