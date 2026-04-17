// On Enter skript pro jednorazovy spawn pomoci waypointu
// Spousti pouze PC (DM possesed NPC)
// NPC se spawnou v nahodnem kruhovem rozestupu podle promennych MAX_DIST a MIN_DIST

// Promenne k pouziti:
// MAX_TYPES int = pocet typu NPC co se objevi na spawnu (typ znamena unikatni resref)
// SPAWN_WP string = tag waypointu kde se maji NPC spawnout
// RESREF1 string = resref NPC ke spawnuti (pro dalsi typ NPC se pouzije RESREF2, RESREF3 atd.)
// COUNT1 int = pocet NPC odkazujici na RESREF1 co se ma spawnout (COUNT1 patri k RESREF1, COUNT2 k RESREF2 atd.)
// MAX_DIST = maximalni rozestup od dalsi spawnute NPC v kruhu
// MIN_DIST = minimalni rozestup od dalsi spawnute NPC v kruhu

void main()
{
    object oPC = GetEnteringObject();
    if (!GetIsPC(oPC)) return;

    // Zabrání opakovanému spawnování
    if (GetLocalInt(OBJECT_SELF, "spawned") == 1)
        return;

    SetLocalInt(OBJECT_SELF, "spawned", 1);

    // ----------------------------------------------------
    // Waypoint
    // ----------------------------------------------------
    string sWP = GetLocalString(OBJECT_SELF, "SPAWN_WP");
    object oWP = GetWaypointByTag(sWP);

    if (!GetIsObjectValid(oWP))
    {
        SendMessageToPC(oPC, "Waypoint '" + sWP + "' nebyl nalezen.");
        return;
    }

    vector vBase = GetPosition(oWP);

    // ----------------------------------------------------
    // Parametry spawnu
    // ----------------------------------------------------
    int nMaxTypes = GetLocalInt(OBJECT_SELF, "MAX_TYPES");
    if (nMaxTypes <= 0) nMaxTypes = 1;

    float fMaxDist = GetLocalFloat(OBJECT_SELF, "MAX_DIST");
    if (fMaxDist <= 0.0) fMaxDist = 5.0;

    float fMinDist = GetLocalFloat(OBJECT_SELF, "MIN_DIST");
    if (fMinDist <= 0.0) fMinDist = 2.0;

    // ----------------------------------------------------
    // Hlavní spawnovací smyèka
    // ----------------------------------------------------
    int iType;
    for (iType = 1; iType <= nMaxTypes; iType++)
    {
        string sResRef = GetLocalString(OBJECT_SELF, "RESREF" + IntToString(iType));
        int nCount     = GetLocalInt(OBJECT_SELF, "COUNT" + IntToString(iType));

        if (sResRef != "" && nCount > 0)
        {
            int i;
            for (i = 0; i < nCount; i++)
            {
                // ----------------------------------------------------
                // Blok pro výpoèet pozice a spawn NPC
                // ----------------------------------------------------
                {
                    vector vRand;
                    int nAttempts = 0;
                    int bValid = FALSE;

                    // Hledání pozice s minimální vzdáleností od ostatních NPC
                    while (!bValid && nAttempts < 20)
                    {
                        nAttempts++;

                        float fDist  = (IntToFloat(Random(100)) / 100.0) * fMaxDist;
                        float fAngle = IntToFloat(Random(360));

                        vRand = vBase;
                        vRand.x += fDist * cos(fAngle * 3.14159 / 180.0);
                        vRand.y += fDist * sin(fAngle * 3.14159 / 180.0);

                        bValid = TRUE;

                        object oCheck = GetNearestObject(OBJECT_TYPE_CREATURE, oWP, 1);
                        while (oCheck != OBJECT_INVALID)
                        {
                            float fD = GetDistanceBetweenLocations(
                                Location(GetArea(oWP), vRand, 0.0),
                                GetLocation(oCheck)
                            );

                            if (fD < fMinDist)
                            {
                                bValid = FALSE;
                                break;
                            }

                            oCheck = GetNearestObject(OBJECT_TYPE_CREATURE, oCheck, 1);
                        }
                    }

                    // Spawn NPC
                    location lSpawn = Location(GetArea(oWP), vRand, GetFacing(oWP));
                    CreateObject(OBJECT_TYPE_CREATURE, sResRef, lSpawn);
                }
            }
        }
    }
}
