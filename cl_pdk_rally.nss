//::///////////////////////////////////////////////
//:: Purple Dragon Knight - Rallying Cry
//:: cl_pdk_rally.nss
//:://////////////////////////////////////////////
//::
//::
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On: 25.6.2011
//:: Update  By: Kucik
//:: Update  On: 26.09.2016
 //:://////////////////////////////////////////////
 #include "sh_classes_inc"
 #include "x0_i0_spells"

void  AddKeenEffectToWeapon(object oMyWeapon, float fDuration)
{
   IPSafeAddItemProperty(oMyWeapon,ItemPropertyKeen(), fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING ,TRUE,TRUE);
   return;
}

void __applyKeen(int iSlot, effect eVis, effect eDur, object oTarget, float fDuration) {
  if(fDuration <= 0.0)
    return;

  object oMyWeapon = GetItemInSlot(iSlot, oTarget);
  if(!GetIsObjectValid(oMyWeapon))
    return;

  /* Only gloves in arms slot */
  if(iSlot == INVENTORY_SLOT_ARMS && (GetBaseItemType(oMyWeapon) != BASE_ITEM_GLOVES))
     return;

  /* Visual effects */
  // Zakomentovat, pokud nechcem dalsi vizualizace keen efektu.
  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration);


  /* Apply keen effect */
  AddKeenEffectToWeapon(oMyWeapon,fDuration);


}


 void main()
 {
 int kontrola;
 if (GetHasEffect(EFFECT_TYPE_SILENCE,OBJECT_SELF))
 {
 // Nelze pouzit kdyz ma silence
 FloatingTextStrRefOnCreature(85764,OBJECT_SELF);
 return;
 }

 //Declare major variables
 int iCHA = GetAbilityModifier(ABILITY_CHARISMA,OBJECT_SELF);
 int iLvl = GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,OBJECT_SELF);
 int iDuration = 10 + iLvl + iCHA;
 int iBonus = (iLvl / 5)+1;
 float fDuration = RoundsToSeconds(iDuration);

 effect eAttack = EffectAttackIncrease(iBonus);// Increase attack by 1

 // +10 on 1st level and each 10. level.
 int iSpeedBonus = ((iLvl / 10) + 1) * 10;
  effect eSpeed = EffectMovementSpeedIncrease(iSpeedBonus);

  // +1 on 20, 25 and 30
  effect eDamage;
  int iDmgBonus = (iLvl - 15)/5;
  // Limit bonus on +3
  if(iDmgBonus > 3)
    iDmgBonus = 3;
  if(iDmgBonus > 0)
    eDamage = EffectDamageIncrease(3, DAMAGE_TYPE_SONIC);


  // Chceme dalsi visual keen efektu?
  effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);


 effect eLink = EffectLinkEffects(eAttack, eSpeed);// Link effects
 // Do not link if effect does not exist
 if(iDmgBonus > 0)
   eLink = EffectLinkEffects(eLink,eDamage);// Link effects

 // Extraordinary nejde dispellnout
 //eLink = ExtraordinaryEffect(eLink);// Make effects ExtraOrdinary

 effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);// Get VFX
 eLink = EffectLinkEffects(eLink, eDur);// Link effects

 // Tohle by mozna zpusobilo crash pri dispellu. ID efektu je nastavene jako ID kouzla.
// SetEffectSpellId(eLink,EFFECT_PDK); //dodano shaman88
 effect eImpact = EffectVisualEffect(VFX_IMP_PDK_GENERIC_HEAD_HIT);// Get VFX

 // Apply effect at a location
 ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PDK_RALLYING_CRY), OBJECT_SELF);
 DelayCommand(0.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PDK_GENERIC_PULSE), OBJECT_SELF));

 // Get first object in sphere
 object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
 // Keep processing until oTarget is not valid
 while(GetIsObjectValid(oTarget))
 {
   // Prohozeni priority podminek na friendly a silence pro lepsi efektivitu.
   // Neutral odstranen - jenom party members
   if((oTarget == OBJECT_SELF) || GetIsFriend(oTarget)) {

 // * GZ Oct 2003: If we are silenced, we can not benefit from bard song
     if (!GetHasEffect(EFFECT_TYPE_SILENCE,oTarget) &&
         !GetHasEffect(EFFECT_TYPE_DEAF,oTarget)) {

       //shozeni stareho effektu
       // Urcite je tu zakazane stackovani? To je schvalne?
       effect eLoop=GetFirstEffect(oTarget);
       while (GetIsEffectValid(eLoop)) {
         if (GetEffectSpellId(eLoop)==EFFECT_PDK) {
           RemoveEffect(oTarget,eLoop);

         }
         eLoop=GetNextEffect(oTarget);
       }
       // oTarget is a friend, apply effects
       DelayCommand(0.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget));
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
       // Aplikujem keen
       __applyKeen(INVENTORY_SLOT_LEFTHAND, eVis, eDur, oTarget, fDuration);
       __applyKeen(INVENTORY_SLOT_RIGHTHAND, eVis, eDur, oTarget, fDuration);
       __applyKeen(INVENTORY_SLOT_ARMS, eVis, eDur, oTarget, fDuration);
     }
   }
   // Get next object in the sphere
   oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
   }
 }
