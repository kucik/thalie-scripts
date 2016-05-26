
//
//  NWSubracesList
//
//  Function that creates a list defining all available subraces.
//
//  (c) Shir'le E. Illios, 2002 (shirle@drowwanderer.com)
//
////////////////////////////////////////////////////////
/*
 * rev. 19.01.2008 Kucik uprava svirfneblina a duergara
 * rev. 23.01.2008 Kucik upravy podtemna, aasimara a vocasa
 * rev. 27.01.2008 Kucik oprava black goblina
 *
 */

 // **************************************************************
// ** Constants
// **********************

// Enum of the supported subraces
const int SUBRACE_NONE                    =   0;  // No Subrace set yet
const int SUBRACE_MONSTER                 =   1;  // For monsters, etc. without subrace

const int SUBRACE_HUMAN_CITY              =   2;  // Clovek mestsky  - DEFAULT
const int SUBRACE_HUMAN_SLAVE             =   3;  // Clovek otrok   - PODTEMNO
const int SUBRACE_HUMAN_DESERT            =   4;  // Clovek poustni
const int SUBRACE_HUMAN_NORDIC            =   5;  // Clovek seversky
const int SUBRACE_HUMAN_EAST              =   6;  // Clovek vychodni
const int SUBRACE_HUMAN_AASIMAR           =   7;  // Clovek mestsky
const int SUBRACE_HUMAN_TIEFLING          =   8;  // Clovek mestsky
const int SUBRACE_HUMAN_GENASI_WATER      =   9;  // Clovek mestsky
const int SUBRACE_HUMAN_GENASI_AIR        =   10;  // Clovek mestsky
const int SUBRACE_HUMAN_GENASI_EARTH      =   11;  // Clovek mestsky
const int SUBRACE_HUMAN_GENASI_FIRE       =   12;  // Clovek mestsky

const int SUBRACE_ELF_WOOD                =   13;  // Elf lesni
const int SUBRACE_ELF_WILD                =   14;  // Elf divoky
const int SUBRACE_ELF_MOON                =   15;  // Elf mesicni
const int SUBRACE_ELF_SUN                 =   16;  // Elf slunecni
const int SUBRACE_ELF_WINGED              =   17;  // Elf okridleny
const int SUBRACE_ELF_EAST                =   18;  // Elf vychodni
const int SUBRACE_ELF_DROW                =   19;  // Drow           - PODTEMNO
const int SUBRACE_ELF_OBSIDIAN_DROW       =   20;  // Drow obsidianovy - PODTEMNO

const int SUBRACE_DWARF_MOUNTAIN          =   21;  // Trpaslik horsky
const int SUBRACE_DWARF_GOLD              =   22;  // Trpaslik zlaty
const int SUBRACE_DWARF_SHIELD            =   23;  // Trpaslik stitovy
const int SUBRACE_DWARF_DUERGAR           =   24;  // Duergar           - PODTEMNO
const int SUBRACE_DWARF_DUERGAR_BRONZED   =   25;  // Duergar Bronzovy  - PODTEMNO

const int SUBRACE_ORC_CITY                =   26;  // Pulork mestsky
const int SUBRACE_ORC_NORDIC              =   27;  // Pulork seversky
const int SUBRACE_ORC_DEEP                =   28;  // Pulork hlubinny   - PODTEMNO
const int SUBRACE_ORC_HIRAN               =   29;  // Hiran             - PODTEMNO

const int SUBRACE_HALFLING_CITY           =   30;  // Pulcik mestsky
const int SUBRACE_HALFLING_WILD           =   31;  // Pulcik divoky
const int SUBRACE_HALFLING_DEEP           =   32;  // Pulcik hlubinny   - PODTEMNO
const int SUBRACE_HALFLING_KOBOLD         =   33;  // Kobold            - PODTEMNO

const int SUBRACE_GNOME_CITY              =   34;  // Gnom mestsky
const int SUBRACE_GNOME_SWIRFNEBLIN       =   35;  // Svirfneblin       - PODTEMNO
const int SUBRACE_GNOME_GOBLIN_DEEP       =   36;  // Skret hlubinny    - PODTEMNO
const int SUBRACE_GNOME_PIXIE             =   37;  // Pixie

const int SUBRACE_HALFELF                 =   38;  // Pulelf
const int SUBRACE_HALFDRAGON_BLACK        =   39;  // Puldrak cerny
const int SUBRACE_HALFDRAGON_BLUE         =   40;  // Puldrak modry
const int SUBRACE_HALFDRAGON_GREEN        =   41;  // Puldrak zeleny
const int SUBRACE_HALFDRAGON_RED          =   42;  // Puldrak cerveny
const int SUBRACE_HALFDRAGON_WHITE        =   43;  // Puldrak bily
const int SUBRACE_ILLITHID                =   44;  // Illithid          - PODTEMNO



