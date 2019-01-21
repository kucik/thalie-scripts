//tag lokace mistru     -ry_thalie_mistri
//resref/tag predmetu tokenu prevodu craftu -  sys_crafttoken

#include "tc_xpsystem_inc"

void main()
{
    object oTarget = GetSpellTargetObject();
    object oDM = OBJECT_SELF;

    int i,iSkillXP;
    if (GetTag(GetArea(oTarget)) != "ry_thalie_mistri") return;
    string sTokenResRef = "sys_crafttoken";
    object oItem = GetItemPossessedBy(oTarget, sTokenResRef);
    if (GetIsObjectValid(oItem))                                //Pokud postava token vraci tak
    {
        //nacti craft
        for (i = 1; i <= 35; i++)
        {
            iSkillXP = GetLocalInt(oItem,"SYS_CRAFT_"+IntToString(i));
            TC_setXP(oTarget,i,iSkillXP);
        }
        SendMessageToPC(oDM,"Craft nacten");
        DestroyObject(oItem,0.3);
    }
    else
    {
        string sText = "";
        object oItem = CreateItemOnObject(sTokenResRef,oDM);
        //vytvor item a uloz craft
        for (i = 1; i <= 35; i++)
        {
            iSkillXP = TC_getXP(oTarget,i);
            SetLocalInt(oItem,"SYS_CRAFT_"+IntToString(i),iSkillXP);
            sText =sText + IntToString(i)+":"+IntToString(iSkillXP)+". \n";

        }
        SetDescription(oItem,sText);
        SetName(oItem,GetName(oTarget));
    }
}
