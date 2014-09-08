//
//  NWSubraces
//
//  Basic subrace functionality
//
//  (c) Shir'le E. Illios, 2002 (shirle@drowwanderer.com)
//
////////////////////////////////////////////////////////
/*
 * rev. Kucik 06.01.2008 pridana funkce pro zjisteni, zda je postava z podtemna
 * Kucik 27.05.2008 Oprava - mazani nastaveni lokace pri relogu
 *
 */

// Include the subrace definitions and the subraces code.
#include "sei_subraces"
//#include "sei_subraceslst"
#include "aps_include"
//#include "sei_xp"   //removed by Kucik



//  END KUCIK

int AREA_NONE                       =   0;
int AREA_DEFAULT_LIGHT              =   1;
int AREA_DARK                       =   2;
int AREA_LIGHT                      =   3;
int AREA_SUN                        =   4;
int AREA_DEFAULT_GROUND             =  10;
int SEI_AREA_UNDERGROUND            =  20;
int SEI_AREA_ABOVEGROUND            =  30;
int KU_AREA_DEFAULT                 = 100;
int KU_AREA_SURFACE                 = 200;
int KU_AREA_UNDERDARK               = 300;

// **************************************************************
// ** Structures
// **********************

// Structure used to pass information on a certain subrace.
struct Subrace
{
    int m_nID;
    int m_nBaseRace;
    int m_nNumFieldValues;
    int m_nNumTraits;
    int m_nLightSensitivity;
    float m_fLightBlindness;
    int m_nStonecunning;
    int m_bIsDefault;

//  ADDED BY KUCIK
    int m_nECLClass;
    int m_bIsUnderdark;
    int m_nAlignmentMask;
    int m_nWingType;
    int m_nWingLevel;
    int m_nTailType;
    int m_nTailLevel;
    int m_nChangeAppearance;
    int m_nRacialType;
//  END KUCIK
};


const int PEVNINAN = 0;
const int PODTEMNAN = 1;
const int PRITEL = 2;
const int OTROK = 3;


// **************************************************************
// ** Event functions
// **********************

// Initializes the available subraces and everything that is needed to properly
// run this script.
// Call this function in the OnModuleLoad event of the module.
//
void Subraces_InitSubraces();


// Sets the default area settings. This is so you don't have to do it for every area.
// Call this function in the OnModuleLoad event of the module.
//  ARGUMENTS:
//      a_nSettings = What the default settings for the area are.
//                    There is light-level:
//                      AREA_DARK   - The area is considered dark.
//                      AREA_LIGHT  - The area is considered daylight.
//                      AREA_SUN    - The light level depends on the sun (day/night).
//                    And there is the 'ground' setting:
//                      SEI_AREA_UNDERGROUND    - The area is underground.
//                      SEI_AREA_ABOVEGROUND    - The area is above ground.
//                    Add the setting for lightness to that of ground for the
//                    final setting, i.e.:
//                      Subraces_SetDefaultAreaSettings( AREA_DARK + SEI_AREA_UNDERGROUND );
//                    for if most of the areas in the module are dark and underground.
//
void Subraces_SetDefaultAreaSettings( int a_nSettings );


// Initializes the subrace for character a_oCharacter.
// Call this function in the OnClientEnter event of the module.
//  ARGUMENTS:
//      a_oCharacter    = The character to initialize the subrace for
//
void Subraces_InitSubrace( object a_oCharacter );


// Modifies the character's subrace attributes on a character's level up.
// Call this function in the OnPlayerLevelUp event of the module.
//  ARGUMENTS:
//      a_oCharacter    = The character to level up.
//
void Subraces_LevelUpSubrace( object a_oCharacter );


// Makes sure that the subrace is set correctly again when the character respawns.
//  ARGUMENTS:
//      a_oCharacter    = The character respawning.
//
void Subraces_RespawnSubrace( object a_oCharacter );


// Does some subrace specific things when a character enters a new area.
// Call this function in the OnEnter event of every area.
//  ARGUMENTS:
//      a_oCharacter    = The character to enter the new area.
//      a_nSettings     = The light and (under)ground settings of the area.
//                        Don't specify this argument to use module defaults.
//
void Subraces_OnEnterArea( object a_oCharacter, int a_nSettings = 0 );




