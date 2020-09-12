//::///////////////////////////////////////////////
//:: Spell Hook Include File
//:: x2_inc_spellhook
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*

    This file acts as a hub for all code that
    is hooked into the nwn spellscripts'

    If you want to implement material components
    into spells or add restrictions to certain
    spells, this is the place to do it.

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-06-04
//:: Updated On: 2003-10-25
//:://////////////////////////////////////////////
//:: Modified By: Deva Winblood
//:: Modified Date: January 15th-16th, 2008
//:://////////////////////////////////////////////
/*
    Modified to insure no shapeshifting spells are castable upon
    mounted targets.  This prevents problems that can occur due
    to dismounting after shape shifting, or other issues that can
    occur due to preserved appearances getting out of synch.

    This can additional check can be disabled by setting the variable
    X3_NO_SHAPESHIFT_SPELL_CHECK to 1 on the module object.  If this
    variable is set then this script will function as it did prior to
    this modification.

*/

//#include "x2_inc_itemprop" - Inherited from x2_inc_craft
#include "x2_inc_craft"
#include "x3_inc_horse"
#include "sh_spells_inc"
#include "ja_inc_stamina"


const int DEBUG = FALSE;

const int X2_EVENT_CONCENTRATION_BROKEN = 12400;

//Returns spell level for oCaster class (or Wizard by default)
int getSpellLevel( int spellID, int iClass );


// Use Magic Device Check.
// Returns TRUE if the Spell is allowed to be cast, either because the
// character is allowed to cast it or he has won the required UMD check
// Only active on spell scroll
int X2UseMagicDeviceCheck();


// This function holds all functions that are supposed to run before the actual
// spellscript gets run. If this functions returns FALSE, the spell is aborted
// and the spellscript will not run
int X2PreSpellCastCode();


// check if the spell is prohibited from being cast on items
// returns FALSE if the spell was cast on an item but is prevented
// from being cast there by its corresponding entry in des_crft_spells
// oItem - pass GetSpellTargetObject in here
int X2CastOnItemWasAllowed(object oItem);

// Sequencer Item Property Handling
// Returns TRUE (and charges the sequencer item) if the spell
// ... was cast on an item AND
// ... the item has the sequencer property
// ... the spell was non hostile
// ... the spell was not cast from an item
// in any other case, FALSE is returned an the normal spellscript will be run
// oItem - pass GetSpellTargetObject in here
int X2GetSpellCastOnSequencerItem(object oItem);

int X2RunUserDefinedSpellScript();

