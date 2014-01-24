/*
 * release Kucik 08.01.2008
 */
#include "ja_inc_frakce"

void main()
{
 object oDM = GetPCSpeaker();
 object oPC = GetLocalObject(oDM,"KU_DM_WAND_USED_TO");
 setFactionsToPC(oPC,2);
 SendMessageToPC(oDM,"Postave " + GetName(oPC) + " byla nastavena fakce na PRITEL.");
}
