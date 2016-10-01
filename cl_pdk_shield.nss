//::///////////////////////////////////////////////
//:: Purple Dragon Knight - Heroic Shield
//:: cl_pdk_shield.nss
//:://////////////////////////////////////////////
//::
//::
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On: 25.6.2011
//:: Edited By: Paulus
//:: Editen On: 01.10.2016
//:://////////////////////////////////////////////

void main()
{
    //Declare main variables.
    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    int iCHA = GetAbilityModifier(ABILITY_CHARISMA,OBJECT_SELF);
    int iLvl =  GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,OBJECT_SELF);
    int iDuration = 10 + iLvl + iCHA;
    int iBonus = (iLvl / 5)+1;  //AC bonus, discipline bonus
    int iBonus2 = (iLvl / 5)+2; //Concentration bonus
    
	if (GetLocalInt(oPC, "PDKHeroicTracking"))
    {
        FloatingTextStringOnCreature("Tuto schopnosti muzes na jeden cil pouzit jen jednou", oPC, FALSE);
        return;
    }
    if (oPC == oTarget)
    {
        FloatingTextStringOnCreature("Nemuzes tuto schopnost pouzit na sebe.", oPC, FALSE);
        return;
    }
    if (!GetIsFriend(oTarget))
    {
        FloatingTextStringOnCreature("Nemuzes tuto schopnost pouzit na nepritele", oPC, FALSE);
        return;
    }

	effect eDIS = EffectSkillIncrease(SKILL_DISCIPLINE, iBonus);
    effect eCONC = EffectSkillIncrease(SKILL_CONCENTRATION, iBonus2);
    effect eAC = EffectACIncrease(iBonus);
	effect eLink = EffectLinkEffects(eDIS, eCONC);
           eLink = EffectLinkEffects(eLink, eAC);
	effect eVFX = EffectVisualEffect(VFX_IMP_PDK_HEROIC_SHIELD);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(iDuration));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oTarget);
    SetLocalInt(oPC, "PDKHeroicTracking", TRUE);
    DelayCommand(RoundsToSeconds(iDuration), DeleteLocalInt(oPC, "PDKHeroicTracking"));
}
