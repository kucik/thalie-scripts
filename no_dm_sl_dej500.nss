#include "tc_xpsystem_inc"

void main()
{
//SetLocalObject(OBJECT_SELF,"no_crafter",no_oPC);
object no_oPC =  GetLocalObject(GetPCSpeaker(),"no_crafter");
//zjisit xp postavy
//int TC_getXP(object oPC, int iCraftID)

int no_xpy = TC_getXP(no_oPC,20);
// nastavy xp postavy v craftu iCraftID
//void TC_setXP(object oPC, int iCraftID ,int nXP)

TC_setXP(no_oPC,20 ,no_xpy + 500);
int no_level =  TC_getLevel(no_oPC,20);

    SendMessageToPC(no_oPC ,"Ziskano 500 craftovych xp ve slevarenstvi");
    SendMessageToPC(no_oPC , "Ve slevarenstvi si na " + IntToString(no_level) + "urovni.");
    SendMessageToPC(no_oPC ,"Celkem jsi ziskal " + IntToString(no_xpy + 500) + " XP" );
SetCustomToken(9026, "Slevarenstvi:" + IntToString(no_xpy +500) + " xp = " + IntToString(no_level) + ". lvl");
}
