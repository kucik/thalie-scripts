#include "nwnx_events"
#include "sh_classes_inc"
#include "ku_hire_inc"
#include "shm_pick_pocket"

void ZrusSDRychlost(object oPC)
{
        if (GetStealthMode(oPC)==STEALTH_MODE_DISABLED)
        {
            effect eLoop=GetFirstEffect(oPC);
            while (GetIsEffectValid(eLoop))
            {
                if (GetEffectSpellId(eLoop)==EFFECT_SD_RYCHLOST)
                {
                    RemoveEffect(oPC, eLoop);

                }
                eLoop=GetNextEffect(oPC);

            }
        }
        else
        {
         DelayCommand(6.0,ZrusSDRychlost(oPC));

        }

}

/*
Prida rychlost SD - v hispu,
vola rekurzivne funkci ZrusSDRychlost v sh_classes_inc_e
*/
void ApplyShadowDancerRychlost(object oPC)
{
        int iLevel = GetLevelByClass(CLASS_TYPE_SHADOWDANCER,oPC);
        effect rychlost = EffectMovementSpeedIncrease(20+iLevel);
        effect eLink = ExtraordinaryEffect(rychlost);

        SetEffectSpellId(eLink,EFFECT_SD_RYCHLOST);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);
        DelayCommand(6.0,ZrusSDRychlost(oPC));
}
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
            break;
        case EVENT_EXAMINE:
            oPC = OBJECT_SELF;
            oTarget = GetActionTarget();

            WriteTimestampedLogEntry(GetName(oPC)+" examined "+GetName(oTarget));
            FloatingTextStringOnCreature(GetName(oPC)+" examined "+GetName(oTarget), oPC, FALSE);
            if(d2()==1)
            {
                BypassEvent();
                WriteTimestampedLogEntry("The action was cancelled");
                FloatingTextStringOnCreature("The action was cancelled", oPC, FALSE);
            }
            break;
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
                    DelayCommand(1.0,DD_RemoveStance(oPC,oSoulStone));
                    DecrementRemainingFeatUses(oPC,FEAT_POSTOJ_TRPASLICI_OBRANCE1);
                }
            }

            if (nSubID == ACTION_MODE_STEALTH)
            {
                if(GetStealthMode(oPC)==STEALTH_MODE_ACTIVATED) { //Unhide penalty
                    effect e = ExtraordinaryEffect(EffectSkillDecrease( SKILL_HIDE, 50 ));
                    effect e2 = ExtraordinaryEffect(EffectSkillDecrease( SKILL_MOVE_SILENTLY, 50 ));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, e, oPC, 6.0f);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, e2, oPC, 6.0f);
                }

                if (GetLevelByClass(CLASS_TYPE_SHADOWDANCER,oPC)>=1) //Hide
                {
                    if (GetStealthMode(oPC)==STEALTH_MODE_DISABLED)
                    {
                         ApplyShadowDancerRychlost(oPC);
                    }
                    else if (GetStealthMode(oPC)==STEALTH_MODE_ACTIVATED)
                    {
                        ZrusSDRychlost(oPC);
                    }
                }
            }


            /*Sermir Propracovana obrana*/
            if (GetHasFeat(FEAT_SERMIR_PROPRACOVANA_OBRANA,oPC)==TRUE && nSubID == ACTION_MODE_PARRY)
            {

                if (GetActionMode(oPC, ACTION_MODE_PARRY)== FALSE)
                {
                    int iCasterLevel = GetLevelByClass(CLASS_TYPE_SERMIR,oPC);
                    int iBonus = (iCasterLevel/5)+1;
                    effect ef = EffectACIncrease(iBonus);
                    effect eLink = ExtraordinaryEffect(ef);
                    SetEffectSpellId(eLink,EFFECT_SERMIR_PROPRACOVANA_OBRANA_DODGE_AC);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);

                }
                else
                {
                      int iEffect;
                      effect eLoop = GetFirstEffect(oPC);
                      while (GetIsEffectValid(eLoop))
                      {
                        iEffect = GetEffectSpellId(eLoop);
                        if
                        (iEffect== EFFECT_SERMIR_PROPRACOVANA_OBRANA_DODGE_AC)

                        {
                            RemoveEffect(oPC,eLoop);
                        }
                        eLoop = GetNextEffect(oPC);
                     }
                }
            }




            //RandomBypass(oPC);

            break;

        case EVENT_TYPE_VALIDATE_CHARACTER:
            BypassEvent();
            SetReturnValue(0);
            break;

    }
}
