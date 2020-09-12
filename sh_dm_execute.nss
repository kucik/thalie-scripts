#include "sh_dm_tools"
#include "sh_deity_inc"
#include "ja_inc_frakce"
#include "ku_persist_inc"

void DoDiceBagFunction(int iDice, object oUser);
int I_DEBUG = FALSE;
void main()
{

    object oMySpeaker = GetLastSpeaker();
    object oArea =GetArea(oMySpeaker);
    object oTarget,oPossessor;
    location lTarget = GetLocalLocation(OBJECT_SELF, "dmfi_univ_location");
    if (!GetIsObjectValid(GetLocalObject(oMySpeaker, "dmfi_univ_target")))
    {
        oTarget = oMySpeaker;
    }
    else
    {
        oTarget = GetLocalObject(oMySpeaker, "dmfi_univ_target");
    }
    object oSoulTarget = GetSoulStone(oTarget);

    location lMyLoc = GetLocalLocation(oMySpeaker, "sh_dm_univ_location");
    int iMainType = GetLocalInt(oMySpeaker, "sh_dm_main_conv");
    //ridici hodnota
    int iUnivInt = GetLocalInt(oMySpeaker, "sh_dm_univ_int");
    object oCarmour = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oMySpeaker);
    // int konstanta
    int iDMSetNumber =GetLocalInt(oCarmour,"DMSetNumber");
    float fDMSetNumber  =IntToFloat(iDMSetNumber);
    //string konstanta
    string sDMstring = GetLocalString(oMySpeaker,"DMstring");
    // pomocne promenne
    int iPreset; //pro prednastavenou barvu
    int iDayMusic,iNightMusic,iBattleMusic;
    int iSet,iCharges;
    string sTemp;
    object oChange;
    effect eI,eA,eT,eEffect,eVis;
    // promenne pro efekty
    string sDMid = "DM_"+GetName(oMySpeaker)+"_"+GetPCPlayerName(oMySpeaker);
    float fDelay = GetCampaignFloat(sDMid,"dmfi_effectdelay",oMySpeaker);
    float fDuration =  GetCampaignFloat(sDMid,"dmfi_effectduration",oMySpeaker);
    float fBeamDuration = GetCampaignFloat(sDMid,"dmfi_beamduration",oMySpeaker);
    // konec promennych pro efekty
    if (I_DEBUG) SendMessageToAllDMs("MAIN INT="+IntToString(iMainType));
    if (I_DEBUG) SendMessageToAllDMs("UNIV INT="+IntToString(iUnivInt));
    switch (iMainType)
    {
    case 1: //Area
    {
         switch (iUnivInt)
         {
             //pocasi cas
             case 70: SetFogAmount(FOG_TYPE_ALL,iDMSetNumber); break;
             case 71: SetFogColor(FOG_TYPE_ALL,iDMSetNumber,oArea); break;
             case 72:
             {
                //Using preset so you do not have to deal with large numbers if you do not want too.
                /*
                You could easily add any more presets you want. :)
                0  BLACK           = 0;
                1  RED             = 16711680;
                2  RED_DARK        = 6684672;
                3  GREEN           = 65280;
                4  GREEN_DARK      = 23112;
                5  BLUE            = 255;
                6  BLUE_DARK       = 102;
                7  YELLOW          = 16776960;
                8  YELLOW_DARK     = 11184640;
                9  CYAN            = 65535;
                10 MAGENTA         = 16711935;
                11 ORANGE          = 16750848;
                12 ORANGE_DARK     = 13395456;
                13 BROWN           = 10053120;
                14 BROWN_DARK      = 6697728;
                15 GREY            = 10066329;
                16 WHITE           = 16777215;
                */
                if(iDMSetNumber==0)iPreset = 0;
                if(iDMSetNumber==1)iPreset = 16711680;
                if(iDMSetNumber==2)iPreset = 6684672;
                if(iDMSetNumber==3)iPreset = 65280;
                if(iDMSetNumber==4)iPreset = 23112;
                if(iDMSetNumber==5)iPreset = 255;
                if(iDMSetNumber==6)iPreset = 102;
                if(iDMSetNumber==7)iPreset = 16776960;
                if(iDMSetNumber==8)iPreset = 11184640;
                if(iDMSetNumber==9)iPreset = 65535;
                if(iDMSetNumber==10)iPreset = 16711935;
                if(iDMSetNumber==11)iPreset = 16750848;
                if(iDMSetNumber==12)iPreset = 13395456;
                if(iDMSetNumber==13)iPreset = 10053120;
                if(iDMSetNumber==14)iPreset = 6697728;
                if(iDMSetNumber==15)iPreset = 10066329;
                if(iDMSetNumber==16)iPreset = 16777215;


                SetFogColor(FOG_TYPE_ALL,iPreset,oArea);
             }
             break;
             case 73: dmwand_SwapDayNight(1);break;
             case 74: dmwand_SwapDayNight(0);break;
             case 75: SetWeather(oArea, WEATHER_CLEAR); break;
             case 76: SetWeather(oArea, WEATHER_RAIN); break;
             case 77: SetWeather(oArea, WEATHER_SNOW); break;
             case 78: SetWeather(oArea, WEATHER_USE_AREA_SETTINGS); break;
             case 79: dmwand_AdvanceTime(iDMSetNumber);break;
             // konec cas / pocasi
             // zatopeni lokace
             case 10: TilesetMagic(oMySpeaker, X2_TL_GROUNDTILE_WATER, 0);break;
             case 11: TilesetMagic(oMySpeaker, X2_TL_GROUNDTILE_ICE, 0);break;
             case 12: TilesetMagic(oMySpeaker, X2_TL_GROUNDTILE_LAVA, 0) ;break;
             case 13: TilesetMagic(oMySpeaker, X2_TL_GROUNDTILE_SEWER_WATER, 0);break;
             case 14: TilesetMagic(oMySpeaker, X2_TL_GROUNDTILE_WATER, 1);break;
             case 15: TilesetMagic(oMySpeaker, X2_TL_GROUNDTILE_ICE, 1);break;
             case 16: TilesetMagic(oMySpeaker, X2_TL_GROUNDTILE_LAVA, 1) ;break;
             case 17: TilesetMagic(oMySpeaker, X2_TL_GROUNDTILE_SEWER_WATER, 1);break;
             case 18: TLResetAreaGroundTiles(oArea, GetAreaXAxis(oArea), GetAreaYAxis(oArea)); break;
             case 19: break;
             // konec zatopeni lokace
             // uprava povrchu lokace
             case 20: TilesetMagic(oMySpeaker, X2_TL_GROUNDTILE_ICE, 2);break;
             case 21: TilesetMagic(oMySpeaker, X2_TL_GROUNDTILE_GRASS, 2);break;
             case 22: TilesetMagic(oMySpeaker, X2_TL_GROUNDTILE_CAVEFLOOR, 2) ;break;
             case 23: TLResetAreaGroundTiles(oArea, GetAreaXAxis(oArea), GetAreaYAxis(oArea)); break;
             case 24: break;
             case 25: break;
             case 26: break;
             case 27: break;
             case 28: break;
             case 29: break;
             case 60: SetSkyBox(iDMSetNumber,oArea); break;
             // konec - uprava povrchu lokace
             // efekty - magicke dlouhodobe
             case 300: ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_CALTROPS),lTarget, fDuration); break;
             case 301: ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_TENTACLE),lTarget, fDuration); break;
             case 302: ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_WEB_MASS),lTarget, fDuration); break;
             case 303: FnFEffect(oMySpeaker, VFX_FNF_GAS_EXPLOSION_MIND,lTarget, fDelay); break;
             case 304: FnFEffect(oMySpeaker, VFX_FNF_LOS_HOLY_30,lTarget, fDelay); break;
             case 305: FnFEffect(oMySpeaker, VFX_FNF_LOS_EVIL_30,lTarget, fDelay); break;
             case 306: FnFEffect(oMySpeaker, VFX_FNF_SMOKE_PUFF,lTarget, fDelay); break;
             case 307: FnFEffect(oMySpeaker, VFX_FNF_GAS_EXPLOSION_NATURE,lTarget, fDelay); break;
             case 308: FnFEffect(oMySpeaker, VFX_FNF_DISPEL_DISJUNCTION,lTarget, fDelay); break;
             case 309: FnFEffect(oMySpeaker, VFX_FNF_GAS_EXPLOSION_EVIL,lTarget, fDelay); break;
             // efekty - magicke dlouhodobe
             //Magical Status Effects (must have a target)
            case 310: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR), oTarget, fDuration); break;
            case 311: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROT_BARKSKIN), oTarget, fDuration); break;
            case 312: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROT_GREATER_STONESKIN), oTarget, fDuration); break;
            case 313: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_ENTANGLE), oTarget, fDuration); break;
            case 314: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_ETHEREAL_VISAGE), oTarget, fDuration); break;
            case 315: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE), oTarget, fDuration); break;
            case 316: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_INVISIBILITY), oTarget, fDuration); break;
            case 317: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BARD_SONG), oTarget, fDuration); break;
            case 318: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GLOBE_INVULNERABILITY), oTarget, fDuration); break;
            case 319: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PARALYZED), oTarget, fDuration); break;
            // konec magical status effects
            //Magical Burst Effects
            case 320: FnFEffect(oMySpeaker, VFX_FNF_FIREBALL,lTarget, fDelay); break;
            case 321: FnFEffect(oMySpeaker, VFX_FNF_FIRESTORM,lTarget, fDelay); break;
            case 322: FnFEffect(oMySpeaker, VFX_FNF_STRIKE_HOLY,lTarget, fDelay); break;
            case 323: FnFEffect(oMySpeaker, VFX_FNF_WORD,lTarget, fDelay); break;
            case 324: FnFEffect(oMySpeaker, VFX_FNF_HORRID_WILTING,lTarget, fDelay); break;
            case 325: FnFEffect(oMySpeaker, VFX_FNF_IMPLOSION,lTarget, fDelay); break;
            case 326: FnFEffect(oMySpeaker, VFX_FNF_PWKILL,lTarget, fDelay); break;
            case 327: FnFEffect(oMySpeaker, VFX_FNF_PWSTUN,lTarget, fDelay); break;
            case 328: FnFEffect(oMySpeaker, VFX_FNF_SOUND_BURST,lTarget, fDelay); break;
            case 329: FnFEffect(oMySpeaker, VFX_FNF_HOWL_WAR_CRY,lTarget, fDelay); break;
            // konec Magical Burst Effects
            //Lighting Effects
            case 331: ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BLACKOUT),lTarget, fDuration); break;
            case 332: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_ANTI_LIGHT_10),oTarget, fDuration); break;
            case 333: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_BLUE_20),oTarget, fDuration); break;
            case 334: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_GREY_20),oTarget, fDuration); break;
            case 335: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_ORANGE_20),oTarget, fDuration); break;
            case 336: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_PURPLE_20),oTarget, fDuration); break;
            case 337: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_RED_20),oTarget, fDuration); break;
            case 338: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_WHITE_20),oTarget, fDuration); break;
            case 339: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_20),oTarget, fDuration); break;
            //konec - Lighting Effects
            // Enviromental
            case 340: FXWand_Earthquake_extend(oTarget); break;
            case 341: FXWand_Firestorm(oTarget); break;
            case 342: FnFEffect(oMySpeaker, VFX_FNF_ICESTORM,lTarget, fDelay); break;
            case 343: FXWand_Lightning(oTarget, lTarget); break;
            case 344: FnFEffect(oMySpeaker, VFX_FNF_NATURES_BALANCE,lTarget, fDelay);break;
            case 345: FnFEffect(oMySpeaker, VFX_FNF_SUNBEAM,lTarget, fDelay); break;
            // konec - enviromental
            //Beam Effects
            case 350: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_CHAIN, oMySpeaker, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration);break;
            case 351: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_COLD, oMySpeaker, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration); break;
            case 352: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_EVIL, oMySpeaker, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration); break;
            case 353: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_FIRE, oMySpeaker, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration); break;
            case 354: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_FIRE_LASH, oMySpeaker, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration); break;
            case 355: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_HOLY, oMySpeaker, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration); break;
            case 356: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_LIGHTNING, oMySpeaker, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration); break;
            case 357: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_MIND, oMySpeaker, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration); break;
            case 358: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_ODD, oMySpeaker, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration); break;
            case 359: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_COLD, oMySpeaker, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_EVIL, oMySpeaker, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_FIRE, oMySpeaker, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_FIRE_LASH, oMySpeaker, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_HOLY, oMySpeaker, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_LIGHTNING, oMySpeaker, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_MIND, oMySpeaker, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_ODD, oMySpeaker, BODY_NODE_CHEST, FALSE), oTarget, fBeamDuration); break;
            // konec  - Beam Effects
            //summon effects
            case 360: FnFEffect(oMySpeaker, VFX_FNF_SUMMON_MONSTER_1,lTarget, fDelay); break;
            case 361: FnFEffect(oMySpeaker, VFX_FNF_SUMMON_MONSTER_2,lTarget, fDelay); break;
            case 362: FnFEffect(oMySpeaker, VFX_FNF_SUMMON_MONSTER_3,lTarget, fDelay); break;
            case 363: FnFEffect(oMySpeaker, VFX_FNF_SUMMON_CELESTIAL,lTarget, fDelay); break;
            case 364: FnFEffect(oMySpeaker, VFX_FNF_SUMMONDRAGON,lTarget, fDelay); break;
            case 365: FnFEffect(oMySpeaker, VFX_FNF_SUMMON_EPIC_UNDEAD,lTarget, fDelay); break;
            case 366: FnFEffect(oMySpeaker, VFX_FNF_SUMMON_GATE,lTarget, fDelay); break;
            case 367: FnFEffect(oMySpeaker, VFX_FNF_SUMMON_UNDEAD,lTarget, fDelay); break;
            case 368: FnFEffect(oMySpeaker, VFX_FNF_UNDEAD_DRAGON,lTarget, fDelay); break;
            case 369: FnFEffect(oMySpeaker, VFX_FNF_WAIL_O_BANSHEES,lTarget, fDelay); break;
            //konec summon effects
            //SoU/HotU Duration Effects(must have a target)
            case 370: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BIGBYS_CLENCHED_FIST), oTarget, fDuration); break;
            case 371: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BIGBYS_CRUSHING_HAND), oTarget, fDuration); break;
            case 372: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BIGBYS_GRASPING_HAND), oTarget, fDuration); break;
            case 373: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BIGBYS_INTERPOSING_HAND), oTarget, fDuration); break;
            case 374: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_ICESKIN), oTarget, fDuration); break;
            case 375: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_INFERNO), oTarget, fDuration); break;
            case 376: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PIXIEDUST), oTarget, fDuration); break;
            case 377: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY), oTarget, fDuration); break;
            case 378: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION), oTarget, fDuration); break;
            case 379: ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GHOSTLY_PULSE), oTarget, fDuration); break;
            //konec - SoU/HotU Duration Effects(must have a target)
            //SoU/HotU Effects
            case 380: ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(322), oTarget, fDuration); break;
            case 381: ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(132), oTarget, fDuration); break;
            case 382: ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(133), oTarget, fDuration); break;
            case 383: ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(136), oTarget, fDuration); break;
            case 384: ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(137), oTarget, fDuration); break;
            case 385: FnFEffect(oMySpeaker, VFX_FNF_DEMON_HAND,lTarget, fDelay); break;
            case 386: FnFEffect(oMySpeaker, VFX_FNF_ELECTRIC_EXPLOSION,lTarget, fDelay); break;
            case 387: FnFEffect(oMySpeaker, VFX_FNF_GREATER_RUIN,lTarget, fDelay); break;
            case 388: FnFEffect(oMySpeaker, VFX_FNF_MYSTICAL_EXPLOSION,lTarget, fDelay); break;
            case 389: FnFEffect(oMySpeaker, VFX_FNF_SWINGING_BLADE,lTarget, fDelay); break;
            //konec - SoU/HotU Effects
            //Settings
            case 390: SetCampaignFloat(sDMid,"dmfi_effectduration",fDMSetNumber,oMySpeaker); break;
            case 391: SetCampaignFloat(sDMid,"dmfi_effectdelay",fDMSetNumber,oMySpeaker); break;
            case 392: SetCampaignFloat(sDMid,"dmfi_beamduration",fDMSetNumber,oMySpeaker); break;
            case 393: //Change Day Music
            iDayMusic = MusicBackgroundGetDayTrack(oArea) + 1;
            if (iDayMusic > 33) iDayMusic = 49;
            if (iDayMusic > 55) iDayMusic = 1;
            MusicBackgroundStop(oArea);
            MusicBackgroundChangeDay(oArea, iDayMusic);
            MusicBackgroundPlay(oArea);
            break;
            case 394: //Change Night Music
            iNightMusic = MusicBackgroundGetDayTrack(oArea) + 1;
            if (iNightMusic > 33) iNightMusic = 49;
            if (iNightMusic > 55) iNightMusic = 1;
            MusicBackgroundStop(oArea);
            MusicBackgroundChangeNight(oArea, iNightMusic);
            MusicBackgroundPlay(oArea);
            break;
            case 395: //Play Background Music
            MusicBackgroundPlay(oArea);
            break;
            case 396: //Stop Background Music
            MusicBackgroundStop(oArea);
            break;
            case 397: //Change and Play Battle Music
            iBattleMusic = MusicBackgroundGetBattleTrack(oArea) + 1;
            if (iBattleMusic < 34 || iBattleMusic > 48) iBattleMusic = 34;
            MusicBattleStop(oArea);
            MusicBattleChange(oArea, iBattleMusic);
            MusicBattlePlay(oArea);
            break;
            case 398: //Stop Battle Music
            MusicBattleStop(oArea);
            break;
            //------------------MUSIC -------------------------
            case 400: MusicBackgroundPlay(oArea); break;
            case 401: MusicBackgroundStop(oArea); DelayCommand(1.0, MusicBackgroundStop(oArea)); break;
            case 402: iSet = TRACK_BATTLE_WINTER; TurnOnMusic(oArea,iSet); break;
            case 403: iSet = TRACK_BATTLE_DESERT;TurnOnMusic(oArea,iSet);  break;
            case 404: iSet = TRACK_DESERT_DAY;TurnOnMusic(oArea,iSet);  break;
            case 405: iSet = TRACK_DESERT_NIGHT;TurnOnMusic(oArea,iSet);  break;
            case 406: iSet = TRACK_WINTER_DAY;TurnOnMusic(oArea,iSet); break;
            case 407: iSet = TRACK_HOTU_UNDERMOUNTAIN;TurnOnMusic(oArea,iSet);  break;
            case 408: iSet = TRACK_HOTU_WATERDEEP;TurnOnMusic(oArea,iSet);  break;
            case 410: iSet = TRACK_HOTU_BATTLE_BOSS1;TurnOnMusic(oArea,iSet);  break;
            case 411: iSet = TRACK_HOTU_BATTLE_BOSS2;TurnOnMusic(oArea,iSet);  break;
            case 412: iSet = TRACK_HOTU_BATTLE_HELL;TurnOnMusic(oArea,iSet);  break;
            case 413: iSet = TRACK_HOTU_THEME;TurnOnMusic(oArea,iSet); break;
            case 414: iSet = TRACK_HOTU_REBELCAMP;TurnOnMusic(oArea,iSet); break;
            case 415: iSet = TRACK_HOTU_QUEEN;TurnOnMusic(oArea,iSet); break;
            case 416: iSet = TRACK_HOTU_DRACOLICH;TurnOnMusic(oArea,iSet); break;
            case 417: iSet = TRACK_HOTU_FIREPLANE;TurnOnMusic(oArea,iSet); break;
            case 418: iSet = TRACK_HOTU_HELLFROZEOVER;TurnOnMusic(oArea,iSet); break;
            case 420: iSet = 34;TurnOnMusic(oArea,iSet);  break;
            case 421: iSet = 35;TurnOnMusic(oArea,iSet);  break;
            case 422: iSet = 36;TurnOnMusic(oArea,iSet);  break;
            case 423: iSet = 37;TurnOnMusic(oArea,iSet);  break;
            case 424: iSet = 38;TurnOnMusic(oArea,iSet);  break;
            case 425: iSet = 39;TurnOnMusic(oArea,iSet);  break;
            case 426: iSet = 40;TurnOnMusic(oArea,iSet);  break;
            case 427: iSet = 41;TurnOnMusic(oArea,iSet);  break;
            case 428: iSet = 42;TurnOnMusic(oArea,iSet);  break;
            case 430: iSet = 43;TurnOnMusic(oArea,iSet);  break;
            case 431: iSet = 44;TurnOnMusic(oArea,iSet);  break;
            case 432: iSet = 45;TurnOnMusic(oArea,iSet);  break;
            case 433: iSet = 46;TurnOnMusic(oArea,iSet);  break;
            case 434: iSet = 47;TurnOnMusic(oArea,iSet);  break;
            case 435: iSet = 48;TurnOnMusic(oArea,iSet);  break;
            case 440: iSet = 15;TurnOnMusic(oArea,iSet);  break;
            case 441: iSet = 16;TurnOnMusic(oArea,iSet);  break;
            case 442: iSet = 17;TurnOnMusic(oArea,iSet);  break;
            case 443: iSet = 18;TurnOnMusic(oArea,iSet);  break;
            case 444: iSet = 19;TurnOnMusic(oArea,iSet);  break;
            case 445: iSet = 20;TurnOnMusic(oArea,iSet);  break;
            case 446: iSet = 21;TurnOnMusic(oArea,iSet);  break;
            case 447: iSet = 29;TurnOnMusic(oArea,iSet);  break;
            case 450: iSet = 22;TurnOnMusic(oArea,iSet);  break;
            case 451: iSet = 23;TurnOnMusic(oArea,iSet);  break;
            case 452: iSet = 24;TurnOnMusic(oArea,iSet);  break;
            case 453: iSet = 56;TurnOnMusic(oArea,iSet);  break;
            case 454: iSet = 25;TurnOnMusic(oArea,iSet);  break;
            case 455: iSet = 26;TurnOnMusic(oArea,iSet);  break;
            case 456: iSet = 27;TurnOnMusic(oArea,iSet);  break;
            case 457: iSet = 49;TurnOnMusic(oArea,iSet);  break;
            case 458: iSet = 50;TurnOnMusic(oArea,iSet);  break;
            case 460: iSet = 28;TurnOnMusic(oArea,iSet);  break;
            case 461: iSet = 7;TurnOnMusic(oArea,iSet);  break;
            case 462: iSet = 8;TurnOnMusic(oArea,iSet);  break;
            case 463: iSet = 9;TurnOnMusic(oArea,iSet);  break;
            case 464: iSet = 10;TurnOnMusic(oArea,iSet);  break;
            case 465: iSet = 11;TurnOnMusic(oArea,iSet);  break;
            case 466: iSet = 12;TurnOnMusic(oArea,iSet);  break;
            case 467: iSet = 13;TurnOnMusic(oArea,iSet);  break;
            case 468: iSet = 14;TurnOnMusic(oArea,iSet);  break;
            case 470: iSet = 1;TurnOnMusic(oArea,iSet);  break;
            case 471: iSet = 2;TurnOnMusic(oArea,iSet);  break;
            case 472: iSet = 3;TurnOnMusic(oArea,iSet);  break;
            case 473: iSet = 4;TurnOnMusic(oArea,iSet);  break;
            case 474: iSet = 5;TurnOnMusic(oArea,iSet);  break;
            case 475: iSet = 6;TurnOnMusic(oArea,iSet);  break;
            case 480: iSet = 30;TurnOnMusic(oArea,iSet);  break;
            case 481: iSet = 31;TurnOnMusic(oArea,iSet);  break;
            case 482: iSet = 32;TurnOnMusic(oArea,iSet);  break;
            case 483: iSet = 33;TurnOnMusic(oArea,iSet);  break;
            case 484: iSet = 51;TurnOnMusic(oArea,iSet);  break;
            case 485: iSet = 52;TurnOnMusic(oArea,iSet);  break;
            case 486: iSet = 53;TurnOnMusic(oArea,iSet);  break;
            case 487: iSet = 54;TurnOnMusic(oArea,iSet);  break;
            case 488: iSet = 55;TurnOnMusic(oArea,iSet);  break;
            case 500: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_batsflap1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 501: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_bugsscary1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 502: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_crptvoice1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 503: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_orcgrunt1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 504: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_cv_minepick2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 505: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_ratssqeak1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 506: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_na_rockfallg1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 507: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_na_rockfalgl2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 508: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_wt_gustcavrn1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;

            case 510: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_cv_belltower3"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 511: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_cv_claybreak3"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 512: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_cv_glasbreak2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 513: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_cv_gongring3"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 514: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_marketgrp4"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 515: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_cv_millwheel1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 516: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_cv_sawing1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 517: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_cv_bellwind1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 518: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_cv_smithhamr2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;

            case 520: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_na_firelarge1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 521: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_na_lavapillr1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 522: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_na_lavafire1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 523: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_na_firelarge2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 524: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_na_surf2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 525: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_na_drips1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 526: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_na_waterlap1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 527: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_na_stream4"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 528: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_na_waterfall2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;

            case 530: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_crynight3"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 531: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_na_bushmove1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 532: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_birdsflap2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 533: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_na_grassmove3"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 534: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_hawk1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 535: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_na_leafmove3"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 536: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_gulls2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 537: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_songbirds1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 538: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_an_toads1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;

            case 540: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_mg_beaker1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 541: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_mg_cauldron1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 542: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_mg_chntmagic1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 543: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_mg_crystalev1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 544: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_mg_crystalic1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 545: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("al_mg_portal1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 546: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_mg_telepin1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 547: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_mg_telepout1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 548: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_mg_frstmagic1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;

            case 550: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_tavclap1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 551: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_battlegrp7"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 552: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_laughincf2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 553: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_comtntgrp3"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 554: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_chantingm2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 555: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_cryingf2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 556: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_laughingf3"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 557: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_chantingf2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 558: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_wailingm6"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;

            case 560: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_evilchantm"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 561: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_crows2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 562: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_wailingcf1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 563: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_crptvoice2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 564: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_lafspook2"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 565: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_owlhoot1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 566: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_an_wolfhowl1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 567: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_screamf3"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 568: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_pl_zombiem3"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;

            case 570: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_wt_gustsoft1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 571: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_wt_thundercl3"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 572: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_wt_thunderds4"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;
            case 573: oTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTarget); DelayCommand(fDelay, AssignCommand(oTarget, PlaySound("as_wt_gusforst1"))); DelayCommand(20.0f, DestroyObject(oTarget)); break;

            //Settings
            case 580:
            if(iDMSetNumber==0)
            {
            fDMSetNumber=0.2;
            }
            SetCampaignFloat(sDMid,"dmfi_sound_delay",fDMSetNumber,oMySpeaker);
            break;
            case 581: //Change Day Music
            iDayMusic = MusicBackgroundGetDayTrack(oArea) + 1;
            if (iDayMusic > 33) iDayMusic = 49;
            if (iDayMusic > 55) iDayMusic = 1;
            MusicBackgroundStop(oArea);
            MusicBackgroundChangeDay(oArea, iDayMusic);
            MusicBackgroundPlay(oArea);
            break;
            case 582: //Change Night Music
            iNightMusic = MusicBackgroundGetDayTrack(GetArea(oMySpeaker)) + 1;
            if (iNightMusic > 33) iNightMusic = 49;
            if (iNightMusic > 55) iNightMusic = 1;
            MusicBackgroundStop(oArea);
            MusicBackgroundChangeNight(oArea, iNightMusic);
            MusicBackgroundPlay(oArea);
            break;
            case 583: //Play Background Music
            MusicBackgroundPlay(oArea);
            break;
            case 584: //Stop Background Music
            MusicBackgroundStop(oArea);
            break;
            case 585: //Change and Play Battle Music
            iBattleMusic = MusicBackgroundGetBattleTrack(oArea) + 1;
            if (iBattleMusic < 34 || iBattleMusic > 48) iBattleMusic = 34;
            MusicBattleStop(oArea);
            MusicBattleChange(oArea, iBattleMusic);
            MusicBattlePlay(oArea);
            break;
            case 588: //Stop Battle Music
            MusicBattleStop(oArea);
            break;
         }
    }
    break;

    case 2: //placeably,itemy, potvory
    switch (iUnivInt)
    {
        case 1: //kopirovani objektu
        if (GetObjectType(oTarget)==OBJECT_TYPE_ITEM || GetObjectType(oTarget)==OBJECT_TYPE_CREATURE)
        {
            CopyObject(oTarget,GetLocation(oMySpeaker),oMySpeaker);
        }
        else if (GetObjectType(oTarget)==OBJECT_TYPE_PLACEABLE)
        {
            CreateObject(OBJECT_TYPE_PLACEABLE,GetResRef(oTarget),GetLocation(oMySpeaker));
        }
        break;

        case 10: //zmena nazvu
        SetName(oTarget,sDMstring);
        break;

        case 11: //zmena nazvu na puvodni
        SetName(oTarget,"");
        break;

        case 20: //zmena popisu - identifikovane
        SetDescription(oTarget,sDMstring,TRUE);
        break;

        case 21: //zmena popisu - neidentifikovane
        SetDescription(oTarget,sDMstring,FALSE);
        break;

        case 22: //pridani popisu - identifikovane
        SetDescription(oTarget,GetDescription(oTarget,FALSE,TRUE)+sDMstring,TRUE);
        break;

        case 23: //pridani popisu - neidentifikovane
        SetDescription(oTarget,GetDescription(oTarget,FALSE,FALSE)+sDMstring,FALSE);
        break;

        case 24: //zmena popisu - identifikovane  - obnova puvodniho
        SetDescription(oTarget,"",TRUE);
        break;

        case 25: //zmena popisu - neidentifikovane - obnova puvodniho
        SetDescription(oTarget,"",FALSE);
        break;

        case 30:
        if (GetObjectType(oTarget)==OBJECT_TYPE_ITEM)
        {
            oPossessor = GetItemPossessor(oTarget); AssignCommand(oPossessor,ActionEquipItem(oTarget,iDMSetNumber-1));
        }
        break;
        case 31:
        if (GetObjectType(oTarget)==OBJECT_TYPE_ITEM)
        {
            SetItemCharges(oTarget, 0);
            FloatingTextStringOnCreature( GetName(oTarget)+": Zbyvajici naboje odstraneny.", oMySpeaker);
        }
        else
        {
            FloatingTextStringOnCreature("Neplatny predmet", oMySpeaker);
        }
        break;
        case 32:
        if (GetObjectType(oTarget)==OBJECT_TYPE_ITEM)
        {
            SetItemCharges(oTarget, 999);
            FloatingTextStringOnCreature( GetName(oTarget)+": Predmet plne nabit.", oMySpeaker);
        }
        else
        {
            FloatingTextStringOnCreature("Neplatny predmet", oMySpeaker);
        }
        break;
        case 33:
        if (GetObjectType(oTarget)==OBJECT_TYPE_ITEM)
        {
            iCharges =GetItemCharges(oTarget);
            SetItemCharges(oTarget,iCharges+1);
            FloatingTextStringOnCreature( GetName(oTarget)+": Pridan naboj.", oMySpeaker);
        }
        else
        {
            FloatingTextStringOnCreature("Neplatny predmet", oMySpeaker);
        }
        break;
        case 34:
        if (GetObjectType(oTarget)==OBJECT_TYPE_ITEM)
        {
            iCharges =GetItemCharges(oTarget);
            SetItemCharges(oTarget,iCharges-1);
            FloatingTextStringOnCreature( GetName(oTarget)+": Odebran naboj.", oMySpeaker);
        }
        else
        {
            FloatingTextStringOnCreature("Neplatny predmet", oMySpeaker);
        }
        break;
        case 35:
        if (GetIdentified(oTarget))
        {
            SetIdentified(oTarget, FALSE);
            FloatingTextStringOnCreature(GetName(oTarget)+": neni identifikovan.", oMySpeaker);
        }
        else
        {
            SetIdentified(oTarget, TRUE);
            FloatingTextStringOnCreature( GetName(oTarget)+": je identifikovan.", oMySpeaker);
        }
        break;
        case 36:
        if (GetObjectType(oTarget)==OBJECT_TYPE_ITEM)
        {
            if (GetDroppableFlag(oTarget))
            {
                SetDroppableFlag(oTarget, FALSE);
                FloatingTextStringOnCreature(GetName(oTarget)+": NELZE polozit", oMySpeaker);
            }
            else
            {
                SetDroppableFlag(oTarget, TRUE);
                FloatingTextStringOnCreature( GetName(oTarget)+": lze polozit", oMySpeaker);
            }
        }
        else
        {
            FloatingTextStringOnCreature("Neplatny predmet.", oMySpeaker);
        }
        break;
        case 37:
        if (GetObjectType(oTarget)==OBJECT_TYPE_ITEM)
        {
            if (GetItemCursedFlag(oTarget))
            {
                SetItemCursedFlag(oTarget, FALSE);
                FloatingTextStringOnCreature(GetName(oTarget)+": neni proklety.", oMySpeaker);
            }
            else
            {
                SetItemCursedFlag(oTarget, TRUE);
                FloatingTextStringOnCreature( GetName(oTarget)+": je proklety.", oMySpeaker);
            }
        }
        else
        {
            FloatingTextStringOnCreature("Neplatny predmet.", oMySpeaker);
        }
        break;
        case 38:
        if (GetObjectType(oTarget)==OBJECT_TYPE_ITEM)
        {
            if (GetStolenFlag(oTarget))
            {
                SetStolenFlag(oTarget, FALSE);
                FloatingTextStringOnCreature(GetName(oTarget)+": neni ukradeny.", oMySpeaker);
            }
            else
            {
                SetStolenFlag(oTarget, TRUE);
                FloatingTextStringOnCreature( GetName(oTarget)+": je ukradeny.", oMySpeaker);
            }
        }
        else
        {
            FloatingTextStringOnCreature("Neplatny predmet.", oMySpeaker);
        }
        break;
        // Placeably
        case 40:
        if (GetObjectType(oTarget) != OBJECT_TYPE_PLACEABLE)
        {
            oTarget = GetNearestObject(OBJECT_TYPE_PLACEABLE, oMySpeaker);
            FloatingTextStringOnCreature("Cil neni placeable, takze je vybran nejblizsi placeable", oMySpeaker);
        }
        if (GetIsObjectValid(oTarget))
        {
              DestroyObject(oTarget);
              DelayCommand(2.0, FloatingTextStringOnCreature(GetName(oTarget) + "zniceno.  Pokud byl staticky musite opustit lokaci, abyste videli zmenu.", oMySpeaker));
        }
        break;
        case 41:
        if (GetObjectType(oTarget) != OBJECT_TYPE_PLACEABLE)
        {
            oTarget = GetNearestObject(OBJECT_TYPE_PLACEABLE, oMySpeaker);
            FloatingTextStringOnCreature("Cil neni placeable, takze je vybran nejblizsi placeable", oMySpeaker);
        }
        if (GetIsObjectValid(oTarget))
        {
              AssignCommand(oTarget, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
              DelayCommand(0.4,SetPlaceableIllumination(oTarget, FALSE));
              DelayCommand(0.5,RecomputeStaticLighting(oArea));
        }
        break;
        case 42:
        if (GetObjectType(oTarget) != OBJECT_TYPE_PLACEABLE)
        {
            oTarget = GetNearestObject(OBJECT_TYPE_PLACEABLE, oMySpeaker);
            FloatingTextStringOnCreature("Cil neni placeable, takze je vybran nejblizsi placeable", oMySpeaker);
        }
        if (GetIsObjectValid(oTarget))
        {
              AssignCommand(oTarget, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
              DelayCommand(0.4,SetPlaceableIllumination(oTarget, TRUE));
              DelayCommand(0.5,RecomputeStaticLighting(oArea));
        }
        break;
        case 43: RotateMe(oTarget, -2, oMySpeaker);break;
        case 44: RotateMe(oTarget, -1, oMySpeaker);break;
        case 45: RotateMe(oTarget,iDMSetNumber,oMySpeaker);break;
        case 500: AdjustAlignment(oTarget, ALIGNMENT_GOOD, iDMSetNumber); FloatingTextStringOnCreature("Presveceni cile bylo posunuto k dobru o " + IntToString(iDMSetNumber), oMySpeaker); break;
        case 501: AdjustAlignment(oTarget, ALIGNMENT_EVIL, iDMSetNumber); FloatingTextStringOnCreature("Presveceni cile bylo posunuto ke zlu o " + IntToString(iDMSetNumber), oMySpeaker); break;
        case 502: AdjustAlignment(oTarget, ALIGNMENT_LAWFUL, iDMSetNumber); FloatingTextStringOnCreature("Presveceni cile bylo posunuto k zakonu o " + IntToString(iDMSetNumber), oMySpeaker); break;
        case 503: AdjustAlignment(oTarget, ALIGNMENT_CHAOTIC, iDMSetNumber); FloatingTextStringOnCreature("Presveceni cile bylo posunuto k chaosu o " + IntToString(iDMSetNumber), oMySpeaker); break;
        case 510: TakeStuff(1, oTarget, oMySpeaker); break;
        case 511: TakeStuff(0, oTarget, oMySpeaker); break;
        case 512: IdenStuff(oTarget); break;
        case 520: SendMessageToPC(oMySpeaker, GetName(oTarget) +" ma dohromady " + IntToString(DMFI_GetNetWorth(oTarget)) + " itemu a v hodnote " + IntToString(GetGold(oTarget)) +" zl.");break;
        case 521: DMFI_toad(oTarget, oMySpeaker); break;
        case 522: DMFI_untoad(oTarget, oMySpeaker); break;
        case 523: AssignCommand(oMySpeaker, AddToParty( oMySpeaker, GetFactionLeader(oTarget)));break;
        case 524: RemoveFromParty(oMySpeaker);break;
        case 525: ExploreAreaForPlayer(GetArea(oTarget), oTarget); FloatingTextStringOnCreature("Map Given: Target", oMySpeaker);break;
        case 526: {
                    FloatingTextStringOnCreature("Map Given: Party", oMySpeaker);
                    object oParty = GetFirstFactionMember(oTarget,TRUE);
                    while (GetIsObjectValid(oParty))
                        {
                        ExploreAreaForPlayer(GetArea(oTarget), oTarget);
                        oParty = GetNextFactionMember(oTarget,TRUE);
                        }
         break;
         }
        case 527: ExportAllCharacters();break;
        case 528: //dmwand_KickPC(oTarget, oMySpeaker);break;
        case 601: ChangeToStandardFaction(oTarget, STANDARD_FACTION_HOSTILE);  break;
        case 602: ChangeToStandardFaction(oTarget, STANDARD_FACTION_COMMONER); break;
        case 603: ChangeToStandardFaction(oTarget, STANDARD_FACTION_DEFENDER); break;
        case 604: ChangeToStandardFaction(oTarget, STANDARD_FACTION_MERCHANT); break;
        case 605: oChange = GetFirstObjectInArea(oArea);
            while (GetIsObjectValid(oChange))
            {if (GetObjectType(oChange) == OBJECT_TYPE_CREATURE && !GetIsPC(oChange))
                    ChangeToStandardFaction(oChange, STANDARD_FACTION_HOSTILE);
                  oChange = GetNextObjectInArea(oArea);}break;
        case 606: oChange = GetFirstObjectInArea(oArea);
            while (GetIsObjectValid(oChange))
            {if (GetObjectType(oChange) == OBJECT_TYPE_CREATURE && !GetIsPC(oChange))
                    ChangeToStandardFaction(oChange, STANDARD_FACTION_COMMONER);
                 oChange = GetNextObjectInArea(oArea);}break;
        case 607: oChange = GetFirstObjectInArea(oArea);
            while (GetIsObjectValid(oChange))
            {if (GetObjectType(oChange) == OBJECT_TYPE_CREATURE && !GetIsPC(oChange))
                    ChangeToStandardFaction(oChange, STANDARD_FACTION_DEFENDER);
                oChange = GetNextObjectInArea(oArea);}break;
        case 608: oChange = GetFirstObjectInArea(oArea);
            while (GetIsObjectValid(oChange))
            {if (GetObjectType(oChange) == OBJECT_TYPE_CREATURE && !GetIsPC(oChange))
                    ChangeToStandardFaction(oChange, STANDARD_FACTION_MERCHANT);
                 oChange = GetNextObjectInArea(oArea);}break;
          /*    DODELAT FRAKCE  */
       case 611: setFactionsToPC(oTarget,0);break;
       case 612: setFactionsToPC(oTarget,1);break;


        case 620: AssignCommand(oTarget, ClearAllActions()); AssignCommand(oTarget, ActionMoveAwayFromObject(oMySpeaker, TRUE));break;
        case 621: AssignCommand(oTarget, ClearAllActions()); AssignCommand(oTarget, ActionForceMoveToObject(oMySpeaker, TRUE, 2.0f, 30.0f)); break;
        case 622: AssignCommand(oTarget, ClearAllActions()); AssignCommand(oTarget, ActionRandomWalk()); break;
        case 623: AssignCommand(oTarget, ClearAllActions()); AssignCommand(oTarget, ActionRest()); break;
        case 624: oChange = GetFirstObjectInArea(oArea);
            while (GetIsObjectValid(oChange))
            {if (GetObjectType(oChange) == OBJECT_TYPE_CREATURE && !GetIsPC(oChange)){
                    AssignCommand(oChange, ClearAllActions()); AssignCommand(oChange, ActionMoveAwayFromObject(oMySpeaker, TRUE));}
                oChange = GetNextObjectInArea(oArea);} break;
        case 625: oChange = GetFirstObjectInArea(oArea);
            while (GetIsObjectValid(oChange))
            {if (GetObjectType(oChange) == OBJECT_TYPE_CREATURE && !GetIsPC(oChange)){
                    AssignCommand(oChange, ClearAllActions()); AssignCommand(oChange, ActionForceMoveToObject(oMySpeaker, TRUE, 2.0f, 30.0f));}
                oChange = GetNextObjectInArea(oArea);} break;
        case 626: oChange = GetFirstObjectInArea(oArea);
            while (GetIsObjectValid(oChange))
            {if (GetObjectType(oChange) == OBJECT_TYPE_CREATURE && !GetIsPC(oChange)){
                    AssignCommand(oChange, ClearAllActions()); AssignCommand(oChange, ActionRandomWalk());}
                oChange = GetNextObjectInArea(oArea);} break;
        case 627: oChange = GetFirstObjectInArea(oArea);
            while (GetIsObjectValid(oChange))
            {if (GetObjectType(oChange) == OBJECT_TYPE_CREATURE && !GetIsPC(oChange)){
                    AssignCommand(oChange, ClearAllActions()); AssignCommand(oChange, ActionRest());}
                oChange = GetNextObjectInArea(oArea);} break;
        case 628: ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDisappear(), oTarget);
                DestroyObject(oTarget, 1.0);
                break;
        case 71: {
            object oArea = GetArea(oMySpeaker);
            object oPlc = GetFirstObjectInArea(oArea);
            while(GetIsObjectValid(oPlc)) {
              if(GetLocalInt(oPlc,"ku_plc_origin") == 0) {
                switch(GetObjectType(oPlc)) {
                  case OBJECT_TYPE_PLACEABLE:
                    SendMessageToPC(oMySpeaker,"Ukladam "+GetName(oPlc));
                    Persist_SavePlaceable(oPlc,oArea);
                    SetLocalInt(oPlc,"ku_plc_origin",2);
                    break;
                  default:
                   break;
                }
              }
              oPlc = GetNextObjectInArea(oArea);
            }
          }
          break;
        // Vymazat objekty z DB
        case 72: {
            object oArea = GetArea(oMySpeaker);
            Persist_DeletePlaceablesInArea(oArea);
          }
          break;
        // Odstranit persistentni placeably
        case 73: {
          object oArea = GetArea(oMySpeaker);
          Persist_DestroyObjectsInArea(oArea,2,OBJECT_TYPE_PLACEABLE);
        }
        break;
        // Odstranit persistentni placeably
        case 74: {
            object oArea = GetArea(oMySpeaker);
            Persist_DestroyObjectsInArea(oArea,0,OBJECT_TYPE_PLACEABLE);
          }
          break;
        case 75: {
          object oArea = GetArea(oMySpeaker);
          Persist_DestroyObjectsInArea(oArea,0,OBJECT_TYPE_PLACEABLE);
          Persist_DestroyObjectsInArea(oArea,2,OBJECT_TYPE_PLACEABLE);
          Persist_DestroyObjectsInArea(oArea,2,OBJECT_TYPE_CREATURE);
          Persist_LoadAddedPlaceables(oArea);
          }
          break;
        //Zpersistentni/zrus NPC
        case 76: {

          object oArea = GetArea(oTarget);
          if(GetLocalInt(oTarget,"ku_plc_origin") == 2 ) {
            Persist_DeleteNPCSInArea(oArea,oTarget);
            AssignCommand(oTarget,SpeakString("NPC odstraneno z persistence"));
          }
          else {
            Persist_SavePlaceable(oTarget,oArea);
            AssignCommand(oTarget,SpeakString("NPC zpersistentneno"));
          }
        }
        break;
        //odstran NPC z DB
        case 77: {
            object oArea = GetArea(oMySpeaker);
            Persist_DeleteNPCSInArea(oArea);
          }
          break;
        //Zapni spawn
        case 78:

            Persist_SetSpawnInAreaDisabled(GetArea(oMySpeaker),0);

        break;
        //Vypni spawn
        case 79:
            Persist_SetSpawnInAreaDisabled(GetArea(oMySpeaker),1);
        break;
    }
    break;

    //funkce
    case 3:
    switch (iUnivInt)
    {
        case 150: eI= EffectDamage(d4(iDMSetNumber), DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY);
                 eVis = EffectVisualEffect(VFX_COM_BLOOD_SPARK_SMALL);
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, eI, oTarget);
                 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oTarget);break;
        case 151: eI = EffectDamage(d6(iDMSetNumber), DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY);
                 eVis = EffectVisualEffect(VFX_COM_BLOOD_LRG_RED);
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, eI, oTarget);
                 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oTarget);break;
        case 152: eI = EffectDamage(d8(iDMSetNumber), DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY);
                 eVis = EffectVisualEffect(VFX_COM_BLOOD_LRG_RED);
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, eI, oTarget);
                 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oTarget);break;
        case 153: eI = EffectDamage(d10(iDMSetNumber), DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY);
                 eVis = EffectVisualEffect(VFX_COM_BLOOD_SPARK_SMALL);
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, eI, oTarget);
                 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oTarget);break;
        case 154: eI = EffectDamage(d12(iDMSetNumber), DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY);
                 eVis = EffectVisualEffect(VFX_COM_BLOOD_SPARK_SMALL);
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, eI, oTarget);
                 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oTarget);break;
        case 155: eI = EffectDamage(FloatToInt(IntToFloat(iDMSetNumber)/100*GetCurrentHitPoints(oTarget)), DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY);
                 eVis = EffectVisualEffect(VFX_COM_BLOOD_LRG_RED);
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, eI, oTarget);
                 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oTarget);break;
        case 156: eI = EffectDamage(GetCurrentHitPoints(oTarget)-1, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY);
                 eVis =EffectVisualEffect(VFX_COM_CHUNK_RED_SMALL);
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, eI, oTarget);
                 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oTarget);break;
         case 110: eT =EffectBlindness(); ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eT, oTarget, fDuration); break;
        case 111: eT = EffectCurse(4,4,4,4,4,4); ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eT, oTarget, fDuration);break;
        case 112: eT = EffectFrightened(); ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eT, oTarget, fDuration);break;
        case 113: eT = EffectParalyze(); ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eT, oTarget, fDuration);break;
        case 114: eT = EffectSilence(); ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eT, oTarget, fDuration);break;
        case 115: eT = EffectSleep(); ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eT, oTarget, fDuration);break;
        case 116: eT = EffectSlow(); ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eT, oTarget, fDuration);break;
        case 117: eT = EffectKnockdown(); ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eT, oTarget, fDuration); break;
        case 118: eT = EffectPetrify(); ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eT, oTarget, fDuration);break;
        case 119: eI = EffectDamage( GetCurrentHitPoints(oTarget)-1, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL);
                 AssignCommand( oTarget, ClearAllActions());
                 AssignCommand( oTarget, ActionPlayAnimation( ANIMATION_LOOPING_DEAD_FRONT, 1.0, 99999.0));
                 DelayCommand(0.5, SetCommandable( FALSE, oTarget)); ApplyEffectToObject(DURATION_TYPE_INSTANT, eI, oTarget);break;
        case 120: eA = EffectCutsceneDominated();ApplyEffectToObject(DURATION_TYPE_PERMANENT, eA, oTarget);break;
        case 121: eA = EffectCutsceneGhost(); ApplyEffectToObject(DURATION_TYPE_PERMANENT, eA, oTarget);break;
        case 122: eA = EffectCutsceneImmobilize(); ApplyEffectToObject(DURATION_TYPE_PERMANENT, eA, oTarget);break;
        case 123: eA = EffectCutsceneParalyze(); ApplyEffectToObject(DURATION_TYPE_PERMANENT, eA, oTarget);break;
        case 130: eEffect = GetFirstEffect(oTarget);
                 while (GetIsEffectValid(eEffect))
                 {
                    if (GetEffectType(eEffect) == EFFECT_TYPE_PETRIFY) RemoveEffect(oTarget, eEffect);
                    eEffect = GetNextEffect(oTarget);
                 } break;//Added July 5, 2003
        case 131: eEffect = GetFirstEffect(oTarget);
                 while (GetIsEffectValid(eEffect))
                 {
                    if (GetEffectType(eEffect) == EFFECT_TYPE_POISON) RemoveEffect(oTarget, eEffect);
                    eEffect = GetNextEffect(oTarget);
                 } break;
        case 132: eEffect = GetFirstEffect(oTarget);
                 while (GetIsEffectValid(eEffect))
                 {
                    if (GetEffectType(eEffect) == EFFECT_TYPE_DISEASE) RemoveEffect(oTarget, eEffect);
                    eEffect = GetNextEffect(oTarget);
                 } break;
        case 133: eEffect = GetFirstEffect(oTarget);
                 while (GetIsEffectValid(eEffect))
                 {
                    if (GetEffectType(eEffect) == EFFECT_TYPE_BLINDNESS) RemoveEffect(oTarget, eEffect);
                    eEffect = GetNextEffect(oTarget);
                 } break;
        case 134: eEffect = GetFirstEffect(oTarget);
                 while (GetIsEffectValid(eEffect))
                 {
                    if (GetEffectType(eEffect) == EFFECT_TYPE_CURSE) RemoveEffect(oTarget, eEffect);
                    eEffect = GetNextEffect(oTarget);
                 } break;
        case 135: eEffect = GetFirstEffect(oTarget);
                 while (GetIsEffectValid(eEffect))
                 {
                    if (GetEffectType(eEffect) == EFFECT_TYPE_FRIGHTENED) RemoveEffect(oTarget, eEffect);
                    eEffect = GetNextEffect(oTarget);
                 } break;
        case 136: eEffect = GetFirstEffect(oTarget);
                 while (GetIsEffectValid(eEffect))
                 {
                    if (GetEffectType(eEffect) == EFFECT_TYPE_STUNNED) RemoveEffect(oTarget, eEffect);
                    eEffect = GetNextEffect(oTarget);
                 } break;
        case 137: eEffect = GetFirstEffect(oTarget);
                 while (GetIsEffectValid(eEffect))
                 {
                    if (GetEffectType(eEffect) == EFFECT_TYPE_SILENCE) RemoveEffect(oTarget, eEffect);
                    eEffect = GetNextEffect(oTarget);
                 } break;
        case 138: eEffect = GetFirstEffect(oTarget);
                 while (GetIsEffectValid(eEffect))
                 {
                    RemoveEffect(oTarget, eEffect);
                    eEffect = GetNextEffect(oTarget);
                 } break;
        case 139: SetCommandable(TRUE, oTarget);
                 AssignCommand(oTarget, ClearAllActions()); break;
        case 140:SetCampaignFloat(sDMid, "dmfi_effectduration",fDMSetNumber,oMySpeaker);break;
        case 90:SetLocalInt(oSoulTarget,"NT_XP_BONUS_LEVEL",iDMSetNumber);break;
        //bozstva
        case 20:
            SetDeity(oTarget,sDMstring);
        break;//buh
        case 21:ChangeDomain(oTarget,iDMSetNumber, 1 );break;//domena1

        case 22:ChangeDomain(oTarget,iDMSetNumber, 2 );break;//domena2
        //ziskani kuze postavy
        case 3:
        CopyObject(GetItemInSlot(INVENTORY_SLOT_CARMOUR,oTarget),GetLocation(oMySpeaker),oMySpeaker);
        break;//domena2

    }
    break;
        // hody kostkou
    case 4:
        DoDiceBagFunction(iUnivInt, GetLocalObject(oMySpeaker, "dmfi_univ_target"));
    break;
    }
    DeleteLocalInt(oMySpeaker, "sh_dm_univ_int");

}




