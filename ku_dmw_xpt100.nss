#include "ku_libbase"

void main()
{

 object oDM = GetPCSpeaker();
 object oPC = GetLocalObject(oDM,"KU_DM_WAND_USED_TO");

 object oSoul = GetSoulStone(oPC);
 int xpt = GetLocalInt(oSoul,"ku_XPbyXPPT");

 SetLocalInt(oSoul,"ku_XPbyXPPT",xpt + 100);   //pridat 100xp za NPC

}
