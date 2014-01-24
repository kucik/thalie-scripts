#include "x2_inc_itemprop"
object oPCspeaker =GetPCSpeaker();
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");
int iDMCraftnumber =GetLocalInt(oCheck,"DMCNumber");
int iDMCraftnumber2 =GetLocalInt(oCheck,"DMCNumber2");
int iItemproperty = GetLocalInt(oCheck,"Itemproperty");


//Itemproperty Additional is left out

//between 1-12 bonus   1
itemproperty ip_AbilityBonus =ItemPropertyAbilityBonus(iDMSetNumber,iDMCraftnumber);

//between 1-20 bonus   2
itemproperty ip_ACBonus =ItemPropertyACBonus(iDMSetNumber);

//between 1-20 bonus  // group alignment  3
itemproperty ip_ACBonusVsAlign =ItemPropertyACBonusVsAlign(iDMSetNumber,iDMCraftnumber);

//between 1-20 bonus  4
itemproperty ip_ACBonusVsDmgType =ItemPropertyACBonusVsDmgType(iDMSetNumber,iDMCraftnumber);

//between 1-20 bonus   5
itemproperty ip_ACBonusVsRace =ItemPropertyACBonusVsRace(iDMSetNumber,iDMCraftnumber);

//between 1-20 bonus //specific aligment  6
itemproperty ip_ACBonusVsSAlign =ItemPropertyACBonusVsSAlign(iDMSetNumber,iDMCraftnumber);

//    7
itemproperty ip_Additional =ItemPropertyAdditional(iDMSetNumber);


// From -50 to +50 in incriments of 5 (need converting)     8
itemproperty ip_ArcaneSpellFailure =ItemPropertyArcaneSpellFailure(iDMSetNumber);

//between 1-20 bonus      9
itemproperty ip_AttackBonus =ItemPropertyAttackBonus(iDMSetNumber);

//between 1-20 bonus      10
itemproperty ip_AttackBonusVsAlign =ItemPropertyAttackBonusVsAlign(iDMSetNumber,iDMCraftnumber);

//between 1-20 bonus      11
itemproperty ip_AttackBonusVsRace =ItemPropertyAttackBonusVsRace(iDMSetNumber,iDMCraftnumber);

//between 1-20 bonus      12
itemproperty ip_AttackBonusVsSAlign =ItemPropertyAttackBonusVsSAlign(iDMSetNumber,iDMCraftnumber);

//between 1-5       13
itemproperty ip_AttackPenalty =ItemPropertyAttackPenalty(iDMSetNumber);

//      14
itemproperty ip_BonusFeat =ItemPropertyBonusFeat(iDMSetNumber);

//       15
itemproperty ip_BonusLevelSpell =ItemPropertyBonusLevelSpell(iDMSetNumber,iDMCraftnumber);

//  1-20     16
itemproperty ip_BonusSavingThrow =ItemPropertyBonusSavingThrow(iDMSetNumber,iDMCraftnumber);

//  1-20     17
itemproperty ip_BonusSavingThrowVsX =ItemPropertyBonusSavingThrowVsX(iDMSetNumber,iDMCraftnumber);

//      18
itemproperty ip_BonusSpellResistance =ItemPropertyBonusSpellResistance(iDMSetNumber);

//      19
itemproperty ip_CastSpell =ItemPropertyCastSpell(iDMSetNumber,iDMCraftnumber);

//      20
itemproperty ip_ContainerReducedWeight =ItemPropertyContainerReducedWeight(iDMSetNumber);

//      21
itemproperty ip_DamageBonus =ItemPropertyDamageBonus(iDMSetNumber,iDMCraftnumber);

//      22
itemproperty ip_DamageBonusVsAlign =ItemPropertyDamageBonusVsAlign(iDMSetNumber,iDMCraftnumber,iDMCraftnumber2);

//      23
itemproperty ip_DamageBonusVsRace =ItemPropertyDamageBonusVsRace(iDMSetNumber,iDMCraftnumber,iDMCraftnumber2);

//      24
itemproperty ip_DamageBonusVsSAlign =ItemPropertyDamageBonusVsSAlign(iDMSetNumber,iDMCraftnumber,iDMCraftnumber2);