//Returns spell level for oCaster class (or Wizard by default)
int getSpellLevel( int nSpellID, int iClass ){

    string sClass;

    switch(iClass){
        default:
            sClass = "Wiz_Sorc";
            break;
        case CLASS_TYPE_BARD:
            sClass = "Bard";
            break;
        case CLASS_TYPE_CLERIC:
            sClass = "Cleric";
            break;
        case CLASS_TYPE_DRUID:
            sClass = "Druid";
            break;
        case CLASS_TYPE_PALADIN:
            sClass = "Paladin";
            break;
        case CLASS_TYPE_RANGER:
            sClass = "Ranger";
            break;
    }

    int nSpellLevel = 0;
//    SendMessageToPC(GetFirstPC(),"class:"+IntToString(iClass));
//    SendMessageToPC(GetFirstPC(),"sclass:"+sClass);

    int CacheD = GetLocalInt(GetModule(), "Cached_"+sClass + IntToString(nSpellID));
    string sSpellLevel;
    if (CacheD!=1)
      {
       sSpellLevel = Get2DAString("spells", sClass, nSpellID);
       SetLocalString(GetModule(), "2DA_"+sClass+IntToString(nSpellID), sSpellLevel);
       SetLocalInt(GetModule(), "Cached_"+sClass + IntToString(nSpellID),1);
       if (DEBUG) SendMessageToPC(GetFirstPC(), "Set Cached Result:"+sSpellLevel);
      }
    else
      {
       sSpellLevel = GetLocalString(GetModule(), "2DA_"+ sClass + IntToString(nSpellID));
       if (DEBUG) SendMessageToPC(GetFirstPC(), "Pulled Cached Result:"+sSpellLevel);
      }

    if(GetStringLength(sSpellLevel)<1) {
      if(GetLocalInt(GetModule(), "Cached_Innate" + IntToString(nSpellID)) != 1) {
        sSpellLevel = Get2DAString("spells", "Innate", nSpellID);
        SetLocalString(GetModule(), "2DA_SPELLS_INNATE"+IntToString(nSpellID), sSpellLevel);
        SetLocalInt(GetModule(), "Cached_Innate" + IntToString(nSpellID),1);
        if (DEBUG) SendMessageToPC(GetFirstPC(), "Set Cached Result:"+sSpellLevel);
      }
      else {
        sSpellLevel = GetLocalString(GetModule(), "2DA_SPELLS_INNATE"+IntToString(nSpellID));
        if (DEBUG) SendMessageToPC(GetFirstPC(), "Pulled Cached Result:"+sSpellLevel);
      }
    }

//    string sSpellLevel = Get2DAString("spells",sClass,nSpellID);
//    SendMessageToPC(GetFirstPC(),"spell:"+sSpellLevel);
//    WriteTimestampedLogEntry("Casting "+IntToString(nSpellID)+" with spell level "+sSpellLevel+" by "+sClass);

    if (sSpellLevel != "")
    {
        nSpellLevel=StringToInt(sSpellLevel);
    }

    return nSpellLevel;
}

int X2UseMagicDeviceCheck()
{
    int nRet = ExecuteScriptAndReturnInt("x2_pc_umdcheck",OBJECT_SELF);
    return nRet;
}

//------------------------------------------------------------------------------
// GZ: This is a filter I added to prevent spells from firing their original spell
// script when they were cast on items and do not have special coding for that
// case. If you add spells that can be cast on items you need to put them into
// des_crft_spells.2da
//------------------------------------------------------------------------------
int X2CastOnItemWasAllowed(object oItem)
{
    int bAllow = (Get2DAString(X2_CI_CRAFTING_SP_2DA,"CastOnItems",GetSpellId()) == "1");
    if (!bAllow)
    {
        FloatingTextStrRefOnCreature(83453, OBJECT_SELF); // not cast spell on item
    }
    return bAllow;

}

//------------------------------------------------------------------------------
// Execute a user overridden spell script.
//------------------------------------------------------------------------------
int X2RunUserDefinedSpellScript()
{
    // See x2_inc_switches for details on this code
    string sScript =  GetModuleOverrideSpellscript();
    if (sScript != "")
    {
        ExecuteScript(sScript,OBJECT_SELF);
        if (GetModuleOverrideSpellScriptFinished() == TRUE)
        {
            return FALSE;
        }
    }
    return TRUE;
}



