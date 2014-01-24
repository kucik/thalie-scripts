/*

        Jaara's generic functions

*/

//CONSTANTS
#include "ja_variables"
#include "aps_include"
#include "ja_inc_stamina"
#include "persistence"
#include "me_pcneeds_inc"
#include "sh_classes_inc_e"

//DECLARATIONS

//Returns a random name
string GetRandName(object oCreature);

//Returns a random deity
string GetRandDeity(object oCreature);

//Gets wheter the creature is commoner to run generic dialog
int GetIsCommoner(object oCreature);

//Returns a PC with given name
object FindPCByName(string sName);

//Returns TRUE if the given object is guard
int GetIsGuard(object oGuard);

//Sets as enemy for creatures in range
void SetIsTemporaryEnemyInSphere( object oTarget, int bLineOfSight=TRUE, float fRange=20.0f, int bDecays=TRUE, float fDurationInSeconds=300.0);

//Stores current time
void StoreTime();

//Restores current time
void RestoreTime();

//Returns spell level for oCaster class (or Wizard by default)
int getSpellLevel( int spellID, object oCaster = OBJECT_INVALID );

//Gets a deity alignment 0 - atheist; 1 - good; 2 - neutral; 3 - evil
int GetDeityAlignment(object oPC);

//on script head, proceed master check
int proceedMaster();

//use to ensure script will trigger only once a restart
int doOnce();

// Returns random float 0<=x<1
float randomFloat();

// Returns a soulstone of PC
//object GetSoulStone(object oPC);

// Saves a PC
void SavePlayer(object oPC, int bSaveSpellsAndFeats=1);

// Check if and how much is oWanted wanted in city of guard oGuard
int GetWantedPerson(object oWanted, object oGuard);

//DEFINITIONS

//Returns a random name
string GetRandName(object oCreature)
{
    int iRace = GetRacialType(oCreature);
    int iGen  = GetGender(oCreature);

    string sName;

        switch(iRace)
        {
            case RACIAL_TYPE_DWARF:
                if(iGen == GENDER_FEMALE)
                    sName += RandomName(NAME_FIRST_DWARF_FEMALE);
                else
                    sName += RandomName(NAME_FIRST_DWARF_MALE);
                break;
            case RACIAL_TYPE_ELF:
                if(iGen == GENDER_FEMALE)
                    sName += RandomName(NAME_FIRST_ELF_FEMALE);
                else
                    sName += RandomName(NAME_FIRST_ELF_MALE);
                break;
            case RACIAL_TYPE_GNOME:
                if(iGen == GENDER_FEMALE)
                    sName += RandomName(NAME_FIRST_GNOME_FEMALE);
                else
                    sName += RandomName(NAME_FIRST_GNOME_MALE);
                break;
            case RACIAL_TYPE_HUMAN:
                if(iGen == GENDER_FEMALE)
                    sName += RandomName(NAME_FIRST_HUMAN_FEMALE);
                else
                    sName += RandomName(NAME_FIRST_HUMAN_MALE);
                break;
            case RACIAL_TYPE_HALFELF:
                if(iGen == GENDER_FEMALE)
                    sName += RandomName(NAME_FIRST_HALFELF_FEMALE);
                else
                    sName += RandomName(NAME_FIRST_HALFELF_MALE);
                break;
            case RACIAL_TYPE_HALFORC:
                if(iGen == GENDER_FEMALE)
                    sName += RandomName(NAME_FIRST_HALFORC_FEMALE);
                else
                    sName += RandomName(NAME_FIRST_HALFORC_MALE);
                break;
            case RACIAL_TYPE_HALFLING:
                if(iGen == GENDER_FEMALE)
                    sName += RandomName(NAME_FIRST_HALFLING_FEMALE);
                else
                    sName += RandomName(NAME_FIRST_HALFLING_MALE);
                break;
        }
        sName += " ";
        //surname
        switch(iRace)
        {
            case RACIAL_TYPE_DWARF:
                sName += RandomName(NAME_LAST_DWARF);
                break;
            case RACIAL_TYPE_ELF:
                sName += RandomName(NAME_LAST_ELF);
                break;
            case RACIAL_TYPE_GNOME:
                sName += RandomName(NAME_LAST_GNOME);
                break;
            case RACIAL_TYPE_HUMAN:
                sName += RandomName(NAME_LAST_HUMAN);
                break;
            case RACIAL_TYPE_HALFELF:
                sName += RandomName(NAME_LAST_HALFELF);
                break;
            case RACIAL_TYPE_HALFORC:
                sName += RandomName(NAME_LAST_HALFORC);
                break;
            case RACIAL_TYPE_HALFLING:
                sName += RandomName(NAME_LAST_HALFLING);
                break;
        }

    if(sName == "") sName = GetName(oCreature, TRUE);

    return sName;
}


