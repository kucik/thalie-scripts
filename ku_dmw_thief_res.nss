/*
 * release Kucik 29.01.2008
 */
 #include "ja_lib"

/*
 * melvik upava na novy zpusob nacitani soulstone 16.5.2009
 */
void main()
{
 object oDM = GetPCSpeaker();
 object oPC = GetLocalObject(oDM,"KU_DM_WAND_USED_TO");
 SetLocalInt(GetSoulStone(oPC),"KU_ZLODEJ",FALSE);
 SetLocalInt(GetSoulStone(oPC),"KU_STOLECNT",0);
 SendMessageToPC(oDM,"Kradeni na postave " + GetName(oPC) + " bylo vyresetovano.");
}