//------------------------------------------------------------------------------
// Created Brent Knowles, Georg Zoeller 2003-07-31
// Returns TRUE (and charges the sequencer item) if the spell
// ... was cast on an item AND
// ... the item has the sequencer property
// ... the spell was non hostile
// ... the spell was not cast from an item
// in any other case, FALSE is returned an the normal spellscript will be run
//------------------------------------------------------------------------------
int X2GetSpellCastOnSequencerItem(object oItem)
{

    if (!GetIsObjectValid(oItem))
    {
        return FALSE;
    }

    int nMaxSeqSpells = IPGetItemSequencerProperty(oItem); // get number of maximum spells that can be stored
    if (nMaxSeqSpells <1)
    {
        return FALSE;
    }

    if (GetIsObjectValid(GetSpellCastItem())) // spell cast from item?
    {
        // we allow scrolls
        int nBt = GetBaseItemType(GetSpellCastItem());
        if ( nBt !=BASE_ITEM_SPELLSCROLL && nBt != 105)
        {
            FloatingTextStrRefOnCreature(83373, OBJECT_SELF);
            return TRUE; // wasted!
        }
    }

    // Check if the spell is marked as hostile in spells.2da
    int nHostile = StringToInt(Get2DAString("spells","HostileSetting",GetSpellId()));
    if(nHostile ==1)
    {
        FloatingTextStrRefOnCreature(83885,OBJECT_SELF);
        return TRUE; // no hostile spells on sequencers, sorry ya munchkins :)
    }

    int nNumberOfTriggers = GetLocalInt(oItem, "X2_L_NUMTRIGGERS");
    // is there still space left on the sequencer?
    if (nNumberOfTriggers < nMaxSeqSpells)
    {
        // success visual and store spell-id on item.
        effect eVisual = EffectVisualEffect(VFX_IMP_BREACH);
        nNumberOfTriggers++;
        //NOTE: I add +1 to the SpellId to spell 0 can be used to trap failure
        int nSID = GetSpellId()+1;
        SetLocalInt(oItem, "X2_L_SPELLTRIGGER" + IntToString(nNumberOfTriggers), nSID);
        SetLocalInt(oItem, "X2_L_NUMTRIGGERS", nNumberOfTriggers);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, OBJECT_SELF);
        FloatingTextStrRefOnCreature(83884, OBJECT_SELF);
    }
    else
    {
        FloatingTextStrRefOnCreature(83859,OBJECT_SELF);
    }

    return TRUE; // in any case, spell is used up from here, so do not fire regular spellscript
}

//------------------------------------------------------------------------------
// * This is our little concentration system for black blade of disaster
// * if the mage tries to cast any kind of spell, the blade is signaled an event to die
//------------------------------------------------------------------------------
void X2BreakConcentrationSpells()
{
    // * At the moment we got only one concentration spell, black blade of disaster

    object oAssoc = GetAssociate(ASSOCIATE_TYPE_SUMMONED);
    if (GetIsObjectValid(oAssoc) && GetIsPC(OBJECT_SELF)) // only applies to PCS
    {
        if(GetTag(oAssoc) == "x2_s_bblade") // black blade of disaster
        {
            if (GetLocalInt(OBJECT_SELF,"X2_L_CREATURE_NEEDS_CONCENTRATION"))
            {
                SignalEvent(oAssoc,EventUserDefined(X2_EVENT_CONCENTRATION_BROKEN));
            }
        }
    }
}

//------------------------------------------------------------------------------
// being hit by any kind of negative effect affecting the caster's ability to concentrate
// will cause a break condition for concentration spells
//------------------------------------------------------------------------------
int X2GetBreakConcentrationCondition(object oPlayer)
{
     effect e1 = GetFirstEffect(oPlayer);
     int nType;
     int bRet = FALSE;
     while (GetIsEffectValid(e1) && !bRet)
     {
        nType = GetEffectType(e1);

        if (nType == EFFECT_TYPE_STUNNED || nType == EFFECT_TYPE_PARALYZE ||
            nType == EFFECT_TYPE_SLEEP || nType == EFFECT_TYPE_FRIGHTENED ||
            nType == EFFECT_TYPE_PETRIFY || nType == EFFECT_TYPE_CONFUSED ||
            nType == EFFECT_TYPE_DOMINATED || nType == EFFECT_TYPE_POLYMORPH)
         {
           bRet = TRUE;
         }
                    e1 = GetNextEffect(oPlayer);
     }
    return bRet;
}

