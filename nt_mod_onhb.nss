#include "ku_libbase"
#include "tc_ds_system_inc"

// dat ruzne hodnoty casu, at se ukony co se maji pravodet nepotkavaji v jedno HB -> odlehceni HB
const int time_update_locations = 1;
const int time_update_database  = 10;
const int time_pc_needs = 13;
const int time_drugs_check = 20;
const int time_fatigue_check = 18;
const int time_upd_LOC_and_HP = 5;
const int time_effect_dying_pc = 7;
const int time_subraces_check = 3;
// soucasny system expeni nastaven na hodnotu 2; nemenit, nechcete-li menit rychlost expeni
const int time_xp_system = 2;

// int t: heartbeat counter
void HeartbeatPCActions(object oPC, int t);

void EffectDyingPC(object oPC)
{
    effect eDmg = EffectDamage(1, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oPC);
}

void main()
{
    int i;
    int t = GetLocalInt(OBJECT_SELF, "TIME");
    float fPCDelayStep = 5.8f / IntToFloat(GetLocalInt(OBJECT_SELF, "LAST_PC_COUNTER_RECORD"));
    float fPCDelay = fPCDelayStep;
    object oPC = GetFirstPC();

    SetLocalInt(OBJECT_SELF, "TIME", t+1);

    if (t % time_update_database == 0)
    {
        SetTime( GetTimeHour(), GetTimeMinute(), GetTimeSecond(), GetTimeMillisecond());
        StoreTime();
    }

    if (t % time_update_locations == 0)
        SetPersistentInt(OBJECT_SELF, "CURRENT_TIMESTAMP", ku_GetTimeStamp());
    
    // Iterate over PCs
    while (GetIsObjectValid(oPC))
    {
        if(GetIsDM(oPC) || GetIsDMPossessed(oPC))
        {
            oPC = GetNextPC();
            continue;
        }
        DelayCommand(fPCDelay, HeartbeatPCActions(oPC, t));
        fPCDelay = fPCDelay + fPCDelayStep;
        oPC = GetNextPC();
        i++;
    }
    
    // Save number of PCs playing
    if (t % time_update_database == 0)
        SetLocalInt(OBJECT_SELF, "LAST_PC_COUNTER_RECORD", i);
}

void HeartbeatPCActions(object oPC, int t)
{
    if (!GetIsObjectValid(oPC)) return;
    
    // ulozeni hrace
    if (t % time_update_database == 0)
        SavePlayer(oPC);

    // aktualizace pozice a hp hrace    
    else if (t % time_upd_LOC_and_HP == 0)
    {
        location lLoc = GetLocation(oPC);
        if ((GetAreaFromLocation(lLoc) != OBJECT_INVALID))
            SetLocalLocation(oPC, "LOCATION", lLoc);
        SetLocalInt(oPC, "HP", GetCurrentHitPoints(oPC));
    }
        
    // Kontrola zmeny den/noc pro subrasy
    if (t % time_subraces_check == 0)
        Subraces_ModuleHeartBeatPC(oPC);

    // Fce systemu zkusenosti
    if (t % time_xp_system == 0)
    {
        ku_CheckXPStop(oPC);
        ku_GiveXPPerTime(oPC);
    }        

    // system potreby jidla a piti
    if (t % time_pc_needs == 0)
    {
        woundStamina(oPC, IntToFloat(time_pc_needs));
        PC_NeedsHB(oPC);
    }
        
    // System zavislosti na drogach
    if (t % time_drugs_check == 0)
        ds_doHB(oPC);

    // system unavy
    if (t % time_fatigue_check == 0)
        FatigueCheck(oPC, TRUE);

    // umirajici postava
    if (t % time_effect_dying_pc == 0)
    {
        if (GetCurrentHitPoints(oPC) <= 0)
            EffectDyingPC(oPC);
    }
}