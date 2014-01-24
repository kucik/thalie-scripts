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
#include "sh_classes_inc"
void main()
{
    if (GetArcaneSpellFailure(OBJECT_SELF)> 20)
    {
        return;
    }
    object oSaveItem = GetSoulStone(OBJECT_SELF);
    int iBonus = 1;
    if (GetHasFeat(FEAT_CERNOKNEZNIK_INVOKACE2_DOZVUK_BOLESTI))
    {
       iBonus = 3;
    }
    SetLocalInt(OBJECT_SELF,ULOZENI_CERNOKNEZNIK_OHAVNA_RANA,iBonus);
    SendMessageToPC(OBJECT_SELF,"Aktivovana Ohavna Rana.");
}
