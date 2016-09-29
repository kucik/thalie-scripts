//::///////////////////////////////////////////////
//:: Purple Dragon Knight - Oath of wrath
//:: cl_pdk_wrath.nss
//:://////////////////////////////////////////////
//::
//::
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On: 25.6.2011
//:://////////////////////////////////////////////



void main()
{
    //Declare main variables.
    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();// Target

    if (oPC == oTarget)
    {
         FloatingTextStringOnCreature("Nemuzes tuto schopnost pouzit na sebe.", oPC, FALSE);
         return;
    }
    if (GetIsFriend(oTarget))
    {
         FloatingTextStringOnCreature("Nemuzes tuto schopnost pouzit na spojence.", oPC, FALSE);
         return;
    }
    // Dodano shaman88
    int iCHA = GetAbilityModifier(ABILITY_CHARISMA,OBJECT_SELF);
    int iLvl =  GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,OBJECT_SELF);
    int iDuration = 10 + iLvl + iCHA;
    int iBonus = (iLvl / 5)+1;


    int nRace = GetRacialType(oTarget);// Get race of target
    int nClass = GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT, oPC);


    effect eAttack = EffectAttackIncrease(iBonus);// Increase attack
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, iBonus);// Increase saving throws
    effect eSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, iBonus);    // Increase skills
    effect eAC = EffectACIncrease(iBonus);
    // Create 'versis racial type' effects
    eAttack = VersusRacialTypeEffect(eAttack, nRace);
    eSave = VersusRacialTypeEffect(eSave, nRace);
    eSkill = VersusRacialTypeEffect(eSkill, nRace);
    eAC = VersusRacialTypeEffect(eAC, nRace);
    // Apply effects to caster
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAttack, oPC, RoundsToSeconds(iDuration));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSave, oPC, RoundsToSeconds(iDuration));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSkill, oPC, RoundsToSeconds(iDuration));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAC, oPC, RoundsToSeconds(iDuration));

    // apply fx
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PDK_OATH), oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PDK_WRATH), oTarget);
}
