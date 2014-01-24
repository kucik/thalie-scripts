#include "sh_classes_inc"

void main()
{
    object oSaveItem    = GetSoulStone(OBJECT_SELF);
    SetLocalInt(oSaveItem,"ROGUE_MODE",ROGUE_MODE_UTISENI);
    SendMessageToPC(OBJECT_SELF,"Bylo aktivavano utiseni.");
}
