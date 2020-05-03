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




    /*Sermir - presny bod*/
    if (GetHasFeat(FEAT_SERMIR_PRESNY_BOD,oSpellOrigin))
     {
        int iBaseMain = GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oSpellOrigin));
        int iResult = FALSE;
        switch(iBaseMain) {
            case BASE_ITEM_KATANA:
            case BASE_ITEM_SHORTSPEAR:
            case BASE_ITEM_DWARVENWARAXE:
            case 317:  // Heavy mace
            case 301:  // heavy pick
            case BASE_ITEM_LONGSWORD:
            case BASE_ITEM_BATTLEAXE:
            case BASE_ITEM_WARHAMMER:
            case BASE_ITEM_MORNINGSTAR:
            case 304:  // Nunchaku
            case 319:  // Mercurial longsword
            case 203:  // One handed spear
            case 300:  // Onehanded triden
            case BASE_ITEM_SHORTSWORD:
            case BASE_ITEM_RAPIER:
            case BASE_ITEM_SCIMITAR:
            case BASE_ITEM_KAMA:
            case BASE_ITEM_SICKLE:
            case BASE_ITEM_HANDAXE:
            case BASE_ITEM_LIGHTHAMMER:
            case BASE_ITEM_CLUB:
            case BASE_ITEM_LIGHTMACE:
            case 303:  // Sai
            case 308:  // Sap
            case 302:  // Light pick
            case BASE_ITEM_DAGGER:
            case BASE_ITEM_WHIP:
            case BASE_ITEM_KUKRI:
            case 310:  // Katar
            case BASE_ITEM_LIGHTFLAIL:
              iResult = TRUE;

            int iRacialType = GetRacialType(oSpellTarget) ;
            if (
                (iRacialType != RACIAL_TYPE_UNDEAD) &&
                (iRacialType != RACIAL_TYPE_ABERRATION) &&
                (iRacialType != RACIAL_TYPE_CONSTRUCT) &&
                (iRacialType != RACIAL_TYPE_ELEMENTAL) &&
                (iRacialType != RACIAL_TYPE_INVALID) &&
                (iRacialType != RACIAL_TYPE_OOZE) &&
                (iResult == TRUE)
            )
            {
            int iBonus = 1;
            int iCasterLevel = GetLevelByClass(CLASS_TYPE_SERMIR,oSpellOrigin);
            if (iCasterLevel >= 4)
            {
                iBonus = (iCasterLevel/5)+2;
            }
            if (GetHasFeat(1652,oSpellOrigin) == TRUE)//Vylepseny presny bod
            {
                iBonus += 1;
            }
            if (GetHasFeat(1653,oSpellOrigin) == TRUE)//Vylepseny presny bod
            {
                iBonus += 1;
            }
            if (GetHasFeat(1654,oSpellOrigin) == TRUE)//Vylepseny presny bod
            {
                iBonus += 1;
            }
            if (GetHasFeat(1655,oSpellOrigin) == TRUE)//Vylepseny presny bod
            {
                iBonus += 1;
            }
            if (GetHasFeat(1656,oSpellOrigin) == TRUE)//Vylepseny presny bod
            {
                iBonus += 1;
            }
            if (GetHasFeat(1657,oSpellOrigin) == TRUE)//Vylepseny presny bod
            {
                iBonus += 1;
            }
            if (GetHasFeat(1658,oSpellOrigin) == TRUE)//Vylepseny presny bod
            {
                iBonus += 1;
            }
            if (GetHasFeat(1659,oSpellOrigin) == TRUE)//Vylepseny presny bod
            {
                iBonus += 1;
            }
            if (GetHasFeat(1660,oSpellOrigin) == TRUE)//Vylepseny presny bod
            {
                iBonus += 1;
            }
            if (GetHasFeat(1661,oSpellOrigin) == TRUE)//Vylepseny presny bod
            {
                iBonus += 1;
            }


            int iDamage = d6(iBonus);
            AssignCommand(oSpellOrigin,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(iDamage,DAMAGE_TYPE_BLUDGEONING),oSpellTarget));
            }

         }
     }
}