void X2DoBreakConcentrationCheck()
{
    object oMaster = GetMaster();
    if (GetLocalInt(OBJECT_SELF,"X2_L_CREATURE_NEEDS_CONCENTRATION"))
    {
         if (GetIsObjectValid(oMaster))
         {
            int nAction = GetCurrentAction(oMaster);
            // master doing anything that requires attention and breaks concentration
            if (nAction == ACTION_DISABLETRAP || nAction == ACTION_TAUNT ||
                nAction == ACTION_PICKPOCKET || nAction ==ACTION_ATTACKOBJECT ||
                nAction == ACTION_COUNTERSPELL || nAction == ACTION_FLAGTRAP ||
                nAction == ACTION_CASTSPELL || nAction == ACTION_ITEMCASTSPELL)
            {
                SignalEvent(OBJECT_SELF,EventUserDefined(X2_EVENT_CONCENTRATION_BROKEN));
            }
            else if (X2GetBreakConcentrationCondition(oMaster))
            {
                SignalEvent(OBJECT_SELF,EventUserDefined(X2_EVENT_CONCENTRATION_BROKEN));
            }
         }
    }
}


//------------------------------------------------------------------------------
// This function will return TRUE if the spell that is cast is a shape shifting
// spell.
//------------------------------------------------------------------------------
int X3ShapeShiftSpell(object oTarget)
{ // PURPOSE: Return TRUE if a shape shifting spell was cast at oTarget
    int nSpellID=GetSpellId();
    string sUp=GetStringUpperCase(Get2DAString("x3restrict","SHAPESHIFT", nSpellID));
    if (sUp=="YES") return TRUE;
    return FALSE;
} // X3ShapeShiftSpell()

/*
 * Funkce prepocita kruh kouzla na lvl castera
 */
int KU_RingToLevel(int SpellLevel, int iClass)
{
 float fEqLevel = 0.0;

 if(SpellLevel == 0){
    SpellLevel = 1;
 }

 if( (iClass==CLASS_TYPE_RANGER)  ||
     (iClass==CLASS_TYPE_PALADIN) ) {
   return FloatToInt(SpellLevel * 3.4 + 0.71);
 }
 if( (iClass==CLASS_TYPE_BARD) ) {
   if(SpellLevel == 2)
     return 5;
   if(SpellLevel == 3)
     return 8;

   return FloatToInt(SpellLevel * 2.5 + 0.5);
 }
 else {
   return (SpellLevel * 2 - 1);
 }


 return 0;
}

float KU_GetStaminaWoundKoeficient(object oPC, int nSpellID, int iClass)
{
  int iKostKoef = 70;

  int iLevel = GetLevelByClass(iClass,oPC);
  int iSpellRing = getSpellLevel(nSpellID,iClass );

  //spell-like abilita
  if(iLevel == 0)
    return 1.0;

  return (IntToFloat(iKostKoef * KU_RingToLevel(iSpellRing, iClass)) / iLevel);

}

void __checkEffects(object oPC) {
  effect eff = GetFirstEffect(oPC);
  while(GetIsEffectValid(eff)) {
    switch(GetEffectSpellId(eff)) {
      case 885: //FEAT_CERNOKNEZNIK_INVOKACE3_PROJDI_NESPATREN
        RemoveEffect(oPC,eff);
    }
    eff = GetNextEffect(oPC);
  }
}

