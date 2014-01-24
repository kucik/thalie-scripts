#include "sh_classes_inc_e"
#include "cl_kurt_plav_inc"
void main()
{
    object oSoul = GetSoulStone(OBJECT_SELF);
    //int iBaseBarva = GetLocalInt(oSoul,"KURTIZANA_ZAKLADNI_BARVA");
    SetLocalInt(oSoul,"KURTIZANA_PANOVE_RADEJI_PLAVOVLASKY_VYBER",PANOVE_RADEJI_PLAVOVLASKY_VYCHOZI);
    SendMessageToPC(OBJECT_SELF,"Po meditaci budes mit puvodni barvu vlasu.");
    //SetColor(oTarget,COLOR_CHANNEL_HAIR,iDMSetNumber);
}