//DMFI Processes the dice rolls
void RollDemBones(object oUser, int iBroadcast, int iMod = 0, string sAbility = "", int iNum = 1, int iSide = 20)
{

    string sString = "";
    int iRoll = 0;
    int iTotal = 0;
    //Build the string
    sString = sAbility+"Roll " + IntToString(iNum) + "d" + IntToString(iSide) + ": ";
    while(iNum > 1)
    {
        iRoll = Random(iSide) + 1;
        iTotal = iTotal + iRoll;
        sString = sString + IntToString(iRoll) + " + ";
        iNum--;
    }
    iRoll = Random(iSide) + 1;
    iTotal = iTotal + iRoll;
    sString = sString + IntToString(iRoll);
    if (iMod)
    {
        iTotal = iTotal + iMod;
        sString = sString + " + Modifier: " + IntToString(iMod);
    }
    sString = sString + " = Total: " + IntToString(iTotal);

    //Perform appropriate animation
    if (GetLocalInt(OBJECT_SELF, "dmfi_dice_no_animate")!=1)
    {
    switch(GetLocalInt(oUser, "dmfi_univ_int"))
    {
        case 71: AssignCommand(oUser, PlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 5.0f)); break;
        case 72: AssignCommand(oUser, PlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 1.0)); break;
        case 73: AssignCommand(oUser, PlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0)); break;
        case 74: AssignCommand(oUser, PlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 1.0)); break;
        case 78: AssignCommand(oUser, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 5.0f)); break;
        case 81: AssignCommand(oUser, PlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 5.0f)); break;
        case 82: AssignCommand(oUser, PlayAnimation(ANIMATION_FIREFORGET_DODGE_SIDE, 1.0)); break;
        case 83: AssignCommand(oUser, PlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0)); break;
        case 84: AssignCommand(oUser, PlayAnimation(ANIMATION_LOOPING_LISTEN, 1.0, 5.0f)); break;
        case 85: AssignCommand(oUser, PlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 1.0)); break;
        case 89: AssignCommand(oUser, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BARD_SONG), oUser, 6.0f)); break;
        case 91: AssignCommand(oUser, PlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 5.0f)); break;
        case 95: AssignCommand(oUser, PlayAnimation(ANIMATION_LOOPING_CONJURE2, 1.0, 5.0f)); break;
        case 97: AssignCommand(oUser, PlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0)); break;
        case 98: AssignCommand(oUser, PlayAnimation(ANIMATION_FIREFORGET_DODGE_DUCK, 1.0)); break;
        default: AssignCommand(oUser, PlayAnimation (ANIMATION_LOOPING_GET_MID, 1.0, 3.0)); break;
    }
    }

