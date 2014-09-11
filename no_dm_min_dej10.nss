#include "tc_xpsystem_inc"
#include "cnr_persist_inc"

void main()
{
//SetLocalObject(OBJECT_SELF,"no_crafter",no_oPC);
object no_oPC =  GetLocalObject(GetPCSpeaker(),"no_crafter");
//zjisit xp postavy
//int TC_getXP(object oPC, int iCraftID)

int iMiningSkill = CnrGetPersistentInt(no_oPC,"iMiningSkill");
//int no_xpy = TC_getXP(no_oPC,1);
// nastavy xp postavy v craftu iCraftID
//void TC_setXP(object oPC, int iCraftID ,int nXP)

 CnrSetPersistentInt(no_oPC,"iMiningSkill",iMiningSkill+100);

    SendMessageToPC(no_oPC ,"Ziskano 10% mining skill");

    SetCustomToken(9033, "Mining skill:" + IntToString(iMiningSkill+100));
}
