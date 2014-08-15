#include "tc_xpsystem_inc"
#include "me_soul_inc"

void main()
{
//SetLocalObject(OBJECT_SELF,"no_crafter",no_oPC);
object no_oPC =  GetLocalObject(GetPCSpeaker(),"no_crafter");
//zjisit xp postavy
//int TC_getXP(object oPC, int iCraftID)

int no_xpy = TC_getXP(no_oPC,21);
// nastavy xp postavy v craftu iCraftID
//void TC_setXP(object oPC, int iCraftID ,int nXP)

TC_setXP(no_oPC,21 ,no_xpy  - 500);
int no_level =  TC_getLevel(no_oPC,21);

    SendMessageToPC(no_oPC ,"Odebrano 500 craftovych xp v drevarine");
    SendMessageToPC(no_oPC , "V drevarine si na " + IntToString(no_level) + "urovni.");
    SendMessageToPC(no_oPC ,"Celkem jsi ziskal " + IntToString(no_xpy - 500) + " XP" );
SetCustomToken(9023, "Drevarina:" + IntToString(no_xpy -500) + " xp = " + IntToString(no_level) + ". lvl");

SetPersistentInt(no_oPC,"tcXPSystem" + IntToString(21),no_xpy - 500,0);
SendMessageToPC(no_oPC ,"Do databaze ulozeno " + IntToString(no_xpy - 500) + " craftovych xp ");
}