// **************************************************************
// ** Useage functions
// **********************

// Returns the subrace (enum) for the target.
//  ARGUMENTS:
//      a_oCharacter    = The character to get the subrace from (assumed valid)
//  RESULT:
//      The subrace of a_oCharacter (see te "SUBRACE_" variables)
//
int Subraces_GetCharacterSubrace( object a_oCharacter );


// Returns whether the character is of subrace a_nSubrace.
//  ARGUMENTS:
//      a_oCharacter    = The character to get the subrace from (assumed valid)
//      a_nSubrace      = The subrace to check against
//  RESULT:
//      Whether a_oCharacter is of subrace a_nSubrace
//
int Subraces_IsCharacterOfSubrace( object a_oCharacter, int a_nSubrace );


// Returns the effective character level of the character.
//  ARGUMENTS:
//      a_oCharacter    = The character to get the ECL from (assumed valid)
//
int Subraces_GetEffectiveCharacterLevel( object a_oCharacter );


// Returns if is character from underdark
// return 1 if yes
//        0 if not
//  ARGUMENTS:
//      a_oCharacter    = The character which we want (assumed valid)
//
int Subraces_GetIsCharacterFromUnderdark( object a_oCharacter );


// Remove subrace related items before starting a new module.
// If the new module supports subraces it should re-initialize them.
//  ARGUMENTS:
//      a_sModuleName   = The name of the module to start.
//
void Subraces_StartNewModule( string a_sModuleName );


// Remove subrace related items before sending PC through protal.
// If the new server supports subraces it should re-initialize them.
//  ARGUMENTS:
//      a_oTarget       = The character to send through the portal.
//      a_sIPaddress    = This can be numerical "192.168.0.84" or alphanumeric
//                        "www.bioware.com". It can also contain a port
//                        "192.168.0.84:5121" or "www.bioware.com:5121"; if the
//                        port is not specified, it will default to 5121.
//      a_sPassword     = Login password for the destination server.
//      a_sWaypointTag  = If this is set, after portalling the character will be
//                        moved to this waypoint if it exists.
//      a_bSeamless     = If this is set, the client wil not be prompted with
//                        the information window telling them about the server,
//                        and they will not be allowed to save a copy of their
//                        character if they are using a local vault character.
//
void Subraces_ActivatePortal( object a_oTarget, string a_sIPaddress="", string a_sPassword="", string a_sWaypointTag="", int a_bSeemless=FALSE );


// Change the area settings dependent traits for the character.
// This function can for instance be called in the OnEnter and OnExit scripts
// of a trigger to create an area where the settings differ from the rest of the
// area. (Like a room of sunlight in an otherwise lightless dungeon).
//  ARGUMENTS:
//      a_oCharacter    = The character the settings affect.
//      a_nSettings     = What these differing settings are. Leave away to reset
//                        to the area defaults.
//
void Subraces_ChangeAreaSettings( object a_oCharacter, int a_nSettings = 0 );


// A subrace safe version of BioWare's RemoveEffect function. Removes effect
// in such a way as not to touch te subraces (i.e. te subraces are safe).
//  ARGUMENTS:
//      a_oCreature     = The creature to remove the effect from.
//      a_eEffect       = The effect to remove from the creature.
//
void Subraces_SafeRemoveEffect( object a_oCreature, effect a_eEffect );


// A subrace safe version that removes all non-subrace effects from the char.
//  ARGUMENTS:
//      a_oCreature     = The creature to remove the effect from.
//
void Subraces_SafeRemoveEffects( object a_oCreature );

// Check if was changed day/night
// Execute it in ModuleHeartbeat as often as you want
//
void Subraces_ModuleHeartBeat();

// heartbeat jen pro jedno pc
// pridano melvik > optimalizace
void Subraces_ModuleHeartBeatPC(object oPC);

int Subrace_GetECLClass( object a_oCharacter );


// **************************************************************
// ** Function definitions
// **********************

// Initializes the available subraces and everything that is needed to properly
// run this script.
//
void Subraces_InitSubraces()
{
    SEI_InitSubraces();
}


