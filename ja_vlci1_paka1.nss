#include "ja_lib"

void surprise(object oPortal){
 effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2); //portal effect
 ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oPortal));

 CreateObject(OBJECT_TYPE_CREATURE, "ry_prizr_vlkod", GetLocation(oPortal));
}

void main()
{
    if(doOnce()) return;

    ExecuteScript("zep_onoff", OBJECT_SELF);      //play animation

    //earthquake
    FXWand_Earthquake(OBJECT_SELF);

    //create portal
    object oPortalWP = GetNearestObjectByTag("JA_VLCI_PORTAL1_WP");
    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "ja_vlci_portal1", GetLocation(oPortalWP));

    //send a message ;)
    float fDelay = IntToFloat(Random(10)+5);
    DelayCommand(fDelay, surprise(oPortal));
}
