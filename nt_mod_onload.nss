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

void __saveAllPlayers(float delay);
void __InitWeaponsFeats();

void __resetResmanLocStatus() {
  string sql = "UPDATE resman_locations SET status='0';";
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
    SetModuleSwitch (MODULE_SWITCH_DISABLE_ITEM_CREATION_FEATS, TRUE);

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

   /* Trofeje */
   ku_InitTrofeje();

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

  SetWeaponFocusFeat(202,1116);// Social_Beermug
  SetWeaponFocusFeat(203,1117);// Short Spear
  SetWeaponFocusFeat(300,1118);// Trident 1h
  SetWeaponFocusFeat(301,1119);// Heavypick
  SetWeaponFocusFeat(302,1120);// Lightpick
  SetWeaponFocusFeat(303,1121);// Sai (vidlicka)
  SetWeaponFocusFeat(304,1122);// Nunchaku
  SetWeaponFocusFeat(316,1123);// Falchion2
  SetWeaponFocusFeat(308,1124);// Sap (Pytlik)
  SetWeaponFocusFeat(309,1125);// Daggerassassin
  SetWeaponFocusFeat(310,1126);// Katar
  SetWeaponFocusFeat(317,1127);// Heavy mace
  SetWeaponFocusFeat(318,1128);// Maul
  SetWeaponFocusFeat(319,1129);// Mercurial_longsword
  SetWeaponFocusFeat(320,1130);// Mercurial_greatsword
  SetWeaponFocusFeat(321,1131);// Scimitar double
  SetWeaponFocusFeat(322,1132);// Goad (halapartma)
  SetWeaponFocusFeat(323,1133);// Windfirewheel
  SetWeaponFocusFeat(324,1134);// MauDoubleSword
  //Improved critical
  SetWeaponImprovedCriticalFeat(202,1135);// Social_Beermug
  SetWeaponImprovedCriticalFeat(203,1136);// Short Spear
  SetWeaponImprovedCriticalFeat(300,1137);// Trident 1h
  SetWeaponImprovedCriticalFeat(301,1138);// Heavypick
  SetWeaponImprovedCriticalFeat(302,1139);// Lightpick
  SetWeaponImprovedCriticalFeat(303,1140);// Sai (vidlicka)
  SetWeaponImprovedCriticalFeat(304,1141);// Nunchaku
  SetWeaponImprovedCriticalFeat(316,1142);// Falchion2
  SetWeaponImprovedCriticalFeat(308,1143);// Sap (Pytlik)
  SetWeaponImprovedCriticalFeat(309,1144);// Daggerassassin
  SetWeaponImprovedCriticalFeat(310,1145);// Katar
  SetWeaponImprovedCriticalFeat(317,1146);// Heavy mace
  SetWeaponImprovedCriticalFeat(318,1147);// Maul
  SetWeaponImprovedCriticalFeat(319,1148);// Mercurial_longsword
  SetWeaponImprovedCriticalFeat(320,1149);// Mercurial_greatsword
  SetWeaponImprovedCriticalFeat(321,1150);// Scimitar double
  SetWeaponImprovedCriticalFeat(322,1151);// Goad (halapartma)
  SetWeaponImprovedCriticalFeat(323,1152);// Windfirewheel
  SetWeaponImprovedCriticalFeat(324,1153);// MauDoubleSword
  //Weapon specialization
  SetWeaponSpecializationFeat(202,1154);// Social_Beermug
  SetWeaponSpecializationFeat(203,1155);// Short Spear
  SetWeaponSpecializationFeat(300,1156);// Trident 1h
  SetWeaponSpecializationFeat(301,1157);// Heavypick
  SetWeaponSpecializationFeat(302,1158);// Lightpick
  SetWeaponSpecializationFeat(303,1159);// Sai (vidlicka)
  SetWeaponSpecializationFeat(304,1160);// Nunchaku
  SetWeaponSpecializationFeat(316,1161);// Falchion2
  SetWeaponSpecializationFeat(308,1162);// Sap (Pytlik)
  SetWeaponSpecializationFeat(309,1163);// Daggerassassin
  SetWeaponSpecializationFeat(310,1164);// Katar
  SetWeaponSpecializationFeat(317,1165);// Heavy mace
  SetWeaponSpecializationFeat(318,1166);// Maul
  SetWeaponSpecializationFeat(319,1167);// Mercurial_longsword
  SetWeaponSpecializationFeat(320,1168);// Mercurial_greatsword
  SetWeaponSpecializationFeat(321,1169);// Scimitar double
  SetWeaponSpecializationFeat(322,1170);// Goad (halapartma)
  SetWeaponSpecializationFeat(323,1171);// Windfirewheel
  SetWeaponSpecializationFeat(324,1172);// MauDoubleSword
  //Weapon of choice
  SetWeaponOfChoiceFeat(202,1173);// Social_Beermug
  SetWeaponOfChoiceFeat(203,1174);// Short Spear
  SetWeaponOfChoiceFeat(300,1175);// Trident 1h
  SetWeaponOfChoiceFeat(301,1176);// Heavypick
  SetWeaponOfChoiceFeat(302,1177);// Lightpick
  SetWeaponOfChoiceFeat(303,1178);// Sai (vidlicka)
  SetWeaponOfChoiceFeat(304,1179);// Nunchaku
  SetWeaponOfChoiceFeat(316,1180);// Falchion2
  SetWeaponOfChoiceFeat(308,1181);// Sap (Pytlik)
  SetWeaponOfChoiceFeat(309,1182);// Daggerassassin
  SetWeaponOfChoiceFeat(310,1183);// Katar
  SetWeaponOfChoiceFeat(317,1184);// Heavy mace
  SetWeaponOfChoiceFeat(318,1185);// Maul
  SetWeaponOfChoiceFeat(319,1186);// Mercurial_longsword
  SetWeaponOfChoiceFeat(320,1187);// Mercurial_greatsword
  SetWeaponOfChoiceFeat(321,1188);// Scimitar double
  SetWeaponOfChoiceFeat(322,1189);// Goad (halapartma)
  SetWeaponOfChoiceFeat(323,1190);// Windfirewheel
  SetWeaponOfChoiceFeat(324,1191);// MauDoubleSword
  //Overhelming critical
  SetWeaponOverwhelmingCriticalFeat(202,1192);// Social_Beermug
  SetWeaponOverwhelmingCriticalFeat(203,1193);// Short Spear
  SetWeaponOverwhelmingCriticalFeat(300,1194);// Trident 1h
  SetWeaponOverwhelmingCriticalFeat(301,1195);// Heavypick
  SetWeaponOverwhelmingCriticalFeat(302,1196);// Lightpick
  SetWeaponOverwhelmingCriticalFeat(303,1197);// Sai (vidlicka)
  SetWeaponOverwhelmingCriticalFeat(304,1198);// Nunchaku
  SetWeaponOverwhelmingCriticalFeat(316,1199);// Falchion2
  SetWeaponOverwhelmingCriticalFeat(308,1200);// Sap (Pytlik)
  SetWeaponOverwhelmingCriticalFeat(309,1201);// Daggerassassin
  SetWeaponOverwhelmingCriticalFeat(310,1202);// Katar
  SetWeaponOverwhelmingCriticalFeat(317,1203);// Heavy mace
  SetWeaponOverwhelmingCriticalFeat(318,1204);// Maul
  SetWeaponOverwhelmingCriticalFeat(319,1205);// Mercurial_longsword
  SetWeaponOverwhelmingCriticalFeat(320,1206);// Mercurial_greatsword
  SetWeaponOverwhelmingCriticalFeat(321,1207);// Scimitar double
  SetWeaponOverwhelmingCriticalFeat(322,1208);// Goad (halapartma)
  SetWeaponOverwhelmingCriticalFeat(323,1209);// Windfirewheel
  SetWeaponOverwhelmingCriticalFeat(324,1210);// MauDoubleSword
  //Devastating critical
  SetWeaponDevastatingCriticalFeat(202,1211);// Social_Beermug
  SetWeaponDevastatingCriticalFeat(203,1212);// Short Spear
  SetWeaponDevastatingCriticalFeat(300,1213);// Trident 1h
  SetWeaponDevastatingCriticalFeat(301,1214);// Heavypick
  SetWeaponDevastatingCriticalFeat(302,1215);// Lightpick
  SetWeaponDevastatingCriticalFeat(303,1216);// Sai (vidlicka)
  SetWeaponDevastatingCriticalFeat(304,1217);// Nunchaku
  SetWeaponDevastatingCriticalFeat(316,1218);// Falchion2
  SetWeaponDevastatingCriticalFeat(308,1219);// Sap (Pytlik)
  SetWeaponDevastatingCriticalFeat(309,1220);// Daggerassassin
  SetWeaponDevastatingCriticalFeat(310,1221);// Katar
  SetWeaponDevastatingCriticalFeat(317,1222);// Heavy mace
  SetWeaponDevastatingCriticalFeat(318,1223);// Maul
  SetWeaponDevastatingCriticalFeat(319,1224);// Mercurial_longsword
  SetWeaponDevastatingCriticalFeat(320,1225);// Mercurial_greatsword
  SetWeaponDevastatingCriticalFeat(321,1226);// Scimitar double
  SetWeaponDevastatingCriticalFeat(322,1227);// Goad (halapartma)
  SetWeaponDevastatingCriticalFeat(323,1228);// Windfirewheel
  SetWeaponDevastatingCriticalFeat(324,1229);// MauDoubleSword
  //Epic Weapon focus
  SetWeaponEpicFocusFeat(202,1230);// Social_Beermug
  SetWeaponEpicFocusFeat(203,1231);// Short Spear
  SetWeaponEpicFocusFeat(300,1232);// Trident 1h
  SetWeaponEpicFocusFeat(301,1233);// Heavypick
  SetWeaponEpicFocusFeat(302,1234);// Lightpick
  SetWeaponEpicFocusFeat(303,1235);// Sai (vidlicka)
  SetWeaponEpicFocusFeat(304,1236);// Nunchaku
  SetWeaponEpicFocusFeat(316,1237);// Falchion2
  SetWeaponEpicFocusFeat(308,1238);// Sap (Pytlik)
  SetWeaponEpicFocusFeat(309,1239);// Daggerassassin
  SetWeaponEpicFocusFeat(310,1240);// Katar
  SetWeaponEpicFocusFeat(317,1241);// Heavy mace
  SetWeaponEpicFocusFeat(318,1242);// Maul
  SetWeaponEpicFocusFeat(319,1243);// Mercurial_longsword
  SetWeaponEpicFocusFeat(320,1244);// Mercurial_greatsword
  SetWeaponEpicFocusFeat(321,1245);// Scimitar double
  SetWeaponEpicFocusFeat(322,1246);// Goad (halapartma)
  SetWeaponEpicFocusFeat(323,1247);// Windfirewheel
  SetWeaponEpicFocusFeat(324,1248);// MauDoubleSword
  //Epic Weapon specialization
  SetWeaponEpicSpecializationFeat(202,1249);// Social_Beermug
  SetWeaponEpicSpecializationFeat(203,1250);// Short Spear
  SetWeaponEpicSpecializationFeat(300,1251);// Trident 1h
  SetWeaponEpicSpecializationFeat(301,1252);// Heavypick
  SetWeaponEpicSpecializationFeat(302,1253);// Lightpick
  SetWeaponEpicSpecializationFeat(303,1254);// Sai (vidlicka)
  SetWeaponEpicSpecializationFeat(304,1255);// Nunchaku
  SetWeaponEpicSpecializationFeat(316,1256);// Falchion2
  SetWeaponEpicSpecializationFeat(308,1257);// Sap (Pytlik)
  SetWeaponEpicSpecializationFeat(309,1258);// Daggerassassin
  SetWeaponEpicSpecializationFeat(310,1259);// Katar
  SetWeaponEpicSpecializationFeat(317,1260);// Heavy mace
  SetWeaponEpicSpecializationFeat(318,1261);// Maul
  SetWeaponEpicSpecializationFeat(319,1262);// Mercurial_longsword
  SetWeaponEpicSpecializationFeat(320,1263);// Mercurial_greatsword
  SetWeaponEpicSpecializationFeat(321,1264);// Scimitar double
  SetWeaponEpicSpecializationFeat(322,1265);// Goad (halapartma)
  SetWeaponEpicSpecializationFeat(323,1266);// Windfirewheel
  SetWeaponEpicSpecializationFeat(324,1267);// MauDoubleSword

  SetWeaponIsMonkWeapon (BASE_ITEM_SHURIKEN,1); // shuriken jako monk weapon
  SetWeaponIsMonkWeapon (304,1); // nunchaku jako monk weapon
  SetWeaponIsMonkWeapon (303,1); // sai jako monk weapon
  SetWeaponFinesseSize(304,1);
  SetWeaponFinesseSize(303,1);
  SetWeaponFinesseSize(BASE_ITEM_CLUB,2);
  DelayCommand(30.0,__AllowLogin());

}

