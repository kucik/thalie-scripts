//::///////////////////////////////////////////////
//:: Example XP2 OnLoad Script
//:: x2_mod_def_load
//:: (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Put into: OnModuleLoad Event

    This example script demonstrates how to tweak the
    behavior of several subsystems in your module.

    For more information, please check x2_inc_switches
    which holds definitions for several variables that
    can be set on modules, creatures, doors or waypoints
    to change the default behavior of Bioware scripts.

    Warning:
    Using some of these switches may change your games
    balancing and may introduce bugs or instabilities. We
    recommend that you only use these switches if you
    know what you are doing. Consider these features
    unsupported!

    Please do NOT report any bugs you experience while
    these switches have been changed from their default
    positions.

    Make sure you visit the forums at nwn.bioware.com
    to find out more about these scripts.

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-16
//:://////////////////////////////////////////////
/*
 * Kucik 19.10.2008 Pridana inicializace chat commandu
 * Kucik 05.01.2009 Pridan init munice
 */

#include "x2_inc_switches"
#include "x2_inc_restsys"
#include "nwnx_weapons"
#include "nwnx_areas"
#include "restart"
#include "subraces"
#include "ku_ships"
#include "ku_libbase"
#include "ku_libchat"
#include "ku_loot_inc"
#include "ja_inc_frakce"
#include "quest_inc"

void __saveAllPlayers(float delay);
void __InitWeaponsFeats();

void __resetResmanLocStatus() {
  string sql = "UPDATE resman_locations SET status='0';";
  SQLExecDirect(sql);
}

void __updateAreaTable(object oArea) {
  string sql = "UPDATE location_property SET name ='"+SQLEncodeSpecialChars(GetName(oArea))+"' WHERE tag = '"+GetTag(oArea)+"';";
  SQLExecDirect(sql);
}

void __setMarkLocationLoaded(string sResRef) {
  string sql = "UPDATE resman_locations SET status='3' where location = '"+sResRef+"';";
  SQLExecDirect(sql);
}

void __loadLocations() {
  object oArea;

  /* Mark locations in module */
  oArea = GetFirstArea();
  while(GetIsObjectValid(oArea)) {
    __setMarkLocationLoaded(GetResRef(oArea));
    __updateAreaTable(oArea);
    WriteTimestampedLogEntry("AREAS: Area "+GetResRef(oArea)+" ("+GetTag(oArea)+") marked as loaded.");
    oArea = GetNextArea();
  }

  /* Load the rest of locations */
  string sSql = "SELECT location from resman_locations where status='0';";
  SQLExecDirect(sSql);
  while (SQLFetch() == SQL_SUCCESS) {
    string sResRef = SQLGetData(1);
    WriteTimestampedLogEntry("AREAS: Load Area:"+sResRef);
    oArea = LoadArea(sResRef);
    DelayCommand(10.0,__setMarkLocationLoaded(sResRef));
    WriteTimestampedLogEntry("AREAS: Area "+GetResRef(oArea)+" ("+GetTag(oArea)+") marked as loaded.");
  }

}



void __saveAllPlayers(float delay) {
  object oPC = GetFirstPC();

  while(GetIsObjectValid(oPC)) {
    if(!GetIsDM(oPC))
      SavePlayer(oPC,0);

    oPC = GetNextPC();
  }

  DelayCommand(delay,__saveAllPlayers(delay));
}

void __AllowLogin() {
  SetPersistentInt(OBJECT_SELF,"PLAYERS_LOGIN_ALLOWED",1);
}

