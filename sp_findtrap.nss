//::///////////////////////////////////////////////
//:: Find Traps
//:: NW_S0_FindTrap
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Finds and removes all traps within 30m.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 29, 2001
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    effect eVis = EffectVisualEffect(VFX_IMP_KNOCK);
    int nCnt = 1,iTrapDC,iBonus;
    object oTrap = GetNearestObject(OBJECT_TYPE_TRIGGER | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nCnt);
    int iCasterLvl = GetCasterLevel(OBJECT_SELF);
    iCasterLvl = GetThalieCaster(OBJECT_SELF,OBJECT_SELF,iCasterLvl,FALSE);
    int iBonusWis = GetAbilityModifier(ABILITY_WISDOM);
    int iBonusCha = GetAbilityModifier(ABILITY_CHARISMA);
    int iBonusInt = GetAbilityModifier(ABILITY_INTELLIGENCE);
    iBonus = iBonusCha;
    if (iBonusWis > iBonus) iBonus = iBonusWis;
    if (iBonusInt > iBonus) iBonus = iBonusInt;
    while(GetIsObjectValid(oTrap) && GetDistanceToObject(oTrap) <= 30.0)
    {
        if(GetIsTrapped(oTrap))
        {
            int iTest = d20()+iBonus+iCasterLvl;
            if (iTest>35)
            {
                iTest = 35;
            }
            if(GetTrapDisarmDC(oTrap) <= iTest)
            {
                SetTrapDetectedBy(oTrap, OBJECT_SELF);
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTrap));
                DelayCommand(2.0, SetTrapDisabled(oTrap));
            }
        }
        nCnt++;
        oTrap = GetNearestObject(OBJECT_TYPE_TRIGGER | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nCnt);
    }
}

