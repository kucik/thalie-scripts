object oPCspeaker =GetPCSpeaker();
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");
void main()
{
int iAI_LEVEL;
if(iDMSetNumber==0)iAI_LEVEL=AI_LEVEL_DEFAULT;
if(iDMSetNumber==1)iAI_LEVEL=AI_LEVEL_VERY_LOW;
if(iDMSetNumber==2)iAI_LEVEL=AI_LEVEL_LOW;
if(iDMSetNumber==3)iAI_LEVEL=AI_LEVEL_NORMAL;
if(iDMSetNumber==4)iAI_LEVEL=AI_LEVEL_HIGH;
if(iDMSetNumber==5)iAI_LEVEL=AI_LEVEL_VERY_HIGH;
SetAILevel(oTarget,iAI_LEVEL);
}
