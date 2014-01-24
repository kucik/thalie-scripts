#include    "sh_classes_inc_e"
object oPC = GetPCSpeaker();
object oCheck = GetSoulStone(oPC);
/*

int    LANGUAGE_SYLVAN          = 17;
int    LANGUAGE_TERRAN          = 18;
int    LANGUAGE_UNDERCOMMON     = 19;
*/
void main()
{
SetLocalInt(oCheck,"Language",17);
}