//Returns a random deity
string GetRandDeity(object oCreature){
    int iRan;
    string sDeity;

    if(GetIsObjectValid(oCreature)){
        string sLoc = GetName(GetArea(oCreature));
        if( FindSubString(sLoc, "Har - Ganeth") == -1 ){
            iRan = Random(10);
        }
        else iRan = Random(3)+10;
    }
    else iRan = Random(13);

    switch(iRan){
        case 0: sDeity = "Juana"; break;
        case 1: sDeity = "Dei-Anang"; break;
        case 2: sDeity = "Nord"; break;
        case 3: sDeity = "Lothian"; break;
        case 4: sDeity = "Lilith"; break;
        case 5: sDeity = "Azhar"; break;
        case 6: sDeity = "Morus"; break;
        case 7: sDeity = "Thal"; break;
        case 8: sDeity = "Zeir"; break;
        case 9: sDeity = "Lilith"; break;
        case 10: sDeity = "Xi´An"; break;
        case 11: sDeity = "Helgaron"; break;
        case 12: sDeity = "Gordul"; break;
    }

    return sDeity;
}

//Gets whether the creature is commoner to run generic dialog
int GetIsCommoner(object oCreature){
    int iHostile = GetFactionEqual(OBJECT_SELF, GetObjectByTag("NPC_FACTION_HOSTILE"));
    if(iHostile)
        return FALSE;

    string sName = GetStringUpperCase(GetName(oCreature));

    if( sName == "OBYVATEL IVORY" ||
        sName == "OBYVATELKA IVORY" ||
        sName == "OBYVATEL KARATHY" ||
        sName == "OBYVATELKA KARATHY" ||
        sName == "OBYVATEL" ||
        sName == "OBYVATELKA" ||
        sName == "ZEMEDELEC" ||
        sName == "ZAKAZNIK" ||
        sName == "ZAKAZNICE" )

//        sName == "STRAZ KARATHY" ||
//        sName == "STRAZ KEL - A - HAZRU" ||
//        sName == "KARATHSKA STRAZ - STRELEC")
            return TRUE;

    return FALSE;
}

//Returns a PC with given name
object FindPCByName(string sName){

    object oPC = GetFirstPC();

    while(GetIsObjectValid(oPC)){
        if(GetName(oPC, TRUE) == sName)
            return oPC;
        oPC = GetNextPC();
    }

    return OBJECT_INVALID;
}

//Returns TRUE if the given object is guard
int GetIsGuard(object oGuard){
    string sName = GetStringUpperCase(GetName(oGuard));
    string sTag  = GetTag(oGuard);
    return GetLocalInt(GetModule(),"KU_STRAZ_"+sTag);

/*    if( sName == "STRAZ KARATHY" ||
        sName == "KARATHSKA STRAZ" ||
        sName == "KARATHSKA SRAZ - STRELEC" ||
        sName == "KARATHSKA STRAZ - STRELEC" ||
        sName == "HORNICKA STRAZ" ||
        sName == "PULCICKA STRAZ" ||
        sTag  == "Pulcickastraz")
            return TRUE;
*/

    return FALSE;
}

//Stores current time
void StoreTime(){

    SetPersistentInt( GetModule(), "JA_TIME_YEAR", GetCalendarYear() );
    SetPersistentInt( GetModule(), "JA_TIME_MONTH", GetCalendarMonth() );
    SetPersistentInt( GetModule(), "JA_TIME_DAY", GetCalendarDay() );

    SetPersistentInt( GetModule(), "JA_TIME_HOUR", GetTimeHour() );
    SetPersistentInt( GetModule(), "JA_TIME_MINUTE", GetTimeMinute() );
    SetPersistentInt( GetModule(), "JA_TIME_SECOND", GetTimeSecond() );
    SetPersistentInt( GetModule(), "JA_TIME_MILISECOND", GetTimeMillisecond() );

}

