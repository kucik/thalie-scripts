#include "ja_lib"
#include "ku_libtime"  // casova knihovna
#include "ku_libbase"  // xp system
#include "subraces"    // subrasy
#include "ku_ships"    // kvuli lodim
#include "ku_ether_inc" // etherealnes GS
#include "tc_ds_system_inc" // drogy
// dat ruzne hodnoty casu, at se ukony co se maji pravodet nepotkavaji v jedno HB -> odlehceni HB
const int time_update_locations = 1;          //every xth heartbeat
const int time_update_database  = 10;         //every xth update_locations
const int time_pc_needs = 13;
const int time_fagitue_check = 18;
const int time_upd_LOC_and_HP = 5;
const int time_effect_dying_pc = 3;

void FagitueCheck(object oPC)
{
            int iStatus = getStatusInt(oPC);

            if(iStatus < 4)
              SendMessageToPC(oPC, "Prave jsi "+getStatusString(oPC)+".");

            if(iStatus < 3 && !GetLocalInt(oPC, "KU_STAMINA_PENALTY") ){
                SetLocalInt(oPC, "KU_STAMINA_PENALTY", 1);
                effect ePenalty = ExtraordinaryEffect(EffectAttackDecrease(2));
                ePenalty = EffectLinkEffects(ExtraordinaryEffect(EffectACDecrease(2)),ePenalty);
                ApplyEffectToObject( DURATION_TYPE_PERMANENT, ExtraordinaryEffect(ePenalty), oPC );
            }

            if(iStatus < 2 && !GetLocalInt(oPC, "JA_STAMINA_SLOWED") ){
                SetLocalInt(oPC, "JA_STAMINA_SLOWED", 1);
                effect eSlow = ExtraordinaryEffect(EffectSlow());

                ApplyEffectToObject( DURATION_TYPE_PERMANENT, eSlow, oPC );
            }
            if( (iStatus < 1) && (!GetLocalInt(oPC,"ku_sleeping")) ){
                AssignCommand(oPC, ActionRest(TRUE));
            }

}

void EffectDyingPC(object oPC)
{
    effect eDmg = EffectDamage(1, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oPC);
}
    
void main()
{
//==stampedLogEntry("START");
//ExecuteScript("kh_hbeat", OBJECT_SELF);
//==stampedLogEntry("AFTER kh_hbeat");

//ExecuteScript("ku_module_hb", OBJECT_SELF);


//kk
//inicializace funkci pro casovani
 SetRoundInMinute();
 SetRoundInHour();

 object oMod = GetModule();
 int iActRound = GetLocalInt(oMod,"ku_RoundInMinute"); //cislo Roundu v aktualni minute

int t = GetLocalInt(OBJECT_SELF, "TIME");

int update_database = ((t % (time_update_database*time_update_locations)) == 0);

if ( update_database )
    SetTime( GetTimeHour(), GetTimeMinute(), GetTimeSecond(), GetTimeMillisecond());


if(t % time_update_locations == 0){
    object oPC;
    location lLoc;
    int    iHP;
    string ID;
    float  fStamina;
    int i = 0;

    //==stampedLogEntry("IN time_update_locations");
    SetPersistentInt(oMod,"CURRENT_TIMESTAMP",ku_GetTimeStamp());

    oPC = GetFirstPC();
    while (GetIsObjectValid(oPC)){
        //==stampedLogEntry("in while: "+GetName(oPC));
        if(GetIsDM(oPC)){
            oPC = GetNextPC();
            continue;
        }

//kk
        if(iActRound == 3 ) { // Kontrola zmeny den/noc pro subrasy
            Subraces_ModuleHeartBeatPC(oPC);
        }

        if(iActRound == 2 )
        {
            ku_CheckXPStop(oPC);
            ku_GiveXPPerTime(oPC);
        }
//kk
        // system zavislosti na drogach
        if((t % 20)==0) ds_doHB(oPC);

        // system potreby jidla a piti
        if(t % time_pc_needs == 0){
            woundStamina(oPC, IntToFloat(time_pc_needs));
            PC_NeedsHB(oPC);
        }

        // aktualizace pozice a hp hrace
        if(t%time_upd_LOC_and_HP == 0)
        {
            lLoc   = GetLocation(oPC);
            iHP    = GetCurrentHitPoints(oPC);
            if((GetAreaFromLocation(lLoc) != OBJECT_INVALID)) SetLocalLocation(oPC, "LOCATION", lLoc);
            SetLocalInt(oPC, "HP", iHP);
        }

        // system unavy
        if(t%time_fagitue_check == 0)
        {
            FagitueCheck(oPC);
        }
        
        // umirajici postava
        if (t % time_effect_dying_pc == 0)
        {
            if (GetCurrentHitPoints(oPC) <= 0)
            {
                EffectDyingPC(oPC);
            }
        }

        // ulozeni hrace
        if(update_database){
            DelayCommand(4.0*i,SavePlayer(oPC));
        }

        oPC = GetNextPC();
        i++;
    }
}

if(update_database){
    //==stampedLogEntry("IN StoreTime");
    StoreTime();
}

SetLocalInt(OBJECT_SELF, "TIME", t+1);

  ku_EtherealsCheck();
}

