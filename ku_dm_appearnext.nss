/*
 * release Kucik 26.01.2008
 */
void main()
{
 object oDM = GetPCSpeaker();
 object oPC = GetLocalObject(oDM,"KU_DM_WAND_USED_TO");
 SetCreatureAppearanceType(oPC,GetAppearanceType(oPC) + 1);
 SendMessageToPC(oDM,"Vzhled cislo:" + IntToString(GetAppearanceType(oPC)));
}
