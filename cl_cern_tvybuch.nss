//::///////////////////////////////////////////////
//:: cl_cern_tvybuch
//:://////////////////////////////////////////////
/*
   Tajemny vybuch cernokneznika - paprsek.
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

//#include "X0_I0_SPELLS"
//#include "sh_classes_inc_e"

#include "sh_effects_const"
#include "x2_inc_spellhook"
#include "me_soul_inc"
//:://////////////////////////////////////////////

void main()
{
    object oPC = OBJECT_SELF;
    int iIsBlastActive = GetLocalInt(oPC,ULOZENI_VAZAC_TAJEMNY_VYBUCH);

    if (iIsBlastActive==TRUE)
    {
        SetLocalInt(oPC,ULOZENI_VAZAC_TAJEMNY_VYBUCH,FALSE);
        SendMessageToPC(oPC,"Tajemny vybuch vypnuty.");
    }
    else
    {
        SetLocalInt(oPC,ULOZENI_VAZAC_TAJEMNY_VYBUCH,TRUE);
        SendMessageToPC(oPC,"Tajemny vybuch zapnuty.");
    }

}



