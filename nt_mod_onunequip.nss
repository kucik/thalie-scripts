//script sa aktivuje ak PC odlozi veci do batohu (len pre equip veci)
//tento script patri do modules->OnPlayerUnEquip
/*
 * rev. Kucik 24.01.2008 Postihy zbrani.
 */

#include "x2_inc_switches"
#include "sy_main_lib"
#include "sh_classes_inc"
void main()
{
    object oItem = GetPCItemLastUnequipped();
    object oPC   = GetPCItemLastUnequippedBy();
    OnUnEquipClassSystem(oPC,oItem);
    //sy_on_unequip (oPC, oItem);
    //pytel na hlavu - perma slepota
    if (GetTag(oItem)=="sys_blind_helmet")
    {
        effect ef = GetFirstEffect(oPC);
        while (GetIsEffectValid(ef))
        {
            if (GetEffectSpellId(ef)==EFFECT_PYTEL_NA_HLAVU)
            {
                RemoveEffect(oPC,ef);
            }
            ef = GetNextEffect(oPC);
        }
    }
    int bByItem=FALSE;
    int iItemType=GetBaseItemType(oItem);

    object oMod = GetModule();
    if(GetLocalInt(oMod,"KU_WEAPON_REQ_"+IntToString(iItemType)))
      bByItem = TRUE;

   /*
    if(bByItem) {
      SetLocalObject(oItem,"KU_OWNER",oPC);
      SetLocalInt(oItem,"KU_WPENALTY",0);
      ExecuteScript("ku_weapon_equip",oItem);
    }*/

   // Shinobi - boure uderu
   if(GetLocalInt(oPC,AKTIVNI_SAMURAJ_BOURE_UDERU))
     ExecuteScript("cl_sa_boure", oPC);  // stop this of weapon switched
}


