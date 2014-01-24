/*
 * release Kucik 27.01.2008
 */
void main()
{
 object oDM = GetPCSpeaker();
 object oPC = GetLocalObject(oDM,"KU_DM_WAND_USED_TO");
 SetCreatureAppearanceType(oPC,GetLocalInt(oDM,"KU_DM_PC_APPEAR") + 9);
 SendMessageToPC(oDM,"Nasraven vzhled cislo:" + IntToString(GetAppearanceType(oPC)));
}
