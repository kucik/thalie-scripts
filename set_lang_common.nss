#include    "sh_classes_inc_e"
object oPC = GetPCSpeaker();
object oCheck = GetSoulStone(oPC);

void main()
{
SetLocalInt(oCheck,"Language",0);
}
