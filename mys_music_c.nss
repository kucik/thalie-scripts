// Maximal allowed distance between musician and placeable instrument
const float MUSIC_PLACEABLE_INSTRUMENT_MAX_DISTANCE = 4.0f;

// Maximal allowed number of tracks in area queue
const int MUSIC_AREA_QUEUE_MAX_ALLOWED_TRACKS = 99;

// Item instruments
// Item GetItemAppearance(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, ITEM_APPR_WEAPON_MODEL_MIDDLE) return values.
const int MUSIC_APPEARANCE_ITEM_DRUM = 11;
const int MUSIC_APPEARANCE_ITEM_HARP = 12;
const int MUSIC_APPEARANCE_ITEM_LUTE = 13;
const int MUSIC_APPEARANCE_ITEM_PIPE = 14;
const int MUSIC_APPEARANCE_ITEM_GUITAR = 15;
const int MUSIC_APPEARANCE_ITEM_FIDDLESTICK = 16;

// Placeable instruments
// Placeable GetAppearanceType() return values.
// Pianos
const int MUSIC_APPEARANCE_TYPE_LIGHT_WOOD_PIANO = 2637;
const int MUSIC_APPEARANCE_TYPE_DARK_WOOD_PIANO = 2636;
const int MUSIC_APPEARANCE_TYPE_BLACK_GRAND_PIANO = 2638;
const int MUSIC_APPEARANCE_TYPE_CEP24_PIANO = 10773;

// Drums
const int MUSIC_APPEARANCE_TYPE_DRUM = 2320;
const int MUSIC_APPEARANCE_TYPE_MEDIUM_TAIKO_DRUM = 2667;

// Harps
const int MUSIC_APPEARANCE_TYPE_HARP = 2640;
const int MUSIC_APPEARANCE_TYPE_STANDING_HARP = 2316;

// Placeable instruments
// Tag values od musical placeables.
const string MUSIC_INSTRUMENT_GUITAR_TAG = "kytara";
const string MUSIC_INSTRUMENT_HARP_TAG = "harfa";
const string MUSIC_INSTRUMENT_LUTE_TAG = "loutna";
const string MUSIC_INSTRUMENT_PIANO_TAG = "klavir";
const string MUSIC_INSTRUMENT_PIPE_TAG = "pistala";
const string MUSIC_INSTRUMENT_VIOLIN_TAG = "housle";
const string MUSIC_INSTRUMENT_DRUM_TAG = "buben";

// Chat commands
const string MUSIC_INSTRUMENT_GUITAR_CHAT_COMMAND_1 = "kytara";
const string MUSIC_INSTRUMENT_HARP_CHAT_COMMAND_1 = "harfa";
const string MUSIC_INSTRUMENT_LUTE_CHAT_COMMAND_1 = "loutna";
const string MUSIC_INSTRUMENT_PIANO_CHAT_COMMAND_1 = "klavir";
const string MUSIC_INSTRUMENT_PIPE_CHAT_COMMAND_1 = "pistala";
const string MUSIC_INSTRUMENT_VIOLIN_CHAT_COMMAND_1 = "housle";
const string MUSIC_INSTRUMENT_DRUM_CHAT_COMMAND_1 = "buben";

const string MUSIC_INSTRUMENT_GUITAR_CHAT_COMMAND_2 = "ky";
const string MUSIC_INSTRUMENT_HARP_CHAT_COMMAND_2 = "ha";
const string MUSIC_INSTRUMENT_LUTE_CHAT_COMMAND_2 = "lo";
const string MUSIC_INSTRUMENT_PIANO_CHAT_COMMAND_2 = "kl";
const string MUSIC_INSTRUMENT_PIPE_CHAT_COMMAND_2 = "pi";
const string MUSIC_INSTRUMENT_VIOLIN_CHAT_COMMAND_2 = "ho";
const string MUSIC_INSTRUMENT_DRUM_CHAT_COMMAND_2 = "bu";

// Local variables' names
// Indexes of original area music track (day & night).
const string MUSIC_ORIGINAL_AREA_MUSIC_DAY = "iOriginalAreaMusicDay";
const string MUSIC_ORIGINAL_AREA_MUSIC_NIGHT = "iOriginalAreaMusicNight";