//Restores current time
void RestoreTime(){

    int iYear  = GetPersistentInt( GetModule(), "JA_TIME_YEAR" );

    if(iYear == 0) return;  //first check

    int iMonth = GetPersistentInt( GetModule(), "JA_TIME_MONTH" );
    int iDay   = GetPersistentInt( GetModule(), "JA_TIME_DAY" );

    int iHour   = GetPersistentInt( GetModule(), "JA_TIME_HOUR" );
    int iMinute = GetPersistentInt( GetModule(), "JA_TIME_MINUTE" );
    int iSecond = GetPersistentInt( GetModule(), "JA_TIME_SECOND" );
    int iMillisecond = GetPersistentInt( GetModule(), "JA_TIME_MILISECOND" );

    SetTime(iHour, iMinute, iSecond, iMillisecond);
    SetCalendar(iYear, iMonth, iDay);

}

//Returns spell level for oCaster class (or Wizard by default)
int getSpellLevel( int nSpellID, object oCaster = OBJECT_INVALID ){

    string sClass;

    if(oCaster == OBJECT_INVALID){
        sClass ="Wiz_Sorc";
    }
    else if (GetLevelByClass(CLASS_TYPE_BARD, oCaster)){
        sClass = "Bard";
    }
    else if (GetLevelByClass(CLASS_TYPE_CLERIC, oCaster)){
        sClass = "Cleric";
    }
    else if (GetLevelByClass(CLASS_TYPE_DRUID, oCaster)){
        sClass = "Druid";
    }
    else if (GetLevelByClass(CLASS_TYPE_PALADIN, oCaster)){
        sClass = "Paladin";
    }
    else if (GetLevelByClass(CLASS_TYPE_RANGER, oCaster)){
        sClass = "Ranger";
    }
    else{
        sClass = "Wiz_Sorc";
    }

    int nSpellLevel = 0;
    string sSpellLevel = Get2DAString("spells",sClass,nSpellID);

    if (sSpellLevel != "")
    {
        nSpellLevel=StringToInt(sSpellLevel);
    }

    return nSpellLevel;
}

//Gets a deity alignment 0 - atheist; 1 - good; 2 - neutral; 3 - evil
int GetDeityAlignment(object oPC){
    string sDeity = GetDeity(oPC);

    if(sDeity == "Juana" || sDeity == "Dei-Anang" || sDeity == "Nord" || sDeity == "Lothian")
        return 1;

    if(sDeity == "Lilith" || sDeity == "Azhar" || sDeity == "Morus" || sDeity == "Thal")
        return 2;

    if(sDeity == "Zeir" || sDeity == "Xi´An" || sDeity == "Helgaron" || sDeity == "Gordul" || sDeity == "Astaroth")
        return 3;

    return 0;
}


//on script head, proceed master check
int proceedMaster(){
    int iHasMaster = GetLocalInt(OBJECT_SELF, "JA_HAS_MASTER");

    if(iHasMaster == 1){
        return 1;
    }

    if(iHasMaster == 2){
        return 0;
    }

    if(iHasMaster == 0){
        if(GetIsObjectValid(GetMaster())){
            SetLocalInt(OBJECT_SELF, "JA_HAS_MASTER", 1);
            return 1;
        }
        else{
            SetLocalInt(OBJECT_SELF, "JA_HAS_MASTER", 2);
            return 0;
        }
    }

    return 0;
}

//use to ensure script will trigger only once a restart
int doOnce(){
    int iTriggered = GetLocalInt(OBJECT_SELF, "JA_TRIGGERED");

    if(iTriggered == 0){
        SetLocalInt(OBJECT_SELF, "JA_TRIGGERED", 1);
    }
    else return 1;

    return 0;
}

void FXWand_Earthquake(object oDM)
{
   // Earthquake Effect by Jhenne, 06/29/02
   // declare variables used for targetting and commands.
   location lDMLoc = GetLocation ( oDM);

   // tell the DM object to shake the screen
   AssignCommand( oDM, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), lDMLoc));
   AssignCommand ( oDM, DelayCommand( 2.8, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_BUMP), lDMLoc)));
   AssignCommand ( oDM, DelayCommand( 3.0, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_SHAKE), lDMLoc)));
   AssignCommand ( oDM, DelayCommand( 4.5, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_BUMP), lDMLoc)));
   AssignCommand ( oDM, DelayCommand( 5.8, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_BUMP), lDMLoc)));
   // tell the DM object to play an earthquake sound
   AssignCommand ( oDM, PlaySound ("as_cv_boomdist1"));
   AssignCommand ( oDM, DelayCommand ( 2.0, PlaySound ("as_wt_thunderds3")));
   AssignCommand ( oDM, DelayCommand ( 4.0, PlaySound ("as_cv_boomdist1")));
   // create a dust plume at the DM and clicking location
   object oTargetArea = GetArea(oDM);
   int nXPos, nYPos, nCount;
   for(nCount = 0; nCount < 15; nCount++)
   {
      nXPos = Random(30) - 15;
      nYPos = Random(30) - 15;

      vector vNewVector = GetPosition(oDM);
      vNewVector.x += nXPos;
      vNewVector.y += nYPos;

      location lDustLoc = Location(oTargetArea, vNewVector, 0.0);
      object oDust = CreateObject ( OBJECT_TYPE_PLACEABLE, "plc_dustplume", lDustLoc, FALSE);
      DelayCommand ( 4.0, DestroyObject ( oDust));
   }
}

