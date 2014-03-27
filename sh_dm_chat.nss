#include "sh_lang_inc"
//#include "ku_libbase"
#include "ku_exp_time"
#include "ku_libchat"
#include "mys_music"
#include "mys_dmlisten_lib"
    
    /*
    int    TALKVOLUME_TALK          = 0;
    int    TALKVOLUME_WHISPER       = 1;
    int    TALKVOLUME_SHOUT         = 2;
    int    TALKVOLUME_SILENT_TALK   = 3;
    int    TALKVOLUME_SILENT_SHOUT  = 4;
    int    TALKVOLUME_PARTY         = 5;
    int    TALKVOLUME_TELL          = 6;
    */

    /*
    int    LANGUAGE_COMMON          = 0;
    int    LANGUAGE_ABYSSAL         = 1;
    int    LANGUAGE_AQUAN           = 2;
    int    LANGUAGE_AURAN           = 3;
    int    LANGUAGE_CELESTIAL       = 4;
    int    LANGUAGE_DRACONIC        = 5;
    int    LANGUAGE_DRUIDIC         = 6;
    int    LANGUAGE_DWARVEN         = 7;
    int    LANGUAGE_ELVEN           = 8;
    int    LANGUAGE_GIANT           = 9;
    int    LANGUAGE_GNOME           = 10;
    int    LANGUAGE_GOBLIN          = 11;
    int    LANGUAGE_GNOLL           = 12;
    int    LANGUAGE_HALFLING        = 13;
    int    LANGUAGE_IGNAN           = 14;
    int    LANGUAGE_INFERNAL        = 15;
    int    LANGUAGE_ORC             = 16;
    int    LANGUAGE_SYLVAN          = 17;
    int    LANGUAGE_TERRAN          = 18;
    int    LANGUAGE_UNDERCOMMON     = 19;
    int    LANGUAGE_PLANT           = 20;
    int    LANGUAGE_ANIMAL          = 21;
    */    
    
    object oSpeaker = GetPCChatSpeaker();
    string sName = GetName(oSpeaker, FALSE);
    object oCarmour = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oSpeaker);
    string sSpoke = GetPCChatMessage();
    int iDM = GetIsDM(oSpeaker);
    int iDMp = GetIsDMPossessed(oSpeaker);
    int iPC = GetIsPC(oSpeaker);
    string sLeftDM = GetStringLeft(sSpoke, 4);
    string sDMstring = GetLocalString(oSpeaker, "DMstring");
    object oCheck = GetSoulStone(oSpeaker);
    int iDMSetNumber = GetLocalInt(oCarmour, "DMSetNumber");
    int iLength = GetStringLength(sSpoke);
    int iGetVolume = GetPCChatVolume();

    object oTargetSpeak = GetLocalObject(oSpeaker, "dmfi_Lang_target");
    string sNameTarget =  GetName(oTargetSpeak,FALSE);
    int iGettype = GetObjectType(oTargetSpeak);
    int iLanguageSpeaker = GetLocalInt(oCheck,"Language");

void ChatXpSystem();
void HenchmanChat();
    
void main()
{
    // Allow shout only for DMs
    if (iGetVolume == TALKVOLUME_SHOUT)
    {
        if (!iDM && !iDMp)
            SetPCChatVolume(TALKVOLUME_TALK);
    }
    
    if (GetStringLeft(sSpoke, 1) == "/" && GetStringLeft(sSpoke, 2) != "//")
    {
        // DM commands
        if ((iDM || iDMp) && GetStringLeft(sSpoke, 3) == "/dm")
            DmSpeakFunction();
        
        else if (GetStringLeft(sSpoke, 3) == "/pc")
        {
            MusicInstrumentChoice();
            ku_ChatCommand(oSpeaker,sSpoke,iGetVolume);
        }
        else if (sSpoke == "/emo")
            AssignCommand(oSpeaker, ActionStartConversation(oSpeaker, "myd_emote", TRUE, FALSE));
            
        else if (GetIsObjectValid(oTargetSpeak))
            oSpeaker = oTargetSpeak;
                    
        else
        {
            PCEmoteFunction();
            PCDiceFuntion();
            LanguageSet();
        }
        SetPCChatVolume(TALKVOLUME_TELL);
        SetPCChatMessage("");
        return;
    }
    
    if (GetIsObjectValid(oTargetSpeak))
    {
        TargetSpeak(oTargetSpeak);
        SetPCChatMessage("");
        return;
    }
    Languagespeech();
    ChatXpSystem();

    // Send chat to DMs
    SendChatToListeners(oSpeaker, sSpoke, iGetVolume);
}

void ChatXpSystem()
{
    // Now system check last #(KU_MASSAGE_CACHE) messages that player sent for xp system
    int i;
    int match = FALSE;
    for (i=0;i < KU_CHAT_CACHE_SIZE ;i++)
    {
        if (sSpoke == GetLocalString(oSpeaker,KU_CHAT_CACHE+IntToString(i)) )
        {
            match = TRUE;
            break;
        }
    }
    
    // Prodluz pridelovani xp
    if (!match)
        SetLocalInt(oSpeaker,"ku_LastActionStamp",ku_GetTimeStamp(0,5)); // +5 minutes
    
    int CacheIndex = GetLocalInt(oSpeaker,"KU_CHAT_CACHE_INDEX");
    CacheIndex = (CacheIndex + 1) % KU_CHAT_CACHE_SIZE;
    
    SetLocalString(oSpeaker,KU_CHAT_CACHE+IntToString(CacheIndex),sSpoke);
    SetLocalInt(oSpeaker,"KU_CHAT_CACHE_INDEX",CacheIndex);
    SetLocalInt(oSpeaker,"ku_LastActionType",KU_ACTIONS_SPEAK);
}

void HenchmanChat() {
  object oPC = GetPCChatSpeaker();
  int bCreatureCommand = FALSE;
  int HideText = FALSE;

  object oFam = OBJECT_INVALID;
  if(left == "/f ") {
    oFam = GetLocalObject(oPC,"FAMILIAR");
    bCreatureCommand = TRUE;
  }
  if(left == "/c ") {
    bCreatureCommand = TRUE;
    oFam = GetLocalObject(oPC,"COMPANION");
  }
  if(left == "/h ") {
    bCreatureCommand = TRUE;
    oFam = GetLocalObject(oPC,"JA_HORSE_OBJECT");
  }
  if( (bCreatureCommand) &&
      (GetIsObjectValid(oFam)) ) {
    string sRight = GetSubString(mess,3,100);
    float fDur = 9999.0f; //Duration
    if(sRight == "*sedni*") {
      AssignCommand(oFam, PlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur));
    } else if(sRight == "*lehni*") {
      AssignCommand(oFam, PlayAnimation( ANIMATION_LOOPING_DEAD_BACK, 1.0, fDur));
    } else if(sRight == "*uhni*") {
      AssignCommand(oFam, PlayAnimation( ANIMATION_FIREFORGET_DODGE_SIDE, 1.0));
    } else {
      AssignCommand(oFam,SpeakString(sRight));
    }
    HideText = TRUE;
  }
 
  if(HideText) {
    SetPCChatVolume(TALKVOLUME_TELL);
    SetPCChatMessage("");
  }

}