// This file contains the data defining the subraces. In this way it is very
// easy to change existing subraces or add new ones. Below follows an
// explanation of the functions and fields available to set the subrace data.
//
//
// SEI_CreateSubrace( Subrace, Base race, Description )
//
//  This function creates a new subrace. The first parameter must be a unique
//  ID number to define the subrace (best would be to add to the SUBRACE_ enum
//  list). The second parameter is the base race on which the subrace is based
//  and the third parameter is a textual descriptive name for the subrace.
//
//
// SEI_AddFieldText( subrace struct, Text )
//
//  This function adds a text that the subrace will recognize. When a character
//  of the subrace's base race has this text somewhere in their "Subrace" field
//  (on their character sheet) the character will be seen as a character of this
//  subrace. Multiple texts can be added to allow for maximum compatibility.
//
//
// SEI_AddTrait( subrace struct, "<trait>" )
//
//  This function adds a subrace trait (as represented by an effect) to the
//  character. Each trait consists of a string that the script will interpret
//  and translate to the correct effect. For this a strict syntax must be
//  followed. Below is a list of all the texts it recognizes. Everything between
//  angular brackets "<>" has it's own section with tokens to put there. Thus a
//  trait can be 'constructed'.
//
//
// trait:
// - "ability_inc <ability> <amount>"       = Increase ability by amount
// - "ability_dec <ability> <amount>"       = Decrease ability by amount
// - "skill_inc <skill> <amount>"           = Increase skill by amount
// - "skill_dec <skill> <amount>"           = Decrease skill by amount
// - "save_inc <save> <amount> <save-type>" = Increase saving throws of save and save-type by amount
// - "save_dec <save> <amount> <save-type>" = Decrease saving throws of save and save-type by amount
//
// ability:
// - "0" = ABILITY_STRENGTH
// - "1" = ABILITY_DEXTERITY
// - "2" = ABILITY_CONSTITUTION
// - "3" = ABILITY_INTELLIGENCE
// - "4" = ABILITY_WISDOM
// - "5" = ABILITY_CHARISMA
//
// save:
// - "0" = SAVING_THROW_ALL
// - "1" = SAVING_THROW_FORT
// - "2" = SAVING_THROW_REFLEX
// - "3" = SAVING_THROW_WILL
//
// save-type:
// -  "0" = SAVING_THROW_TYPE_ALL
// -  "1" = SAVING_THROW_TYPE_MIND_SPELLS
// -  "2" = SAVING_THROW_TYPE_POISON
// -  "3" = SAVING_THROW_TYPE_DISEASE
// -  "4" = SAVING_THROW_TYPE_FEAR
// -  "5" = SAVING_THROW_TYPE_SONIC
// -  "6" = SAVING_THROW_TYPE_ACID
// -  "7" = SAVING_THROW_TYPE_FIRE
// -  "8" = SAVING_THROW_TYPE_ELECTRICITY
// -  "9" = SAVING_THROW_TYPE_POSITIVE
// - "10" = SAVING_THROW_TYPE_NEGATIVE
// - "11" = SAVING_THROW_TYPE_DEATH
// - "12" = SAVING_THROW_TYPE_COLD
// - "13" = SAVING_THROW_TYPE_DIVINE
// - "14" = SAVING_THROW_TYPE_TRAP
// - "15" = SAVING_THROW_TYPE_SPELL
// - "16" = SAVING_THROW_TYPE_GOOD
// - "17" = SAVING_THROW_TYPE_EVIL
// - "18" = SAVING_THROW_TYPE_LAW
// - "19" = SAVING_THROW_TYPE_CHAOS
//
//
//
// stSubrace.m_nLightSensitivity = <sensitivity level>;
//
//  This field sets the subrace's light sensitivity. Characters sensitive to
//  bright light get a penalty based on the light sensitivity. Note that while
//  light blindness isn't included in the light sensitivity, a subrace must have
//  a light sensitivity of at least 1 to have light blindness.
//
// sensitivity level:
//  0 = Not sensitive to bright light.
//  1 = Exposure to bright light give a -1 penalty.
//  2 = Exposure to bright light give a -2 penalty.
//  3 = Blindness if on daylight - by kucik
//
//
// stSubrace.m_nStonecunning = <TRUE/FALSE>;
//
//  This field describes if the subrace gives stonecunning. Characters with
//  stonecunning will have a higher search and hide skill while underground.
//
//
// stSubrace.m_nSpellLikeAbility = <spell-like ability>;
//
//  This field describes which spell-like ability the subrace gives. Currently
//  there are three spell-like abilities supported (based on spells available
//  in NWN): Blindness/deafness, darkness and invisibility. A subrace can only
//  have one spell-like ability.
//
// spell-like ability:
//  0 = No spell-like ability.
//  1 = Blindness/deafness
//  2 = Darkness
//  3 = Invisibility
//  4 = Cure light wounds once a day
//  5 = Inflict light wounds once a day
//
//
// stSubrace.m_bSpellResistance = <TRUE/FALSE>;
//
//
//
// stSubrace.m_nECLAdd = <amount to add for ECL>;
//
//  These fields set how much must be added to the subrace's level to get to
//  the effective character level. This is used to define the powerful races.
//
//
// stSubrace.m_bIsDefault = <TRUE/FALSE>;
//
//  This field sets if the subrace is the default race for the base race. Only
//  use it if you know what you're doing.
//
//
//  ADDED BY KUCIK
//
// m_nECLClass
//
//  ECL Class - urcuje postih na expy pridelovane za cas
//
// m_bIsUnderdark
//
//  Nastavuje se, pokud subrasa patri do podtemna
//
//
// m_nAlignmentMask
//
//  Maska presvedceni
//                LAWFUL
//      ||=======================||
//  E   ||   400 |   40  |   4   ||  G
//  V   ||-----------------------||  O
//  I   ||   200 |   20  |   2   ||  O
//  L   ||-----------------------||  D
//      ||   100 |   10  |   1   ||
//      ||=======================||
//                CHAOTIC
//
//  END KUCIK
//
// SEI_SaveSubrace( subrace struct )
//
//  Once the subrace is completely defined this function saves the data so
//  that characters can become this subrace when they enter.


// **************************************************************
// ** Forward declarations
// **********************