//      25
itemproperty ip_DamageImmunity =ItemPropertyDamageImmunity(iDMSetNumber,iDMCraftnumber);

// 1-5     26
itemproperty ip_DamagePenalty =ItemPropertyDamagePenalty(iDMSetNumber);

// 27
itemproperty ip_DamageReduction =ItemPropertyDamageReduction(iDMSetNumber,iDMCraftnumber);

// 28
itemproperty ip_DamageResistance =ItemPropertyDamageResistance(iDMSetNumber,iDMCraftnumber);

// 29
itemproperty ip_DamageVulnerability =ItemPropertyDamageVulnerability(iDMSetNumber,iDMCraftnumber);

// 30
itemproperty ip_Darkvision =ItemPropertyDarkvision();

// 31
itemproperty ip_DecreaseAbility =ItemPropertyDecreaseAbility(iDMSetNumber,iDMCraftnumber);

// 32
itemproperty ip_DecreaseAC =ItemPropertyDecreaseAC(iDMSetNumber,iDMCraftnumber);

// 33
itemproperty ip_DecreaseSkill =ItemPropertyDecreaseSkill(iDMSetNumber,iDMCraftnumber);

// 34
itemproperty ip_EnhancementBonus =ItemPropertyEnhancementBonus(iDMSetNumber);

// 35
itemproperty ip_EnhancementBonusVsAlign =ItemPropertyEnhancementBonusVsAlign(iDMSetNumber,iDMCraftnumber);

// 36
itemproperty ip_EnhancementBonusVsRace =ItemPropertyEnhancementBonusVsRace(iDMSetNumber,iDMCraftnumber);

// 37
itemproperty ip_EnhancementBonusVsSAlign =ItemPropertyEnhancementBonusVsSAlign(iDMSetNumber,iDMCraftnumber);

// 38
itemproperty ip_EnhancementPenalty =ItemPropertyEnhancementPenalty(iDMSetNumber);

// 39
itemproperty ip_ExtraMeleeDamageType =ItemPropertyExtraMeleeDamageType(iDMSetNumber);

// 40
itemproperty ip_ExtraRangeDamageType =ItemPropertyExtraRangeDamageType(iDMSetNumber);

// 41
itemproperty ip_FreeAction =ItemPropertyFreeAction();

// 42
itemproperty ip_Haste =ItemPropertyHaste();

// 43
itemproperty ip_HealersKit =ItemPropertyHealersKit(iDMSetNumber);

// 44
itemproperty ip_HolyAvenger =ItemPropertyHolyAvenger();

// 45
itemproperty ip_ImmunityMisc =ItemPropertyImmunityMisc(iDMSetNumber);

// 46
itemproperty ip_ImmunityToSpellLevel =ItemPropertyImmunityToSpellLevel(iDMSetNumber);

// 47
itemproperty ip_ImprovedEvasion =ItemPropertyImprovedEvasion();

// 48
itemproperty ip_Keen =ItemPropertyKeen();

// 49
itemproperty ip_Light =ItemPropertyLight(iDMSetNumber,iDMCraftnumber);

// 50
itemproperty ip_LimitUseByAlign =ItemPropertyLimitUseByAlign(iDMSetNumber);

// 51
itemproperty ip_LimitUseByClass =ItemPropertyLimitUseByClass(iDMSetNumber);

// 52
itemproperty ip_LimitUseByRace =ItemPropertyLimitUseByRace(iDMSetNumber);

// 53
itemproperty ip_LimitUseBySAlign =ItemPropertyLimitUseBySAlign(iDMSetNumber);

// 54
itemproperty ip_MassiveCritical =ItemPropertyMassiveCritical(iDMSetNumber);

//   55
itemproperty ip_Material =ItemPropertyMaterial(iDMSetNumber);

// 56
itemproperty ip_MaxRangeStrengthMod =ItemPropertyMaxRangeStrengthMod(iDMSetNumber);

// 57
itemproperty ip_MonsterDamage =ItemPropertyMonsterDamage(iDMSetNumber);

// 58
itemproperty ip_NoDamage =ItemPropertyNoDamage();

