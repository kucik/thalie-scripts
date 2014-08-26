//::///////////////////////////////////////////////
//:: cl_cern_esoslep
//:://////////////////////////////////////////////
/*
   Cernokneznik - pekelna esence
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
    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    if (GetArcaneSpellFailure(OBJECT_SELF)> 20)
    {
        return;
    }
    object oSaveItem = GetSoulStone(OBJECT_SELF);
    SetLocalInt(OBJECT_SELF,ULOZENI_CERNOKNEZNIK_TYP_ESENCE,ESENCE_PEKELNA);
    SendMessageToPC(OBJECT_SELF,"Tajemny vybuch tvori pekelna esence.");

}
