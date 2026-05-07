// OnHeartbeat skript pro kontrolu FoM/Haste uvnitr triggeru

int HasSlow(object oPC)
{
    effect e = GetFirstEffect(oPC);
    while (GetIsEffectValid(e))
    {
        if (GetEffectType(e) == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE)
            return TRUE;

        e = GetNextEffect(oPC);
    }
    return FALSE;
}

void RemoveFoM(object oPC)
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

void RemoveHaste(object oPC)
{
    effect e = GetFirstEffect(oPC);
    while (GetIsEffectValid(e))
    {
        if (GetEffectType(e) == EFFECT_TYPE_HASTE)
        {
            RemoveEffect(oPC, e);
        }
        e = GetNextEffect(oPC);
    }
}

void main()
{
    int iEnv = GetLocalInt(OBJECT_SELF, "sy_env_type");
    if (iEnv < 1 || iEnv > 2) iEnv = 1;

    int iSlow = GetLocalInt(OBJECT_SELF, "sy_slow_const");

    object oPC = GetFirstInPersistentObject(OBJECT_SELF);
    while (GetIsObjectValid(oPC))
    {
        if (GetObjectType(oPC) == OBJECT_TYPE_CREATURE)
        {
            if (GetLocalInt(oPC, "sy_ignore_slow") != 1)
            {
                if (!(iEnv == 1 && GetLocalInt(oPC, "sy_swimmer") == 1) &&
                    !(iEnv == 2 && GetLocalInt(oPC, "sy_crawler") == 1))
                {
                    RemoveFoM(oPC);
                    RemoveHaste(oPC);

                    if (!HasSlow(oPC))
                    {
                        effect eSlow = EffectMovementSpeedDecrease(iSlow);
                        DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSlow, oPC));
                    }
                }
            }
        }

        oPC = GetNextInPersistentObject(OBJECT_SELF);
    }
}
