#include "sh_classes_inc_e"

object oPCspeaker =GetPCSpeaker();
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");
object oSoul = GetSoulStone(oTarget);
void main()
{
SetCreatureWingType(iDMSetNumber,oTarget);
SetLocalInt(oSoul,"SUBRACE_WING_TYPE",iDMSetNumber);
}
