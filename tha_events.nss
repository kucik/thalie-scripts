#include "nwnx_events"
#include "sh_classes_inc"
#include "ku_hire_inc"
#include "shm_pick_pocket"
#include "quest_inc"

const float INTERVAL = 0.2;    //check interval in seconds



//declaration




void RandomBypass(object oPC)
{
    if(d2()==1)
    {
        BypassEvent();
        WriteTimestampedLogEntry("The action was cancelled");
        FloatingTextStringOnCreature("The action was cancelled", oPC, FALSE);
    }
}

void main()
{
    int nEventType = GetEventType();
//    WriteTimestampedLogEntry("NWNX Event fired: "+IntToString(nEventType)+", '"+GetName(OBJECT_SELF)+"'");
    object oPC, oTarget, oItem, oSoulStone;
    vector vTarget;
    int nSubID;
    switch(nEventType)
    {
    /*
        case EVENT_PICKPOCKET:
           oPC = OBJECT_SELF;
            oTarget = GetActionTarget();
            WriteTimestampedLogEntry(GetName(oPC)+" tried to steal from "+GetName(oTarget));
            FloatingTextStringOnCreature("You're trying to steal from "+GetName(oTarget), oPC, FALSE);

            BypassEvent();
            break;
        case EVENT_ATTACK:
            oPC = OBJECT_SELF;
            oTarget = GetActionTarget();
            WriteTimestampedLogEntry(GetName(oPC)+" attacked "+GetName(oTarget));
            FloatingTextStringOnCreature("Attacking "+GetName(oTarget), oPC, FALSE);

            break;
        case EVENT_USE_ITEM:
            oPC = OBJECT_SELF;
            oTarget = GetActionTarget();
            oItem = GetEventItem();
            vTarget = GetEventPosition();
            WriteTimestampedLogEntry(GetName(oPC)+" used item '"+GetName(oItem)+"' on "+GetName(oTarget));
            FloatingTextStringOnCreature("Using item '"+GetName(oItem)+"' on "+GetName(oTarget), oPC, FALSE);
            SendMessageToPC(oPC, "Location: "+FloatToString(vTarget.x)+"/"+FloatToString(vTarget.y)+"/"+FloatToString(vTarget.z));
            if(d2()==1)
            {
                BypassEvent();
                WriteTimestampedLogEntry("The action was cancelled");
                FloatingTextStringOnCreature("The action was cancelled", oPC, FALSE);
            }
            break;
        case EVENT_QUICKCHAT:
            oPC = OBJECT_SELF;
            nSubID = GetEventSubType();
            FloatingTextStringOnCreature("Quickchat: phrase #"+IntToString(nSubID), oPC, FALSE);
            break;   */
        /*case EVENT_EXAMINE:
            oPC = OBJECT_SELF;
            oTarget = GetActionTarget();
            WriteTimestampedLogEntry(GetName(oPC)+" examined "+GetName(oTarget));
            FloatingTextStringOnCreature(GetName(oPC)+" examined "+GetName(oTarget), oPC, FALSE);
            if(d2()==1)
            {
                BypassEvent();
                WriteTimestampedLogEntry("The action was cancelled");
                FloatingTextStringOnCreature("The action was cancelled", oPC, FALSE);
            }*
            break;     /*
        case EVENT_USE_SKILL:
            oPC = OBJECT_SELF;
            nSubID = GetEventSubType();    //SKILL_*
            oTarget = GetActionTarget();
            WriteTimestampedLogEntry(GetName(oPC)+" used skill  #"+IntToString(nSubID)+" on "+GetName(oTarget));
            FloatingTextStringOnCreature(GetName(oPC)+" used skill  #"+IntToString(nSubID)+" on "+GetName(oTarget), oPC, FALSE);
            RandomBypass(oPC);
            break;
        case EVENT_USE_FEAT:
            oPC = OBJECT_SELF;
            nSubID = GetEventSubType();   //FEAT_*
            oTarget = GetActionTarget();
            WriteTimestampedLogEntry(GetName(oPC)+" used feat  #"+IntToString(nSubID)+" on "+GetName(oTarget));
            FloatingTextStringOnCreature(GetName(oPC)+" used feat  #"+IntToString(nSubID)+" on "+GetName(oTarget), oPC, FALSE);
            RandomBypass(oPC);
            break;*/
        case EVENT_PICKPOCKET:
            oPC = OBJECT_SELF;
            oTarget = GetActionTarget();
            shm_PickPocket(oPC,oTarget);
            BypassEvent();
            break;
        case EVENT_EXAMINE:
            oPC = OBJECT_SELF;
            oTarget = GetActionTarget();
            ku_HireCheckHireLeft(oTarget);
            QUEST_QuestBoardExamine(oPC,oTarget);
            QUEST_QuestLogExamine(oTarget);
            break;

        case EVENT_TOGGLE_MODE:
            oPC = OBJECT_SELF;
            oSoulStone = GetSoulStone(oPC);
            nSubID = GetEventSubType();  //ACTION_MODE_*
            //WriteTimestampedLogEntry(GetName(oPC)+" toggled mode  #"+IntToString(nSubID));
            //FloatingTextStringOnCreature(GetName(oPC)+" toggled mode  #"+IntToString(nSubID), oPC, FALSE);
            if ((nSubID==ACTION_MODE_EXPERTISE) || (nSubID==ACTION_MODE_IMPROVED_EXPERTISE) || (nSubID==ACTION_MODE_IMPROVED_POWER_ATTACK) || (nSubID==ACTION_MODE_POWER_ATTACK))
            {
                if (GetLocalInt(oSoulStone,AKTIVNI_POSTOJ_OBRANCE) == 1)
                {
                    //odebrani efektu
                    DecrementRemainingFeatUses(oPC,FEAT_POSTOJ_TRPASLICI_OBRANCE1);
                }
            }

            if (nSubID == ACTION_MODE_STEALTH)
            {
                if(GetStealthMode(oPC)==STEALTH_MODE_ACTIVATED)
                { //Unhide penalty
                    effect e = ExtraordinaryEffect(EffectSkillDecrease( SKILL_HIDE, 100 ));
                    effect e2 = ExtraordinaryEffect(EffectSkillDecrease( SKILL_MOVE_SILENTLY, 100 ));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, e, oPC, 10.0f);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, e2, oPC, 10.0f);
                    DelayCommand(10.8,SendMessageToPC(oPC,"Nyni se lze znovu ukryt."));
                }
            }
            break;

        case EVENT_TYPE_VALIDATE_CHARACTER:
            BypassEvent();
            SetReturnValue(0);
            break;

    }
}
