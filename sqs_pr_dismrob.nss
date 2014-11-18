#include "sqs_inc"
#include "ku_exp_inc"
#include "x0_i0_spawncond"
#include "nw_i0_generic"

void main()
{
    object oNPC = OBJECT_SELF;
    object oPC = GetLastSpeaker();
    string sAreaTag = GetTag(GetArea(oNPC));
    int iXP = GetLocalInt(oNPC,SQS_PRISONER_DISMISSANDROB_XP_VALUE);
    int iGP = GetLocalInt(oNPC,SQS_PRISONER_DISMISSANDROB_GP_VALUE);
    string sText = GetLocalString(oNPC,SQS_PRISONER_DISMISSANDROB_ANSWER);
    if(GetLocalInt(oPC, "SQS_PRISONER_COMPLETED_"+sAreaTag)) {
      SendMessageToPC(oNPC,"Tento ukol jsi jiz splnil");
      return;
    }
    if (GetIsRewardValid(oNPC,oPC)==TRUE)
    {
        if (iXP > 0)
        {
            ku_GiveXP(oPC, iXP);
        }
        if (iGP >0)
        {
            GiveGoldToCreature(oPC, iGP);
        }
        AssignCommand(oNPC,SpeakString(sText));
        DestroyObject(oNPC,1.2);
        SetSpawnInLocals(NW_FLAG_ESCAPE_LEAVE );
        ActivateFleeToExit();
    }
    else
    {
        SendMessageToPC(oNPC,"Tvoje uroven je prilis vysoka");
    }
}
