#include "sh_classes_inc_e"
object oPCspeaker =GetPCSpeaker();
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
object oSoul = GetSoulStone(oTarget);
int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");
void main()
{
SetCreatureTailType(iDMSetNumber,oTarget);
SetLocalInt(oSoul,"SUBRACE_TAIL_TYPE",iDMSetNumber);
}
