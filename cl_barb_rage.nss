//::///////////////////////////////////////////////
//:: Barbarian Rage
//:: sh_barb_rage
//:: //:://////////////////////////////////////////////
/*



*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On: 14.5.2011
//:://////////////////////////////////////////////


//include pro schopnosti terryfing rage a thundering rage
//include pro barbarovy funkce
#include "sh_classes_inc"
#include "x2_i0_spells"

void CheckAndApplyEpicRageFeats(int nRounds)
{

    effect eAOE;
    if (GetHasFeat(989, OBJECT_SELF))
    {
     eAOE = EffectAreaOfEffect(AOE_MOB_FEAR,"cl_barb_terrage", "****","****");
     eAOE = ExtraordinaryEffect(eAOE);
     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eAOE,OBJECT_SELF,RoundsToSeconds(nRounds));
    }

    if (GetHasFeat(988, OBJECT_SELF))
    {
        object oWeapon =  GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
        if (GetIsObjectValid(oWeapon))
        {
           IPSafeAddItemProperty(oWeapon, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_1d8), RoundsToSeconds(nRounds), X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE,TRUE);
           IPSafeAddItemProperty(oWeapon, ItemPropertyVisualEffect(ITEM_VISUAL_SONIC), RoundsToSeconds(nRounds), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
           IPSafeAddItemProperty(oWeapon, ItemPropertyOnHitProps(IP_CONST_ONHIT_STUN,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_ONHIT_DURATION_50_PERCENT_2_ROUNDS), RoundsToSeconds(nRounds), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
        }
        oWeapon =  GetItemInSlot(INVENTORY_SLOT_LEFTHAND);

        if (GetIsObjectValid(oWeapon) )
        {
           IPSafeAddItemProperty(oWeapon, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_1d8), RoundsToSeconds(nRounds), X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE,TRUE);
           IPSafeAddItemProperty(oWeapon, ItemPropertyVisualEffect(ITEM_VISUAL_SONIC), RoundsToSeconds(nRounds), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
           IPSafeAddItemProperty(oWeapon, ItemPropertyOnHitProps(IP_CONST_ONHIT_STUN,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_ONHIT_DURATION_50_PERCENT_2_ROUNDS), RoundsToSeconds(nRounds), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
        }
     }
}

void UpdateState(object oPC)
{
  SetLocalInt(oPC,"BARBARIAN_RAGE",0);
  SendMessageToPC(oPC,"Nyni muzete zurivost opet pouzit.");
}




void main()
{
    object oSaveItem;
    if(GetIsPC(OBJECT_SELF) && !GetIsDMPossessed(OBJECT_SELF) )
      oSaveItem = GetSoulStone(OBJECT_SELF);
    else
      oSaveItem = OBJECT_SELF;
    object oPC =    OBJECT_SELF;
    int iRage = GetLocalInt(oPC,"BARBARIAN_RAGE");
    if (iRage==0)
    {
       //Declare major variables

       int iCon = GetAbilityModifier(ABILITY_CONSTITUTION);
       int nLevel = GetLevelByClass(CLASS_TYPE_BARBARIAN);
       PlayVoiceChat(VOICE_CHAT_BATTLECRY1);

       int iAB = nLevel / 4;
       if (iAB>6)
       {
         iAB = 6;
       }
       if (iAB==0)
       {
         iAB = 1;
       }
       int iDMG = nLevel / 4;
       if (iDMG>5)
       {
         iDMG = 5;
       }
       if (iDMG==0)
       {
         iDMG = 1;
       }
       int iSaves = nLevel / 8;
       int iHPbonus = 2 * nLevel;

       effect ef1 = EffectAttackIncrease(iAB);
       effect ef2 =EffectDamageIncrease(GetDamageBonusByValue(iDMG),DAMAGE_TYPE_BASE_WEAPON);
       effect eLink = EffectLinkEffects(ef1,ef2);
       if (iSaves>0)
       {
         effect ef3 = EffectSavingThrowIncrease(SAVING_THROW_WILL,iSaves);
         effect ef4 = EffectSavingThrowIncrease(SAVING_THROW_FORT,iSaves);
         eLink = EffectLinkEffects(eLink,ef3);
         eLink = EffectLinkEffects(eLink,ef4);
       }
       if (nLevel <17)
       {
         effect ef5 = EffectACDecrease(2);
         eLink = EffectLinkEffects(eLink,ef5);
       }


       if (GetHasFeat(FEAT_MIGHTY_RAGE))
       {
         effect ef7 = EffectSavingThrowIncrease(SAVING_THROW_ALL,nLevel/7);
         effect ef8 = EffectRegenerate(5,3.0);
         eLink = EffectLinkEffects(eLink,ef7);
         eLink = EffectLinkEffects(eLink,ef8);
         iHPbonus = iHPbonus + (10*nLevel);
       }
       eLink = ExtraordinaryEffect(eLink);
       int iDuration = iCon +5;

       effect ef6 = EffectTemporaryHitpoints(iHPbonus);
       ef6 = ExtraordinaryEffect(ef6);
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink,oPC,RoundsToSeconds(iDuration));
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ef6,oPC,RoundsToSeconds(iDuration));
       CheckAndApplyEpicRageFeats(iDuration);
       SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BARBARIAN_RAGE, FALSE));
       SetLocalInt(oPC,"BARBARIAN_RAGE",1);
       DelayCommand(RoundsToSeconds(iDuration+10),UpdateState(oPC));
   }
   else
   {
       SendMessageToPC(oPC,"Nyni nelze zurivost pouzit.");
   }

}