// 59
itemproperty ip_OnHitCastSpell =ItemPropertyOnHitCastSpell(iDMSetNumber,iDMCraftnumber);

// 60
itemproperty ip_OnHitProps =ItemPropertyOnHitProps(iDMSetNumber,iDMCraftnumber,iDMCraftnumber2);

// 61
itemproperty ip_OnMonsterHitProperties =ItemPropertyOnMonsterHitProperties(iDMSetNumber,iDMCraftnumber);

// 62
itemproperty ip_Quality =ItemPropertyQuality(iDMSetNumber);


// 63
itemproperty ip_ReducedSavingThrow =ItemPropertyReducedSavingThrow(iDMSetNumber,iDMCraftnumber);

//64
itemproperty ip_ReducedSavingThrowVsX =ItemPropertyReducedSavingThrowVsX(iDMSetNumber,iDMCraftnumber);

// 65
itemproperty ip_Regeneration =ItemPropertyRegeneration(iDMSetNumber);

//66
itemproperty ip_SkillBonus =ItemPropertySkillBonus(iDMSetNumber,iDMCraftnumber);

// 67
itemproperty ip_SpecialWalk =ItemPropertySpecialWalk(iDMSetNumber);

// 68
itemproperty ip_SpellImmunitySchool =ItemPropertySpellImmunitySchool(iDMSetNumber);

// 69
itemproperty ip_SpellImmunitySpecific =ItemPropertySpellImmunitySpecific(iDMSetNumber);

// 70
itemproperty ip_ThievesTools =ItemPropertyThievesTools(iDMSetNumber);

// 71
itemproperty ip_Trap =ItemPropertyTrap(iDMSetNumber,iDMCraftnumber);

// 72
itemproperty ip_TrueSeeing =ItemPropertyTrueSeeing();

// 73
itemproperty ip_TurnResistance =ItemPropertyTurnResistance(iDMSetNumber);

// 74
itemproperty ip_UnlimitedAmmo =ItemPropertyUnlimitedAmmo(iDMSetNumber);

// 75
itemproperty ip_VampiricRegeneration =ItemPropertyVampiricRegeneration(iDMSetNumber);

// 76
itemproperty ip_VisualEffect =ItemPropertyVisualEffect(iDMSetNumber);

// 77
itemproperty ip_WeightIncrease =ItemPropertyWeightIncrease(iDMSetNumber);

// 78
itemproperty ip_WeightReduction =ItemPropertyWeightReduction(iDMSetNumber);

void RemoveAllItemproperties(object oItem)
{
itemproperty ipLoop=GetFirstItemProperty(oItem);

//Loop for as long as the ipLoop variable is valid
while (GetIsItemPropertyValid(ipLoop))
   {
     RemoveItemProperty(oItem, ipLoop);
   ipLoop=GetNextItemProperty(oItem);
   }
}

/*



*/

