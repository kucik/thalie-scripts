//::///////////////////////////////////////////////
//:: Summon Creature Series
//:: NW_S0_Summon
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Carries out the summoning of the appropriate
    creature for the Summon Monster Series of spells
    1 to 9
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 8, 2002
//:://////////////////////////////////////////////

effect SetSummonEffect(int nSpellID);

#include "x2_inc_spellhook"
//#include "sh_classes_const"
#include "nwnx_funcs"
#include "me_soul_inc"

int __getSummonLevel(int SpellID){
    int sSumon = 0;

    switch (SpellID){
     case SPELL_SUMMON_CREATURE_I :  sSumon = 1; break;
     case SPELL_SUMMON_CREATURE_II:  sSumon = 2; break;
     case SPELL_SUMMON_CREATURE_III: sSumon = 3; break;
     case SPELL_SUMMON_CREATURE_IV: sSumon = 4; break;
     case SPELL_SUMMON_CREATURE_V: sSumon = 5; break;
     case SPELL_SUMMON_CREATURE_VI: sSumon = 6; break;
     case SPELL_SUMMON_CREATURE_VII: sSumon = 7; break;
     case SPELL_SUMMON_CREATURE_VIII: sSumon = 8; break;
     case SPELL_SUMMON_CREATURE_IX: sSumon = 9; break;
    }
    return sSumon;
}

int __getSummonEffect(int SpellID) {
 switch (SpellID){
     case SPELL_SUMMON_CREATURE_I :
     case SPELL_SUMMON_CREATURE_II:
     case SPELL_SUMMON_CREATURE_III: return VFX_FNF_SUMMON_MONSTER_1;
     case SPELL_SUMMON_CREATURE_IV:
     case SPELL_SUMMON_CREATURE_V:   return VFX_FNF_SUMMON_MONSTER_2;
     case SPELL_SUMMON_CREATURE_VI:
     case SPELL_SUMMON_CREATURE_VII:
     case SPELL_SUMMON_CREATURE_VIII:
     case SPELL_SUMMON_CREATURE_IX:  return VFX_FNF_SUMMON_MONSTER_3;
 }

  // fallback value
 return VFX_FNF_SUMMON_MONSTER_1;
}

string __chooseSummon(int iLevel) {
  object oCaster = OBJECT_SELF;
  string sSummon = "";
  if(GetIsPC(oCaster)) {
    object oSoul = GetSoulStone(oCaster);
    sSummon = GetLocalString(oSoul,"KU_SUMMON_"+IntToString(iLevel));
  }

  if(sSummon != "")
    return sSummon;


  // If summon is not set or it's not PC
  int iRow;
  //Clerics summon planars
  if( GetLastSpellCastClass() == CLASS_TYPE_CLERIC ) {
    // little bit hardcoded 2da lines
    switch(GetAlignmentGoodEvil(oCaster)) {
      case ALIGNMENT_GOOD:    iRow = 45; break; // + iLevel - 1;
      case ALIGNMENT_NEUTRAL: iRow = 54; break; // + iLevel - 1;
      case ALIGNMENT_EVIL:    iRow = 63; break; // + iLevel - 1;
      default: iRow = 0; //fallback
    }
  }
  else {
    iRow = (Random(4) * 9);
  }

  sSummon = Get2DAString("summon","BASERESREF",iRow);
  sSummon = sSummon+"0"+IntToString(iLevel);
  return sSummon;
}

void __boostSummon() {
    // Boost summon
    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED);
    SendMessageToPC(OBJECT_SELF,"Summon name is"+GetName(oSummon));
    if (GetHasFeat(1478 )) //FEAT_GENERAL_POSILENE_VYVOLAVANI
    {
        SetAbilityScore(oSummon,ABILITY_STRENGTH,GetAbilityScore(oSummon,ABILITY_STRENGTH,TRUE)+4);
        SetAbilityScore(oSummon,ABILITY_CONSTITUTION,GetAbilityScore(oSummon,ABILITY_CONSTITUTION,TRUE)+4);
    }
    SetName(oSummon,"Povolany");

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
    int nSpellID = GetSpellId();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    nDuration = GetThalieCaster(OBJECT_SELF,OBJECT_SELF,nDuration);
    if(nDuration == 1)
    {
        nDuration = 2;
    }
    int iSummoningLevel = __getSummonLevel(nSpellID);

    //Make metamagic check for extend
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Apply the VFX impact and summon effect

    string sSummon = __chooseSummon(iSummoningLevel);
    int nFNF_Effect = __getSummonEffect(nSpellID);
    effect eSummon = EffectSummonCreature(sSummon, nFNF_Effect);

    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));

    DelayCommand(0.2,__boostSummon());
}

