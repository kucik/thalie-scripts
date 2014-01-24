object oPCspeaker =GetPCSpeaker();
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");
int iClassPos =GetClassByPosition(1,oTarget);
int iGetStartP =GetCreatureStartingPackage(oTarget);
int iGetLevelAnimal =GetLevelByClass(CLASS_TYPE_ANIMAL,oTarget);
int iRacialtype =GetRacialType(oTarget);

void main()
{
LevelUpHenchman(oTarget,iClassPos,FALSE,iGetStartP);

}