void main()
{
int iItemPropRemove;
itemproperty ip_addingThis;

switch(iItemproperty)
{
//   iItemPropRemove = 83;
case -78:iItemPropRemove = 11;ip_addingThis = ip_WeightReduction;break;

case -77:iItemPropRemove = 81;ip_addingThis = ip_WeightIncrease;break;

case -76:iItemPropRemove = 83;ip_addingThis = ip_VisualEffect;break;

case -75:iItemPropRemove = 67;ip_addingThis = ip_VampiricRegeneration;break;

case -74:iItemPropRemove = 61;ip_addingThis = ip_UnlimitedAmmo;break;

case -73:iItemPropRemove = 73;ip_addingThis = ip_TurnResistance;break;

case -72:iItemPropRemove = 71;ip_addingThis = ip_TrueSeeing;break;

case -71:iItemPropRemove = 70;ip_addingThis = ip_Trap;break;

case -70:iItemPropRemove = 55;ip_addingThis = ip_ThievesTools;break;

case -69:iItemPropRemove = 53;ip_addingThis = ip_SpellImmunitySpecific;break;

case -68: iItemPropRemove = 54;ip_addingThis = ip_SpellImmunitySchool;break;

case -67:iItemPropRemove = 79;ip_addingThis = ip_SpecialWalk;break;

case -66:iItemPropRemove = 52;ip_addingThis = ip_SkillBonus;break;

case -65:iItemPropRemove = 51;ip_addingThis = ip_Regeneration;break;

case -64:iItemPropRemove = 50;ip_addingThis = ip_ReducedSavingThrowVsX;break;

case -63:iItemPropRemove = 49;ip_addingThis = ip_ReducedSavingThrow;break;

case -62:iItemPropRemove = 86;ip_addingThis = ip_Quality;break;

case -61:iItemPropRemove = 72;ip_addingThis = ip_OnMonsterHitProperties;break;

case -60:iItemPropRemove = 48;ip_addingThis = ip_OnHitProps;break;

case -59:iItemPropRemove = 82;ip_addingThis = ip_OnHitCastSpell;break;

case -58:iItemPropRemove = 47;ip_addingThis = ip_NoDamage;break;

case -57:iItemPropRemove = 77;ip_addingThis = ip_MonsterDamage;break;

case -56:iItemPropRemove = 45;ip_addingThis = ip_MaxRangeStrengthMod;break;

case -55:iItemPropRemove = 85;ip_addingThis = ip_Material;break;

case -54:iItemPropRemove = 74;ip_addingThis = ip_MassiveCritical;break;

case -53:iItemPropRemove = 65;ip_addingThis = ip_LimitUseBySAlign;break;

case -52:iItemPropRemove = 64;ip_addingThis = ip_LimitUseByRace;break;

case -51:iItemPropRemove = 63;ip_addingThis = ip_LimitUseByClass;break;

case -50:iItemPropRemove = 62;ip_addingThis = ip_LimitUseByAlign;break;

case -49:iItemPropRemove = 44;ip_addingThis = ip_Light;break;

case -48:iItemPropRemove = 43;ip_addingThis = ip_Keen;break;

case -47:iItemPropRemove = 38;ip_addingThis = ip_ImprovedEvasion;break;

case -46:iItemPropRemove = 78;ip_addingThis = ip_ImmunityToSpellLevel;break;

case -45:iItemPropRemove = 37;ip_addingThis = ip_ImmunityMisc;break;

case -44:iItemPropRemove = 36;ip_addingThis = ip_HolyAvenger;break;

case -43:iItemPropRemove = 80;ip_addingThis = ip_HealersKit;break;

case -42:iItemPropRemove = 35;ip_addingThis = ip_Haste;break;

case -41:iItemPropRemove = 75;ip_addingThis = ip_FreeAction;break;

case -40:iItemPropRemove = 34;ip_addingThis = ip_ExtraRangeDamageType;break;

case -39:iItemPropRemove = 33;ip_addingThis = ip_ExtraMeleeDamageType;break;

case -38:iItemPropRemove = 10;ip_addingThis = ip_EnhancementPenalty;break;

case -37:iItemPropRemove = 9;ip_addingThis = ip_EnhancementBonusVsSAlign;break;

case -36:iItemPropRemove = 8;ip_addingThis = ip_EnhancementBonusVsRace;break;

case -35:iItemPropRemove = 7;ip_addingThis = ip_EnhancementBonusVsAlign;break;

case -34:iItemPropRemove = 6;ip_addingThis = ip_EnhancementBonus;break;

case -33:iItemPropRemove = 29;ip_addingThis = ip_DecreaseSkill;break;

case -32:iItemPropRemove = 28;ip_addingThis = ip_DecreaseAC;break;

case -31:iItemPropRemove = 27;ip_addingThis = ip_DecreaseAbility;break;

case -30:iItemPropRemove = 26;ip_addingThis = ip_Darkvision;break;

case -29:iItemPropRemove = 24;ip_addingThis = ip_DamageVulnerability;break;

case -28:iItemPropRemove = 23;ip_addingThis = ip_DamageResistance;break;

case -27:iItemPropRemove = 22;ip_addingThis = ip_DamageReduction;break;

case -26:iItemPropRemove = 21;ip_addingThis = ip_DamagePenalty;break;

case -25:iItemPropRemove = 20;ip_addingThis = ip_DamageImmunity;break;

case -24:iItemPropRemove = 19;ip_addingThis = ip_DamageBonusVsSAlign;break;

case -23:iItemPropRemove = 18;ip_addingThis = ip_DamageBonusVsRace;break;

case -22:iItemPropRemove = 17;ip_addingThis = ip_DamageBonusVsAlign;break;

case -21:iItemPropRemove = 16;ip_addingThis = ip_DamageBonus;break;

case -20:iItemPropRemove = 32;ip_addingThis = ip_ContainerReducedWeight;break;

case -19:iItemPropRemove = 15;ip_addingThis = ip_CastSpell;break;

case -18:iItemPropRemove = 39;ip_addingThis = ip_BonusSpellResistance;break;

case -17:iItemPropRemove = 41;ip_addingThis = ip_BonusSavingThrowVsX;break;

case -16:iItemPropRemove = 40;ip_addingThis = ip_BonusSavingThrow;break;

case -15:iItemPropRemove = 13;ip_addingThis = ip_BonusLevelSpell;break;

case -14:iItemPropRemove = 12;ip_addingThis = ip_BonusFeat;break;

case -13:iItemPropRemove = 60;ip_addingThis = ip_AttackPenalty;break;

case -12:iItemPropRemove = 59;ip_addingThis = ip_AttackBonusVsSAlign;break;

case -11:iItemPropRemove = 58;ip_addingThis = ip_AttackBonusVsRace;break;

case -10:iItemPropRemove = 57;ip_addingThis = ip_AttackBonusVsAlign;;break;

case -9:iItemPropRemove = 56;ip_addingThis = ip_AttackBonus;break;

case -8:iItemPropRemove = 84;ip_addingThis = ip_ArcaneSpellFailure;break;

case -7:iItemPropRemove = 87;ip_addingThis = ip_Additional;break;

case -6:iItemPropRemove = 5;ip_addingThis = ip_ACBonusVsSAlign;break;

case -5:iItemPropRemove = 4;ip_addingThis = ip_ACBonusVsRace;break;

case -4:iItemPropRemove = 3;ip_addingThis = ip_ACBonusVsDmgType;

case -3:iItemPropRemove = 2;ip_addingThis = ip_ACBonusVsAlign;break;

case -2:iItemPropRemove = 1;ip_addingThis = ip_ACBonus;break;

case -1:iItemPropRemove = 0;ip_addingThis = ip_AbilityBonus;break;

case 0: RemoveAllItemproperties(oTarget);break;

case 1:ip_addingThis = ip_AbilityBonus;break;

case 2:ip_addingThis = ip_ACBonus;break;

case 3:ip_addingThis = ip_ACBonusVsAlign;break;

case 4:ip_addingThis = ip_ACBonusVsDmgType;

case 5:ip_addingThis = ip_ACBonusVsRace;break;

case 6:ip_addingThis = ip_ACBonusVsSAlign;break;

case 7:ip_addingThis = ip_Additional;break;

case 8:ip_addingThis = ip_ArcaneSpellFailure;break;

case 9:ip_addingThis = ip_AttackBonus;break;

case 10:ip_addingThis = ip_AttackBonusVsAlign;;break;

case 11:ip_addingThis = ip_AttackBonusVsRace;break;

case 12:ip_addingThis = ip_AttackBonusVsSAlign;break;

case 13:ip_addingThis = ip_AttackPenalty;break;

case 14:ip_addingThis = ip_BonusFeat;break;

case 15:ip_addingThis = ip_BonusLevelSpell;break;

case 16:ip_addingThis = ip_BonusSavingThrow;break;

case 17:ip_addingThis = ip_BonusSavingThrowVsX;break;

case 18:ip_addingThis = ip_BonusSpellResistance;break;

case 19:ip_addingThis = ip_CastSpell;break;

case 20:ip_addingThis = ip_ContainerReducedWeight;break;

case 21:ip_addingThis = ip_DamageBonus;break;

case 22:ip_addingThis = ip_DamageBonusVsAlign;break;

case 23:ip_addingThis = ip_DamageBonusVsRace;break;

case 24:ip_addingThis = ip_DamageBonusVsSAlign;break;

case 25:ip_addingThis = ip_DamageImmunity;break;

case 26:ip_addingThis = ip_DamagePenalty;break;

case 27:ip_addingThis = ip_DamageReduction;break;

case 28:ip_addingThis = ip_DamageResistance;break;

case 29:ip_addingThis = ip_DamageVulnerability;break;

case 30:ip_addingThis = ip_Darkvision;break;

case 31:ip_addingThis = ip_DecreaseAbility;break;

case 32:ip_addingThis = ip_DecreaseAC;break;

case 33:ip_addingThis = ip_DecreaseSkill;break;

case 34:ip_addingThis = ip_EnhancementBonus;break;

case 35:ip_addingThis = ip_EnhancementBonusVsAlign;break;

case 36:ip_addingThis = ip_EnhancementBonusVsRace;break;

case 37:ip_addingThis = ip_EnhancementBonusVsSAlign;break;

case 38:ip_addingThis = ip_EnhancementPenalty;break;

case 39:ip_addingThis = ip_ExtraMeleeDamageType;break;

case 40:ip_addingThis = ip_ExtraRangeDamageType;break;

case 41:ip_addingThis = ip_FreeAction;break;

case 42:ip_addingThis = ip_Haste;break;

case 43:ip_addingThis = ip_HealersKit;break;

case 44:ip_addingThis = ip_HolyAvenger;break;

case 45:ip_addingThis = ip_ImmunityMisc;break;

case 46:ip_addingThis = ip_ImmunityToSpellLevel;break;

case 47:ip_addingThis = ip_ImprovedEvasion;break;

case 48:ip_addingThis = ip_Keen;break;

case 49:ip_addingThis = ip_Light;break;

case 50:ip_addingThis = ip_LimitUseByAlign;break;

case 51:ip_addingThis = ip_LimitUseByClass;break;

case 52:ip_addingThis = ip_LimitUseByRace;break;

case 53:ip_addingThis = ip_LimitUseBySAlign;break;

case 54:ip_addingThis = ip_MassiveCritical;break;

case 55:ip_addingThis = ip_Material;break;

case 56:ip_addingThis = ip_MaxRangeStrengthMod;break;

case 57:ip_addingThis = ip_MonsterDamage;break;

case 58:ip_addingThis = ip_NoDamage;break;

case 59:ip_addingThis = ip_OnHitCastSpell;break;

case 60:ip_addingThis = ip_OnHitProps;break;

case 61:ip_addingThis = ip_OnMonsterHitProperties;break;

case 62:ip_addingThis = ip_Quality;break;

case 63:ip_addingThis = ip_ReducedSavingThrow;break;

case 64:ip_addingThis = ip_ReducedSavingThrowVsX;break;

case 65:ip_addingThis = ip_Regeneration;break;

case 66:ip_addingThis = ip_SkillBonus;break;

case 67:ip_addingThis = ip_SpecialWalk;break;

case 68:ip_addingThis = ip_SpellImmunitySchool;break;

case 69:ip_addingThis = ip_SpellImmunitySpecific;break;

case 70:ip_addingThis = ip_ThievesTools;break;

case 71:ip_addingThis = ip_Trap;break;

case 72:ip_addingThis = ip_TrueSeeing;break;

case 73:ip_addingThis = ip_TurnResistance;break;

case 74:ip_addingThis = ip_UnlimitedAmmo;break;

case 75:ip_addingThis = ip_VampiricRegeneration;break;

case 76:ip_addingThis = ip_VisualEffect;break;

case 77:ip_addingThis = ip_WeightIncrease;break;

case 78:ip_addingThis = ip_WeightReduction;break;
}

if(iItemproperty >=1)
{
IPSafeAddItemProperty(oTarget,ip_addingThis,0.0,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,FALSE);
SetLocalInt(oCheck,"Itemproperty",0);
}
if(iItemproperty <=-1)
{
IPRemoveMatchingItemProperties(oTarget,iItemPropRemove,DURATION_TYPE_PERMANENT, GetItemPropertySubType(ip_addingThis));
SetLocalInt(oCheck,"Itemproperty",0);
}
}