// Sets the default area settings. This is so you don't have to do it for every area.
//
void Subraces_SetDefaultAreaSettings( int a_nSettings )
{
    SEI_SetDefaultAreaSettings( a_nSettings );
}


// Initializes the subrace for character a_oCharacter.
//
void Subraces_InitSubrace( object a_oCharacter )
{
    if(SUBRACE_DEBUG)
      SendMessageToPC(a_oCharacter, "Nastavuji subrasu. "+GetName(OBJECT_SELF));
    DeleteLocalInt(a_oCharacter, GROUND_SETTING );
    object oPermEffect = GetLocalObject(GetModule(),KU_SUBRACES_PERM_FIELD);
    AssignCommand( oPermEffect, SEI_InitSubrace( a_oCharacter ) );
    SEI_InitSubrace( a_oCharacter );
    if(SUBRACE_DEBUG)
      SendMessageToPC(a_oCharacter,"Subrasa nastavena.");

    // Dopocitej skillpointy
    KU_CalcAndGiveSkillPoints(a_oCharacter);
}


// Modifies the character's subrace attributes on a character's level up.
//
void Subraces_LevelUpSubrace( object a_oCharacter )
{
    SEI_LevelUpSubrace( a_oCharacter );
}


// Makes sure that the subrace is set correctly again when the character respawns.
//
void Subraces_RespawnSubrace( object a_oCharacter )
{
    SEI_InitSubrace( a_oCharacter );
}


// Does some subrace specific things when a character enters a new area.
//
void Subraces_OnEnterArea( object a_oCharacter, int a_nSettings = 0 )
{

    object oArea = GetArea(a_oCharacter);
    // Use JA_LOC_TYPE variable to set area environment
    if(a_nSettings == 0) {
      a_nSettings=ku_CountAreaEnvSettings(oArea);
    }
    if(SUBRACE_DEBUG)
      SendMessageToPC(GetFirstPC(),"area setting " + IntToString(a_nSettings));
    SEI_EnterArea( a_oCharacter, oArea, a_nSettings );
}

// Does some subrace specific things when a character enters a new area.
//
void KU_Subraces_OnEnterArea( object a_oCharacter, int a_nSettings = 0 )
{
    object oArea = GetArea(a_oCharacter);
    // Use JA_LOC_TYPE variable to set area environment
    if(a_nSettings == 0) {
      a_nSettings=ku_CountAreaEnvSettings(oArea);
    }
    if(SUBRACE_DEBUG)
      SendMessageToPC(GetFirstPC(),"area setting " + IntToString(a_nSettings));

//    object oExecutor = GetObjectByTag(KU_SUBRACES_AREA_TAG);
    object oMod = GetModule();
//    object oExecutor = a_oCharacter;
    object oExecutor = GetLocalObject(oMod,KU_SUBRACES_AREA_FIELD);
/*    SetLocalObject(oExecutor,"KU_CHARAKTER",a_oCharacter);
    SetLocalObject(oExecutor,"KU_AREA",oArea);
    SetLocalInt(oExecutor,"KU_AREA_SETTINGS",a_nSettings);
    ExecuteScript("ku_apply_area_s",oExecutor);
*/

    AssignCommand( oExecutor, SEI_EnterArea( a_oCharacter, oArea, a_nSettings ) );
//    SEI_EnterArea( a_oCharacter, oArea, a_nSettings );
}

// Returns the subrace (enum) for the target.
//
int Subraces_GetCharacterSubrace( object a_oCharacter )
{
    return SEI_GetCharacterSubrace( a_oCharacter );
}


// Returns whether the character is of subrace a_nSubrace.
//
int Subraces_IsCharacterOfSubrace( object a_oCharacter, int a_nSubrace )
{
    return SEI_IsCharacterOfSubrace( a_oCharacter, a_nSubrace );
}


// Returns if the character is from underdark.
//
int Subraces_GetIsCharacterFromUnderdark( object a_oCharacter )
{
    return KU_GetIsFromUnderdark( a_oCharacter );
}


