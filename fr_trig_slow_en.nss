// OnEnter skript pro zpomaleni podle typu prostredi a odstraneni Freedom of Movement
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

void RemoveFreedomOfMovement(object oPC)
{
    effect e = GetFirstEffect(oPC);
    while (GetIsEffectValid(e))
    {
        if (GetEffectSpellId(e) == SPELL_FREEDOM_OF_MOVEMENT)
        {
            RemoveEffect(oPC, e);
        }
        e = GetNextEffect(oPC);
    }
}

void main()
{
    object oPC = GetEnteringObject();
    if (!GetIsObjectValid(oPC)) return;

    // Povolit vsechny creature (PC, DM-possessed NPC, bezne NPC)
    if (GetObjectType(oPC) != OBJECT_TYPE_CREATURE)
        return;

    // Vylouceni familiaru
    if (GetAssociateType(oPC) == ASSOCIATE_TYPE_FAMILIAR)
        return;

    // Vylouceni vybranych summonù (napr. letajicich)
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

    // Zjistime, zda mel PC aktivni Freedom of Movement
    int bHadFoM = FALSE;
    effect eCheck = GetFirstEffect(oPC);
    while (GetIsEffectValid(eCheck))
    {
    if (GetEffectSpellId(eCheck) == SPELL_FREEDOM_OF_MOVEMENT)
    {
        bHadFoM = TRUE;
        break;
    }
    eCheck = GetNextEffect(oPC);
}

// Odstraneni Freedom of Movement
    RemoveFreedomOfMovement(oPC);

// Hlaseni jen pokud mel PC FoM
    if (bHadFoM && GetIsPC(oPC))
    {
    SendMessageToPC(oPC, "Magicka ochrana proti omezeni pohybu je potlacena prirodnimi podminkami.");
    }

    // Aplikace PERMANENT slow efektu
    int iSlow = GetLocalInt(OBJECT_SELF, "sy_slow_const");
    effect eSlow = EffectMovementSpeedDecrease(iSlow);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSlow, oPC);

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
