//tag lokace mistru     -ry_thalie_mistri
//resref/tag predmetu tokenu prevodu craftu -  sys_crafttoken

#include "tc_xpsystem_inc"

void main()
{
    int i,iSkillXP;
    object oPC = GetLastUsedBy();
    if (GetTag(GetArea(oPC)) != "ry_thalie_mistri") return;
    string sTokenResRef = "sys_crafttoken";
    object oItem = GetItemPossessedBy(oPC, sTokenResRef);
    if (GetIsObjectValid(oItem))                                //Pokud postava token vraci tak
    {
        //nacti craft
        for (i = 1; i <= 35; i++)
        {
            iSkillXP = GetLocalInt(oItem,"SYS_CRAFT_"+IntToString(i));
            TC_setXP(oItem,i,iSkillXP);
        }
        SendMessageToPC(oPC,"Craft nacten");

    }
    else
    {
        object oItem = CreateItemOnObject(sTokenResRef,oPC);
        //vytvor item a uloz craft
        for (i = 1; i <= 35; i++)
        {
            iSkillXP = TC_getXP(oItem,i);
            SetLocalInt(oItem,"SYS_CRAFT_"+IntToString(i),iSkillXP);

        }
        SendMessageToPC(oPC,"Craft ulozen");
    }
}
