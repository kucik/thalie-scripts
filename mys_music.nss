#include "mys_music_c"
#include "mys_music_h"

void MusicDebugOutput(string sMessage)
{
    object oPC = GetPCChatSpeaker();
    if (!GetIsObjectValid(oPC))
        oPC = GetItemActivator();
        
    SendMessageToPC(oPC, sMessage);
}

void MusicInstrumentChoice()
{
    object oPC = GetPCChatSpeaker();
    string sText = GetPCChatMessage();
    string sParam = GetSubString(sText, 4, GetStringLength(sText) - 4);
    
    //int iDebugChatCommandMatch = 0;
    string sDialogResRef = "";
    
    if (sParam == MUSIC_INSTRUMENT_PIANO_CHAT_COMMAND_1 || sParam == MUSIC_INSTRUMENT_PIANO_CHAT_COMMAND_2)
    {
        //iDebugChatCommandMatch = 1;
        if (MusicGetIsInstrumentNearby(oPC, MUSIC_INSTRUMENT_PIANO_TAG, MUSIC_APPEARANCE_TYPE_LIGHT_WOOD_PIANO, MUSIC_APPEARANCE_TYPE_DARK_WOOD_PIANO, MUSIC_APPEARANCE_TYPE_BLACK_GRAND_PIANO, MUSIC_APPEARANCE_TYPE_CEP24_PIANO))
            sDialogResRef = "myd_mus_piano";
    }
    else if (sParam == MUSIC_INSTRUMENT_GUITAR_CHAT_COMMAND_1 || sParam == MUSIC_INSTRUMENT_GUITAR_CHAT_COMMAND_2)
    {
        //iDebugChatCommandMatch = 1;
        if (MusicGetIsInstrumentEquipped(oPC, MUSIC_INSTRUMENT_GUITAR_TAG, MUSIC_APPEARANCE_ITEM_GUITAR))
            sDialogResRef = "myd_mus_guitar";
    }
    else if (sParam == MUSIC_INSTRUMENT_LUTE_CHAT_COMMAND_1 || sParam == MUSIC_INSTRUMENT_LUTE_CHAT_COMMAND_2)
    {
        //iDebugChatCommandMatch = 1;
        if (MusicGetIsInstrumentEquipped(oPC, MUSIC_INSTRUMENT_LUTE_TAG, MUSIC_APPEARANCE_ITEM_LUTE))
            sDialogResRef = "myd_mus_lute";
    }
    else if (sParam == MUSIC_INSTRUMENT_VIOLIN_CHAT_COMMAND_1 || sParam == MUSIC_INSTRUMENT_VIOLIN_CHAT_COMMAND_2)
    {
        //iDebugChatCommandMatch = 1;
        if (MusicGetIsInstrumentEquipped(oPC, MUSIC_INSTRUMENT_VIOLIN_TAG, MUSIC_APPEARANCE_ITEM_FIDDLESTICK))
            sDialogResRef = "myd_mus_violin";
    }
    else if (sParam == MUSIC_INSTRUMENT_PIPE_CHAT_COMMAND_1 || sParam == MUSIC_INSTRUMENT_PIPE_CHAT_COMMAND_2)
    {
        //iDebugChatCommandMatch = 1;
        if (MusicGetIsInstrumentEquipped(oPC, MUSIC_INSTRUMENT_PIPE_TAG, MUSIC_APPEARANCE_ITEM_PIPE))
            sDialogResRef = "myd_mus_pipe";
    }
    else if (sParam == MUSIC_INSTRUMENT_HARP_CHAT_COMMAND_1 || sParam == MUSIC_INSTRUMENT_HARP_CHAT_COMMAND_2)
    {
        //iDebugChatCommandMatch = 1;
        if (MusicGetIsInstrumentNearby(oPC, MUSIC_INSTRUMENT_HARP_TAG, MUSIC_APPEARANCE_TYPE_HARP, MUSIC_APPEARANCE_TYPE_STANDING_HARP) || MusicGetIsInstrumentEquipped(oPC, MUSIC_INSTRUMENT_HARP_TAG, MUSIC_APPEARANCE_ITEM_HARP))
            sDialogResRef = "myd_mus_harp";
    }
    else if (sParam == MUSIC_INSTRUMENT_DRUM_CHAT_COMMAND_1 || sParam == MUSIC_INSTRUMENT_DRUM_CHAT_COMMAND_2)
    {
        //iDebugChatCommandMatch = 1;
        if (MusicGetIsInstrumentNearby(oPC, MUSIC_INSTRUMENT_DRUM_TAG, MUSIC_APPEARANCE_TYPE_DRUM, MUSIC_APPEARANCE_TYPE_MEDIUM_TAIKO_DRUM) || MusicGetIsInstrumentEquipped(oPC, MUSIC_INSTRUMENT_DRUM_TAG, MUSIC_APPEARANCE_ITEM_DRUM))
            sDialogResRef = "myd_mus_drum";
    }
    else if (sParam == "music reset")
    {
        ActionMusicReset(oPC);
        return;
    }
    else return;
    
    //if (iDebugChatCommandMatch)
    //    MusicDebugOutput("Èisté G");
    //else
    //    MusicDebugOutput("Falešné Fis");
    
    if (sDialogResRef != "")
    {
        //MusicDebugOutput("Èisté H");
        AssignCommand(oPC, ActionStartConversation(oPC, sDialogResRef, TRUE, FALSE));
    }
    else
        SendMessageToPC(oPC, "Nástroj není k dispozici.");
        
    //MusicDebugOutput(sDialogResRef);
    //MusicDebugOutput("Èisté D");
}

