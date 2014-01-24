/*
 * release 08.01.2008 Kucik
 */
void main()
{
 SetLocalInt(GetPCSpeaker(),"KU_ZAKAZ_OZIVENI",TRUE);
 SendMessageToPC(GetPCSpeaker(),"Oziveni zakazano.");
}
