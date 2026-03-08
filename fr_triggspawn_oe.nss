// On Enter skript pro jednorazovy spawn pomoci waypointu
// Spousti pouze PC (DM possesed NPC)
// NPC se spawnout v nahodnych rozestupech +- 1m

// Promenne k pouziti:
// MAX_TYPES int = pocet typu NPC co se objevi na spawnu (typ znamena unikatni resref)
// SPAWN_WP string = tag waypointu kde se maji NPC spawnout
// RESREF1 string = resref NPC ke spawnuti (pro dalsi typ NPC se pouzije RESREF2, RESREF3 atd.)
// COUNT1 int = pocet NPC odkazujici na RESREF1 co se ma spawnout (COUNT1 patri k RESREF1, COUNT2 k RESREF2 atd.)

void main()
{
    object oPC = GetEnteringObject();
    if (!GetIsPC(oPC)) return;

    // zabrání opakovanému spawnování
    if (GetLocalInt(OBJECT_SELF, "spawned") == 1)
        return;

    SetLocalInt(OBJECT_SELF, "spawned", 1);

    // waypoint
    string sWP = GetLocalString(OBJECT_SELF, "SPAWN_WP");
    object oWP = GetWaypointByTag(sWP);

    if (!GetIsObjectValid(oWP))
    {
        SendMessageToPC(oPC, "Waypoint '" + sWP + "' nebyl nalezen.");
        return;
    }

    location lBase = GetLocation(oWP);
    vector vBase = GetPosition(oWP);

    // poèet typù NPC naètený z triggeru
    int nMaxTypes = GetLocalInt(OBJECT_SELF, "MAX_TYPES");
    if (nMaxTypes <= 0) nMaxTypes = 1; // bezpeèný fallback

    int iType;
    for (iType = 1; iType <= nMaxTypes; iType++)
    {
        string sResRef = GetLocalString(OBJECT_SELF, "RESREF" + IntToString(iType));
        int nCount = GetLocalInt(OBJECT_SELF, "COUNT" + IntToString(iType));

        if (sResRef != "" && nCount > 0)
        {
            int i;
            for (i = 0; i < nCount; i++)
            {
                // náhodné rozhození kolem waypointu (±1 metr)
                vector vRand = vBase;
                vRand.x += (Random(200) - 100) / 100.0; // -1.0 až +1.0
                vRand.y += (Random(200) - 100) / 100.0;

                location lSpawn = Location(GetArea(oWP), vRand, GetFacing(oWP));

                CreateObject(OBJECT_TYPE_CREATURE, sResRef, lSpawn);
            }
        }
    }
}
