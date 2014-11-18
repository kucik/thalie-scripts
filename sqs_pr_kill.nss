#include "sqs_inc"
void main()
{
    object oNPC = OBJECT_SELF;
    object oPC = GetLastSpeaker();
    string sText = GetLocalString(oNPC,SQS_PRISONER_KILL_ANSWER);

    AssignCommand(oNPC,SpeakString(sText));
    SetIsTemporaryEnemy(oPC,oNPC);
    SetIsTemporaryEnemy(oNPC,oPC);
}
