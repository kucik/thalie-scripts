#include "pc_lib"
#include "sh_chat_inc"
#include "sh_lang_inc"
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

void ChatXpSystem(object oSpeaker, string sSpoken);
void AssociateSpeak(object oAssociate, string sRight);
object GetAssociateSpeaker(object oSpeaker, int iPlayerType, string sVarName);

void Test_MountDebug(object oPC);
void Test_MountSetValue(object oPC, string sSpoken);

void main()
{
    object oSpeaker = GetPCChatSpeaker();
    object oSoul = GetSoulStone(oSpeaker);
    object oTargetSpeaker = GetLocalObject(oSpeaker, "dmfi_Lang_target");
    string sSpoken = GetPCChatMessage();
    string sLeft3 = GetStringLeft(sSpoken, 3);
    int iLength = GetStringLength(sSpoken);
    int iVolume = GetPCChatVolume();
    int iPlayerType = GetPlayerType(oSpeaker);

    // Allow shout only for DMs
    if (GetPCChatVolume() == TALKVOLUME_SHOUT)
    {
        if (GetIsPlayer(GetPCChatSpeaker()))
        {
            SetPCChatVolume(TALKVOLUME_TALK);
            iVolume = TALKVOLUME_TALK;
        }
    }

    if (GetStringLeft(sSpoken, 1) == "/" && GetStringLeft(sSpoken, 2) != "//")
    {
        // DM commands
        if ((iPlayerType == PLAYER_TYPE_DM || iPlayerType == PLAYER_TYPE_DM_POSSESSED) && sLeft3 == "/dm")
            DmSpeakFunction(oSpeaker, oSoul, sSpoken, iPlayerType);

        else if (sLeft3 == "/pc")
        {
            MusicInstrumentChoice();
            ku_ChatCommand(oSpeaker, sSpoken, iVolume);
        }
        else if (sLeft3 == "/f ")
            AssociateSpeak(GetAssociateSpeaker(oSpeaker, iPlayerType, "FAMILIAR"), GetStringRight(sSpoken, iLength - 3));
        else if (sLeft3 == "/c ")
            AssociateSpeak(GetAssociateSpeaker(oSpeaker, iPlayerType, "COMPANION"), GetStringRight(sSpoken, iLength - 3));
        else if (sLeft3 == "/h ")
            AssociateSpeak(GetAssociateSpeaker(oSpeaker, iPlayerType, "HENCHMAN"), GetStringRight(sSpoken, iLength - 3));

        else if (sSpoken == "/emo")
            AssignCommand(oSpeaker, ActionStartConversation(oSpeaker, "myd_emote", TRUE, FALSE));

        else if (GetStringLeft(sSpoken, 5) == "/test")
        {
            Test_MountSetValue(oSpeaker, sSpoken);
            Test_MountDebug(oSpeaker);
        }
        
        else
        {
            PCEmoteFunction(oSpeaker, sSpoken);
            PCDiceFuntion(oSpeaker, sSpoken);
            LanguageSet(oSpeaker, oSoul, sSpoken);
        }
        SetPCChatVolume(TALKVOLUME_TELL);
        SetPCChatMessage("");
        return;
    }

    if (GetIsObjectValid(oTargetSpeaker))
    {
        TargetSpeak(oTargetSpeaker, oSoul, sSpoken, iVolume);
        SetPCChatMessage("");
        return;
    }
    LanguageSpeech(oSpeaker, oSoul, sSpoken, iVolume);
    ChatXpSystem(oSpeaker, sSpoken);

    // Send chat to DMs
    SendChatToListeners(oSpeaker, sSpoken, iVolume);
}

void ChatXpSystem(object oSpeaker, string sSpoken)
{
    // Now system check last #(KU_MASSAGE_CACHE) messages that player sent for xp system
    int i;
    int match = FALSE;
    for (i=0;i < KU_CHAT_CACHE_SIZE ;i++)
    {
        if (sSpoken == GetLocalString(oSpeaker,KU_CHAT_CACHE+IntToString(i)) )
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

    SetLocalString(oSpeaker,KU_CHAT_CACHE+IntToString(CacheIndex),sSpoken);
    SetLocalInt(oSpeaker,"KU_CHAT_CACHE_INDEX",CacheIndex);
    SetLocalInt(oSpeaker,"ku_LastActionType",KU_ACTIONS_SPEAK);
}

object GetAssociateSpeaker(object oSpeaker, int iPlayerType, string sVarName)
{
    if (iPlayerType == PLAYER_TYPE_PC_POSSESSED)
        return GetMaster(oSpeaker);
    else
        return GetLocalObject(oSpeaker, sVarName);
}

void AssociateSpeak(object oAssociate, string sRight)
{
    if (!GetIsObjectValid(oAssociate) || sRight == "")
        return;

    float fDur = 9999.0f;

    if(sRight == "*sedni*") {
      AssignCommand(oAssociate, PlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur));
    } else if(sRight == "*lehni*") {
      AssignCommand(oAssociate, PlayAnimation( ANIMATION_LOOPING_DEAD_BACK, 1.0, fDur));
    } else if(sRight == "*uhni*") {
      AssignCommand(oAssociate, PlayAnimation( ANIMATION_FIREFORGET_DODGE_SIDE, 1.0));
    } else {
      AssignCommand(oAssociate, SpeakString(sRight));
    }
}

void Test_MountDebug(object oPC)
{
    int iAppearance = GetAppearanceType(oPC);
    int iPhenoType = GetPhenoType(oPC);    
    int iWing = GetCreatureWingType(oPC);
    int iTail = GetCreatureTailType(oPC);
    
    SendMessageToPC(oPC, "("+GetName(oPC)+") appearance="+IntToString(iPhenoType));
    SendMessageToPC(oPC, "("+GetName(oPC)+") phenotype="+IntToString(iPhenoType));    
    SendMessageToPC(oPC, "("+GetName(oPC)+") wing="+IntToString(iPhenoType));
    SendMessageToPC(oPC, "("+GetName(oPC)+") tail="+IntToString(iPhenoType));
}

void Test_MountSetValue(object oPC, string sSpoken)
{
    int iLen = GetStringLength(sSpoken);
    string sVal = GetStringRight(sSpoken, iLen - 8);
    
    if (GetStringLeft(sSpoken, 8) == "/test89 ")
    {
         SetCreatureAppearanceType(oPC, StringToInt(sVal));
    }
    if (GetStringLeft(sSpoken, 8) == "/test90 ")
    {
        SetPhenoType(StringToInt(sVal), oPC); 
    }
    if (GetStringLeft(sSpoken, 8) == "/test91 ")
    {
        SetCreatureWingType(StringToInt(sVal), oPC); 
    }
    if (GetStringLeft(sSpoken, 8) == "/test92 ")
    {
        SetCreatureTailType(StringToInt(sVal), oPC); 
    }
}
