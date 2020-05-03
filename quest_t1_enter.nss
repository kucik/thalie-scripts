#include "quest_inc"
//Aplikovat vstup do specialniho triggeru - tasktype 1
void main()
{
    object oPC = GetEnteringObject();
    object oTrigger = OBJECT_SELF;
    QUEST_ProcessTaskType1(oPC,oTrigger);
}
