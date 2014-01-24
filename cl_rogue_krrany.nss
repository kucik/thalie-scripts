#include "sh_classes_inc"

void main()
{
    object oSaveItem    = GetSoulStone(OBJECT_SELF);
    SetLocalInt(oSaveItem,"ROGUE_MODE",ROGUE_MODE_KRVACIVE_RANY);
    SendMessageToPC(OBJECT_SELF,"Byly aktivovany krvacive rany.");
}
