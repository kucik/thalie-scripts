 //::///////////////////////////////////////////////
//:: Vlastni onhit property
//:: sh_onhit_default
//:: //:://////////////////////////////////////////////
/*



*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:
//:://////////////////////////////////////////////
#include "sh_classes_inc"
#include "X0_I0_SPELLS"
#include "ku_libtime"
//#include "cl_kurt_plav_inc"

void  AssassinUderDoTepny(object oTarget, effect eDamage,int iAct)
{
    if(iAct<=GetLocalInt(oTarget,"UderDoTepny"))
    {

            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget);
            DelayCommand(RoundsToSeconds(1), AssassinUderDoTepny(oTarget, eDamage, iAct+1));


    }
    else
    {
        DeleteLocalInt(oTarget,"UderDoTepny");
    }
}

void main()
{

   object oItem;        // The item casting triggering this spellscript
   object oSpellTarget; // On a weapon: The one being hit. On an armor: The one hitting the armor
   object oSpellOrigin; // On a weapon: The one wielding the weapon. On an armor: The one wearing an armor
   object oSaveItem;

   // fill the variables
   oSpellOrigin = OBJECT_SELF;
   oSpellTarget = GetSpellTargetObject();
   oItem        =  GetSpellCastItem();
   oSaveItem    = GetSoulStone(oSpellOrigin);
   int iTargetRace = GetRacialType(oSpellTarget);
   int iRogueMode = GetLocalInt(oSaveItem,"ROGUE_MODE");
   int iRandom = 0;

    // SendMessageToPC(oSpellTarget,"Tady to dojede");
    // SendMessageToPC(oSpellOrigin,"Tady to dojede");
     //uder do tepny
     if ((GetHasFeat(FEAT_ASSASSIN_UDER_DO_TEPNY,oSpellOrigin))  && (iTargetRace!=RACIAL_TYPE_UNDEAD) && (iTargetRace!=RACIAL_TYPE_CONSTRUCT) && (iTargetRace!=RACIAL_TYPE_ELEMENTAL) && (iTargetRace!=RACIAL_TYPE_OUTSIDER) && (iTargetRace!=RACIAL_TYPE_OOZE))
     {
        if (GetLocalInt(oSpellTarget,"UderDoTepny") == 0)
        {
            int iCasterLevel =GetLevelByClass(CLASS_TYPE_ASSASSIN,oSpellOrigin);
            SetLocalInt(oSpellTarget,"UderDoTepny",iCasterLevel);
            effect eDamage = EffectDamage(iCasterLevel /3);
            int iC = iCasterLevel *3;
            int id100 = d100(1);
            if (id100< iC)
            {

               AssassinUderDoTepny(oSpellTarget, eDamage,1);
            }

        }
     }/*Konec uderu to tepny*/

    //znacka smrti
     if (GetHasFeat(FEAT_ASSASSIN_ZNACKA_SMRTI,oSpellOrigin))
     {
        int iCasterLevel =GetLevelByClass(CLASS_TYPE_ASSASSIN,oSpellOrigin);
        string sAttackerName = GetLocalString(oSpellTarget, "OZNACEN");
        int iDC = 15 + iCasterLevel/2 + GetAbilityModifier(ABILITY_INTELLIGENCE,oSpellOrigin);
        if (GetName(oSpellOrigin)==sAttackerName)
        {
            if (MySavingThrow(SAVING_THROW_FORT, oSpellTarget, iDC) == 0)
            {
               effect eDeath = EffectDeath();
               ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oSpellTarget);
               SendMessageToPC(oSpellTarget,"Smrt znackou smrti");
            }
        }

     }/*Konec znacky smrti*/

    //udery zlodeje
    //krvacive rany
     if ((iRogueMode == ROGUE_MODE_KRVACIVE_RANY) && (GetHasFeat(FEAT_ROGUE_KRVACIVE_RANY,oSpellOrigin)) && (iTargetRace!=RACIAL_TYPE_UNDEAD) && (iTargetRace!=RACIAL_TYPE_CONSTRUCT) && (iTargetRace!=RACIAL_TYPE_ELEMENTAL) && (iTargetRace!=RACIAL_TYPE_OUTSIDER) && (iTargetRace!=RACIAL_TYPE_OOZE))
     {
        iRandom = d100(1);

        if  (iRandom <= 24)
        {
            SendMessageToPC(oSpellOrigin,"Krvacive rany: " + IntToString(iRandom)+" proti 25. Uspech.");
            if (GetLocalInt(oSpellTarget,"UderDoTepny") == 0)
            {
                int iCasterLevel = GetLevelByClass(CLASS_TYPE_NEWROGUE,oSpellOrigin);
                SetLocalInt(oSpellTarget,"UderDoTepny",(iCasterLevel/5)*2);
                int iDC = 10 + (iCasterLevel+1) / 2;
                effect eDamage = EffectDamage(2);
                if (MySavingThrow(SAVING_THROW_FORT, oSpellTarget, iDC) == 0)
                {
                    AssassinUderDoTepny(oSpellTarget, eDamage,1);
                }

            }
        }
        else
        {
            SendMessageToPC(oSpellOrigin,"Krvacive rany: " + IntToString(iRandom)+"proti 25. Neuspech.");
        }
     }
     if ((iRogueMode == ROGUE_MODE_UTISENI) && GetHasFeat(FEAT_ROGUE_UTISENI,oSpellOrigin))
     {
        iRandom = d100(1);
        if  (iRandom <= 24)
        {
            SendMessageToPC(oSpellOrigin,"Utiseni: " + IntToString(iRandom)+"<25. Uspech.");
            int iCasterLevel = GetLevelByClass(CLASS_TYPE_NEWROGUE,oSpellOrigin);
            effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
            effect eSilence = EffectSilence();
            effect eLink = EffectLinkEffects(eDur2, eSilence);
            int iDC = 10 + (iCasterLevel+1) / 2;
            if (MySavingThrow(SAVING_THROW_FORT, oSpellTarget, iDC) == 0)
            {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oSpellTarget,RoundsToSeconds(iCasterLevel/5));
            }
        }
        else
        {
            SendMessageToPC(oSpellOrigin,"Utiseni: " + IntToString(iRandom)+"proti 25. Neuspech.");
        }
     }

     if ((iRogueMode == ROGUE_MODE_OSLEPENI) && GetHasFeat(FEAT_ROGUE_OSLEPENI,oSpellOrigin))
     {
        iRandom = d100(1);
        if  (iRandom <= 24)
        {
            SendMessageToPC(oSpellOrigin,"Oslepeni: " + IntToString(iRandom)+"proti 25. Uspech.");
            int iCasterLevel = GetLevelByClass(CLASS_TYPE_NEWROGUE,oSpellOrigin);
            effect ef = EffectBlindness();
            effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
            effect eLink = EffectLinkEffects(ef,eDur);
            int iDC = 10 + (iCasterLevel+1) / 2;
            if (MySavingThrow(SAVING_THROW_FORT, oSpellTarget, iDC) == 0)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oSpellTarget,RoundsToSeconds(iCasterLevel/5));
            }
        }
        else
        {
            SendMessageToPC(oSpellOrigin,"Oslepeni: " + IntToString(iRandom)+"proti 25. Neuspech.");
        }
     }
     /*Konec udery zlodeje*/
     if (GetLocalInt(oSpellTarget,"SHINOBI_UTISUJICI_UTOK"))
     {
            int iCasterLevel = GetLevelByClass(CLASS_TYPE_SHINOBI,oSpellOrigin);
            effect ef = EffectSilence();
            int iDC = 15 + (iCasterLevel+1) / 2 + GetAbilityModifier(ABILITY_WISDOM,oSpellOrigin);
            if (MySavingThrow(SAVING_THROW_FORT, oSpellTarget, iDC) == 0)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ef,oSpellTarget,RoundsToSeconds(iCasterLevel/5));
            }
            DeleteLocalInt(oSpellTarget,"SHINOBI_UTISUJICI_UTOK");
     }

    /*Sermir - presny bod*/
    if (GetHasFeat(FEAT_SERMIR_PRESNY_BOD,oSpellOrigin))
     {
        if  (((GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oSpellOrigin)) == BASE_ITEM_RAPIER )
        && GetHasFeat(FEAT_WEAPON_FOCUS_RAPIER, oSpellOrigin))||
        ((GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oSpellOrigin)) == BASE_ITEM_DAGGER )
        && GetHasFeat(FEAT_WEAPON_FOCUS_DAGGER, oSpellOrigin))||
        ((GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oSpellOrigin)) == BASE_ITEM_SHORTSWORD )
        && GetHasFeat(FEAT_WEAPON_FOCUS_SHORT_SWORD, oSpellOrigin)))


         {
            if (
                (GetRacialType(oSpellTarget) != RACIAL_TYPE_UNDEAD) &&
                (GetRacialType(oSpellTarget) != RACIAL_TYPE_ABERRATION) &&
                (GetRacialType(oSpellTarget) != RACIAL_TYPE_CONSTRUCT) &&
                (GetRacialType(oSpellTarget) != RACIAL_TYPE_ELEMENTAL) &&
                (GetRacialType(oSpellTarget) != RACIAL_TYPE_INVALID) &&
                (GetRacialType(oSpellTarget) != RACIAL_TYPE_OOZE)
            )
            {

            int iCasterLevel = GetLevelByClass(CLASS_TYPE_SERMIR,oSpellOrigin);
            int iBonus = (iCasterLevel/5)+1;
            int iDamage = d6(iBonus);
            AssignCommand(oSpellOrigin,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(iDamage,DAMAGE_TYPE_BASE_WEAPON),oSpellTarget));
            }

         }
     }

      /*Exorcista - naruseni magie*/
     if (GetHasFeat(FEAT_EXORCISTA_NARUSENI_MAGIE,oSpellOrigin))
     {

            int iTime = GetLocalInt(oSpellOrigin,ULOZENI_EXORCISTA_NARUSENI_MAGIE);
            if  (ku_GetTimeStamp(GetTimeSecond()-9,GetTimeMinute(),GetTimeHour()) <= iTime)
            {
                int  nCasterLevel = GetLevelByClass(CLASS_TYPE_EXORCISTA);
                effect ef = EffectSpellFailure((nCasterLevel + GetAbilityModifier(ABILITY_CHARISMA)) * 2);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ef,oSpellTarget,RoundsToSeconds(nCasterLevel));
            }
            DeleteLocalInt(oSpellOrigin,ULOZENI_EXORCISTA_NARUSENI_MAGIE);


     }
      /*Cernokneznik - ohavna rana */
     int iNum = GetLocalInt(oSpellOrigin,ULOZENI_CERNOKNEZNIK_OHAVNA_RANA);
     if (iNum > 0)
     {
        int iCasterLevel = GetLevelByClass(CLASS_TYPE_CERNOKNEZNIK,oSpellOrigin);
        int iEsenceType = GetLocalInt(OBJECT_SELF,ULOZENI_CERNOKNEZNIK_TYP_ESENCE);
        int iDamage,iDC,iDur;
        effect eEf,eDur;
        SetLocalInt(oSpellOrigin,ULOZENI_CERNOKNEZNIK_OHAVNA_RANA,iNum-1);
        switch (iEsenceType)
        {
            case ESENCE_MAGIC:
                iDamage = d6((iCasterLevel+1)/2);
                eEf = EffectDamage(iDamage, DAMAGE_TYPE_MAGICAL);
                AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_INSTANT, eEf, oSpellTarget));
                break;

                case ESENCE_SZIRAVA:
                //UTOK DOTYKEM NA DALKU
                iDC = 10 + 5 + GetAbilityModifier(ABILITY_CHARISMA);
                iDur = 1;
                eEf = EffectSlow();
                if(!MySavingThrow(SAVING_THROW_WILL, oSpellTarget, iDC, SAVING_THROW_TYPE_SPELL, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                {
                    AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oSpellTarget,RoundsToSeconds(iDur)));
                }
                break;

                case ESENCE_STRASLIVA:
                //UTOK DOTYKEM NA DALKU
                iDC = 10 + 1 + GetAbilityModifier(ABILITY_CHARISMA);
                iDur = 1;
                eEf = EffectFrightened();
                if(!MySavingThrow(SAVING_THROW_WILL, oSpellTarget, iDC, SAVING_THROW_TYPE_SPELL, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                {
                    AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oSpellTarget,RoundsToSeconds(iDur)));
                }
                break;

                case ESENCE_OSLEPUJICI:
                //UTOK DOTYKEM NA DALKU
                iDC = 10 + 1 + GetAbilityModifier(ABILITY_CHARISMA);
                iDur = 1;
                eEf = EffectBlindness();
                if(!MySavingThrow(SAVING_THROW_WILL, oSpellTarget, iDC, SAVING_THROW_TYPE_SPELL, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                {
                    AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oSpellTarget,RoundsToSeconds(iDur)));
                }
                break;

                case ESENCE_PEKELNA:
                ExecuteScript("x0_s0_inferno",oSpellTarget);
                break;

                case ESENCE_MRAZIVA:
                iDamage = d6((iCasterLevel+1)/2);
                iDC = 10 + 3 + GetAbilityModifier(ABILITY_CHARISMA);
                eDur = EffectAbilityDecrease(ABILITY_DEXTERITY,4);
                if(!MySavingThrow(SAVING_THROW_FORT, oSpellTarget, iDC, SAVING_THROW_TYPE_SPELL, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                {
                    AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oSpellTarget,TurnsToSeconds(10)));
                }
                eEf = EffectDamage(iDamage, DAMAGE_TYPE_COLD);
                AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_INSTANT, eEf, oSpellTarget));
                break;

                case ESENCE_UHRANCIVA:
                //UTOK DOTYKEM NA DALKU
                iDC = 10 + 4 + GetAbilityModifier(ABILITY_CHARISMA);
                iDur = 1;
                eEf = EffectConfused();
                if(!MySavingThrow(SAVING_THROW_FORT, oSpellTarget, iDC, SAVING_THROW_TYPE_SPELL, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                {
                    AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oSpellTarget,RoundsToSeconds(iDur)));
                }
                break;

                case ESENCE_ZADRZUJICI:
                //UTOK DOTYKEM NA DALKU
                iDC = 10 + 5 + GetAbilityModifier(ABILITY_CHARISMA);
                iDur = 1;
                eEf = EffectSlow();
                if(!MySavingThrow(SAVING_THROW_WILL, oSpellTarget, iDC, SAVING_THROW_TYPE_SPELL, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                {
                    AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oSpellTarget,RoundsToSeconds(iDur)));
                }
                break;

                case ESENCE_ZHOUBNA:
                //UTOK DOTYKEM NA DALKU
                iDC = 10 + 5 + GetAbilityModifier(ABILITY_CHARISMA);
                iDur = 1;
                eEf = EffectParalyze();
                if(!MySavingThrow(SAVING_THROW_WILL, oSpellTarget, iDC, SAVING_THROW_TYPE_SPELL, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                {
                    AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oSpellTarget,RoundsToSeconds(iDur)));
                }
                break;

                case ESENCE_LEPTAVA:
                iDamage = d6((iCasterLevel+1)/2);
                eEf = EffectDamage(iDamage, DAMAGE_TYPE_ACID);
                AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_INSTANT, eEf, oSpellTarget));
                break;

                case ESENCE_SVAZUJICI:
                //UTOK DOTYKEM NA DALKU
                iDC = 10 + 5 + GetAbilityModifier(ABILITY_CHARISMA);
                iDur = 1;
                eEf = EffectKnockdown();
                if(!MySavingThrow(SAVING_THROW_WILL, oSpellTarget, iDC, SAVING_THROW_TYPE_SPELL, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                {
                    AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oSpellTarget,RoundsToSeconds(iDur)));
                }
                break;

                case ESENCE_TEMNA:
                iDamage = d6((iCasterLevel+1)/2);
                iDC = 10 + 5 + GetAbilityModifier(ABILITY_CHARISMA);
                eEf = EffectDamage(iDamage, DAMAGE_TYPE_NEGATIVE);
                AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_INSTANT, eEf, oSpellTarget));
                eDur = EffectNegativeLevel(6);
                if(!MySavingThrow(SAVING_THROW_WILL, oSpellTarget, iDC, SAVING_THROW_TYPE_SPELL, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                {
                    AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oSpellTarget,TurnsToSeconds(10)));
                }
                break;

                default:
        }
     }
     if (GetHasFeat(FEAT_KURTIZANA_ODHALENY_ZIVUTEK,oSpellOrigin))
     {
        if (GetLocalInt(oSpellOrigin,"KURTIZANA_ODHALENY_ZIVUTEK") && GetLocalInt(oSpellTarget,"KURTIZANA_ODHALENY_ZIVUTEK_TARGET"))
        {
            int iLaw = GetAlignmentLawChaos(oSpellTarget) == ALIGNMENT_LAWFUL;
            int iCasterLevel = GetLevelByClass(CLASS_TYPE_KURTIZANA,oSpellTarget);
            int iDamage = 0;
            if (iLaw)
            {
                iDamage = d4((iCasterLevel+1)/2+1);
            }
            else
            {
                iDamage = d6((iCasterLevel+1)/2+1);
            }
            effect eDamage = EffectDamage(iDamage,DAMAGE_TYPE_SLASHING);
            AssignCommand(oSpellOrigin,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oSpellTarget));
        }
     }










}