int MusicGetMusicianPerformRank(object oPC, int iValue)
{
    //return GetSkillRank(SKILL_PERFORM, oPC) >= iValue && GetLevelByClass(CLASS_TYPE_BARD, oPC) > 0;
    return GetSkillRank(SKILL_PERFORM, oPC) >= iValue;
}

int MusicGetIsInstrumentEquipped(object oPC, string sTag, int iWeaponMiddleModel = 0)
{
    object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    
    if (sTag != "" && GetTag(oItem) == sTag)
        return TRUE;
    if (iWeaponMiddleModel && iWeaponMiddleModel == GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, ITEM_APPR_WEAPON_MODEL_MIDDLE)
        && GetBaseItemType(oItem) == 314)
        return TRUE;
    return FALSE;
}

int MusicGetIsInstrumentNearby(object oPC, string sTag, int iModel1 = 0, int iModel2 = 0, int iModel3 = 0, int iModel4 = 0)
{
    int i = 1;
    object oInstrument = OBJECT_INVALID;
    object oPlaceable = OBJECT_INVALID;

    while(!GetIsObjectValid(oInstrument))
    {
        oPlaceable = GetNearestObject(OBJECT_TYPE_PLACEABLE, oPC, i);

        if (!GetIsObjectValid(oPlaceable))
            return FALSE;

        if (GetDistanceBetweenLocations(GetLocation(oPC), GetLocation(oPlaceable)) > MUSIC_PLACEABLE_INSTRUMENT_MAX_DISTANCE)
            return FALSE;

        if (sTag != "" && GetTag(oPlaceable) == sTag)
            return TRUE;

        if (iModel1 && GetAppearanceType(oPlaceable) == iModel1)
            return TRUE;

        if (iModel2 && GetAppearanceType(oPlaceable) == iModel2)
            return TRUE;

        if (iModel3 && GetAppearanceType(oPlaceable) == iModel3)
            return TRUE;
            
        if (iModel4 && GetAppearanceType(oPlaceable) == iModel4)
            return TRUE;

        i++;
    }
    return FALSE;
}

