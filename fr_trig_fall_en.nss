// ------------------------------------------------------
// Lavina - pad kamenu a lavina s plne konfigurovatelnymi promenymi
// On enter skript na trigger

// fr_mode int = 1 (pad kamenu), 2 (lavina)
// fr_chance int = sance v % na pad kamenu/laviny
// fr_cooldown float = cas v sekundach, po ktery je trigger neaktivni
// fr_radius float = radius zasahu, pokud neni nastaven, pouzije se default podle modu
// fr_damage int = damage v % z max HP ciloveho objektu
// fr_dc_reflex int = DC pro reflex save
// fr_knockdown float = doba trvani knockdown efektu
// fr_msg string = text hlasky, ktera se zobrazi vsem PC s line of sight
// fr_sound string = zvuk, ktery se prehrava pri padu kameni/laviny
// ------------------------------------------------------

void PadKameniLavina(
            int nDefChance,
            string sDefSound,
            int nDefDamage,
            float fDefCooldown,
            int nDefDC,
            float fDefKnock,
            float fDefRadiusSmall,
            float fDefRadiusBig)
{
    object oTrap = OBJECT_SELF;
    object oEnter = GetEnteringObject();
    if (!GetIsObjectValid(oEnter)) return;

    // ------------------------------------------------------
    // Nacteni promennych z triggeru
    // ------------------------------------------------------

    int nChance = GetLocalInt(oTrap, "fr_chance");
    if (nChance <= 0) nChance = nDefChance;

    string sSound = GetLocalString(oTrap, "fr_sound");
    if (sSound == "") sSound = sDefSound;

    int nDamagePct = GetLocalInt(oTrap, "fr_damage");
    if (nDamagePct <= 0) nDamagePct = nDefDamage;

    int nDC = GetLocalInt(oTrap, "fr_dc_reflex");
    if (nDC <= 0) nDC = nDefDC;

    float fCooldown = GetLocalFloat(oTrap, "fr_cooldown");
    if (fCooldown <= 0.0) fCooldown = fDefCooldown;

    float fKnock = GetLocalFloat(oTrap, "fr_knockdown");
    if (fKnock <= 0.0) fKnock = fDefKnock;

    int nMode = GetLocalInt(oTrap, "fr_mode");
    if (nMode <= 0) nMode = 2;

    float fRadius = GetLocalFloat(oTrap, "fr_radius");
    if (fRadius <= 0.0)
        fRadius = (nMode == 1 ? fDefRadiusSmall : fDefRadiusBig);

    string sMsgFinal = GetLocalString(oTrap, "fr_msg");
    if (sMsgFinal == "")
        sMsgFinal = "Spadla na tebe lavina!";

    // ------------------------------------------------------
    // Kontrola aktivace
    // ------------------------------------------------------
    if (GetLocalInt(oTrap, "activate") == 1) return;

    // ------------------------------------------------------
    // Procentualni sance
    // ------------------------------------------------------
    if (Random(100) + 1 > nChance) return;

    // ------------------------------------------------------
    // Aktivace a cooldown
    // ------------------------------------------------------
    SetLocalInt(oTrap, "activate", 1);
    DelayCommand(fCooldown, SetLocalInt(oTrap, "activate", 0));

    location lLoc = GetLocation(oEnter);

    // ------------------------------------------------------
    // Prehrani zvuku
    // ------------------------------------------------------
    PlaySound(sSound);

    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);

    // ------------------------------------------------------
    // Otras obrazovky pro vsechny PC v oblasti
    // ------------------------------------------------------
    object oPC = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE);

    while (GetIsObjectValid(oPC))
    {
        if (GetIsPC(oPC))
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShake, oPC, 6.0);

        oPC = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE);
    }

    // ------------------------------------------------------
    // Aplikace efektu na vsechny objekty v oblasti
    // ------------------------------------------------------
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE,
                                           OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE);

    while (GetIsObjectValid(oTarget))
    {
        float fDelay = GetDistanceBetweenLocations(lLoc, GetLocation(oTarget)) / 5.0;

        // ------------------------------------------------------
        // Damage + reflex save + knockdown logika
        // ------------------------------------------------------
        int nDamage = (GetMaxHitPoints(oTarget) * nDamagePct) / 100;

        int bSave = ReflexSave(oTarget, nDC, SAVING_THROW_TYPE_ALL);
        int bApplyKnock = TRUE;

        if (nMode == 1)
        {
            // Pad kamenu: uspech = 0 damage + zadny knockdown
            if (bSave)
            {
                nDamage = 0;
                bApplyKnock = FALSE;
            }
        }
        else
        {
            // Lavina: uspech = polovicni damage
            if (bSave)
            {
                nDamage = nDamage / 2;
            }
        }

        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,
            EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING), oTarget));

        if (bApplyKnock)
        {
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                EffectKnockdown(), oTarget, fKnock));
        }

        // ------------------------------------------------------
        // VFX podle modu
        // ------------------------------------------------------
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,
            EffectVisualEffect(VFX_FNF_SMOKE_PUFF), oTarget));

        if (nMode == 2)
        {
            DelayCommand(fDelay + 0.2, ApplyEffectToObject(DURATION_TYPE_INSTANT,
                EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_ACID), oTarget));
        }

        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE,
                                       OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE);
    }

    // ------------------------------------------------------
    // Globalni hlaska pro vsechny PC s line of sight
    // ------------------------------------------------------
    object oPC2 = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE);

    while (GetIsObjectValid(oPC2))
    {
        if (GetIsPC(oPC2))
        {
            if (LineOfSightObject(oPC2, oEnter))
            {
                SendMessageToPC(oPC2, sMsgFinal);
            }
        }

        oPC2 = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lLoc, TRUE, OBJECT_TYPE_CREATURE);
    }
}

void main()
{
    PadKameniLavina(
           50,
           "as_rockcrumble3",
           10,
           15.0,
           100,
           5.0,
           12.0,
           20.0);
}
