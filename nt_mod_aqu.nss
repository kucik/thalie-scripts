//::///////////////////////////////////////////////
//:: Example XP2 OnItemAcquireScript
//:: x2_mod_def_aqu
//:: (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Put into: OnItemAcquire Event

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-16
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "me_ncr_on_aquinc"
void main()
{
     object oItem = GetModuleItemAcquired();
     ExecuteScript("ku_m_onacquired",OBJECT_SELF);
/*
     // ncraft - start (me_ncr_on_aquinc)
     object oMod=GetModule();
     object oPC = GetModuleItemAcquiredBy(); //GetItemPossessor(oItem);
     object oLast = GetModuleItemAcquiredFrom();

     doWithAquiredItem(oItem,oPC,oLast,oMod);
     // ncraft - end
*/
     // * Generic Item Script Execution Code
     // * If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
     // * it will execute a script that has the same name as the item's tag
     // * inside this script you can manage scripts for all events by checking against
     // * GetUserDefinedItemEventNumber(). See x2_it_example.nss
     if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
     {
        object oItem = GetModuleItemAcquired();
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_ACQUIRE);
        int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
           return;
        }

     }

}


