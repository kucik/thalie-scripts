//::///////////////////////////////////////////////
//:: cl_cern_esstras
//:://////////////////////////////////////////////
/*
   Cernokneznik - strasliva esence
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

//:://////////////////////////////////////////////
#include "sh_classes_inc"
#include "x2_inc_spellhook"
void main()
{
/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook

    if (GetArcaneSpellFailure(OBJECT_SELF)> 20)
    {
        return;
    }
    object oSaveItem = GetSoulStone(OBJECT_SELF);
    SetLocalInt(OBJECT_SELF,ULOZENI_CERNOKNEZNIK_TYP_ESENCE,ESENCE_STRASLIVA);
    SendMessageToPC(OBJECT_SELF,"Tajemny vybuch tvori strasliva esence.");

}
