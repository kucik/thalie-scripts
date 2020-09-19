#include "pc_lib"
#include "sh_lang_inc"
#include "ku_exp_time"
#include "ku_libchat"
#include "mys_music"
#include "mys_dmlisten_lib"
#include "ku_write_inc"
#include "sh_classes_inc"

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

// Speaks as associate/master.
// Returns name of speaker.
string AssociateSpeak(object oAssociate, string sRight);
object GetAssociateSpeaker(int iPlayerType, string sVarName);

void main()
{
    int bXP;
    int iPlayerType = GetPlayerType(oSpeaker);
    string sSpeakerName = GetName(oSpeaker);
    string sLeft3 = GetStringLeft(sSpoke, 3);

    // Allow shout only for DMs
    if (iGetVolume == TALKVOLUME_SHOUT)
    {
        if (!iDM && !iDMp)
            SetPCChatVolume(TALKVOLUME_TALK);
    }

    // Call system for books/letters writing
    WriteCheck(oSpeaker, sSpoke);
    int iLocationBonus = 0;
    if (GetStringLeft(sSpoke, 1) == "/" && GetStringLeft(sSpoke, 2) != "//")
    {
        if (sSpoke == "/AreaC")
        {
            object oArea = GetFirstArea();
            while (GetIsObjectValid(oArea))
            {
                iLocationBonus = GetLocalInt(oArea, "XP_BONUS");
                if (iLocationBonus>0)
                {
                    SendMessageToPC(oSpeaker,"Area "+GetName(oArea)+":"+IntToString(iLocationBonus));
                }
                oArea = GetNextArea();
            }

        }

        // DM commands
        if ((iDM || iDMp) && sLeft3 == "/dm")
            DmSpeakFunction();

        else if (sLeft3 == "/pc")
        {
            MusicInstrumentChoice();
            ku_ChatCommand(oSpeaker,sSpoke,iGetVolume);
            bXP = TRUE;
        }
        else if (sSpoke == "/emo")
        {
            AssignCommand(oSpeaker, ActionStartConversation(oSpeaker, "myd_emote", TRUE, FALSE));
            bXP = TRUE;
        }

        // Talking as associate/master
        else if (sLeft3 == "/f ")
        {
            sSpeakerName = AssociateSpeak(GetAssociateSpeaker(iPlayerType, "FAMILIAR"), GetStringRight(sSpoke, iLength - 3));
            bXP = TRUE;
        }
        else if (sLeft3 == "/c ")
        {
            sSpeakerName = AssociateSpeak(GetAssociateSpeaker(iPlayerType, "COMPANION"), GetStringRight(sSpoke, iLength - 3));
            bXP = TRUE;
        }
        else if (sLeft3 == "/h ")
        {
            sSpeakerName = AssociateSpeak(GetAssociateSpeaker(iPlayerType, "HENCHMAN"), GetStringRight(sSpoke, iLength - 3));
            bXP = TRUE;
        }

        else if (sSpoke == "/mount" || sSpoke == "/mount2" || sSpoke == "/dismount")
        {
            ExecuteScript("mys_mount_chat", oSpeaker);
        }

        else if (GetIsObjectValid(oTargetSpeak))
            oSpeaker = oTargetSpeak;

        else if (sLeft3 == "/oo")
        {
            ExecuteScript("mys_chat_debug", OBJECT_SELF);
            return;
        }
        else if (sSpoke == "/relevel")
        {
            if (iDM)
            {
                SendMessageToPC(oSpeaker,"Relevely:");
                object oPC = GetFirstPC();
                while (GetIsObjectValid(oPC))
                {
                    object oSoulStone = GetSoulStone(oPC);
                    int iRelevelCount = GetLocalInt(oSoulStone,"RELEVEL_COUNT");
                    SendMessageToPC(oSpeaker,GetName(oPC)+":"+IntToString(iRelevelCount));
                    oPC = GetNextPC();
                }
                return;
            }
            else
            {
                int iHasRelevel = GetLocalInt(oSpeaker,"HAS_RELEVEL");
                if (iHasRelevel==FALSE)
                {
                    int iXP = GetXP(oSpeaker);
                    SetLocalInt(oSpeaker,"HAS_RELEVEL",1);
                    object oSoulStone = GetSoulStone(oSpeaker);
                    int iRelevelCount = GetLocalInt(oSoulStone,"RELEVEL_COUNT");
                    SetLocalInt(oSoulStone,"RELEVEL_COUNT",iRelevelCount+1);
                    SetXP(oSpeaker,0);
                    DelayCommand(1.0,SetXP(oSpeaker,iXP));
                    ApplyClassConditions(oSpeaker);
                    return;
                }
            }
        }
        /*else if (sLeft3 == "/-xp")
        {
            if (GetTag(GetArea(oSpeaker))=="th_vitejte") return;
            string sXP = GetStringRight(sSpoke, iLength - 4);
            sXP = StrTrim(sXP," ");
            int iXPToRemove = StringToInt(sXP);
            if (iXPToRemove>0)
            {
                int iXP = GetXP(oSpeaker);
                int iNewXP = iXP-iXPToRemove;
                SetXP(oSpeaker,iNewXP);
            }
            return;
        }*/
        else
        {
            PCEmoteFunction();
            PCDiceFuntion();
            LanguageSet();
        }
        SetPCChatVolume(TALKVOLUME_TELL);
        SetPCChatMessage("");

        if (bXP)
             ChatXpSystem();

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
    // if speaker is associate, add its name to spoken message
    sSpeakerName = sSpeakerName == GetName(oSpeaker) ? "" : "(" + sSpeakerName + ") ";
    SendChatToListeners(oSpeaker, sSpeakerName + sSpoke, iGetVolume);
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

object GetAssociateSpeaker(int iPlayerType, string sVarName)
{
    if (iPlayerType == PLAYER_TYPE_PC_POSSESSED)
        return GetMaster(oSpeaker);
    else
        return GetLocalObject(oSpeaker, sVarName);
}

string AssociateSpeak(object oAssociate, string sRight)
{
    if (!GetIsObjectValid(oAssociate) || sRight == "")
        return "";

    float fDur = 9999.0f;

    if(sRight == "*sedni*") {
      AssignCommand(oAssociate, PlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur));
    } else if(sRight == "*lehni*") {
      AssignCommand(oAssociate, PlayAnimation( ANIMATION_LOOPING_DEAD_BACK, 1.0, fDur));
    } else if(sRight == "*uhni*") {
      AssignCommand(oAssociate, PlayAnimation( ANIMATION_FIREFORGET_DODGE_SIDE, 1.0));
    } else {
      AssignCommand(oAssociate, SpeakString(sRight));
      return GetName(oAssociate);
    }
    return GetName(oSpeaker);
}
