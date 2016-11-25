/*
    System spanku

 * Updates :
 * Kucik 05.01.08 - pridano spani u ohnist, pridat spanek v leze
 * jaara - 26.1.08
 * jaara - 4.2.02
 * Kucik 25.02.08
 */

#include "ja_inc_meditace"
#include "ja_inc_stamina"
#include "persistence"
#include "ku_libtime"
#include "me_pcneeds_inc"
#include "sh_feat_uses"
#include "sh_classes_inc_e"
#include "sh_feat_uses"
// doba spanku
float iSleepTime = 150.0;

// typ spanku 0=puvodni; 1=novy
int KU_SLEEP_TYPE = 1;

void main()
{

    object oPC = GetLastPCRested();
    object oSoul = GetSoulStone(oPC);
    int restType = GetLastRestEventType();
    
    string sInn = GetLocalString(GetArea(oPC), "INN");
    int insideInn = GetLocalInt(oPC, sInn);

    string zone = GetLocalString(GetArea(oPC), "REST_ZONE");
    if(zone == "") zone = "med";

    if(restType == REST_EVENTTYPE_REST_STARTED){
        int arena = ( GetTag(GetArea(oPC)) == GetLocalString( oPC, "JA_ARENA_PER" ) );
        if(arena){ //je v arene
            ForceRest(oPC);
            FloatingTextStringOnCreature("*regeneruje*", oPC);
            restoreStamina(oPC, 10000.0);
			RestoreFeatUses(oPC);
            return;
        }

        if(zone == "nosleep"){
            SendMessageToPC(oPC, "V teto lokaci nemuzes spat.");
            AssignCommand(oPC, ClearAllActions());
            return;
        }

/*        if(zone == "inn" && !insideInn){
            SendMessageToPC(oPC, "Nemuzes zde spat, dokud si nekoupis pokoj.");
            AssignCommand(oPC, ClearAllActions());
            return;
        }*/
        
        // No rest if mounted
        if (GetLocalInt(oSoul, "MOUNTED"))
        {
            SendMessageToPC(oPC, "Akci nelze provést v sedle.");
            AssignCommand(oPC, ClearAllActions());
            return;
        }

        // V techto lokacich se budem shanet po ohynku
        if( (zone == "high") ||
            (zone == "med" ) ||
            (zone == "safe") )
        {
            location lPCLoc = GetLocation(oPC);
            object oOhniste = GetFirstObjectInShape(SHAPE_SPHERE,3.0,lPCLoc,FALSE,OBJECT_TYPE_PLACEABLE);
            int iFired = 0;
            while( (GetIsObjectValid(oOhniste)) && ( iFired == 0 ) )
            {
                if( ( (GetTag(oOhniste) == "sy_ohnisko") ||
                  (GetTag(oOhniste) == "ka_pohen") )&&
                ( iFired == 0                        ) )
                {
                iFired = GetLocalInt(oOhniste,"hori");
                }
                oOhniste = GetNextObjectInShape(SHAPE_SPHERE,3.0,lPCLoc,FALSE,OBJECT_TYPE_PLACEABLE);
            }
            // pokud nenasel ohniste
            if(iFired == 0 ) {
            SendMessageToPC(oPC, "Nehori ohen, u ktereho by bylo mozne spat.");
            AssignCommand(oPC, ClearAllActions());
            return;
          }
        }

        int status = getStatusInt(oPC);

        if(zone != "home" && zone != "inn" && status > 4){
            SendMessageToPC(oPC, "Nemas chut spat.");
            AssignCommand(oPC, ClearAllActions());
            return;
        }

        if( (GetLocalInt(oPC,"ku_sleeping") == 1) && (KU_SLEEP_TYPE == 1) ) {
            AssignCommand(oPC, ClearAllActions());
            return;
        }

        ApplyEffectToObject( DURATION_TYPE_TEMPORARY, EffectBlindness(), oPC, 15.0);
        if ((GetRacialType(oPC) != RACIAL_TYPE_ELF))
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SLEEP), oPC);
        }

        if(getRestStyle(oPC) != SPANEK){// neobnovuji se kouzla
            string spells = pGetSpells(oPC);
//            SendMessageToPC(oPC,spells);
            SetLocalString(oPC, "JA_REST_SPELLS", spells);
        }
        SetLocalInt(oPC, "JA_MED_HP", GetCurrentHitPoints(oPC));

        if(KU_SLEEP_TYPE == 1) {
          object oSleep = GetObjectByTag("ku_sleepstone");
          int sleepcnt = GetLocalInt(oSleep,"sleepers");
          sleepcnt = sleepcnt % 100;
          sleepcnt++;
          SetLocalInt(oSleep,"sleepers",sleepcnt);
          SetLocalObject(oSleep,"sleeper_pc_" + IntToString(sleepcnt),oPC);
          SetLocalInt(oSleep,"sleeper_time_" + IntToString(sleepcnt),ku_GetTimeStamp(FloatToInt(iSleepTime)));
          AssignCommand(oPC, ClearAllActions());
          AssignCommand(oPC, PlayAnimation (ANIMATION_LOOPING_CUSTOM10, 1.0, iSleepTime * 10));
          SetLocalLocation(oPC,"ku_LastPossition",GetLocation(oPC));
          SetLocalInt(oPC,"ku_sleeping",2);
          DelayCommand(0.2,SignalEvent(oSleep,EventUserDefined(6000 + sleepcnt)));
        }

        DeleteLocalInt( oPC, VARNAME_ALCOHOL + "needlvl" );
        DeleteLocalInt( oPC, VARNAME_FOOD + "needlvl");
        DeleteLocalInt( oPC, VARNAME_WATER + "needlvl");
        DeleteLocalInt( oPC, "JA_STAMINA_SLOWED" );
        DeleteLocalInt( oPC, "KU_STAMINA_PENALTY" );
    }
    else if(restType == REST_EVENTTYPE_REST_FINISHED){


            float mult = 0.0;   //nebezpecnost
            if(GetLocalInt(GetArea(oPC), "SAFE")) mult = 1.0;
            //else if(GetLocalInt(GetArea(oPC), "JA_LOCK_LONGSPAWN")) mult = 0.75;

            if(zone == "high") mult = 0.25;
            else if(zone == "med") mult = 0.5;
            else if(zone == "safe") mult = 0.75;
            else if(zone == "inn" && insideInn) mult = 1.0;
            else if(zone == "home") mult = 1.0;


            if(getRestStyle(oPC) != SPANEK){
                string spells = GetLocalString(oPC, "JA_REST_SPELLS");
//                SendMessageToPC(oPC,spells);
                if(spells != "")
                    pSetSpells(oPC, spells);
            }


            int lastHP = GetLocalInt(oPC, "JA_MED_HP");
            int healed = FloatToInt(GetMaxHitPoints(oPC) * mult);

            int newHP = lastHP + healed;

            int damage = GetCurrentHitPoints(oPC) - newHP;
            if(lastHP > 0 && damage > 0){
                effect e = EffectDamage( damage, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY);
                ApplyEffectToObject( DURATION_TYPE_INSTANT, e, oPC );
            }

//            restoreStamina(oPC, getMaxStamina(oPC) * mult);
            restoreStamina(oPC, getMaxStamina(oPC));
            DeleteLocalInt(oPC, sInn);
            PC_NeedsOnRest(oPC);
            RestoreFeatUses(oPC);
            DeleteLocalInt(oSoul,"KURTIZANA_KZEMI");

            DeleteLocalInt(oPC, "JA_MED_HP");
            DeleteLocalString(oPC, "JA_REST_SPELLS");
    }
    else if(restType == REST_EVENTTYPE_REST_CANCELLED){

            if(GetLocalInt(oPC,"ku_sleeping"))
              return;

            if(getRestStyle(oPC) != SPANEK){
                string spells = GetLocalString(oPC, "JA_REST_SPELLS");
                if(spells != "")
                    pSetSpells(oPC, spells);
            }

            int lastHP = GetLocalInt(oPC, "JA_MED_HP");
            int damage = GetCurrentHitPoints(oPC) - lastHP;
            if(lastHP > 0 && damage > 0){
                effect e = EffectDamage( damage, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY);
                ApplyEffectToObject( DURATION_TYPE_INSTANT, e, oPC );
            }

            DeleteLocalInt(oPC, "JA_MED_HP");
            DeleteLocalString(oPC, "JA_REST_SPELLS");
    }

}

