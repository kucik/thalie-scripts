/*
 * release Kucik 05.01.2008
 */

#include "ja_inc_meditace"
#include "ja_inc_stamina"
#include "persistence"
#include "ku_libtime"

void main()
{
  int iSleeper = GetUserDefinedEventNumber() - 6000 ;
  object oSleep = OBJECT_SELF;
  int sleeptime = GetLocalInt(oSleep,"sleeper_time_" + IntToString(iSleeper));
  object oPC = GetLocalObject(oSleep,"sleeper_pc_" + IntToString(iSleeper));
  int iSleep = GetLocalInt(oPC,"ku_sleeping");


  if(iSleep == 2 ) {
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionWait(11.0));
    SetLocalInt(oPC,"ku_sleeping",1);
    DelayCommand(10.0,SignalEvent(oSleep,EventUserDefined(6000 + iSleeper)));
    return;
  }

  if( (GetLocalLocation(oPC,"ku_LastPossition") == GetLocation(oPC)) && (iSleep == 1 ) ) {
//  if( (GetCurrentAction(oPC) == ACTION_WAIT) && (iSleep == 1 ) ) {

//        SendMessageToPC(oPC,"sleep:"+ IntToString(sleeptime)+" > "+IntToString(ku_GetTimeStamp()));
        if( sleeptime > ku_GetTimeStamp() ) { // Still sleep
            ApplyEffectToObject( DURATION_TYPE_TEMPORARY, EffectBlindness(), oPC, 15.0);
            if ((GetRacialType(oPC) != RACIAL_TYPE_ELF))
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SLEEP), oPC);
            }

            AssignCommand(oPC, ClearAllActions());
            AssignCommand(oPC, ActionWait(16.0));
            DelayCommand(15.0,SignalEvent(oSleep,EventUserDefined(6000 + iSleeper)));
        }
        else { // wake up

//            SendMessageToPC(oPC,"wake up");
            SetLocalInt(oPC,"ku_sleeping",0);
            DeleteLocalInt(oSleep,"sleeper_time_" + IntToString(iSleeper));
            DeleteLocalObject(oSleep,"sleeper_pc_" + IntToString(iSleeper));

            ForceRest(oPC);
//            SendMessageToPC(oPC,"rested");
//            if(getRestStyle(oPC) != SPANEK){
            {
                string spells = GetLocalString(oPC, "JA_REST_SPELLS");
//                SendMessageToPC(oPC,"spells:"+spells);
                pSetSpells(oPC, spells);
            }

            float mult = 0.5;   //nebezpecnost
            if(GetLocalInt(GetArea(oPC), "SAFE"))
              mult = 1.0;
            //else if(GetLocalInt(GetArea(oPC), "JA_LOCK_LONGSPAWN")) mult = 0.75;

            string zone = GetLocalString(GetArea(oPC), "REST_ZONE");
            string sMessage;
//            if(GetGender(oPC) == GENDER_FEMALE )

            if(zone == "high") {
              mult = 0.25;
              if(GetGender(oPC) == GENDER_FEMALE )
                sMessage= "Spat na takovych mistech je o zdravi. Probudila ses cela rozlamana.";
              else
                sMessage= "Spat na takovych mistech je o zdravi. Probudil ses cely rozlamany.";
            }
            else if(zone == "med") {
              mult = 0.5;
                sMessage= "Spanek za moc nestal. Neustale te rusily divne zvuky.";
            }
            else if(zone == "safe") {
              mult = 0.75;
              if(GetGender(oPC) == GENDER_FEMALE )
                sMessage= "Vyspala jsi se dobre, ale postel by byla jeste lepsi.";
              else
                sMessage= "Vyspal jsi se dobre, ale postel by byla jeste lepsi.";
            }
            else if(zone == "inn") {
              mult = 1.0;
              if(GetGender(oPC) == GENDER_FEMALE )
                sMessage= "Skvele jsi se vyspala.";
              else
                sMessage= "Skvele jsi se vyspal.";
            }
            else if(zone == "home") {
              mult = 1.0;
              if(GetGender(oPC) == GENDER_FEMALE )
                sMessage= "Skvele jsi se vyspala.";
              else
                sMessage= "Skvele jsi se vyspal.";
            }

            int lastHP = GetLocalInt(oPC, "JA_MED_HP");
            int healed = FloatToInt(GetMaxHitPoints(oPC) * mult);

            int newHP = lastHP + healed;

            int damage = GetCurrentHitPoints(oPC) - newHP;
            if(lastHP > 0 && damage > 0){
                effect e = EffectDamage( damage, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY);
                ApplyEffectToObject( DURATION_TYPE_INSTANT, e, oPC );
            }

            restoreStamina(oPC, getMaxStamina(oPC) * mult);
            SendMessageToPC(oPC,sMessage);
        }

  }
  else {
        SendMessageToPC(oPC,"Spanek byl prerusen.");
        SetLocalInt(oPC,"ku_sleeping",0);
  }
}

