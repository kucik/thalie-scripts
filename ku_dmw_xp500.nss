#include "ku_libbase"

void main()
{

 object oDM = GetPCSpeaker();
 object oPC = GetLocalObject(oDM,"KU_DM_WAND_USED_TO");

 object oSoul = GetSoulStone(oPC);
 int xpk = GetLocalInt(oSoul,"ku_XPbyKill");

 SetLocalInt(oSoul,"ku_XPbyKill",xpk + 500);   //pridat 100xp za NPC

}
