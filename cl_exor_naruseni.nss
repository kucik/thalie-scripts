//::///////////////////////////////////////////////
//:: cl_exor_naruseni
//:://////////////////////////////////////////////
/*
   Naruseni magie exorcisty
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

//:://////////////////////////////////////////////
#include "sh_classes_inc"
#include "ku_libtime"

void main()
{

    object oSaveItem =  GetSoulStone(OBJECT_SELF);
    int time = ku_GetTimeStamp();
    SetLocalInt(oSaveItem,ULOZENI_EXORCISTA_NARUSENI_MAGIE,time);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, OBJECT_SELF, 9.0);
    SendMessageToPC(OBJECT_SELF,"Naruseni magie spusteno.");

}