//    sString = ColorText(sString, "cyan");
    //--------------------------------------------------------
    switch(iBroadcast)
    {
        case 3: break;                             //dm only
        case 1: AssignCommand(oUser, SpeakString(sString , TALKVOLUME_SHOUT)); break;
        case 2: AssignCommand(oUser, SpeakString(sString)); break;
        default: if (GetIsPC(oUser)) SendMessageToPC(oUser, sString); break;
    }
    //--------------------------------------------------------
    AssignCommand(oUser, SpeakString( sString, TALKVOLUME_SILENT_SHOUT));
    return;
}
string ColorTextRGB(int red = 15,int green = 15,int blue = 15)
{
    string sColor = GetLocalString(GetModule(),"ColorSet");
    if(red > 15) red = 15; if(green > 15) green = 15; if(blue > 15) blue = 15;

    return "<c" +
    GetSubString(sColor, red - 1, 1) +
    GetSubString(sColor, green - 1, 1) +
    GetSubString(sColor, blue - 1, 1) +">";

}
//This function is for the DMFI PC Dicebag
void DoDiceBagFunction(int iDice, object oUser)
{
  //  string sDMid = "DM_"+GetName(oUser)+"_"+GetPCPlayerName(oUser);
    string sAbility = "";
    int iTrain =0;
    int iNum = 0;
    int iSide = 0;
    int iMod = 0;
    int iLeft;
    if (iDice < 100)
        iLeft = StringToInt(GetStringLeft(IntToString(iDice), 1));
    else
        iLeft = 10;
        int iRight = StringToInt(GetStringRight(IntToString(iDice), 1));
    if(iRight == 0)
    iRight =10;
    switch(iDice)
    {
        case 61: iNum = 1; iSide = 20; sAbility="Strength Check, "; iMod = GetAbilityModifier(ABILITY_STRENGTH, oUser); break;
        case 62: iNum = 1; iSide = 20; sAbility="Dexterity Check, "; iMod = GetAbilityModifier(ABILITY_DEXTERITY, oUser); break;
        case 63: iNum = 1; iSide = 20; sAbility="Constitution Check, "; iMod = GetAbilityModifier(ABILITY_CONSTITUTION, oUser); break;
        case 64: iNum = 1; iSide = 20; sAbility="Intelligence Check, "; iMod = GetAbilityModifier(ABILITY_INTELLIGENCE, oUser); break;
        case 65: iNum = 1; iSide = 20; sAbility="Wisdom Check, "; iMod = GetAbilityModifier(ABILITY_WISDOM, oUser); break;
        case 66: iNum = 1; iSide = 20; sAbility="Charisma Check, "; iMod = GetAbilityModifier(ABILITY_CHARISMA, oUser); break;
        case 67: iNum = 1; iSide = 20; sAbility="Fortitude Save, "; iMod = GetFortitudeSavingThrow(oUser); break;
        case 68: iNum = 1; iSide = 20; sAbility="Reflex Save, "; iMod = GetReflexSavingThrow(oUser); break;
        case 69: iNum = 1; iSide = 20; sAbility="Will Save, "; iMod = GetWillSavingThrow(oUser); break;

        case 71: iNum = 1; iSide = 20; iTrain = 1; sAbility="Animal Empathy Check, "; iMod = GetSkillRank(SKILL_ANIMAL_EMPATHY, oUser); break;
        case 72: iNum = 1; iSide = 20; sAbility="Appraise Check, "; iMod = GetSkillRank(SKILL_APPRAISE, oUser); break;
        case 73: iNum = 1; iSide = 20; sAbility="Bluff Check, "; iMod = GetSkillRank(SKILL_BLUFF, oUser); break;
        case 74: iNum = 1; iSide = 20; sAbility="Concentration Check, "; iMod = GetSkillRank(SKILL_CONCENTRATION, oUser); break;
        case 75: iNum = 1; iSide = 20; sAbility="Craft Armor Check, "; iMod = GetSkillRank(SKILL_CRAFT_ARMOR, oUser); break;
        case 76: iNum = 1; iSide = 20; sAbility="Craft Trap Check, "; iMod = GetSkillRank(SKILL_CRAFT_TRAP, oUser); break;
        case 77: iNum = 1; iSide = 20; sAbility="Craft Weapon Check, "; iMod = GetSkillRank(SKILL_CRAFT_WEAPON, oUser); break;
        case 78: iNum = 1; iSide = 20; iTrain = 1; sAbility="Disable Trap Check, "; iMod = GetSkillRank(SKILL_DISABLE_TRAP, oUser); break;
        case 79: iNum = 1; iSide = 20; sAbility="Discipline Check, "; iMod = GetSkillRank(SKILL_DISCIPLINE, oUser); break;

        case 81: iNum = 1; iSide = 20; sAbility="Heal Check, "; iMod = GetSkillRank(SKILL_HEAL, oUser); break;
        case 82: iNum = 1; iSide = 20; sAbility="Hide Check, "; iMod = GetSkillRank(SKILL_HIDE, oUser); break;
        case 83: iNum = 1; iSide = 20; sAbility="Intimidate Check, "; iMod = GetSkillRank(SKILL_INTIMIDATE, oUser); break;
        case 84: iNum = 1; iSide = 20; sAbility="Listen Check, "; iMod = GetSkillRank(SKILL_LISTEN, oUser); break;
        case 85: iNum = 1; iSide = 20; sAbility="Lore Check, "; iMod = GetSkillRank(SKILL_LORE, oUser); break;
        case 86: iNum = 1; iSide = 20; sAbility="Move Silently Check, "; iMod = GetSkillRank(SKILL_MOVE_SILENTLY, oUser); break;
        case 87: iNum = 1; iSide = 20; iTrain = 1; sAbility="Open Lock Check, "; iMod = GetSkillRank(SKILL_OPEN_LOCK, oUser); break;
        case 88: iNum = 1; iSide = 20; sAbility="Parry Check, "; iMod = GetSkillRank(SKILL_PARRY, oUser); break;
        case 89: iNum = 1; iSide = 20; sAbility="Perform Check, "; iMod = GetSkillRank(SKILL_PERFORM, oUser); break;
        case 90: iNum = 1; iSide = 20; sAbility="Ride, "; iMod = GetSkillRank(SKILL_RIDE, oUser); break;
        case 91: iNum = 1; iSide = 20; sAbility="Persuade Check, "; iMod = GetSkillRank(SKILL_PERSUADE, oUser); break;
        case 92: iNum = 1; iSide = 20; iTrain = 1; sAbility="Pick Pocket Check, "; iMod = GetSkillRank(SKILL_PICK_POCKET, oUser); break;
        case 93: iNum = 1; iSide = 20; sAbility="Search Check, "; iMod = GetSkillRank(SKILL_SEARCH, oUser); break;
        case 94: iNum = 1; iSide = 20; iTrain = 1; sAbility="Set Trap Check, "; iMod = GetSkillRank(SKILL_SET_TRAP, oUser); break;
        case 95: iNum = 1; iSide = 20; iTrain = 1; sAbility="Spellcraft Check, "; iMod = GetSkillRank(SKILL_SPELLCRAFT, oUser); break;
        case 96: iNum = 1; iSide = 20; sAbility="Spot Check, "; iMod = GetSkillRank(SKILL_SPOT, oUser); break;
        case 97: iNum = 1; iSide = 20; sAbility="Taunt Check, "; iMod = GetSkillRank(SKILL_TAUNT, oUser); break;
        case 98: iNum = 1; iSide = 20; iTrain = 1; sAbility="Tumble Check, "; iMod = GetSkillRank(SKILL_TUMBLE, oUser); break;
        case 99: iNum = 1; iSide = 20; iTrain = 1; sAbility="Use Magic Device Check, "; iMod = GetSkillRank(SKILL_USE_MAGIC_DEVICE, oUser); break;

        case 101: SetLocalInt(oUser, "dmfi_dicebag", 2);  SetCustomToken(20681, "Local"); FloatingTextStringOnCreature("Broadcast Mode set to Local", oUser, FALSE); return; break;
        case 102: SetLocalInt(oUser, "dmfi_dicebag", 1);  SetCustomToken(20681, "Global"); FloatingTextStringOnCreature("Broadcast Mode set to Global", oUser, FALSE); return; break;
        case 103: SetLocalInt(oUser, "dmfi_dicebag", 0);  SetCustomToken(20681, "Private"); FloatingTextStringOnCreature("Broadcast Mode set to Private", oUser, FALSE); return; break;

        default: iNum = iRight;
        switch(iLeft)
        {
            case 1: iSide = 4; break;
            case 2: iSide = 6; break;
            case 3: iSide = 8; break;
            case 4: iSide = 10; break;
            case 5: iSide = 20; break;
        }

        break;
    }
    if ((iTrain)&&(iMod==0))
        {
        string sMsg = ColorTextRGB(1,15,15)+"No dice roll:  Skill requires training";
        SendMessageToPC(oUser, sMsg);
        AssignCommand(oUser, SpeakString( sMsg, TALKVOLUME_SILENT_SHOUT));
        return;
        }


    int iTell = GetLocalInt(oUser, "dmfi_dicebag");
    RollDemBones(oUser, iTell, iMod, sAbility, iNum, iSide);
    DeleteLocalInt(OBJECT_SELF,"Tens");
}
