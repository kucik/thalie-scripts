#include "sh_classes_inc_e"
#include "sh_effects_const"
int UseElixir(object oPC, object oTarget, object oSoul, int iElixirStr)
{
    int iCon = GetAbilityScore(oTarget,ABILITY_CONSTITUTION,FALSE);
    int iMaxPoints = iCon*30+GetHitDice(oTarget)*10;
    int iFreePoints = GetLocalInt(oSoul,"SH_ELIXIR_POINTS");
    if (!iFreePoints)
    {
        SetLocalInt(oSoul,"SH_ELIXIR_POINTS",iMaxPoints);
        iFreePoints = GetLocalInt(oSoul,"SH_ELIXIR_POINTS");
    }
    float iPercent = IntToFloat(iFreePoints)/IntToFloat(iMaxPoints);

    //vypis
    if (iFreePoints >= iElixirStr)
    {
        SetLocalInt(oSoul,"SH_ELIXIR_POINTS",iFreePoints-iElixirStr);
        effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
        if (iPercent>= 0.75)
        {
        SendMessageToPC(oPC, GetName(oTarget)+": elixiry muze pouzivat normalne.");
        }
        else if (iPercent>= 0.50)
        {
            SendMessageToPC(oPC, GetName(oTarget)+": lektvary prestavaji chutnat.");
        }
        else if (iPercent>= 0.25)
        {
            SendMessageToPC(oPC, GetName(oTarget)+": lektvary prestavaji ucinkovat.");
        }
        else if (iPercent>= 0.1)
        {
            SendMessageToPC(oPC, GetName(oTarget)+": bude zvracet.");
        }
        return TRUE;

    }
    else
    {
       SendMessageToPC(oPC, GetName(oTarget)+": bleeeee");
       return FALSE;
    }
}


void sh_OnRestResetElixirPoints(object oPC, object oSoul)
{
    int iCon = GetAbilityScore(oPC,ABILITY_CONSTITUTION,FALSE);
    int iFreePoints = iCon*30+GetHitDice(oPC)*10;
    SetLocalInt(oSoul,"SH_ELIXIR_POINTS",iFreePoints);
    SendMessageToPC(oPC,"Muzes opet pit elixiry.");
}


