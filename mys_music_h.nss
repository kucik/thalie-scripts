/**
 * Notes:
 * - hour 06:     GetIsDay = 0, GetIsNight = 0, GetIsDawn = 1, GetIsDusk = 0, BackgroundDay music is playing;
 * - hour 07-21:  GetIsDay = 1, GetIsNight = 0, GetIsDawn = 0, GetIsDusk = 0, BackgroundDay music is playing;
 * - hour 22:     GetIsDay = 0, GetIsNight = 0, GetIsDawn = 0, GetIsDusk = 1, BackgroundNight music is playing;
 * - hour 23-05:  GetIsDay = 0, GetIsNight = 1, GetIsDawn = 0, GetIsDusk = 0, BackgroundNight music is playing;
 */

// Begins specified instrument conversation.
void MusicInstrumentChoice();

// Checks if musician object has required perform skill and bard level
// - oPC: Musician object.
// - iWeaponMiddleModel: Perform skill required.
// * Returns TRUE if conditions matched, FALSE otherwise. 
int MusicGetMusicianPerformRank(object oPC, int iValue);

// Checks if specified instrument item is equipped.
// - oPC: Musician object.
// - sTag: Tag of specified instrument item.
// - iWeaponMiddleModel: Item appearance type of weapon middle model.
// * Returns TRUE if instrument is in hands. Otherwise returns FALSE.
int MusicGetIsInstrumentEquipped(object oPC, string sTag, int iWeaponMiddleModel = 0);

// Checks if specified instrument placeable is nearby musician.
// - oPC: Musician object.
// - sTag: Tag of specified instrument placeable.
// - iModelX: (Optional alternatives) appearance model of instrument placeable.
// * Returns TRUE if instrument is in close radius. Otherwise returns FALSE.
int MusicGetIsInstrumentNearby(object oPC, string sTag, int iModel1 = 0, int iModel2 = 0, int iModel3 = 0, int iModel = 4);

// Not in use. Prepared for multiinstrumental system usage.
int MusicGetNearestInstrumentReady(object oPC, int iRequiedPerformSkillRank, string sInstrumentTag, float fSize = 6.0f);

int MusicGetTracksInQueue(object oArea);

// Returns unique timestamp of currently playing track.
int MusicGetTrackTimestamp(object oArea);

// Sets unique timestamp of currently playing track.
void MusicSetTrackTimestamp(object oArea, int iTimestamp);

// Adds music track to area queue.
// - oPC: Musician object.
// - iTrackId: Int value of ambientmusic.2da row.
// - iMinutes: Int value of track length in minutes.
// - iSeconds: Int value of estimated seconds of track length minus iMinutes (eg: iMinutes=12, iSeconds=20; //track length is 12min and 20s). 
void MusicQueueAddTrack(object oPC, int iTrackId, int iMinutes, int iSeconds);

// Removes music track from area queue.
// - oPC: Musician object.
// - oArea: Area object.
// - iTrackTimestamp: unique timestamp to identify track.
void MusicQueueRemoveLastTrack(object oPC, object oArea, int iTrackTimestamp);

// Calls function for playing next track in area queue or resets to original area music tracks.
// - oPC: Musician object.
// - oArea: Area object.
// - iTrackTimestamp: unique timestamp to identify track.
void MusicPlayTrack(object oPC, object oArea, int iTrackTimestamp);

void MusicBackgroundStoreOriginalTracks(object oArea);

void MusicChangeTracksToDefault(object oArea);

// Plays music track.
// - oArea: Area object.
// - iTrackId: Int value of ambientmusic.2da row. 
void MusicChangeTrack(object oArea, int iTrackId);

// Stop playing all tracks and resets to original area music. 
// - oPC: Object reset music.
void ActionMusicReset(object oPC);