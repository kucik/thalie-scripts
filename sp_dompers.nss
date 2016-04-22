//::///////////////////////////////////////////////
//:: [Dominate Person]
//:: [NW_S0_DomPers.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Will save or the target is dominated for 1 round
//:: per caster level.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 29, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 6, 2001
//:: Last Updated By: Preston Watamaniuk, On: April 10, 2001
//:: VFX Pass By: Preston W, On: June 20, 2001

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "ku_boss_inc"

void __copyAction(object oTarget, object oSummon);
void __copyAction(object oTarget, object oSummon) {
  if(!GetHasSpellEffect(SPELL_DOMINATE_PERSON,oTarget) || !GetIsObjectValid(oSummon)) {
//    SendMessageToPC(oTarget,"Free");
    SetCommandable(TRUE,oTarget);
    DestroyObject(oSummon);
    return;
  }
//  SendMessageToPC(oTarget,"Dominated");
//  AssignCommand(oTarget,ClearAllActions());

  if(GetCurrentAction(oSummon) == ACTION_ATTACKOBJECT) {
    object oEnemy = GetAttackTarget(oSummon);
    if( (GetCurrentAction(oTarget) != ACTION_ATTACKOBJECT) ||
        (GetAttackTarget(oTarget) != oEnemy) ) {
//    SetCommandable(TRUE,oTarget);
//      SendMessageToPC(oTarget,"Attack "+GetName(oEnemy));
//    SetCommandable(TRUE,oTarget);
      AssignCommand(oTarget,ClearAllActions());
      AssignCommand(oTarget,ActionAttack(oEnemy));
      SetCommandable(TRUE,oTarget);
      DelayCommand(0.01, SetCommandable(FALSE,oTarget));
    }
  }
  else {
//    SendMessageToPC(oTarget,"Follow");
//    AssignCommand(oTarget,ActionForceFollowObject(oSummon));
    SetCommandable(TRUE,oTarget);
    SetCommandable(FALSE,oTarget);
  }

//  SetCommandable(FALSE,oTarget);
  DelayCommand(1.0,__copyAction(oTarget, oSummon));
}

void __followSummon(object oTarget) {
  object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED);
  ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oSummon);
  ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY), oSummon);
//  SendMessageToPC(OBJECT_SELF,"Summon name is"+GetName(oSummon));
  AssignCommand(oTarget,ActionForceFollowObject(oSummon));

   __copyAction(oTarget, oSummon);
}

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eDom = EffectDominated();
    eDom = GetScaledEffect(eDom, oTarget);
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DOMINATED);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

    //Link duration effects
    effect eLink = EffectLinkEffects(eMind, eDom);
    eLink = EffectLinkEffects(eLink, eDur);

    effect eVis = EffectVisualEffect(VFX_IMP_DOMINATE_S);
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    nCasterLevel = GetThalieCaster(OBJECT_SELF,oTarget,nCasterLevel,FALSE);
    int nDuration = 2 + nCasterLevel/3;
    nDuration = GetScaledDuration(nDuration, oTarget);
    int nRacial = GetRacialType(oTarget);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DOMINATE_PERSON, FALSE));
    //Make sure the target is a humanoid
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        if  ((nRacial == RACIAL_TYPE_DWARF) ||
            (nRacial == RACIAL_TYPE_ELF) ||
            (nRacial == RACIAL_TYPE_GNOME) ||
            (nRacial == RACIAL_TYPE_HALFLING) ||
            (nRacial == RACIAL_TYPE_HUMAN) ||
            (nRacial == RACIAL_TYPE_HALFELF) ||
            (nRacial == RACIAL_TYPE_HALFORC))
        {
           //Make SR Check
           if (!MyResistSpell(OBJECT_SELF, oTarget))
           {
                //Make Will Save
                if (!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC()+GetThalieSpellDCBonus(OBJECT_SELF), SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF, 1.0))
                {
                    //Check for metamagic extension
                    if (nMetaMagic == METAMAGIC_EXTEND)
                    {
                        nDuration = nDuration * 2;
                    }
                    //omezeni na HD - Shaman88
                    if (GetHitDice(oTarget) > nCasterLevel || GetIsBoss(oTarget))
                    {
                       SendMessageToPC(OBJECT_SELF,"Nelze ovládnout. NPC má vyšší úroveò než je vaše úroveò sesílatele.");
                       return;
                    }
                    if(GetIsPC(oTarget)) {
                      effect eSummon = EffectSummonCreature("ku_dominated", VFX_NONE);
                      ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetLocation(oTarget), RoundsToSeconds(nDuration));
                      DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMind, oTarget, TurnsToSeconds(nDuration)));
                      DelayCommand(1.3,__followSummon(oTarget));
                    }
                    else {
                      //Apply linked effects and VFX impact
                      DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration)));
                    }
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                }
            }
        }
    }
}
