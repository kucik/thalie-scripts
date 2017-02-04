//::///////////////////////////////////////////////
//:: Sunburst
//:: X0_S0_Sunburst
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
// Brilliant globe of heat
// All creatures in the globe are blinded and
// take 6d6 damage
// Undead creatures take 1d6 damage (max 25d6)
// The blindness is permanent unless cast to remove it
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: July 23 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Andrew Nobbs May 14, 2003
//:: Last Updated By: P.A., Feb 27, 2014
//:: Notes: Changed damage to non-undead to 6d6
//:: If an vampire passed reflex check and is not insta-death,
//:: deal it with damage to non-undead units.


#include "X0_I0_SPELLS"
#include "subraces"
#include "ja_lib"
#include "ja_inc_frakce"
#include "ku_boss_inc"
float nSize =  RADIUS_SIZE_COLOSSAL;

void main()
{
    //Declare major variables
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(oCaster);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage = 0;     // dmg to be dealed to the target
    int bDoNotDoDamage; // logical variable that short-cut evaluation of code for instant-death vampires
    int nBlindDC; // defines DC for blind enemies
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    effect eHitVis = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE);
    effect eLOS = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    effect eDam;
    string sLine;
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    //Limit Caster level for the purposes of damage
    if (nCasterLvl > 25)
    {
        nCasterLvl = 25;
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eLOS, GetSpellTargetLocation());

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, nSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SUNBURST));
            //This visual effect is applied to the target object not the location as above.  This visual effect
            //represents the flame that erupts on the target not on the ground.
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHitVis, oTarget);
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {     // spell not resisted
                if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
                {    //Roll damage for each undead target
                    nDamage = MaximizeOrEmpower(6, nCasterLvl, nMetaMagic);
                }
                else
                {    // target is not unded
                    nDamage = MaximizeOrEmpower(6, 6, nMetaMagic);
                }
                bDoNotDoDamage = FALSE; // initialization
                // * if a vampire then destroy it
                if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_VAMPIRE_MALE ||
                    GetAppearanceType(oTarget) == APPEARANCE_TYPE_VAMPIRE_FEMALE ||
                    GetSubRace(oTarget) == "Vampire")
                {   // target is vampire, try to destroy it by instant-death if failed reflex save
                    if (!ReflexSave(oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_SPELL))
                    {
                        effect eDead = EffectDamage(GetCurrentHitPoints(oTarget));
                        //ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FLAME_M), oTarget);

                        //Apply epicenter explosion on caster
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eExplode, oTarget);
                      //Boss exception
                      if(GetIsBoss(oTarget))
                        DelayCommand(0.5,ApplyBossInstantKillDamage(oTarget, GetCasterLevel(OBJECT_SELF),FALSE));
                      else
                        // Apply instant-death effect
                        DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDead, oTarget));
                        bDoNotDoDamage = TRUE;    // target is destroyed, do not any other damage to it
                    }
                }
                if (bDoNotDoDamage == FALSE)
                {
                    //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
                    nDamage = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_SPELL);
                    // * Do damage
                    if (nDamage > 0)
                    {
                        //Set the damage effect
                        eDam = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
                        // Apply effects to the currently selected target.
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                        if (GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
                        {   // not undead target
                            //Set DC of blind effect
                            nBlindDC = GetSpellSaveDC();
                            // Change of DC for light-sensitive (sub)races has been cancelled.
                            // Check if the oTarget is sensivitve to bright light, if so, improve the spell's DC
                            if (GetIsPC(oTarget))
                            {  // target is PC
                              if (Subraces_GetIsCharacterFromUnderdark(oTarget)) // test for PC faction
                              { // adjust spell's DC
                                sLine = "DEBUG: Target identified as underdark PC, DC increased"; //, ID=" + ObjectToString(oTarget);  //debug
                                PrintString(sLine); //debug
                                nBlindDC = nBlindDC + 2;
                              }
                            }
                            /*
                            else
                            { // target is not PC, check if its faction is underdark
                              if (GetStringLeft(GetNPCFaction(oNPC),8) == "Podtemno");  // test for NPC faction
                              { // adjust spell's DC
                                sLine = "DEBUG: Target identified as underdark NPC, ID=" + ObjectToString(oTarget);  //debug
                                PrintString(sLine); //debug
                                nBlindDC = nBlindDC + 2;
                              }
                            }  // end of else of if GetIsPC(oTarget)
                            */

                            // * if reflex saving throw fails no blindness
                            // TO DO - CHECK LIGHT-SENSITIVE SUBRACES, IF DETECTED, IMPROVE SpellSaveDC by amount of N
                            if (!ReflexSave(oTarget, nBlindDC, SAVING_THROW_TYPE_SPELL))
                            {
                                effect eBlindness = EffectBlindness();
                                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBlindness, oTarget);
                            }
                        }  // end of else of if (GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)

                    } // end of if (nDamage > 0)
                } // end of (bDoNotDoDamage == FALSE)
            }  // end of if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
        }    // end of if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, nSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    } // end of     while (GetIsObjectValid(oTarget))
}
