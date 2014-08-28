//::///////////////////////////////////////////////
//:: Boure Uderu
//:: cl_sa_boure
//:: //:://////////////////////////////////////////////
/*
    Jedna se mod - zapnuti prida sesilateli jeden utok ale snizi AB o 2.


*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On: 3.10.2012
//:://////////////////////////////////////////////


#include "sh_classes_inc"
#include "ku_weapons"

void main()
{
   object oSaveItem =  GetSoulStone(OBJECT_SELF);
   //pokud je zapnut
   if (GetLocalInt(oSaveItem,AKTIVNI_SAMURAJ_BOURE_UDERU))
   {
        int iEffect;
        effect eLoop = GetFirstEffect(OBJECT_SELF);
        while (GetIsEffectValid(eLoop))
        {
            iEffect = GetEffectSpellId(eLoop);
            if (iEffect== EFFECT_SAMURAJ_BOURE_UDERU_AB_POSTIH)
            {
                RemoveEffect(OBJECT_SELF,eLoop);
            }
            eLoop = GetNextEffect(OBJECT_SELF);
        }


        RestoreBaseAttackBonus();
        FloatingTextStringOnCreature("Boure uderu byla vypnuta.",OBJECT_SELF);
        DeleteLocalInt(oSaveItem,AKTIVNI_SAMURAJ_BOURE_UDERU);
        DeleteLocalInt(OBJECT_SELF,AKTIVNI_SAMURAJ_BOURE_UDERU); // For faster check
   }
   else  //Pokud je vypnut
   {
     // Check weapons size
     object oMainWepon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF);
     if(GetIsObjectValid(oMainWepon))
       return;
     int iSize = GetWeaponSize(GetBaseItemType(oMainWepon));
     if(iSize < 1 || iSize > 2)
       return;
            
        SetBaseAttackBonus(GetBaseAttackBonus(OBJECT_SELF)+1);
        effect eLink = EffectAttackDecrease(2);
        eLink = SupernaturalEffect(eLink);
        SetEffectSpellId(eLink,EFFECT_SAMURAJ_BOURE_UDERU_AB_POSTIH);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eLink,OBJECT_SELF);
        FloatingTextStringOnCreature("Boure uderu byla zapnuta.",OBJECT_SELF);
        SetLocalInt(oSaveItem,AKTIVNI_SAMURAJ_BOURE_UDERU,1);
        SetLocalInt(OBJECT_SELF,AKTIVNI_SAMURAJ_BOURE_UDERU,1); // For faster check
   }




}
