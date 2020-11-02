#include "sh_classes_const"
void ActivateFeat(object oPC)
{
    SetLocalInt(oPC,"OHAVNA_BLOK",0);
}



void main()
{
    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    //kontrola na feat ohavne rany
    if (GetHasFeat(FEAT_VAZAC_OHAVNA_RANA,oPC)==FALSE) return;
    //Kontrola na orb
    object oSlotOffHand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
    if (GetIsObjectValid(oSlotOffHand)==FALSE) return;
    string sOffHandTag = GetTag(oSlotOffHand);
    if (sOffHandTag!="sys_orb1") return;

    int iBlok = GetLocalInt(oPC,"OHAVNA_BLOK");
    //Pokud je zablokovany tak konec
    if (iBlok)
    {
        return;
    }
    //Zablokuji
    SetLocalInt(oPC,"OHAVNA_BLOK",1);

    int iCasterLevel = GetLevelByClass(44,oPC) ;//vazac
    int iDice = 1+(iCasterLevel-1)/2;

    //Hlavni kod
    int iCharismaMod = GetAbilityModifier(ABILITY_CHARISMA,oPC);
    if (GetHasFeat(FEAT_VAZAC_TAJEMNY_VYBUCH2,oPC)==TRUE)
    {
        iDice = iDice +5;
    }
    if (GetHasFeat(FEAT_VAZAC_TAJEMNY_VYBUCH3,oPC)==TRUE)
    {
        iDice = iDice +5;
    }
    int iDamage = d4(iDice)+iCharismaMod;
    int iIsCritical = FALSE;
    if (GetHasFeat(FEAT_VAZAC_KRITICKY_VYBUCH,oPC)==TRUE)
    {
        if (d10() == 5)
        {
            iDamage = 2*iDamage;
            iIsCritical = TRUE;
        }
    }
    effect eDamage = EffectDamage(iDamage,DAMAGE_TYPE_MAGICAL);
    AssignCommand(oPC,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget));
    int iDuration = 3;
    if (iIsCritical)
    {
        iDuration = 5;
    }

    if (GetHasFeat(FEAT_VAZAC_OHAVNA_RANA_OSLABENI,oPC)==TRUE)
    {
        effect eVulFire = EffectDamageImmunityDecrease(DAMAGE_TYPE_FIRE,20);
        effect eVulAcid = EffectDamageImmunityDecrease(DAMAGE_TYPE_ACID,20);
        effect eVulCold = EffectDamageImmunityDecrease(DAMAGE_TYPE_COLD,20);
        effect eVulElec = EffectDamageImmunityDecrease(DAMAGE_TYPE_ELECTRICAL,20);
        effect eLink = EffectLinkEffects(eVulFire,eVulAcid);
        eLink = EffectLinkEffects(eVulCold,eLink);
        eLink = EffectLinkEffects(eVulElec,eLink);
        eLink = SupernaturalEffect(eLink);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oTarget,RoundsToSeconds(iDuration));
    }


    if ((GetHasFeat(FEAT_VAZAC_OHAVNA_RANA_ZACELENI,oPC)==TRUE)||
    (GetHasFeat(FEAT_VAZAC_OHAVNA_RANA_UNIKNUTI,oPC)==TRUE))
    {
        effect eHeal;
        int iHeal = 20;

        if (iIsCritical)
        {
            iHeal = 30;
        }
        eHeal = EffectHeal(iHeal);
        effect eHaste = EffectMovementSpeedIncrease(50);

        object oListTarget = GetFirstObjectInShape(SHAPE_SPHERE,15.0,GetLocation(oPC));
        while (GetIsObjectValid(oListTarget))
        {
            //Make faction check on the target
            if(GetIsFriend(oListTarget))
            {
                if (GetHasFeat(FEAT_VAZAC_OHAVNA_RANA_ZACELENI,oPC)==TRUE)
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oListTarget);
                }
                if (GetHasFeat(FEAT_VAZAC_OHAVNA_RANA_UNIKNUTI,oPC)==TRUE)
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eHaste,oListTarget,RoundsToSeconds(iDuration));
                }
            }
            oListTarget = GetNextObjectInShape(SHAPE_SPHERE,15.0,GetLocation(oPC));
        }
    }





    DelayCommand(30.0,ActivateFeat(oPC));
}