// Private function for the subraces script. Do not use.
struct Subrace SEI_CreateSubrace( int a_nSubrace, int a_nBaseRace, string a_sDescription );

// Private function for the subraces script. Do not use.
struct Subrace SEI_AddFieldText( struct Subrace a_stSubrace, string a_sText );

// Private function for the subraces script. Do not use.
struct Subrace SEI_AddTrait( struct Subrace a_stSubrace, string a_sTrait );

// Private function for the subraces script. Do not use.
void SEI_SaveSubrace( struct Subrace a_stSubrace );


// Define all available subraces.
//
void SEI_DefineSubraces()
{

    struct Subrace stSubrace;


    ////////////////////////////////////////////////////////////////////////////
    // Default subraces
    ////////////////////////////////////////////////////////////////////////////

    // SEI_NOTE: The favored classes for the default subraces need to be the
    //           same as the favored classes for the base races in NWN.
    //           Only change the default subraces if you know what you're doing.

//////////////////////////-- LIDE --//////////////////////////
    // Clovek mestsky  - DEFAULT
    stSubrace = SEI_CreateSubrace( SUBRACE_HUMAN_CITY, RACIAL_TYPE_HUMAN, "Clovek");

    stSubrace.m_bIsDefault = TRUE;
    stSubrace = SEI_AddTrait( stSubrace, "dlouhy_mec" );
    SEI_SaveSubrace( stSubrace );

    // Clovek otrok- PODTEMNO
    stSubrace = SEI_CreateSubrace( SUBRACE_HUMAN_SLAVE, RACIAL_TYPE_HUMAN, "Clovek Otrok" );
    // The favored class for elves is any.
    stSubrace = SEI_AddFieldText( stSubrace, "otrok" );                // "otrok"
    stSubrace.m_nLightSensitivity = 3;                                  // Slepy na svetle
    stSubrace.m_bIsUnderdark = 1;                                       // Subrasa podtemna
    stSubrace = SEI_AddTrait( stSubrace, "dlouhy_mec" );
    SEI_SaveSubrace( stSubrace );


    // Clovek poustni
    stSubrace = SEI_CreateSubrace( SUBRACE_HUMAN_DESERT, RACIAL_TYPE_HUMAN, "Poustni Clovek" );
    stSubrace = SEI_AddFieldText( stSubrace, "desert" );                // "desert"
    stSubrace = SEI_AddFieldText( stSubrace, "poustni" );               // "poustni"
    stSubrace = SEI_AddFieldText( stSubrace, "pustny" );                // "pustny"
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 4 2" );           // -2 Wis
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 2 2" );           // +2 Con
    stSubrace = SEI_AddTrait( stSubrace, "scimitar" );
    stSubrace = SEI_AddTrait( stSubrace, "falchion" );
    SEI_SaveSubrace( stSubrace );

    // Clovek seversky
    stSubrace = SEI_CreateSubrace( SUBRACE_HUMAN_NORDIC, RACIAL_TYPE_HUMAN, "Severan" );
    stSubrace = SEI_AddFieldText( stSubrace, "nordic" );                // "nordic"
    stSubrace = SEI_AddFieldText( stSubrace, "severan" );               // "severan"
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 3 2" );           // -2 Int
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 0 2" );           // +2 Con
    SEI_SaveSubrace( stSubrace );

    // Clovek vychodni
    stSubrace = SEI_CreateSubrace( SUBRACE_HUMAN_EAST, RACIAL_TYPE_HUMAN, "Vychodni Clovek" );
    stSubrace = SEI_AddFieldText( stSubrace, "vychodnan" );                // "vychodnan"
    stSubrace = SEI_AddFieldText( stSubrace, "east" );                // "vychodni"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 1 2" );           // +2 Dex
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 2 2" );           // -2 Con
    stSubrace = SEI_AddTrait( stSubrace, "zbrane_vychodni" );
    SEI_SaveSubrace( stSubrace );

    // Define the "Aasimar" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_HUMAN_AASIMAR, RACIAL_TYPE_HUMAN, "Aasimar" );
    stSubrace = SEI_AddFieldText( stSubrace, "aasimar" );               // "aasimar"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 5 2" );           // +2 Cha
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 4 2" );           // +2 wis
    //pridat leceni
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nECLClass = 2;                                          // Postih na expy = 2
    stSubrace.m_nAlignmentMask = 7;                                     // good
    stSubrace.m_nWingType = CREATURE_WING_TYPE_ANGEL;                   // Andelska kridla
    stSubrace.m_nWingLevel = 21;                                        // ^^ na 21. levelu
    stSubrace.m_nRacialType = RACIAL_TYPE_OUTSIDER;
    SEI_SaveSubrace( stSubrace );

    // Define the "Tiefling" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_HUMAN_TIEFLING, RACIAL_TYPE_HUMAN, "Tiefling" );
    stSubrace = SEI_AddFieldText( stSubrace, "tiefling" );              // "tiefling"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 1 2" );           // +2 Dex
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 3 2" );           // +2 Int
    //pridat zran
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nECLClass = 2;                                          // Postih na expy = 2
    stSubrace.m_nAlignmentMask = 700;                                   // Evil
    stSubrace.m_nWingType = CREATURE_WING_TYPE_DEMON;                   // Kridla demona
    stSubrace.m_nWingLevel = 21;                                        // ^^ na 21. levelu
    stSubrace.m_nTailType = CREATURE_TAIL_TYPE_DEVIL;                   // Ocas
    stSubrace.m_nTailLevel = 1;                                         // ^^ na 1. levelu
    stSubrace.m_nRacialType = RACIAL_TYPE_OUTSIDER;
    SEI_SaveSubrace( stSubrace );

    // Clovek Genasi vodni
    stSubrace = SEI_CreateSubrace( SUBRACE_HUMAN_GENASI_WATER, RACIAL_TYPE_HUMAN, "Vodni genasi" );
    stSubrace = SEI_AddFieldText( stSubrace, "vodni genasi" );                // "Vodni genasi"
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 5 2" );           // -2 Cha
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 2 2" );           // +2 Con
    stSubrace = SEI_AddTrait( stSubrace, "genasi_kuzel_mrazu" );
    stSubrace.m_nRacialType = RACIAL_TYPE_OUTSIDER;
    SEI_SaveSubrace( stSubrace );

    // Clovek Genasi vzdusny
    stSubrace = SEI_CreateSubrace( SUBRACE_HUMAN_GENASI_AIR, RACIAL_TYPE_HUMAN, "Vzdusny genasi" );
    stSubrace = SEI_AddFieldText( stSubrace, "vzdusny genasi" );                // "Vzdusny genasi"
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 5 2" );           // -2 Cha
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 1 2" );           // +2 Dex
    stSubrace = SEI_AddTrait( stSubrace, "genasi_zavan_vetru" );
    stSubrace.m_nRacialType = RACIAL_TYPE_OUTSIDER;
    SEI_SaveSubrace( stSubrace );

    // Clovek Genasi vzdusny
    stSubrace = SEI_CreateSubrace( SUBRACE_HUMAN_GENASI_EARTH, RACIAL_TYPE_HUMAN, "Zemni genasi" );
    stSubrace = SEI_AddFieldText( stSubrace, "zemni genasi" );                // "Zemni genasi"
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 5 2" );           // -2 Cha
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 0 2" );           // +2 Str
    stSubrace = SEI_AddTrait( stSubrace, "genasi_kamenna_kuze" );
    stSubrace.m_nRacialType = RACIAL_TYPE_OUTSIDER;
    SEI_SaveSubrace( stSubrace );

     // Clovek Genasi ohnivy
    stSubrace = SEI_CreateSubrace( SUBRACE_HUMAN_GENASI_FIRE, RACIAL_TYPE_HUMAN, "Ohnivy genasi" );
    stSubrace = SEI_AddFieldText( stSubrace, "ohnivy genasi" );                // "Ohnivy genasi"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 3 2" );           // +2 Int
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 5 2" );           // -2 Cha
    stSubrace = SEI_AddTrait( stSubrace, "genasi_fireball" );
    stSubrace.m_nRacialType = RACIAL_TYPE_OUTSIDER;
    SEI_SaveSubrace( stSubrace );

//////////////////////////-- Elfove --//////////////////////////

    // Lesni elf - default
    stSubrace = SEI_CreateSubrace( SUBRACE_ELF_WOOD, RACIAL_TYPE_ELF, "Lesni Elf" );
    stSubrace.m_bIsDefault = TRUE;
    stSubrace = SEI_AddTrait( stSubrace, "dlouhy_mec" );
    stSubrace = SEI_AddTrait( stSubrace, "dlouhy_luk" );
    SEI_SaveSubrace( stSubrace );

     // Divoky elf
    stSubrace = SEI_CreateSubrace( SUBRACE_ELF_WILD, RACIAL_TYPE_ELF, "Divoky Elf" );
    stSubrace = SEI_AddFieldText( stSubrace, "wild" );                  // "wild elf"
    stSubrace = SEI_AddFieldText( stSubrace, "divoky" );                // "divoky elf"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 0 2" );           // +2 Str
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 3 2" );           // -2 Int
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 1 2" );           // -2 Dex
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 2 2" );           // +2 Str
    stSubrace = SEI_AddTrait( stSubrace, "dlouhy_mec" );
    stSubrace = SEI_AddTrait( stSubrace, "dlouhy_luk" );
    SEI_SaveSubrace( stSubrace );

    //Mesicni elf
    stSubrace = SEI_CreateSubrace( SUBRACE_ELF_MOON, RACIAL_TYPE_ELF, "Mesicni Elf" );
    stSubrace = SEI_AddFieldText( stSubrace, "moon" );                  // "moon"
    stSubrace = SEI_AddFieldText( stSubrace, "mesicni" );               // "mesicni elf"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 3 2" );           // +2 Int
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 1 2" );           // -2 Dex
    stSubrace = SEI_AddTrait( stSubrace, "dlouhy_mec" );
    stSubrace = SEI_AddTrait( stSubrace, "dlouhy_luk" );
    SEI_SaveSubrace( stSubrace );


     //Slunecni elf
    stSubrace = SEI_CreateSubrace( SUBRACE_ELF_SUN, RACIAL_TYPE_ELF, "Slunecni Elf" );
    stSubrace = SEI_AddFieldText( stSubrace, "sun" );                   // "sun elf"
    stSubrace = SEI_AddFieldText( stSubrace, "slunecni" );              // "slunecni elf"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 5 2" );           // +2 Char
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 1 2" );           // -2 Dex
    stSubrace = SEI_AddTrait( stSubrace, "dlouhy_mec" );
    stSubrace = SEI_AddTrait( stSubrace, "dlouhy_luk" );
    SEI_SaveSubrace( stSubrace );



    //Okridleny elf
    stSubrace = SEI_CreateSubrace( SUBRACE_ELF_WINGED, RACIAL_TYPE_ELF, "Okridleny Elf" );
    stSubrace = SEI_AddFieldText( stSubrace, "winged" );                // "winged elf"
    stSubrace = SEI_AddFieldText( stSubrace, "okridleny" );             // "okridleny elf"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 1 2" );           // +2 Dex
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 0 2" );           // -2 Str
    stSubrace.m_nAlignmentMask = 33;                                    // non lawfull and non evil
    stSubrace.m_nECLClass = 1;                                          // Postih na expy = 1
    stSubrace.m_nWingType = CREATURE_WING_TYPE_BIRD;                    // Ptaci kridla
    stSubrace.m_nWingLevel = 21;                                        // na 15. levelu
    stSubrace = SEI_AddTrait( stSubrace, "dlouhy_mec" );
    stSubrace = SEI_AddTrait( stSubrace, "dlouhy_luk" );
    SEI_SaveSubrace( stSubrace );


      // Vychodni elf
    stSubrace = SEI_CreateSubrace( SUBRACE_ELF_EAST, RACIAL_TYPE_ELF, "Vychodni Elf" );
    stSubrace = SEI_AddFieldText( stSubrace, "vychodni" );                  // "vychodni elf"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 4 2" );           // +2 Wis
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 1 2" );           // -2 Dex
    stSubrace = SEI_AddTrait( stSubrace, "zbrane_vychodni" );
    SEI_SaveSubrace( stSubrace );


    // Drow obsidianovy
    stSubrace = SEI_CreateSubrace( SUBRACE_ELF_OBSIDIAN_DROW, RACIAL_TYPE_ELF, "Drow obsidianovy" );
    stSubrace = SEI_AddFieldText( stSubrace, "obsidian" );       // "obsidian"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 5 2" );           // +2 Cha
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 3 2" );           // +2 Int
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 1 2" );           // -2 Dex
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nLightSensitivity = 3;                                  // Slepy na svetle
    stSubrace = SEI_AddTrait( stSubrace, "drow_temnota" );
    stSubrace = SEI_AddTrait( stSubrace, "bic" );
    stSubrace = SEI_AddTrait( stSubrace, "scimitar" );
    stSubrace = SEI_AddTrait( stSubrace, "tezka_kuse" );
    stSubrace.m_nECLClass = 1;                                          // Postih na expy = 2
    stSubrace.m_bIsUnderdark = 1;                                       // Subrasa podtemna
    SEI_SaveSubrace( stSubrace );

    // Drow
    stSubrace = SEI_CreateSubrace( SUBRACE_ELF_DROW, RACIAL_TYPE_ELF, "Drow" );
    stSubrace = SEI_AddFieldText( stSubrace, "drow" );                  // "drow"
    stSubrace.m_nAlignmentMask = 700;                                    // evil
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nLightSensitivity = 3;                                  // Slepy na svetle
    stSubrace.m_bIsUnderdark = 1;                                       // Subrasa podtemna
    stSubrace = SEI_AddTrait( stSubrace, "drow_temnota" );
    stSubrace = SEI_AddTrait( stSubrace, "bic" );
    stSubrace = SEI_AddTrait( stSubrace, "scimitar" );
    stSubrace = SEI_AddTrait( stSubrace, "lehka_kuse" );
    SEI_SaveSubrace( stSubrace );


//////////////////////////-- TRPASLICI --//////////////////////////

//  Stitovy
    stSubrace = SEI_CreateSubrace( SUBRACE_DWARF_SHIELD, RACIAL_TYPE_DWARF, "Stitovy Trpaslik" );
    stSubrace = SEI_AddFieldText( stSubrace, "shield" );    // "shield dwarf"
    stSubrace = SEI_AddFieldText( stSubrace, "stitovy" );    // "shield dwarf"
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_bIsDefault = TRUE;
    stSubrace = SEI_AddTrait( stSubrace, "trpaslici_sekera" );
    stSubrace = SEI_AddTrait( stSubrace, "trpaslik_stitovy" );
    SEI_SaveSubrace( stSubrace );

//  Horsky
    stSubrace = SEI_CreateSubrace( SUBRACE_DWARF_MOUNTAIN, RACIAL_TYPE_DWARF, "Horsky Trpaslik" );
    stSubrace = SEI_AddFieldText( stSubrace, "horsky" );    // "shield dwarf"
    stSubrace = SEI_AddFieldText( stSubrace, "mountain" );    // "shield dwarf"
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 0 2" );           // +2 Str
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 2 2" );           // -2 Con
    stSubrace = SEI_AddTrait( stSubrace, "trpaslici_sekera" );
    stSubrace = SEI_AddTrait( stSubrace, "trpaslik_horsky" );
    SEI_SaveSubrace( stSubrace );

    // Zlaty trpos
    stSubrace = SEI_CreateSubrace( SUBRACE_DWARF_GOLD, RACIAL_TYPE_DWARF, "Zlaty Trpaslik" );
    stSubrace = SEI_AddFieldText( stSubrace, "gold" );                  // "gold"
    stSubrace = SEI_AddFieldText( stSubrace, "zlaty" );                 // "zlaty"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 4 2" );           // +2 Wis
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 1 2" );           // -2 Dex
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 5 2" );           // +2 Cha
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 2 2" );           // -2 Con
    stSubrace = SEI_AddTrait( stSubrace, "trpaslici_sekera" );
    stSubrace = SEI_AddTrait( stSubrace, "trpaslik_zlaty" );
    SEI_SaveSubrace( stSubrace );


    // Bronzovy duergar
    stSubrace = SEI_CreateSubrace( SUBRACE_DWARF_DUERGAR_BRONZED, RACIAL_TYPE_DWARF, "Bronzovy Duergar" );
    stSubrace = SEI_AddFieldText( stSubrace, "bronzovy" );               // "bronzovy"
    //dodelat imunitu na paralyzu
    //dodelat imunitu na jedy
    stSubrace = SEI_AddTrait( stSubrace, "feat_add 203" );              // VenomImmunity
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 5 2" );           // +2 Cha
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nLightSensitivity = 3;                                  // Slepy na svetle
    stSubrace.m_nECLClass = 1;                                          // Postih na expy = 1
    stSubrace.m_bIsUnderdark = 1;                                       // Subrasa podtemna
    stSubrace.m_nAlignmentMask = 700;                                    // evil
    stSubrace = SEI_AddTrait( stSubrace, "trpaslici_sekera" );
    stSubrace = SEI_AddTrait( stSubrace, "trpaslik_duergar" );
    SEI_SaveSubrace( stSubrace );

    // Duergar
    stSubrace = SEI_CreateSubrace( SUBRACE_DWARF_DUERGAR, RACIAL_TYPE_DWARF, "Duergar" );
    stSubrace = SEI_AddFieldText( stSubrace, "duergar" );               // "duergar"
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nLightSensitivity = 3;                                  // Slepy na svetle
    stSubrace.m_bIsUnderdark = 1;                                       // Subrasa podtemna
    stSubrace.m_nAlignmentMask = 700;                                    // evil
    stSubrace = SEI_AddTrait( stSubrace, "trpaslici_sekera" );
    stSubrace = SEI_AddTrait( stSubrace, "trpaslik_duergar" );
    SEI_SaveSubrace( stSubrace );


//////////////////////////-- ORKOVE --//////////////////////////

    // Mestsky ork
    stSubrace = SEI_CreateSubrace( SUBRACE_ORC_CITY, RACIAL_TYPE_HALFORC, "Mestsky Pul-Ork" );
    stSubrace = SEI_AddFieldText( stSubrace, "mestsky pulork" );                // "mestsky pulork"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 2 2" );           // +2 Con
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 0 2" );           // -2 Str
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 1 1" );           // +1 Dex
    stSubrace = SEI_AddTrait( stSubrace, "dvojity_palcat" );
    stSubrace = SEI_AddTrait( stSubrace, "dvojity_mec" ) ;
    stSubrace = SEI_AddTrait( stSubrace, "dvojita_sekera" ) ;
    stSubrace = SEI_AddTrait( stSubrace, "ork_zurivost" );
    SEI_SaveSubrace( stSubrace );

    // Seversky ork
    stSubrace = SEI_CreateSubrace( SUBRACE_ORC_NORDIC, RACIAL_TYPE_HALFORC, "Severni Pul-Ork" );
    stSubrace = SEI_AddFieldText( stSubrace, "nordic" );                // "nordic"
    stSubrace = SEI_AddFieldText( stSubrace, "seversky" );              // "seversky"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 1 1" );           // +1 Dex
    stSubrace.m_bIsDefault = TRUE;
    stSubrace = SEI_AddTrait( stSubrace, "dvojity_palcat" );
    stSubrace = SEI_AddTrait( stSubrace, "dvojity_mec" ) ;
    stSubrace = SEI_AddTrait( stSubrace, "dvojita_sekera" ) ;
    stSubrace = SEI_AddTrait( stSubrace, "ork_zurivost" );
    SEI_SaveSubrace( stSubrace );

    // Hlubinny ork
    stSubrace = SEI_CreateSubrace( SUBRACE_ORC_DEEP, RACIAL_TYPE_HALFORC, "Hlubinny ork" );
    stSubrace = SEI_AddFieldText( stSubrace, "hlubinny ork" );          // "hlubinny ork"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 1 1" );           // +1 Dex
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nLightSensitivity = 3;                                  // Slepy na svetle
//    stSubrace.m_nECLClass = 1;                                          // Postih na expy = 1
    stSubrace.m_bIsUnderdark = 1;                                       // Subrasa podtemna
    stSubrace.m_nAlignmentMask = 770;                                    // no good
    stSubrace = SEI_AddTrait( stSubrace, "dvojity_palcat" );
    stSubrace = SEI_AddTrait( stSubrace, "dvojity_mec" ) ;
    stSubrace = SEI_AddTrait( stSubrace, "dvojita_sekera" ) ;
    stSubrace = SEI_AddTrait( stSubrace, "ork_zurivost" );
    SEI_SaveSubrace( stSubrace );

    // Hiran
    stSubrace = SEI_CreateSubrace( SUBRACE_ORC_HIRAN, RACIAL_TYPE_HALFORC, "Hiran" );
    stSubrace = SEI_AddFieldText( stSubrace, "hiran" );                 // "hiran"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 0 2" );           // +2 Str
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 2 4" );           // +4 Con
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 4 2" );           // -2 Wis
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 5 2" );           // -2 Cha
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nLightSensitivity = 3;                                  // Slepy na svetle
    stSubrace.m_nECLClass = 1;                                          // Postih na expy = 1
    stSubrace.m_bIsUnderdark = 1;                                       // Subrasa podtemna
    stSubrace.m_nAlignmentMask = 770;                                    // no good
    stSubrace.m_nChangeAppearance = 985;                                // favored class barbarian
    SEI_SaveSubrace( stSubrace );


//////////////////////////-- Pulcikove --//////////////////////////

    // Mestsky
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFLING_CITY, RACIAL_TYPE_HALFLING, "Mestsky Pulcik" );
    stSubrace = SEI_AddFieldText( stSubrace, "city" );                  //"city"
    stSubrace = SEI_AddFieldText( stSubrace, "mestsky" );               //"mestsky"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 3 2" );           // +2 Int
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 1 2" );           // -2 Dex
    stSubrace = SEI_AddTrait( stSubrace, "kukri" );
    SEI_SaveSubrace( stSubrace );

    // Divoky
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFLING_WILD, RACIAL_TYPE_HALFLING, "Divoky Pulcik" );
    stSubrace = SEI_AddFieldText( stSubrace, "wild" );                  // "wild"
    stSubrace = SEI_AddFieldText( stSubrace, "divoky" );                // "divoky"
    stSubrace.m_bIsDefault = TRUE;
    SEI_SaveSubrace( stSubrace );

    // Hlubinny pulcik
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFLING_DEEP, RACIAL_TYPE_HALFLING, "Hlubinny pulcik" );
    stSubrace = SEI_AddFieldText( stSubrace, "deep" );                  // "deep"
    stSubrace = SEI_AddFieldText( stSubrace, "hlubinny" );              // "hlubinny"
    stSubrace = SEI_AddTrait( stSubrace, "ultravision" );               // Ultravision
    stSubrace.m_bIsUnderdark = 1;                                       // Subrasa podtemna
    stSubrace.m_nLightSensitivity = 3;
    stSubrace.m_nAlignmentMask = 770;                                    // no good
    SEI_SaveSubrace( stSubrace );

    // Kobold
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFLING_KOBOLD, RACIAL_TYPE_HALFLING, "Kobold" );
    stSubrace = SEI_AddTrait( stSubrace, "feat_add 203" );              // VenomImmunity
    stSubrace = SEI_AddFieldText( stSubrace, "kobold" );                // "kobold"
    stSubrace = SEI_AddTrait( stSubrace, "ultravision" );               // Ultravision
    stSubrace.m_bIsUnderdark = 1;                                       // Subrasa podtemna
    stSubrace.m_nLightSensitivity = 3;
    stSubrace.m_nChangeAppearance = 984;                                // Kobold
    stSubrace.m_nAlignmentMask = 770;                                    // no good
    SEI_SaveSubrace( stSubrace );

