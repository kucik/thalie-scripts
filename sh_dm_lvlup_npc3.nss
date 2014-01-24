object oPCspeaker =GetPCSpeaker();
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");
int iClassPos1 =GetClassByPosition(1,oTarget);
int iClassPos2 =GetClassByPosition(2,oTarget);
int iClassPos3 =GetClassByPosition(1,oTarget);
int iGetStartP =GetCreatureStartingPackage(oTarget);
int iGetLevelAnimal =GetLevelByClass(CLASS_TYPE_ANIMAL,oTarget);
int iRacialtype =GetRacialType(oTarget);
int iGlevebyPos =GetLevelByPosition(3,oTarget);
void main()
{
if(iGlevebyPos >=1)iDMSetNumber=  iClassPos3;
if(iDMSetNumber == 0 && iClassPos2 !=0 && iClassPos1 !=0 && iClassPos3 !=0)
{
AdjustAlignment(oTarget,ALIGNMENT_NEUTRAL,50,FALSE);
SendMessageToPC(oPCspeaker,"THE ALIGNMENT HAS CHANGE TO MEET THE CLASS REQUIREMENT, YOU MAY HAVE TO CLICK AGAIN");
}
if(iDMSetNumber == 1 && iClassPos2 !=1 && iClassPos1 !=1 && iClassPos3 !=1)
{
AdjustAlignment(oTarget,ALIGNMENT_NEUTRAL,50,FALSE);
SendMessageToPC(oPCspeaker,"THE ALIGNMENT HAS CHANGE TO MEET THE CLASS REQUIREMENT, YOU MAY HAVE TO CLICK AGAIN");
}

if(iDMSetNumber == 3 && iClassPos2 !=3 && iClassPos1 !=3&& iClassPos3 !=3)
{
AdjustAlignment(oTarget,ALIGNMENT_NEUTRAL,50,FALSE);
SendMessageToPC(oPCspeaker,"THE ALIGNMENT HAS CHANGE TO MEET THE CLASS REQUIREMENT, YOU MAY HAVE TO CLICK AGAIN");
}
if(iDMSetNumber == 5 && iClassPos2 !=5 && iClassPos1 !=5&& iClassPos3 !=5)
{
AdjustAlignment(oTarget,ALIGNMENT_LAWFUL,50,FALSE);
SendMessageToPC(oPCspeaker,"THE ALIGNMENT HAS CHANGE TO MEET THE CLASS REQUIREMENT, YOU MAY HAVE TO CLICK AGAIN");
}
if(iDMSetNumber == 6 && iClassPos2 !=6 && iClassPos1 !=6 && iClassPos3 !=6)
{
AdjustAlignment(oTarget,ALIGNMENT_LAWFUL,50,FALSE);
AdjustAlignment(oTarget,ALIGNMENT_GOOD,50,FALSE);
SendMessageToPC(oPCspeaker,"THE ALIGNMENT HAS CHANGE TO MEET THE CLASS REQUIREMENT, YOU MAY HAVE TO CLICK AGAIN");
}
LevelUpHenchman(oTarget,iDMSetNumber,FALSE,iGetStartP);
}
