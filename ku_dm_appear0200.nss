/*
 * release Kucik 27.01.2008
 */
void main()
{
 object oDM = GetPCSpeaker();
 SetLocalInt(oDM,"KU_DM_PC_APPEAR",GetLocalInt(oDM,"KU_DM_PC_APPEAR") + 200);
}
