#include "ja_lib"
/*
 * release Kucik 08.01.2008
 * melvik upava na novy zpusob nacitani soulstone 16.5.2009
 */
void main()
{
 object oDM = GetPCSpeaker();
 object oPC = GetLocalObject(oDM,"KU_DM_WAND_USED_TO");
 object oSoul = GetSoulStone(oPC);
 SetLocalFloat(oSoul,"KU_LOOT_GP",0.0f);
 SendMessageToPC(oDM,"Loot na postave " + GetName(oPC) + " byl vyresetovan.");
}
