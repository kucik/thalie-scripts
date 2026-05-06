// OnEnter skript pro zpomaleni podle typu prostredi a odstraneni FoM a Haste
// Verze 100% kompatibilni s NWN 1.69

/* Nastavitelne promenne na triggeru:
sy_env_type int = typ prostredi (1 voda, 2 ostatni)
sy_slow_const int = procento zpomaleni
sy_text_enter string = vlastni text pri vstupu
sy_text_exit string = vlastni text pri vystupu

Nastavitelne promenne na NPC:
sy_swimmer int 1 = ignoruje vodni zpomaleni
sy_crawler int 1 = ignoruje zpomaleni pro ostatni tereny
sy_ignore_slow int 1 = ignoruje slow efekt (napr. letajici summon)
*/

void RemoveFreedomOfMovement(object oPC)
{
    effect e = GetFirstEffect(oPC);
    while (GetIsEffectValid(e))
    {
        if (GetEffectSpellId(e) == SPELL_FREEDOM_OF_MOVEMENT)
        {
            RemoveEffect(oPC, e);
        }
        e = GetNextEffect(oPC); // 1.69 kompatibilni
    }
}

void RemoveHasteEffect(object oPC)
{
    effect e = GetFirstEffect(oPC);
    while (GetIsEffectValid(e))
    {
        if (GetEffectType(e) == EFFECT_TYPE_HASTE)
        {
            RemoveEffect(oPC, e);
        }
        e = GetNextEffect(oPC); // 1.69 kompatibilni
    }
}

void main()
{
    object oPC = GetEnteringObject();
    if (!GetIsObjectValid(oPC)) return;

    // Povolit vsechny creature (PC, DM-possessed NPC, bezne NPC)
    if (GetObjectType(oPC) != OBJECT_TYPE_CREATURE)
        return;

    // Vylouceni podle sy_ignore_slow
    if (GetLocalInt(oPC, "sy_ignore_slow") == 1)
        return;

    // Typ prostredi
    int iEnv = GetLocalInt(OBJECT_SELF, "sy_env_type");
    if (iEnv < 1 || iEnv > 2) iEnv = 1;

    // Vyjimky
    if (iEnv == 1 && GetLocalInt(oPC, "sy_swimmer") == 1)
        return;

    if (iEnv == 2 && GetLocalInt(oPC, "sy_crawler") == 1)
        return;

    // Zabrani opakovane aplikaci
    string sFlag = "sy_env_flag_" + IntToString(iEnv);
    if (GetLocalInt(oPC, sFlag) == 1)
        return;

    SetLocalInt(oPC, sFlag, 1);

    // Kontrola FoM
    int bHadFoM = FALSE;
    effect eCheck = GetFirstEffect(oPC);
    while (GetIsEffectValid(eCheck))
    {
        if (GetEffectSpellId(eCheck) == SPELL_FREEDOM_OF_MOVEMENT)
        {
            bHadFoM = TRUE;
            break;
        }
        eCheck = GetNextEffect(oPC); // OPRAVA
    }

    // Kontrola Haste
    int bHadHaste = FALSE;
    effect eH = GetFirstEffect(oPC);
    while (GetIsEffectValid(eH))
    {
        if (GetEffectType(eH) == EFFECT_TYPE_HASTE)
        {
            bHadHaste = TRUE;
            break;
        }
        eH = GetNextEffect(oPC); // OPRAVA
    }

    // Odstraneni FoM a Haste
    RemoveFreedomOfMovement(oPC);
    RemoveHasteEffect(oPC);

    // Univerzalni hlaseni pro PC a DM-possessed NPC
    if ((bHadFoM || bHadHaste) && GetIsPC(oPC))
    {
        SendMessageToPC(oPC, "Magicke efekty ovlivnujici pohyb jsou potlaceny prirodnimi podminkami.");
    }

    // Aplikace slow s malym zpozdenim (engine fix)
    int iSlow = GetLocalInt(OBJECT_SELF, "sy_slow_const");
    effect eSlow = EffectMovementSpeedDecrease(iSlow);
    DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSlow, oPC));

    // Text
    string sCustom = GetLocalString(OBJECT_SELF, "sy_text_enter");

    if (GetIsPC(oPC))
    {
        if (sCustom != "")
            SendMessageToPC(oPC, sCustom);
        else
        {
            if (iEnv == 1)
                SendMessageToPC(oPC, "Brodis se vodou.");
            else
                SendMessageToPC(oPC, "Prochazis narocnym terenem.");
        }
    }
}
