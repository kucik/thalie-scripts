#include    "sh_classes_inc_e"
object oPC = GetPCSpeaker();
object oCheck = GetSoulStone(oPC);
/*


int    LANGUAGE_DRACONIC        = 5;
int    LANGUAGE_DRUIDIC         = 6;
int    LANGUAGE_DWARVEN         = 7;
int    LANGUAGE_ELVEN           = 8;
int    LANGUAGE_GIANT           = 9;
int    LANGUAGE_GNOME           = 10;
int    LANGUAGE_GOBLIN          = 11;
int    LANGUAGE_GNOLL           = 12;
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
SetLocalInt(oCheck,"Language",5);
}