//////////////////////////-- Gnomove --//////////////////////////


    // Mestsky
    stSubrace = SEI_CreateSubrace( SUBRACE_GNOME_CITY, RACIAL_TYPE_GNOME, "Gnome" );
    stSubrace = SEI_AddFieldText( stSubrace, "mestsky gnom" );
    stSubrace.m_bIsDefault = TRUE;
    SEI_SaveSubrace( stSubrace );

    // Define the "svirfneblin" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_GNOME_SWIRFNEBLIN, RACIAL_TYPE_GNOME, "Svirfneblin" );
    stSubrace = SEI_AddFieldText( stSubrace, "svirfneblin" );           // "svirfneblin"
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 5 2" );           // -2 Cha
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 3 2" );           // +2 Int
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nLightSensitivity = 3;                                  // Slepy na svetle
    stSubrace.m_bIsUnderdark = 1;                                       // Subrasa podtemna
    stSubrace.m_nAlignmentMask = 770;                                    // no good
    SEI_SaveSubrace( stSubrace );

    // Hlubinny skret
    stSubrace = SEI_CreateSubrace( SUBRACE_GNOME_GOBLIN_DEEP, RACIAL_TYPE_GNOME, "Hlubinny Skret" );
    stSubrace = SEI_AddFieldText( stSubrace, "skret" );           // "skret"
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 5 2" );           // -2 Cha
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 0 2" );           // +2 Str
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nLightSensitivity = 3;                                  // Slepy na svetle
    stSubrace.m_bIsUnderdark = 1;                                       // Subrasa podtemna
    stSubrace.m_nAlignmentMask = 770;                                   // no good
    stSubrace.m_nChangeAppearance = 1159;
    SEI_SaveSubrace( stSubrace );

    // Pixie
    stSubrace = SEI_CreateSubrace( SUBRACE_GNOME_PIXIE, RACIAL_TYPE_GNOME, "Pixie" );
    stSubrace = SEI_AddFieldText( stSubrace, "pixie" );           // "pixie"