void main()
{
Subraces_InitSubraces();
 Subraces_SetDefaultAreaSettings( KU_AREA_SURFACE + AREA_DARK + SEI_AREA_UNDERGROUND );
//lode
KU_DefineShips();
//Sila potrebna pro zbrane
KU_DefineWeaponPrereq();

//Inicializace chat commandu
ku_ChatCommandsInit();

//Incinializace artefaktu
ExecuteScript("ig_art_inicmod", OBJECT_SELF);

   // Disable nwn craft
   SetLocalInt(OBJECT_SELF,  "X2_L_DO_NOT_ALLOW_MODIFY_ARMOR", TRUE);

/*   if (GetGameDifficulty() ==  GAME_DIFFICULTY_CORE_RULES || GetGameDifficulty() ==  GAME_DIFFICULTY_DIFFICULT)
   {*/
        // * Setting the switch below will enable a seperate Use Magic Device Skillcheck for
        // * rogues when playing on Hardcore+ difficulty. This only applies to scrolls
    SetModuleSwitch (MODULE_SWITCH_ENABLE_UMD_SCROLLS, TRUE);

       // * Activating the switch below will make AOE spells hurt neutral NPCS by default
       // SetModuleSwitch (MODULE_SWITCH_AOE_HURT_NEUTRAL_NPCS, TRUE);
//   }

   // * AI: Activating the switch below will make the creaures using the WalkWaypoint function
   // * able to walk across areas
    SetModuleSwitch (MODULE_SWITCH_ENABLE_CROSSAREA_WALKWAYPOINTS, FALSE);

   // * Spells: Activating the switch below will make the Glyph of Warding spell behave differently:
   // * The visual glyph will disappear after 6 seconds, making them impossible to spot
   // SetModuleSwitch (MODULE_SWITCH_ENABLE_INVISIBLE_GLYPH_OF_WARDING, TRUE);

   // * Craft Feats: Want 50 charges on a newly created wand? We found this unbalancing,
   // * but since it is described this way in the book, here is the switch to get it back...
   // SetModuleSwitch (MODULE_SWITCH_ENABLE_CRAFT_WAND_50_CHARGES, TRUE);

   // * Craft Feats: Use this to disable Item Creation Feats if you do not want
   // * them in your module
   // SetModuleSwitch (MODULE_SWITCH_DISABLE_ITEM_CREATION_FEATS, FALSE);

   // * Palemaster: Deathless master touch in PnP only affects creatures up to a certain size.
   // * We do not support this check for balancing reasons, but you can still activate it...
   // SetModuleSwitch (MODULE_SWITCH_SPELL_CORERULES_DMASTERTOUCH, TRUE);

   // * Epic Spellcasting: Some Epic spells feed on the liveforce of the caster. However this
   // * did not fit into NWNs spell system and was confusing, so we took it out...
   // SetModuleSwitch (MODULE_SWITCH_EPIC_SPELLS_HURT_CASTER, TRUE);

   // * Epic Spellcasting: Some Epic spells feed on the liveforce of the caster. However this
   // * did not fit into NWNs spell system and was confusing, so we took it out...
   // SetModuleSwitch (MODULE_SWITCH_RESTRICT_USE_POISON_TO_FEAT, TRUE);

    // * Spellcasting: Some people don't like caster's abusing expertise to raise their AC
    // * Uncommenting this line will drop expertise mode whenever a spell is cast by a player
     SetModuleSwitch (MODULE_VAR_AI_STOP_EXPERTISE_ABUSE, TRUE);


    SetModuleSwitch (MODULE_SWITCH_ENABLE_BEBILITH_RUIN_ARMOR, FALSE);
    // * Item Event Scripts: The game's default event scripts allow routing of all item related events
    // * into a single file, based on the tag of that item. If an item's tag is "test", it will fire a
    // * script called "test" when an item based event (equip, unequip, acquire, unacquire, activate,...)
    // * is triggered. Check "x2_it_example.nss" for an example.
    // * This feature is disabled by default.
    SetModuleSwitch (MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS, FALSE);

   if (GetModuleSwitchValue (MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
   {
        // * If Tagbased scripts are enabled, and you are running a Local Vault Server
        // * you should use the line below to add a layer of security to your server, preventing
        // * people to execute script you don't want them to. If you use the feature below,
        // * all called item scrips will be the prefix + the Tag of the item you want to execute, up to a
        // * maximum of 16 chars, instead of the pure tag of the object.
        // * i.e. without the line below a user activating an item with the tag "test",
        // * will result in the execution of a script called "test". If you uncomment the line below
        // * the script called will be "1_test.nss"
         SetUserDefinedItemEventPrefix("oa_");

   }

   // * This initializes Bioware's wandering monster system as used in Hordes of the Underdark
   // * You can deactivate it, making your module load faster if you do not use it.
   // * If you want to use it, make sure you set "x2_mod_def_rest" as your module's OnRest Script
   // SetModuleSwitch (MODULE_SWITCH_USE_XP2_RESTSYSTEM, TRUE);

   if (GetModuleSwitchValue(MODULE_SWITCH_USE_XP2_RESTSYSTEM) == TRUE)
   {

       // * This allows you to specify a different 2da for the wandering monster system.
       // SetWanderingMonster2DAFile("des_restsystem");

       //* Do not change this line.
       WMBuild2DACache();
   }

   SQLInit();
   GetLocalObject(GetModule(), "NWNX!INIT");

   RestoreTime();

   restart();

   SetMaxHenchmen(5);

   ExecuteScript("sd_check", GetModule());
   //ExecuteScript("cnr_module_oml", OBJECT_SELF);
   ExecuteScript("kh_modload", OBJECT_SELF);
   // thalia craft
   ExecuteScript("tc_init",OBJECT_SELF);

   string sql = "TRUNCATE TABLE dump;";
   SQLExecDirect(sql);

   /* Load location from resman */
   __resetResmanLocStatus();
   DelayCommand(5.0, __loadLocations()); /* Timing before factions */

   /* Frakce */
   DelayCommand(10.0,InitFactions());

   /* Boss loot */
   DelayCommand(120.0,ku_InitBossUniqueLoot());

   __InitWeaponsFeats();

   /* Docasna funkce pro zjisteni znakove sady */
   //SetPersistentString(OBJECT_SELF,"abeceda",GetName(GetObjectByTag("ku_abeceda")));
   /* Inicializace pro konverzi ceskych znaku */
   SetLocalString(OBJECT_SELF,"KU_ABECEDA_IN",GetPersistentString(OBJECT_SELF,"abeceda_in"));
   SetLocalString(OBJECT_SELF,"KU_ABECEDA_OUT",GetPersistentString(OBJECT_SELF,"abeceda_out"));

   // Devastating Critical changes
   SetWeaponOption(NWNX_WEAPONS_OPT_DEVCRIT_DISABLE_ALL,TRUE);
   SetWeaponOption(NWNX_WEAPONS_OPT_DEVCRIT_MULT_BONUS,1);
   SetWeaponOption(NWNX_WEAPONS_OPT_DEVCRIT_MULT_STACK,TRUE);

   /* *********************************
    *  Definice tagu strazi ve svete  *
    ***********************************/
   SetLocalInt(OBJECT_SELF,"KU_STRAZ_StrazKarathy",1);     /* 1 = Karatha */
   SetLocalInt(OBJECT_SELF,"KU_STRAZ_di_domobranec",2);     /* Ivory */
   SetLocalInt(OBJECT_SELF,"KU_STRAZ_garda_szai",3);     /* Garda S'Zai */
   SetLocalInt(OBJECT_SELF,"KU_STRAZ_Chmurnstr",4);     /* Chmurna straz */
   SetLocalInt(OBJECT_SELF,"KU_STRAZ_Murgondskastraz",5);     /* Murgond */
   SetLocalInt(OBJECT_SELF,"KU_STRAZ_ry_nord_garda",6);     /* Nordova garda */
   SetLocalInt(OBJECT_SELF,"KU_STRAZ_Druidskastraz",7);      /* Druidove */
   SetLocalInt(OBJECT_SELF,"KU_STRAZ_StrazIsilkepevnosti",8);      /* Isilska pevnost */
   SetLocalInt(OBJECT_SELF,"KU_STRAZ_Poustnivalecnik",9);      /* Kel A Hazr */
   SetLocalInt(OBJECT_SELF,"KU_STRAZ_ry_khrd_straz",10);      /* Khar Durn */
   SetLocalInt(OBJECT_SELF,"KU_STRAZ_ry_zrmar_straz",11);      /* Zril Mar */


   /*Definice zakazanych potvor ve mestech
     Prvni cislo znaci mesto, druhe rasu
     1 = Varovat
     2 = zabit
   */
   /* Karatha */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_1_8",1);   /* Animal */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_1_9",1);   /* Beast */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_1_16",1);  /* Elemental */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_1_19",1);  /* Magical Beast */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_1_24",2);  /* Undead */
   /* Ivory */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_2_8",1);   /* Animal */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_2_9",1);   /* Beast */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_2_16",1);  /* Elemental */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_2_19",1);  /* Magical Beast */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_2_24",2);  /* Undead */
   /* Murgong */