int MusicGetNearestInstrumentReady(object oPC, int iRequiedPerformSkillRank, string sInstrumentTag, float fSize = 6.0f)
{
    location lCenter = GetLocation(oPC);
    object oObject = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lCenter, FALSE, OBJECT_TYPE_CREATURE);
    
    while (GetIsObjectValid(oObject))
    {
        // skip oPC which triggered instrument dialog
        if (oObject == oPC)
        {
            continue;
        }
        
        // has oObject instrument with specified tag ready in hands?
        if (GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oObject)) == sInstrumentTag
         || GetTag(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oObject)) == sInstrumentTag)
        {
            // check if perform skill is high enough
            if (GetSkillRank(SKILL_PERFORM, oObject) >= iRequiedPerformSkillRank
             && GetLevelByClass(CLASS_TYPE_BARD, oObject) > 0)
            {
                return TRUE;
            }
        }
        
        oObject = GetNextObjectInShape(SHAPE_SPHERE, fSize, lCenter, FALSE, OBJECT_TYPE_CREATURE);
    }
    return FALSE;
}

int MusicGetTracksInQueue(object oArea)
{
    //MusicDebugOutput("MusicGetTracksInQueue");
    
    int i = 0;
    
    for (i = 0; i < MUSIC_AREA_QUEUE_MAX_ALLOWED_TRACKS; i++)
    {
        if (!GetLocalInt(oArea, "MUSIC_QUEUE_TRACK_ID_" + IntToString(i)))
            return i;
    }
    return i;
}

void MusicQueueAddTrack(object oPC, int iTrackId, int iMinutes, int iSeconds)
{
    //MusicDebugOutput("MusicQueueAddTrack");
    
    object oArea = GetArea(oPC);
  
    // Check how many tracks are in area's queue.
    int iTracksInQueue = MusicGetTracksInQueue(oArea);
 
    // bard music tracks starts at row 301 (ambientmusic.2da)
    iTrackId += 300;
    float fDelay = IntToFloat(60 * iMinutes + iSeconds);
    
    SetLocalInt(oArea, "MUSIC_QUEUE_TRACK_ID_" + IntToString(iTracksInQueue), iTrackId);
    SetLocalFloat(oArea, "MUSIC_QUEUE_DELAY_" + IntToString(iTracksInQueue), fDelay);
    
    //MusicDebugOutput("iTracksInQueue = " + IntToString(iTracksInQueue));
    //MusicDebugOutput("iTrackId = " + IntToString(iTrackId));
    //MusicDebugOutput("fDelay = " + FloatToString(fDelay));
    
    if (!iTracksInQueue)
    {
        MusicBackgroundStoreOriginalTracks(oArea);
        MusicPlayTrack(oPC, oArea);        
    }
    else
        SendMessageToPC(oPC, "Poøadí ve frontì: " + IntToString(iTracksInQueue + 1));
}

void MusicQueueRemoveLastTrack(object oPC, object oArea)
{
    //MusicDebugOutput("MusicQueueRemoveLastTrack");
    SendMessageToPC(oPC, "Skladba dohrála.");
    
    // Check how many tracks are in area's queue.
    int iTracksInQueue = MusicGetTracksInQueue(oArea);
    int i;
    
    //MusicDebugOutput("iTracksInQueue = " + IntToString(iTracksInQueue));
    
    if (iTracksInQueue > 1)
    {
        for (i = 0; i < iTracksInQueue; i++)
        {
            SetLocalInt(oArea, "MUSIC_QUEUE_TRACK_ID_" + IntToString(i), GetLocalInt(oArea, "MUSIC_QUEUE_TRACK_ID_" + IntToString(i + 1)));
            SetLocalFloat(oArea, "MUSIC_QUEUE_DELAY_" + IntToString(i), GetLocalFloat(oArea, "MUSIC_QUEUE_DELAY_" + IntToString(i + 1)));
        }
    }
    DeleteLocalInt(oArea, "MUSIC_QUEUE_TRACK_ID_" + IntToString(iTracksInQueue - 1));
    DeleteLocalFloat(oArea, "MUSIC_QUEUE_DELAY_" + IntToString(iTracksInQueue - 1));
}