// Returns random float 0<=x<1
float randomFloat(){
    return IntToFloat(Random(1000))/1000.0;
}

// Returns a soulstone of PC
/*object GetSoulStone(object oPC){
    object oSoul = GetLocalObject(oPC,"SoulStone");
    if(GetIsObjectValid(oSoul)) {
      return oSoul;
    }

    oSoul = GetItemPossessedBy(oPC, "sy_soulstone");
    SetLocalObject(oPC,"SoulStone",oSoul);
    return oSoul;
}       */

// Saves a PC
void SavePlayer(object oPC, int bSaveSpellsAndFeats=1){
    if(!GetIsPC(oPC) || GetIsDMPossessed(oPC)) return;

     location lLoc = GetLocation(oPC);
     if(!GetIsObjectValid(GetAreaFromLocation(lLoc)))
        lLoc = GetLocalLocation(oPC, "LOCATION");
     else
        SetLocalLocation(oPC, "LOCATION", lLoc);

     int iHP = GetCurrentHitPoints(oPC);
     if(iHP == 0)
        iHP = GetLocalInt(oPC, "HP");
     else
        SetLocalInt(oPC, "HP", iHP);


     float fStamina = GetLocalFloat(oPC, "JA_STAMINA");

     if((GetTag(GetAreaFromLocation(lLoc)) != "th_start_gp") && (GetTag(GetAreaFromLocation(lLoc)) != "th_vitejte"))
         SetPersistentLocation(oPC, "LOCATION", lLoc);

/*
     if(bSaveSpellsAndFeats != 0){
         string spells = pGetSpells(oPC);
         string feats  = pGetFeats(oPC);

         SetPersistentString(oPC, "SPELLS", spells);
         SetPersistentString(oPC, "FEATS", feats);
     }
 */
     SetPersistentInt(oPC, "HP", iHP);
     SetPersistentFloat(oPC, "STAMINA", fStamina);

    //needs
    float fWaterR = GetLocalFloat(oPC, VARNAME_WATER );
    float fAlcoholR = GetLocalFloat(oPC, VARNAME_ALCOHOL );
    float fFoodR = GetLocalFloat(oPC, VARNAME_FOOD );

    SetPersistentFloat(oPC, VARNAME_WATER, fWaterR);
    SetPersistentFloat(oPC, VARNAME_FOOD, fFoodR);
    SetPersistentFloat(oPC, VARNAME_ALCOHOL, fAlcoholR);
    //~needs

    // Save XP and GOLD to DB
   // SetPersistentInt(oPC,"XP_BACKUP",GetXP(oPC));
   // SetPersistentInt(oPC,"GOLD_BACKUP",GetGold(oPC));
    //~Save XP and GOLD to DB

    effect ePoly = GetFirstEffect(oPC);
    int flag = 1;

    //WriteTimestampedLogEntry("BEFORE polymorph check");
    while(GetIsEffectValid(ePoly)){
        if(GetEffectType(ePoly) == EFFECT_TYPE_POLYMORPH){
            flag = 0;
            break;
        }
        ePoly = GetNextEffect(oPC);
    }

    if(flag){ //is NOT polymorphed
        ExportSingleCharacter(oPC);
        //WriteTimestampedLogEntry("exporting player"+ GetPCPlayerName(oPC));
    }
}

int GetWantedPerson(object oWanted, object oGuard) {

  object oSoul = GetSoulStone(oWanted);
  object oMod = GetModule();

  int mesto = GetLocalInt(OBJECT_SELF,"KU_STRAZ_"+GetTag(oGuard));
  return GetLocalInt(oSoul,"KU_WANTED_"+IntToString(mesto));


}

