#include "sh_deity_inc"
void main()
{
    object oNPC = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    DialogSetDomain(oPC,oNPC,5);
}
