//::///////////////////////////////////////////////
//:: x2_s2_whirl.nss
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Performs a whirlwind or improved whirlwind
    attack.

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-08-20
//:://////////////////////////////////////////////
//:: Updated By: GZ, Sept 09, 2003

#include "ku_libtime"


void main()
{
    object oPC = OBJECT_SELF;
    if(GetCurrentHitPoints(OBJECT_SELF) <=0) {
      return;
    }

    int iLastWhirl = GetLocalInt(OBJECT_SELF,"WHIRLWIND_LAST");
    int iStamp = ku_GetTimeStamp();
    if(iLastWhirl + 6 > iStamp) {
      SendMessageToPC(OBJECT_SELF,"Nemuzes pouzit vyrivy utok tak kratce po sobe.");
      return;
    }
    effect eEff = GetFirstEffect(oPC);
    int iEffType;
    while(GetIsEffectValid(eEff)) {
      iEffType = GetEffectType(eEff);
      switch(iEffType) {
        case EFFECT_TYPE_CONFUSED:
        case EFFECT_TYPE_DAZED:
        case EFFECT_TYPE_FRIGHTENED:
        case EFFECT_TYPE_CHARMED:
        case EFFECT_TYPE_PARALYZE:
        case EFFECT_TYPE_PETRIFY:
        case EFFECT_TYPE_SLEEP:
        case EFFECT_TYPE_STUNNED:
          SendMessageToPC(OBJECT_SELF,"V tom to stavu nemuzes pouzit vyrivy utok.");
          return;
          break;
        default:
          break;
      }
      eEff = GetNextEffect(oPC);
    }

    SetLocalInt(OBJECT_SELF,"WHIRLWIND_LAST",iStamp);

    int bImproved = (GetSpellId() == 645);// improved whirlwind

    /* Play random battle cry */
    int nSwitch = d10();
    switch (nSwitch)
    {
        case 1: PlayVoiceChat(VOICE_CHAT_BATTLECRY1); break;
        case 2: PlayVoiceChat(VOICE_CHAT_BATTLECRY2); break;
        case 3: PlayVoiceChat(VOICE_CHAT_BATTLECRY3); break;
    }

    // * GZ, Sept 09, 2003 - Added dust cloud to improved whirlwind
    if (bImproved)
    {
      effect eVis = EffectVisualEffect(460);
      DelayCommand(1.0f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,OBJECT_SELF));
    }

    DoWhirlwindAttack(TRUE,bImproved);
    // * make me resume combat

}