//------------------------------------------------------------------------------
// if FALSE is returned by this function, the spell will not be cast
// the order in which the functions are called here DOES MATTER, changing it
// WILL break the crafting subsystems
//------------------------------------------------------------------------------
int X2PreSpellCastCode()
{
   object oTarget = GetSpellTargetObject();
   int nContinue;
   int iSpell = GetSpellId();

   //---------------------------------------------------------------------------
   // This small addition will check to see if the target is mounted and the
   // spell is therefor one that should not be permitted.
   //---------------------------------------------------------------------------
   if (!GetLocalInt(GetModule(),"X3_NO_SHAPESHIFT_SPELL_CHECK"))
   { // do check for abort due to being mounted check
       if (HorseGetIsMounted(oTarget)&&X3ShapeShiftSpell(oTarget))
       { // shape shifting not allowed while mounted
           if(GetIsPC(oTarget))
           {
               FloatingTextStrRefOnCreature(111982,oTarget,FALSE);
           }
           return FALSE;
       } // shape shifting not allowed while mounted
   } // do check for abort due to being mounted check


   //---------------------------------------------------------------------------
   // This stuff is only interesting for player characters we assume that use
   // magic device always works and NPCs don't use the crafting feats or
   // sequencers anyway. Thus, any NON PC spellcaster always exits this script
   // with TRUE (unless they are DM possessed or in the Wild Magic Area in
   // Chapter 2 of Hordes of the Underdark.
   //---------------------------------------------------------------------------
   if (!GetIsPC(OBJECT_SELF) || GetIsPossessedFamiliar(OBJECT_SELF))
   {
       if( !GetIsDMPossessed(OBJECT_SELF) && !GetLocalInt(GetArea(OBJECT_SELF), "X2_L_WILD_MAGIC"))
       {
            return TRUE;
       }
   }

   object oPC = OBJECT_SELF;

   __checkEffects(oPC);

   if(!GetIsObjectValid(GetSpellCastItem()) && !GetIsDM(oPC) && !GetIsDMPossessed(oPC)){
       float fStamina = getStamina(oPC);

       woundStamina( oPC, KU_GetStaminaWoundKoeficient(oPC,iSpell,GetLastSpellCastClass()) );
//       woundStamina( oPC, 25.0*getSpellLevel(GetLastSpell(), GetLastSpellCastClass()) );

       if(getStatusInt(oPC) == 2){
            if(Random(100) < 30){
                SendMessageToPC(oPC, "Seslani kouzla selhalo diky unave!");
                return FALSE;
            }
       }

       if(getStatusInt(oPC) < 2){
            int iProb = FloatToInt(100*fStamina/(2.0*getMaxStamina(oPC)/5.0));

            if(Random(100) > iProb){
                SendMessageToPC(oPC, "Seslani kouzla selhalo diky unave!");
                return FALSE;
            }
       }


       // Check if the spell is marked as hostile in spells.2da
       int nHostile = StringToInt(Get2DAString("spells","HostileSetting",iSpell));
/*       int bTimeStopped = (GetLocalInt(oPC,"ku_spell_timestop_dur") > ku_GetTimeStamp());*/
       WriteTimestampedLogEntry(GetName(oPC)+" casting "+Get2DAString("spells","Label",iSpell)+"("+IntToString(iSpell)+"). Hostile: "+IntToString(nHostile)+". ");


   }

   //---------------------------------------------------------------------------
   // Break any spell require maintaining concentration (only black blade of
   // disaster)
   // /*REM*/ X2BreakConcentrationSpells();
   //---------------------------------------------------------------------------

   //---------------------------------------------------------------------------
   // Run use magic device skill check
   //---------------------------------------------------------------------------
   nContinue = X2UseMagicDeviceCheck();

   if (nContinue)
   {
       //-----------------------------------------------------------------------
       // run any user defined spellscript here
       //-----------------------------------------------------------------------
       nContinue = X2RunUserDefinedSpellScript();
   }

   //---------------------------------------------------------------------------
   // The following code is only of interest if an item was targeted
   //---------------------------------------------------------------------------
   if (GetIsObjectValid(oTarget) && GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
   {

       //-----------------------------------------------------------------------
       // Check if spell was used to trigger item creation feat
       //-----------------------------------------------------------------------
       if (nContinue) {
           nContinue = !ExecuteScriptAndReturnInt("x2_pc_craft",OBJECT_SELF);
       }

       //-----------------------------------------------------------------------
       // Check if spell was used for on a sequencer item
       //-----------------------------------------------------------------------
       if (nContinue)
       {
            nContinue = (!X2GetSpellCastOnSequencerItem(oTarget));
       }

       //-----------------------------------------------------------------------
       // * Execute item OnSpellCast At routing script if activated
       //-----------------------------------------------------------------------
       if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
       {
             SetUserDefinedItemEventNumber(X2_ITEM_EVENT_SPELLCAST_AT);
             int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oTarget),OBJECT_SELF);
             if (nRet == X2_EXECUTE_SCRIPT_END)
             {
                return FALSE;
             }
       }

       //-----------------------------------------------------------------------
       // Prevent any spell that has no special coding to handle targetting of items
       // from being cast on items. We do this because we can not predict how
       // all the hundreds spells in NWN will react when cast on items
       //-----------------------------------------------------------------------
       if (nContinue) {
           nContinue = X2CastOnItemWasAllowed(oTarget);
       }
   }

   return nContinue;
}

