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
            TC_setXP(oPC,i,iSkillXP);
        }
        SendMessageToPC(oPC,"Craft nacten");
        SendMessageToAllDMs("Craft nacten");

    }
    else
    {
        string sText = "";
        object oItem = CreateItemOnObject(sTokenResRef,oPC);
        //vytvor item a uloz craft
        for (i = 1; i <= 35; i++)
        {
            iSkillXP = TC_getXP(oPC,i);
            SetLocalInt(oItem,"SYS_CRAFT_"+IntToString(i),iSkillXP);
            sText =sText + IntToString(i)+":"+IntToString(iSkillXP)+". \n";

        }
        SetDescription(oItem,sText);
        SetName(oItem,GetName(oPC));
        SendMessageToPC(oPC,"Craft ulozen");
        SendMessageToAllDMs("Craft ulozen");
    }
}
