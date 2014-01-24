#include    "sh_classes_inc_e"
object oPC = GetPCSpeaker();
object oCheck = GetSoulStone(oPC);
/*

int    LANGUAGE_HALFLING        = 13;
int    LANGUAGE_IGNAN           = 14;
int    LANGUAGE_INFERNAL        = 15;
int    LANGUAGE_ORC             = 16;
int    LANGUAGE_SYLVAN          = 17;
int    LANGUAGE_TERRAN          = 18;
int    LANGUAGE_UNDERCOMMON     = 19;
*/
void main()
{
SetLocalInt(oCheck,"Language",13);
}
