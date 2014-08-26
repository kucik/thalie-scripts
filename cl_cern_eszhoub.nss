//::///////////////////////////////////////////////
//:: cl_cern_eszhoub
//:://////////////////////////////////////////////
/*
   Cernokneznik - zhoubna esence
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

//:://////////////////////////////////////////////
#include "sh_effects_const"
#include "x2_inc_spellhook"
#include "me_soul_inc"
void main()
{
    if (GetArcaneSpellFailure(OBJECT_SELF)> 20)
    {
        return;
    }
    object oSaveItem = GetSoulStone(OBJECT_SELF);
    SetLocalInt(OBJECT_SELF,ULOZENI_CERNOKNEZNIK_TYP_ESENCE,ESENCE_ZHOUBNA);
    SendMessageToPC(OBJECT_SELF,"Tajemny vybuch tvori zhoubna esence.");

}
