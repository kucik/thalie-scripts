#include "nwnx_funcs"
void main()
{
    object oNPC = OBJECT_SELF;
    int iDomainOrder= GetLocalInt(oNPC,"DOMAIN");
    object oPC = GetPCSpeaker();
    SetClericDomain(oPC,iDomainOrder,16);
}
