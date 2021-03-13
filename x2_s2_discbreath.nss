//::///////////////////////////////////////////////
//:: Breath Weapon for Dragon Disciple Class
//:: x2_s2_discbreath
//:: Copyright (c) 2003Bioware Corp.
//:://////////////////////////////////////////////
/*

  Damage Type is Fire
  Save is Reflex
  Shape is cone, 30' == 10m

  Level      Damage      Save
  ---------------------------
  3          2d10         19
  7          4d10         19
  10          6d10        19

  after 10:
   damage: 6d10  + 1d10 per 3 levels after 10
   savedc: increasing by 1 every 4 levels after 10



*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: June, 17, 2003
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "sh_classes_const"

void UpdateState(object oPC)
{
  SetLocalInt(oPC,"BREATH",0);
  SendMessageToPC(oPC,"Nyni muzete draci dech opet pouzit.");
}

void main()
{
    int nType = GetSpellId();
    int nDamageDice;
    int iBreath = GetLocalInt(OBJECT_SELF,"BREATH");
    if (iBreath==0)
    {
        int nLevel = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE_NEW,OBJECT_SELF)+GetLevelByClass(CLASS_TYPE_BARD,OBJECT_SELF)+GetLevelByClass(CLASS_TYPE_SORCERER,OBJECT_SELF);
        int nSaveDC = nLevel;
        if (nSaveDC > 20)
        {
            nSaveDC = 20;
        }
        nSaveDC = 10 +nSaveDC+ GetAbilityModifier(ABILITY_CONSTITUTION);
        int nDamage;

        //Declare major variables
        float fDelay;
        object oTarget;
        effect eVis, eBreath;

        eVis = EffectVisualEffect(494);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVis,GetSpellTargetLocation());

        //Get first target in spell area
        location lFinalTarget = GetSpellTargetLocation();
        if ( lFinalTarget == GetLocation(OBJECT_SELF) )
        {
            // Since the target and origin are the same, we have to determine the
            // direction of the spell from the facing of OBJECT_SELF (which is more
            // intuitive than defaulting to East everytime).

            // In order to use the direction that OBJECT_SELF is facing, we have to
            // instead we pick a point slightly in front of OBJECT_SELF as the target.
            vector lTargetPosition = GetPositionFromLocation(lFinalTarget);
            vector vFinalPosition;
            vFinalPosition.x = lTargetPosition.x +  cos(GetFacing(OBJECT_SELF));
            vFinalPosition.y = lTargetPosition.y +  sin(GetFacing(OBJECT_SELF));
            lFinalTarget = Location(GetAreaFromLocation(lFinalTarget),vFinalPosition,GetFacingFromLocation(lFinalTarget));
        }
        oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 10.0, lFinalTarget, TRUE,  OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR  | OBJECT_TYPE_PLACEABLE);

        while(GetIsObjectValid(oTarget))
        {
            nDamage = d10(nLevel);
            if(oTarget != OBJECT_SELF)
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
                //Determine effect delay
                fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
                nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nSaveDC, SAVING_THROW_TYPE_FIRE);
                if (nDamage > 0)
                {
                    //Set Damage and VFX
                    eBreath = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                    eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
                    //Apply the VFX impact and effects
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBreath, oTarget));
                 }
            }
            //Get next target in spell area
            oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 10.0, lFinalTarget, TRUE,  OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR  | OBJECT_TYPE_PLACEABLE);
        }
        SetLocalInt(OBJECT_SELF,"BREATH",1);
        int iCD = 20;
        int iRDDLevel = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE_NEW,OBJECT_SELF);
        if (iRDDLevel>10)
        {
            iCD = iCD -(iRDDLevel-10);
        }
        DelayCommand(RoundsToSeconds(iCD),UpdateState(OBJECT_SELF));
   }
   else
   {
       SendMessageToPC(OBJECT_SELF,"Nyni nelze draci dech pouzit.");
   }
}





