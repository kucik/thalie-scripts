// OnExit skript pro odstraneni zpomaleni podle typu prostredi
// Verze 100% kompatibilni s NWN 1.69

/* Nastavitelne promenne na triggeru:
sy_env_type int =    typ postredi (1 voda,2 ostatni)
sy_slow_const int = procento zpomaleni
sy_text_enter string = vlastni text pri vstupu
sy_text_exit string = vlastni text pri vystupu

Nastavitelne promenne na NPC:
sy_swimmer int 1 = ignoruje vodni zpomaleni
sy_crawler int 1 = ignoruje zpomaleni pro ostatni tereny
sy_ignore_slow int 1 = ignoruje slow efekt (napr. letajici summon)
*/

void main()
{
    object oPC = GetExitingObject();
    if (!GetIsObjectValid(oPC)) return;

    // Povolit vsechny creature (PC, DM-possessed NPC, bezne NPC)
    if (GetObjectType(oPC) != OBJECT_TYPE_CREATURE)
        return;

    // Pokud ma tvor sy_ignore_slow, nic se nedela
    if (GetLocalInt(oPC, "sy_ignore_slow") == 1)
        return;

    // Typ prostredi
    int iEnv = GetLocalInt(OBJECT_SELF, "sy_env_type");
    if (iEnv < 1 || iEnv > 2) iEnv = 1;

    // Flag, ktery rika, zda byl slow aplikovan
    string sFlag = "sy_env_flag_" + IntToString(iEnv);

    // Pokud slow nebyl aplikovan, neni co cistit
    if (GetLocalInt(oPC, sFlag) != 1)
        return;

    // Smazeme flag
    DeleteLocalInt(oPC, sFlag);

    // Odstraneni slow efektu aplikovaneho OnEnter skriptem
    effect e = GetFirstEffect(oPC);
    while (GetIsEffectValid(e))
    {
        if (GetEffectType(e) == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE)
        {
            // OnEnter nepouziva tagy, takze odstranime vsechny slow efekty tohoto typu
            RemoveEffect(oPC, e);
        }
        e = GetNextEffect(oPC); // 1.69 kompatibilni iterace
    }

    // Text pri vystupu
    string sCustom = GetLocalString(OBJECT_SELF, "sy_text_exit");

    if (GetIsPC(oPC))
    {
        if (sCustom != "")
            SendMessageToPC(oPC, sCustom);
        else
        {
            if (iEnv == 1)
                SendMessageToPC(oPC, "Opoustis vodu.");
            else
                SendMessageToPC(oPC, "Opoustis narocny teren.");
        }
    }

    // Engine fix: male zpozdeni pro obnoveni rychlosti
    DelayCommand(0.1, AssignCommand(oPC, ClearAllActions()));
}
