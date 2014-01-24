#include    "sh_classes_inc_e"
object oPC = GetPCSpeaker();
object oCheck = GetSoulStone(oPC);
/*
int    LANGUAGE_PLANT     = 20;
*/
void main()
{
SetLocalInt(oCheck,"Language",20);
}
