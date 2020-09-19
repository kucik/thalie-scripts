//::///////////////////////////////////////////////
//:: Summon Shadow
//:: X0_S2_ShadSum.nss
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    PRESTIGE CLASS VERSION
    Spell powerful ally from the shadow plane to
    battle for the wizard
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 26, 2001
//:://////////////////////////////////////////////
void __boostSummon()
{
    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED);
    object oMaster = OBJECT_SELF;
    int iSDLevel = GetLevelByClass(CLASS_TYPE_SHADOWDANCER,oMaster);
    // Bonus vylepseni
    int iEnhant = iSDLevel/4;
    if (iEnhant > 0)
    {
        itemproperty ip = ItemPropertyEnhancementBonus(iEnhant);
        object oMyWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B,oSummon);
        if(GetIsObjectValid(oMyWeapon) )
        {
            AddItemProperty(DURATION_TYPE_PERMANENT, ip,oMyWeapon);
        }
        oMyWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L,oSummon);
        if(GetIsObjectValid(oMyWeapon) )
        {
             AddItemProperty(DURATION_TYPE_PERMANENT, ip,oMyWeapon);
        }
        oMyWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,oSummon);
        if(GetIsObjectValid(oMyWeapon) )
        {
             AddItemProperty(DURATION_TYPE_PERMANENT, ip,oMyWeapon);
        }
    }
    //Concealment
    int iConceal = 50;
    if (iSDLevel>10)
    {
        iConceal = 50+(iSDLevel-10)*3;
    }
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectConcealment(iConceal),oSummon);
    //Immunity
    int iImm;
    if (iSDLevel>10)
    {
        iImm = 40+(iSDLevel-10)*2;
    }
    else
    {
        iImm = 30+(iSDLevel-10);
    }
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING,iImm),oSummon);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING,iImm),oSummon);
    //Onhit
    if (GetHasFeat(FEAT_EPIC_EPIC_SHADOWLORD))
    {
        itemproperty ip;
        if (iSDLevel >= 19)
        {
            ip =ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ABILITY_CON,12);
        }
        else if (iSDLevel >= 17)
        {
            ip =ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ABILITY_CON,11);
        }
        if (iSDLevel >= 15)
        {
            ip =ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ABILITY_CON,10);
        }
        else //13
        {
            ip =ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ABILITY_CON,9);
        }
        object oMyWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B,OBJECT_SELF);
        if(GetIsObjectValid(oMyWeapon) )
        {
            AddItemProperty(DURATION_TYPE_PERMANENT, ip,oMyWeapon);
        }
        oMyWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L,OBJECT_SELF);
        if(GetIsObjectValid(oMyWeapon) )
        {
             AddItemProperty(DURATION_TYPE_PERMANENT, ip,oMyWeapon);
        }
        oMyWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,OBJECT_SELF);
        if(GetIsObjectValid(oMyWeapon) )
        {
             AddItemProperty(DURATION_TYPE_PERMANENT, ip,oMyWeapon);
        }
    }


}


void main()
{
    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetLevelByClass(27);
    effect eSummon;

    if (GetHasFeat(1002,OBJECT_SELF))
    {
        eSummon = EffectSummonCreature("sd_summon4",VFX_FNF_SUMMON_UNDEAD);
    }
    else if (nCasterLevel >=10)
    {
        eSummon = EffectSummonCreature("sd_summon3",VFX_FNF_SUMMON_UNDEAD);
    }
    else if (nCasterLevel >=7)
    {
        eSummon = EffectSummonCreature("sd_summon2",VFX_FNF_SUMMON_UNDEAD);
    }
    else
    {
        eSummon = EffectSummonCreature("sd_summon1",VFX_FNF_SUMMON_UNDEAD);
    }


    //Apply VFX impact and summon effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(24));
    DelayCommand(4.2,__boostSummon());
}