// Remove subrace related items before starting a new module.
//
void Subraces_StartNewModule( string a_sModuleName )
{
    object oPC = GetFirstPC();
    while( GetIsObjectValid( oPC ) )
    {
        SEI_RemoveSubrace( oPC );
        oPC = GetNextPC();
    }
    StartNewModule( a_sModuleName );
}


// Remove subrace related items before sending PC through protal.
//
void Subraces_ActivatePortal( object a_oTarget, string a_sIPaddress="", string a_sPassword="", string a_sWaypointTag="", int a_bSeemless=FALSE )
{
    SEI_RemoveSubrace( a_oTarget );
    ActivatePortal( a_oTarget, a_sIPaddress, a_sPassword, a_sWaypointTag, a_bSeemless );
}


// Change the area settings dependent traits for the character.
//
void Subraces_ChangeAreaSettings( object a_oCharacter, int a_nSettings = 0 )
{
    SEI_ApplyAreaSettings( a_oCharacter, GetArea(a_oCharacter), a_nSettings );
}


// A subrace safe version of BioWare's RemoveEffect function.
//
void Subraces_SafeRemoveEffect( object a_oCreature, effect a_eEffect )
{
    SEI_RemoveEffect( a_oCreature, a_eEffect );
}


// A subrace safe version that removes all non-subrace effects from the char.
//
void Subraces_SafeRemoveEffects( object a_oCreature )
{
    SEI_RemoveEffects( a_oCreature );
/*    object oExecutor = GetObjectByTag(KU_SUBRACES_PERM_TAG + IntToString(Random(10)));
    SetLocalObject(oExecutor,"KU_CHARAKTER",a_oCreature);
    SetLocalInt(oExecutor,"KU_INCLUDE_ITEMS",FALSE);
    ExecuteScript("ku_subr_init_tr",oExecutor); */
    object oPermEffect = GetLocalObject(GetModule(),KU_SUBRACES_PERM_FIELD);
    AssignCommand( oPermEffect, SEI_InitSubraceTraits( a_oCreature ) );
//    SEI_InitSubraceTraits( a_oCreature, FALSE );
}

void Subraces_ModuleHeartBeat()
{
    ku_SubraceModuleHeartbeat();
}


void Subraces_ModuleHeartBeatPC(object oPC)
{
    me_SubraceModuleHeartbeat(oPC);
}

int Subraces_GetIsSubraceEffect(effect eBad) {

	    if(GetEffectSubType(eBad) != SUBTYPE_SUPERNATURAL)
	      return FALSE;

	    string sCreator = GetTag(GetEffectCreator(eBad));
	    if(sCreator == KU_SUBRACES_PERM_TAG)
	      return TRUE;
	    if(sCreator == KU_SUBRACES_AREA_TAG)
	      return TRUE;

	    return FALSE;
/*
    int iSpellId = GetEffectSpellId(eBad);
    if(iSpellId >= 10999 && iSpellId <= 12000) {
      return TRUE;
    }

    return FALSE;*/
}

int Subrace_DMOnlyAllowed(object oPC, int iLoud=TRUE) {
 object oSoul = GetSoulStone(oPC);

 /* Check for bad duplicit characters */
 if(GetPersistentInt(oPC, "PLAYED") &&
    !GetLocalInt(oSoul,"PLAYED")) {

   SendMessageToAllDMs("Player "+GetPCPlayerName(oPC)+" logged with duplicit character "+GetName(oPC)+"!!!");
   SpeakString("Chybna postava. Kontaktuj DM.");
   return TRUE;
 }

  switch(Subraces_GetCharacterSubrace(oPC)) {
    case SUBRACE_HUMAN_AASIMAR:
    case SUBRACE_HUMAN_TIEFLING:
     if(iLoud) {
        SpeakString("Tato rasa je povolena jen se souhlasem DM. Pozadej DM, aby te vpustil do sveta.");
      }
      return TRUE;
    default: break;
  }

  return FALSE;
}

int Subrace_GetECLClass( object a_oCharacter ) {

  return SEI_GetECLClass( a_oCharacter );
}

// SEI_TODO: Added for development. Remove!
/*
void main ()
{
}
//*/