void sh_ModuleOnActivationItemCheckElixirs(object oItem, object oTarget, object oPC)
{
    string sTag = GetTag(oItem);
    int iElxStr = 0,iEffectID,iEffect;
    effect efInstant,efTemporary,efTemporary2,efTemporary3,eLink,eLoop;
    object oSoul = GetSoulStone(oPC);
    // kompanion
    if (oPC != oTarget) oSoul = oTarget;

    if (sTag =="sh_it_elx10_heal")
    {
        iElxStr = 10;
        if (UseElixir(oPC,oTarget,oSoul,iElxStr))
        {
            efInstant = EffectHeal(12);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,efInstant,oTarget);
        }
    }
    else if (sTag =="sh_it_elx20_heal")
    {
        iElxStr = 20;
        if (UseElixir(oPC,oTarget,oSoul,iElxStr))
        {
            efInstant = EffectHeal(25);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,efInstant,oTarget);
        }
    }
    else if (sTag =="sh_it_elx30_heal")
    {
        iElxStr = 30;
        if (UseElixir(oPC,oTarget,oSoul,iElxStr))
        {
            efInstant = EffectHeal(55);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,efInstant,oTarget);
        }
    }
    else if (sTag =="sh_it_elx50_heal")
    {
        iElxStr = 50;
        if (UseElixir(oPC,oTarget,oSoul,iElxStr))
        {
            efInstant = EffectHeal(150);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,efInstant,oTarget);
        }
    }

    else if (sTag =="sh_it_elx10_str")
    {
        iElxStr = 10;
        if (UseElixir(oPC,oTarget,oSoul,iElxStr))
        {
            iEffectID = SPELL_BULLS_STRENGTH;
            effect eLoop = GetFirstEffect(oTarget);
            while (GetIsEffectValid(eLoop))
            {
                iEffect = GetEffectSpellId(eLoop);
                if (iEffect== iEffectID) RemoveEffect(oTarget,eLoop);
                eLoop = GetNextEffect(oTarget);
            }
            efTemporary = EffectAbilityIncrease(ABILITY_STRENGTH,1);
            SetEffectSpellId(efTemporary,iEffectID);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,efTemporary,oTarget,TurnsToSeconds(16));
        }
    }
    else if (sTag =="sh_it_elx20_str")
    {
        iElxStr = 20;
        if (UseElixir(oPC,oTarget,oSoul,iElxStr))
        {
            iEffectID = SPELL_BULLS_STRENGTH;
            effect eLoop = GetFirstEffect(oTarget);
            while (GetIsEffectValid(eLoop))
            {
                iEffect = GetEffectSpellId(eLoop);
                if (iEffect== iEffectID) RemoveEffect(oTarget,eLoop);
                eLoop = GetNextEffect(oTarget);
            }
            efTemporary = EffectAbilityIncrease(ABILITY_STRENGTH,2);
            SetEffectSpellId(efTemporary,iEffectID);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,efTemporary,oTarget,TurnsToSeconds(8));
        }
    }
    else if (sTag =="sh_it_elx40_str")
    {
        iElxStr = 40;
        if (UseElixir(oPC,oTarget,oSoul,iElxStr))
        {
            iEffectID = SPELL_BULLS_STRENGTH;
            effect eLoop = GetFirstEffect(oTarget);
            while (GetIsEffectValid(eLoop))
            {
                iEffect = GetEffectSpellId(eLoop);
                if (iEffect== iEffectID) RemoveEffect(oTarget,eLoop);
                eLoop = GetNextEffect(oTarget);
            }
            efTemporary = EffectAbilityIncrease(ABILITY_STRENGTH,4);
            SetEffectSpellId(efTemporary,iEffectID);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,efTemporary,oTarget,TurnsToSeconds(4));
        }
    }
    else if (sTag =="sh_it_elx10_dex")
    {
        iElxStr = 10;
        if (UseElixir(oPC,oTarget,oSoul,iElxStr))
        {
            iEffectID = SPELL_CATS_GRACE;
            effect eLoop = GetFirstEffect(oTarget);
            while (GetIsEffectValid(eLoop))
            {
                iEffect = GetEffectSpellId(eLoop);
                if (iEffect== iEffectID) RemoveEffect(oTarget,eLoop);
                eLoop = GetNextEffect(oTarget);
            }
            efTemporary = EffectAbilityIncrease(ABILITY_DEXTERITY,1);
            SetEffectSpellId(efTemporary,iEffectID);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,efTemporary,oTarget,TurnsToSeconds(16));
        }
    }
    else if (sTag =="sh_it_elx20_dex")
    {
        iElxStr = 20;
        if (UseElixir(oPC,oTarget,oSoul,iElxStr))
        {
            iEffectID = SPELL_CATS_GRACE;
            effect eLoop = GetFirstEffect(oTarget);
            while (GetIsEffectValid(eLoop))
            {
                iEffect = GetEffectSpellId(eLoop);
                if (iEffect== iEffectID) RemoveEffect(oTarget,eLoop);
                eLoop = GetNextEffect(oTarget);
            }
            efTemporary = EffectAbilityIncrease(ABILITY_DEXTERITY,2);
            SetEffectSpellId(efTemporary,iEffectID);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,efTemporary,oTarget,TurnsToSeconds(8));
        }
    }
    else if (sTag =="sh_it_elx40_dex")
    {
        iElxStr = 40;
        if (UseElixir(oPC,oTarget,oSoul,iElxStr))
        {
            iEffectID = SPELL_CATS_GRACE;
            effect eLoop = GetFirstEffect(oTarget);
            while (GetIsEffectValid(eLoop))
            {
                iEffect = GetEffectSpellId(eLoop);
                if (iEffect== iEffectID) RemoveEffect(oTarget,eLoop);
                eLoop = GetNextEffect(oTarget);
            }
            efTemporary = EffectAbilityIncrease(ABILITY_DEXTERITY,4);
            SetEffectSpellId(efTemporary,iEffectID);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,efTemporary,oTarget,TurnsToSeconds(4));
        }
    }
    else if (sTag =="sh_it_elx10_con")
    {
        iElxStr = 10;
        if (UseElixir(oPC,oTarget,oSoul,iElxStr))
        {
            iEffectID = SPELL_ENDURANCE;
            effect eLoop = GetFirstEffect(oTarget);
            while (GetIsEffectValid(eLoop))
            {
                iEffect = GetEffectSpellId(eLoop);
                if (iEffect== iEffectID) RemoveEffect(oTarget,eLoop);
                eLoop = GetNextEffect(oTarget);
            }
            efTemporary = EffectAbilityIncrease(ABILITY_CONSTITUTION,1);
            SetEffectSpellId(efTemporary,iEffectID);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,efTemporary,oTarget,TurnsToSeconds(16));
        }
    }
    else if (sTag =="sh_it_elx20_con")
    {
        iElxStr = 20;
        if (UseElixir(oPC,oTarget,oSoul,iElxStr))
        {
            iEffectID = SPELL_ENDURANCE;
            effect eLoop = GetFirstEffect(oTarget);
            while (GetIsEffectValid(eLoop))
            {
                iEffect = GetEffectSpellId(eLoop);
                if (iEffect== iEffectID) RemoveEffect(oTarget,eLoop);
                eLoop = GetNextEffect(oTarget);
            }
            efTemporary = EffectAbilityIncrease(ABILITY_CONSTITUTION,2);
            SetEffectSpellId(efTemporary,iEffectID);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,efTemporary,oTarget,TurnsToSeconds(8));
        }
    }
    else if (sTag =="sh_it_elx40_con")
    {
        iElxStr = 40;
        if (UseElixir(oPC,oTarget,oSoul,iElxStr))
        {
            iEffectID = SPELL_ENDURANCE;
            effect eLoop = GetFirstEffect(oTarget);
            while (GetIsEffectValid(eLoop))
            {
                iEffect = GetEffectSpellId(eLoop);
                if (iEffect== iEffectID) RemoveEffect(oTarget,eLoop);
                eLoop = GetNextEffect(oTarget);
            }
            efTemporary = EffectAbilityIncrease(ABILITY_CONSTITUTION,4);
            SetEffectSpellId(efTemporary,iEffectID);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,efTemporary,oTarget,TurnsToSeconds(4));
        }
    }
    //AFRODIZIAKA
    //Tygri nespoutanost
    else if (sTag =="sh_it_elx_afr1")
    {
            iEffectID = EFFECT_ELIXIR_AFR1;
            effect eLoop = GetFirstEffect(oTarget);
            while (GetIsEffectValid(eLoop))
            {
                iEffect = GetEffectSpellId(eLoop);
                if (iEffect== iEffectID) RemoveEffect(oTarget,eLoop);
                eLoop = GetNextEffect(oTarget);
            }
            efTemporary  = EffectSkillDecrease(SKILL_LISTEN,5);
            efTemporary2 = EffectSkillIncrease(SKILL_PERSUADE,5);
            efTemporary3 = EffectSkillDecrease(SKILL_SPOT,5);
            eLink = EffectLinkEffects(efTemporary,efTemporary3);
            eLink = EffectLinkEffects(efTemporary2,eLink);
            SetEffectSpellId(eLink,iEffectID);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oTarget,TurnsToSeconds(6));

    }
    //Lektvar z horkych pramenu raje
    else if (sTag =="sh_it_elx_afr2")
    {
            iEffectID = EFFECT_ELIXIR_AFR2;
            effect eLoop = GetFirstEffect(oTarget);
            while (GetIsEffectValid(eLoop))
            {
                iEffect = GetEffectSpellId(eLoop);
                if (iEffect== iEffectID) RemoveEffect(oTarget,eLoop);
                eLoop = GetNextEffect(oTarget);
            }
            efTemporary  = EffectSkillDecrease(SKILL_CONCENTRATION,5);
            efTemporary2 = EffectAbilityIncrease(ABILITY_CHARISMA,1);
            efTemporary3 = EffectSkillDecrease(SKILL_DISCIPLINE,5);
            eLink = EffectLinkEffects(efTemporary,efTemporary3);
            eLink = EffectLinkEffects(efTemporary2,eLink);
            SetEffectSpellId(eLink,iEffectID);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oTarget,TurnsToSeconds(6));

    }
    // Mast nekonecne noci
    else if (sTag =="sh_it_elx_afr3")
    {
            iEffectID = EFFECT_ELIXIR_AFR3;
            effect eLoop = GetFirstEffect(oTarget);
            while (GetIsEffectValid(eLoop))
            {
                iEffect = GetEffectSpellId(eLoop);
                if (iEffect== iEffectID) RemoveEffect(oTarget,eLoop);
                eLoop = GetNextEffect(oTarget);
            }
            efTemporary  = EffectSavingThrowDecrease(SAVING_THROW_REFLEX,1);
            efTemporary2 = EffectSavingThrowIncrease(SAVING_THROW_FORT,1);
            efTemporary3 = EffectSavingThrowDecrease(SAVING_THROW_WILL,1);
            eLink = EffectLinkEffects(efTemporary,efTemporary3);
            eLink = EffectLinkEffects(efTemporary2,eLink);
            SetEffectSpellId(eLink,iEffectID);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oTarget,HoursToSeconds(12));

    }
    // Lektvar carodejky roholy
    else if (sTag =="sh_it_elx_afr4")
    {
            iEffectID = EFFECT_ELIXIR_AFR4;
            effect eLoop = GetFirstEffect(oTarget);
            while (GetIsEffectValid(eLoop))
            {
                iEffect = GetEffectSpellId(eLoop);
                if (iEffect== iEffectID) RemoveEffect(oTarget,eLoop);
                eLoop = GetNextEffect(oTarget);
            }
            efTemporary  = EffectSkillDecrease(SKILL_DISCIPLINE,3);
            efTemporary2 = EffectAbilityIncrease(ABILITY_CHARISMA,1);
            efTemporary3 = EffectSkillDecrease(SKILL_CONCENTRATION,3);
            eLink = EffectLinkEffects(efTemporary,efTemporary3);
            eLink = EffectLinkEffects(efTemporary2,eLink);
            SetEffectSpellId(eLink,iEffectID);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oTarget,TurnsToSeconds(8));

    }
    //Afrodisiakum z viliho nektaru
    else if (sTag =="sh_it_elx_afr5")
    {
            iEffectID = EFFECT_ELIXIR_AFR5;
            effect eLoop = GetFirstEffect(oTarget);
            while (GetIsEffectValid(eLoop))
            {
                iEffect = GetEffectSpellId(eLoop);
                if (iEffect== iEffectID) RemoveEffect(oTarget,eLoop);
                eLoop = GetNextEffect(oTarget);
            }
            efTemporary  = EffectAbilityIncrease(SKILL_PERSUADE,3);
            efTemporary2 = EffectAbilityIncrease(ABILITY_CHARISMA,2);
            efTemporary3 = EffectSavingThrowDecrease(SAVING_THROW_WILL,3);
            eLink = EffectLinkEffects(efTemporary,efTemporary3);
            eLink = EffectLinkEffects(efTemporary2,eLink);
            SetEffectSpellId(eLink,iEffectID);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oTarget,TurnsToSeconds(8));

    }
    //Jednorozcuv roh slasti
    else if (sTag =="sh_it_elx_afr6")
    {
            iEffectID = EFFECT_ELIXIR_AFR6;
            effect eLoop = GetFirstEffect(oTarget);
            while (GetIsEffectValid(eLoop))
            {
                iEffect = GetEffectSpellId(eLoop);
                if (iEffect== iEffectID) RemoveEffect(oTarget,eLoop);
                eLoop = GetNextEffect(oTarget);
            }
            efTemporary = EffectSavingThrowIncrease(SAVING_THROW_FORT,2);
            efTemporary2 = EffectAbilityIncrease(ABILITY_CHARISMA,2);
            efTemporary3 = EffectSkillDecrease(SKILL_SPOT,25);
            eLink = EffectLinkEffects(efTemporary,efTemporary3);
            eLink = EffectLinkEffects(efTemporary2,eLink);
            SetEffectSpellId(eLink,iEffectID);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oTarget,TurnsToSeconds(6));
    }












}