//   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_5_8",1);   /* Animal */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_5_9",1);   /* Beast */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_5_16",1);  /* Elemental */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_5_19",1);  /* Magical Beast */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_5_24",2);  /* Undead */
   /* Sherdonsky hajek */
//   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_7_8",1);   /* Animal */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_7_9",1);   /* Beast */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_7_16",1);  /* Elemental */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_7_19",1);  /* Magical Beast */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_7_24",2);  /* Undead */
   /* Isil */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_8_8",1);   /* Animal */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_8_9",1);   /* Beast */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_8_16",1);  /* Elemental */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_8_19",1);  /* Magical Beast */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_8_24",2);  /* Undead */
   /* Kel-A-Hazr */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_9_8",1);   /* Animal */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_9_9",1);   /* Beast */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_9_16",1);  /* Elemental */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_9_19",1);  /* Magical Beast */
   SetLocalInt(OBJECT_SELF,"KU_BAN_RACES_9_24",2);  /* Undead */

   /* Munice */
   SetLocalInt(OBJECT_SELF,"KU_MUNITION_TYPES_lu",20);
   SetLocalInt(OBJECT_SELF,"KU_MUNITION_TYPES_ku",25);
   SetLocalInt(OBJECT_SELF,"KU_MUNITION_TYPES_pr",27);
   SetLocalInt(OBJECT_SELF,"KU_MUNITION_TYPES_si",31);
   SetLocalInt(OBJECT_SELF,"KU_MUNITION_TYPES_hv",59);
   SetLocalInt(OBJECT_SELF,"KU_MUNITION_TYPES_se",63);

   __saveAllPlayers(600.0);
}


void __InitWeaponsFeats() {




  SetWeaponIsMonkWeapon (BASE_ITEM_SHURIKEN,1); // shuriken jako monk weapon
  SetWeaponIsMonkWeapon (BASE_ITEM_QUARTERSTAFF,1); // hul jako monk weapon


  DelayCommand(30.0,__AllowLogin());

}