//    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 0 2" );           // -2 Con
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 0 4" );           // -4 Str
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 1 4" );           // +4 Dex
//    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 2 4" );           // -2 Con
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 2 2" );           // -2 Con
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 5 2" );           // +2 Cha
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nECLClass = 2;                                          // Postih na expy = 2
    stSubrace.m_nAlignmentMask = 333;                                   // no lawfull
    stSubrace.m_nWingType = CREATURE_WING_TYPE_BUTTERFLY;               // Fairy kridla(5) nebo 11-15,48-56
    stSubrace.m_nWingLevel = 1;       // ^^ na 1. levelu
    stSubrace = SEI_AddTrait( stSubrace, "finty" );
    stSubrace = SEI_AddTrait( stSubrace, "kridla_let" );
    stSubrace.m_nChangeAppearance = 1002;
    stSubrace.m_nRacialType = RACIAL_TYPE_OUTSIDER;
    SEI_SaveSubrace( stSubrace );

//////////////////////////-- Pulelfove --//////////////////////////

    // Pulelf
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFELF, RACIAL_TYPE_HALFELF, "Pul-Elf" );
    stSubrace = SEI_AddFieldText( stSubrace, "pulelf" );           // "pulelf"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 1 1" );           // +1 Dex
    stSubrace.m_bIsDefault = TRUE;
    stSubrace = SEI_AddTrait( stSubrace, "dlouhy_mec" );
    stSubrace = SEI_AddTrait( stSubrace, "dlouhy_luk" );
    SEI_SaveSubrace( stSubrace );

    // Cerny puldrak
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFDRAGON_BLACK, RACIAL_TYPE_HALFELF, "Cerny puldrak" );
    stSubrace = SEI_AddFieldText( stSubrace, "cerny puldrak" );               // "cerny puldrak"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 1 2" );           // +2 Dex
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nECLClass = 2;                                          // Postih na expy = 2
    stSubrace.m_nWingType = 34;                                          // 65,75
    stSubrace.m_nWingLevel = 21;                                        // ^^ na 21. levelu
    stSubrace.m_nTailType = 9;                                          // Ocas
    stSubrace.m_nTailLevel = 1;                                         // ^^ na 1. levelu
    stSubrace = SEI_AddTrait( stSubrace, "puldrak_dech_cerny" );
    stSubrace.m_nRacialType = RACIAL_TYPE_HALFELF;
    SEI_SaveSubrace( stSubrace );

    // Modry puldrak
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFDRAGON_BLUE, RACIAL_TYPE_HALFELF, "Modry puldrak" );
    stSubrace = SEI_AddFieldText( stSubrace, "modry puldrak" );               // "modry puldrak"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 4 2" );           // +2 Wis
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nECLClass = 2;                                          // Postih na expy = 2
    stSubrace.m_nWingType = 35;                                          // 67,77
    stSubrace.m_nWingLevel = 21;                                        // ^^ na 21. levelu
    stSubrace.m_nTailType = 10;                                          // Ocas
    stSubrace.m_nTailLevel = 1;                                         // ^^ na 1. levelu
    stSubrace = SEI_AddTrait( stSubrace, "puldrak_dech_modry" );
    stSubrace.m_nRacialType = RACIAL_TYPE_HALFELF;
    SEI_SaveSubrace( stSubrace );

    // Zeleny puldrak
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFDRAGON_GREEN, RACIAL_TYPE_HALFELF, "Zeleny puldrak" );
    stSubrace = SEI_AddFieldText( stSubrace, "zeleny puldrak" );               // "zeleny puldrak"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 2 2" );           // +2 Con
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nECLClass = 2;                                          // Postih na expy = 2
    stSubrace.m_nWingType = 40;                                          // 66,76
    stSubrace.m_nWingLevel = 21;                                        // ^^ na 21. levelu
    stSubrace.m_nTailType = 11;                                          // Ocas
    stSubrace.m_nTailLevel = 1;                                         // ^^ na 1. levelu
    stSubrace = SEI_AddTrait( stSubrace, "puldrak_dech_zeleny" );
    stSubrace.m_nRacialType = RACIAL_TYPE_HALFELF;
    SEI_SaveSubrace( stSubrace );

    // Cerveny puldrak
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFDRAGON_RED, RACIAL_TYPE_HALFELF, "Cerveny puldrak" );
    stSubrace = SEI_AddFieldText( stSubrace, "cerveny puldrak" );               // "cerveny puldrak"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 3 2" );           // +2 int
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nECLClass = 2;                                          // Postih na expy = 2
    stSubrace.m_nWingType = 4;                                          // 68,78
    stSubrace.m_nWingLevel = 21;                                        // ^^ na 21. levelu
    stSubrace.m_nTailType = 12;                                          // Ocas
    stSubrace.m_nTailLevel = 1;                                         // ^^ na 1. levelu
    stSubrace = SEI_AddTrait( stSubrace, "puldrak_dech_cerveny" );
    stSubrace.m_nRacialType = RACIAL_TYPE_HALFELF;
    SEI_SaveSubrace( stSubrace );

    // Bily puldrak
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFDRAGON_WHITE, RACIAL_TYPE_HALFELF, "Bily puldrak" );
    stSubrace = SEI_AddFieldText( stSubrace, "bily puldrak" );               // "bily puldrak"
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 0 2" );           // +2 Str
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nECLClass = 2;                                          // Postih na expy = 2
    stSubrace.m_nWingType = 42;                                          // 64,74
    stSubrace.m_nWingLevel = 21;                                        // ^^ na 21. levelu
    stSubrace.m_nTailType = 13;                                          // Ocas
    stSubrace.m_nTailLevel = 1;                                         // ^^ na 1. levelu
    stSubrace = SEI_AddTrait( stSubrace, "puldrak_dech_bily" );
    stSubrace.m_nRacialType = RACIAL_TYPE_HALFELF;
    SEI_SaveSubrace( stSubrace );

    // Illithid
    stSubrace = SEI_CreateSubrace( SUBRACE_ILLITHID, RACIAL_TYPE_HALFELF, "Illithid " );
    stSubrace = SEI_AddFieldText( stSubrace, "illithid" );           // "Illithid "
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 0 2" );           // -2 Str
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 2 4" );           // -4 Con
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 4 2" );           // +2 Wis
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 3 4" );           // +4 Int
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );                // Darkvision
    stSubrace.m_nLightSensitivity = 3;                                  // Slepy na svetle
    stSubrace.m_nECLClass = 1;                                          // Postih na expy = 1
    stSubrace.m_bIsUnderdark = 1;                                       // Subrasa podtemna
    stSubrace.m_nAlignmentMask = 700;                                   // evil
    stSubrace.m_nChangeAppearance = 413;
    stSubrace = SEI_AddTrait( stSubrace, "zamereni_ocarovani" );
    stSubrace = SEI_AddTrait( stSubrace, "illithid_zachrane_hody" );
    stSubrace.m_nRacialType = RACIAL_TYPE_ABERRATION;
    SEI_SaveSubrace( stSubrace );







} // End SEI_DefineSubraces