int IsImbueArrow(object oTarget, int iSpell)
{
    object oCastItem = GetSpellCastItem();
    if (GetObjectType(oTarget)!=OBJECT_TYPE_ITEM)
    {
        return FALSE;
    }
    if (GetBaseItemType(oTarget)!=BASE_ITEM_ARROW)
    {
        return FALSE;
    }
    itemproperty ip;
    switch (iSpell)
    {
        case SPELL_FIREBALL:
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_1d4);
        break;

        case SPELL_LIGHTNING_BOLT:
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEBONUS_1d4);
        break;

        case SPELL_MESTILS_ACID_BREATH:
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGEBONUS_1d4);
        break;

        case SPELL_NEGATIVE_ENERGY_BURST:
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_NEGATIVE,IP_CONST_DAMAGEBONUS_1d4);
        break;

        case SPELL_ICE_STORM:
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_1d6);
        break;

        case SPELL_WALL_OF_FIRE:
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_1d6);
        break;

        case SPELL_BALL_LIGHTNING:
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEBONUS_1d6);
        break;

        case SPELL_CONE_OF_COLD:
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_1d6);
        break;

        case SPELL_FIREBRAND:
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_1d6);
        break;

        case SPELL_ACID_FOG:
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGEBONUS_1d6);
        break;

        case SPELL_CHAIN_LIGHTNING:
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEBONUS_1d6);
        break;

        case SPELL_CIRCLE_OF_DEATH:
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_NEGATIVE,IP_CONST_DAMAGEBONUS_1d6);
        break;

        case SPELL_DELAYED_BLAST_FIREBALL:
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_1d8);
        break;

        case SPELL_GREAT_THUNDERCLAP:
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEBONUS_1d8);
        break;

        case SPELL_HORRID_WILTING:
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_NEGATIVE,IP_CONST_DAMAGEBONUS_1d8);
        break;

        case SPELL_INCENDIARY_CLOUD:
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_1d8);
        break;

        case SPELL_SUNBURST:
        ip = ItemPropertyDamageBonusVsRace(RACIAL_TYPE_UNDEAD,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_1d10);
        break;

        case SPELL_METEOR_SWARM:
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_1d10);
        break;

        case TALKVOLUME_WHISPER:
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_1d6);
        break;

        default:
        return FALSE;
    }


    object oPC = GetItemPossessor(oTarget);
    if (GetItemInSlot(INVENTORY_SLOT_ARROWS,oPC)!=oTarget)
    {
        SendMessageToPC(oPC,"Lze seslat jen na vyvavene sipy.");
        return TRUE;
    }

    if (GetIsObjectValid(oCastItem))
    {
        SendMessageToPC(oPC,"Sipy nelze ocarovat pomoci kouzel z predmetu.");
        return TRUE;
    }
    itemproperty ipLoop = GetFirstItemProperty(oTarget);
    while (GetIsItemPropertyValid(ipLoop))
    {
        if (GetItemPropertyType(ipLoop)== IP_IMBUEARROW)
        {
            RemoveItemProperty(oTarget,ipLoop);
        }
        ipLoop = GetNextItemProperty(oTarget);
    }
    SetItemPropertySpellId(ip,IP_IMBUEARROW);
    AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oTarget,HoursToSeconds(10));
    SendMessageToPC(oPC,"Sipy byly ocarovany.");
    return TRUE;
}



