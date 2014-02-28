//::///////////////////////////////////////////////
//:: Example XP2 OnActivate Script Script
//:: x2_mod_def_act
//:: (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Put into: OnItemActivate Event

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-16
//:://////////////////////////////////////////////
/*
 * rev Kucik 06.01.2008 Pridanno volani vlastniho scriptu
 */

#include "x2_inc_switches"
//#include "ku_libbase"
#include "ku_exp_time"
#include "sh_cr_potions"
#include "sh_cr_bandages"


void main()
{
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    object oTarget = GetItemActivatedTarget();
    ExecuteScript("tc_onactivate", oPC);
    ku_ItemActivated(GetItemActivator (),GetItemActivated()); //kucik - kvuli pridelovani XP za cas
    string tag = GetStringLeft(GetTag(GetItemActivated()), 12);   //ja_update_fr
    ExecuteScript("act_"+tag, OBJECT_SELF);

    // Pridano Shaman
    sh_ModuleOnActivationItemCheckElixirs(oItem,oTarget,oPC);
    sh_ModuleOnActivationItemCheckBandages(oItem,oTarget,oPC);
    //
    if( ExecuteScriptAndReturnInt("ku_mus_onact", OBJECT_SELF) ) return;
    if( ExecuteScriptAndReturnInt("ja_mod_onactivat", OBJECT_SELF) ) return;
    if( ExecuteScriptAndReturnInt("sy_mod_onitemact", OBJECT_SELF) ) return;
//  if( ExecuteScriptAndReturnInt("cnr_module_onact", OBJECT_SELF) ) return;
    if( ExecuteScriptAndReturnInt("me_nc_onactivate", OBJECT_SELF) ) return;

    ExecuteScript("kh_item_drugs", OBJECT_SELF);
//  ExecuteScript("sy_socket_item", OBJECT_SELF);
    ExecuteScript("ku_onact_item", OBJECT_SELF); // kucik funkce


}

