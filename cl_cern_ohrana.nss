//::///////////////////////////////////////////////
//:: cl_cern_ohrana
//::///////////////////////////////////////////////
/*
   Cernokneznik - ohavna rana
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

//:://////////////////////////////////////////////
//#include "sh_classes_inc"
#include "x2_inc_spellhook"
#include "me_soul_inc"
#include "sh_effects_const"

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
    int iBonus = 1;
    if (GetHasFeat(1456)) //FEAT_CERNOKNEZNIK_INVOKACE2_DOZVUK_BOLESTI
    {
       iBonus = (GetBaseAttackBonus(OBJECT_SELF)+4) / 5;
       if(iBonus > 4)
         iBonus = 4;
    }
    SetLocalInt(OBJECT_SELF,ULOZENI_CERNOKNEZNIK_OHAVNA_RANA,iBonus);
    SendMessageToPC(OBJECT_SELF,"Aktivovana Ohavna Rana.");
}