void MusicPlayTrack(object oPC, object oArea)
{
    //MusicDebugOutput("MusicPlayTrack");
    
    // Check how many tracks are in area's queue.
    int iTracksInQueue = MusicGetTracksInQueue(oArea);
    
    // Get queue-last-track info
    int iTrackId = GetLocalInt(oArea, "MUSIC_QUEUE_TRACK_ID_0");
    float fDelay = GetLocalFloat(oArea, "MUSIC_QUEUE_DELAY_0");
    
    //MusicDebugOutput("iTracksInQueue = " + IntToString(iTracksInQueue));
    //MusicDebugOutput("iTrackId = " + IntToString(iTrackId));
    //MusicDebugOutput("fDelay = " + FloatToString(fDelay));
    
    if (iTracksInQueue > 0)
    {
        SendMessageToPC(oPC, "Pøehrávám skladbu id: " + IntToString(iTrackId));
        MusicChangeTrack(oArea, iTrackId);
        AssignCommand(GetModule(), DelayCommand(fDelay, MusicQueueRemoveLastTrack(oPC, oArea)));
        AssignCommand(GetModule(), DelayCommand(fDelay + 0.2f, MusicPlayTrack(oPC, oArea)));
    }
    else
    {
        SendMessageToPC(oPC, "Všechny skladby z fronty dohrály.");
        MusicChangeTracksToDefault(oArea);
    }
}

void MusicBackgroundStoreOriginalTracks(object oArea)
{
    //MusicDebugOutput("MusicBackgroundStoreOriginalTracks");
    
    SetLocalInt(oArea, MUSIC_ORIGINAL_AREA_MUSIC_DAY, MusicBackgroundGetDayTrack(oArea));
    SetLocalInt(oArea, MUSIC_ORIGINAL_AREA_MUSIC_NIGHT, MusicBackgroundGetNightTrack(oArea));
}

void MusicChangeTracksToDefault(object oArea)
{
    //MusicDebugOutput("MusicChangeTracksToDefault");
    
    MusicBackgroundChangeDay(oArea, GetLocalInt(oArea, MUSIC_ORIGINAL_AREA_MUSIC_DAY));
    MusicBackgroundChangeNight(oArea, GetLocalInt(oArea, MUSIC_ORIGINAL_AREA_MUSIC_NIGHT));
    MusicBackgroundPlay(oArea);
}

void MusicChangeTrack(object oArea, int iTrackId)
{
    //MusicDebugOutput("MusicChangeTrack");
    
    if (GetIsDay() || GetIsDawn())
    {
        MusicBackgroundChangeDay(oArea, iTrackId);
        MusicBackgroundPlay(oArea);
        //MusicDebugOutput("Playing track id = " + IntToString(iTrackId));
    }
    else
    {
        MusicBackgroundChangeNight(oArea, iTrackId);
        MusicBackgroundPlay(oArea);
        //MusicDebugOutput("Playing track id = " + IntToString(iTrackId));
    }
}

void ActionMusicReset(object oPC)
{
    //MusicDebugOutput("ActionMusicReset");
    
    string sName = GetName(oPC);
    object oArea = GetArea(oPC);
    object oPCinArea = GetFirstPC();    
    
    // Send info msg to all PCs in area (let everybody knows who screw the performance).
    while(GetIsObjectValid(oPCinArea))
    {
        if (GetArea(oPCinArea) == oArea)
        {
            SendMessageToPC(oPCinArea, sName + " resetoval hudbu v lokaci.");
        }
        oPCinArea = GetNextPC();        
    }
    
    // Check how many tracks are in area's queue.
    int iTracksInQueue = MusicGetTracksInQueue(oArea);
    int i = 0;
    
    if (!iTracksInQueue)
        MusicBackgroundStoreOriginalTracks(oArea);
    
    for (i = 0; i < iTracksInQueue; i++)
    {
        DeleteLocalInt(oArea, "MUSIC_QUEUE_TRACK_ID_" + IntToString(i));
        DeleteLocalFloat(oArea, "MUSIC_QUEUE_DELAY_" + IntToString(i));
    }
    
    // Reset area music to defaults.
    MusicChangeTracksToDefault(oArea);
}