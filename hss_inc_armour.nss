//::///////////////////////////////////////////////
//:: Name: Armour designer include
//:: FileName: hss_inc_armour
//:: Copyright Heed.
//:://////////////////////////////////////////////
/*

-Main include file holding functions and constants for armour designer system.-

-----------------Data Held on the NPC set/cleared by script.--------------------

HSS_ARMOUR_CUSTOMER = local object of customer
HSS_ARMOUR_CUSTOMER_ID = string, player name + _ + PC name
HSS_CUSTOMER_GENDER = int, 1 male, 2 female
HSS_ARMOUR_VALUE = int, value of current item we are working on.
HSS_ARMOUR_ITEM_TYPE = int, 1 armour, 2 helm, 3 weapon, 4 shield (see constants)
HSS_ARMOUR_PLOT_FLAG = int, 1 it is a plot item
HSS_ARMOUR_TALLY = int, running total of the number of part modifications.
HSS_ARMOUR_COST = int, running total of the cost of all modifications.
HSS_ARMOUR_IS_ROBED = int, 1 denotes an armour that originally had a robe
HSS_ARMOUR_ORIGINALS = string, single string holding all item original states.
HSS_ARMOUR_ITEM_IS_EXCLUDED = int, 1 item cannot be modified
HSS_ARMOUR_COLOUR_TYPE = int, type of colour modification:

metal 1 = 1
metal 2 = 2
cloth 1 = 3
cloth 2 = 4
leather 1 = 5
leather 2 = 6

HSS_ARMOUR_PART_TYPE = int, the armour part we work on:

right foot = 1
left foot = 2
right shin = 3
left shin = 4
left thigh = 5
right thigh = 6
pelvis = 7
torso = 8
belt = 9
neck = 10
right forearm = 11
left forearm = 12
right bicep = 13
left bicep = 14
right shoulder = 15
left shoulder = 16
right hand = 17
left hand  = 18
robe  = 19
helm = 99


--------------------Data Held on the NPC set in the toolset.--------------------
        (Local variables that can be customized on a per npc basis.)

                                IMPORTANT!
        If you change the value of the const string HSS_PREFX below,
        then you MUST update the variable names in the npc armourer's
        variable panel to match with the newly chosen prefix.

HSS_ARMOUR_WRONG_TYPE -- String spoken when given wrong item type.
Default: "Sorry, I don't work with this kind of item. Here, have it back."

HSS_ARMOUR_UNIDENTIFIED -- String spoken when given unidentified item.
Default: "I can do nothing with this item until you have it identified. Here, have it back."

HSS_ARMOUR_CONFIRM -- String spoken when given a valid colour choice.
Default: "Right, let me make the change for you."

HSS_ARMOUR_INVALID_COLOUR -- String spoken when given a invalid colour choice.
Default: "Sorry, that is not a valid colour choice."

HSS_ARMOUR_CONFIRM_PART_CHOICE -- String spoken upon hearing a valid part type
choice. The part choice name is added to the end of this string.
Default: "Right, I've got the alternate styles ready for the "

HSS_ARMOUR_PART_COST_X -- float, cost multiplier for the individual armour designer.
Default: 0.05  That is 5% of item cost PER modification.

HSS_ARMOUR_COLOUR_COST_X -- float, cost multiplier for the individual armour designer.
Default: 0.10  That is 10% of item cost PER modification.

HSS_ARMOUR_INSCRIBE_COST_X -- float, cost multiplier for the individual armour designer.
Default: 0.20  That is 20% of item cost PER modification.

HSS_ARMOUR_GO_CONVO = string, the name of the conversation file the npc
initiates when a valid item is put in his work container.
Default: hss_armourer_go

HSS_ARMOUR_IS_ROBED = string, spoken by armourer when given armour with robes
default: "Sorry, I cannot change the robe style. I can colour it, though."

HSS_ARMOUR_COLOUR_EXCLUDED = string, spoken by armourer when given an excluded
colour choice.
default: "Sorry, that colour is not available."

HSS_ARMOUR_PART_ORIGINAL = string, spoken by armourer when part is set to
its original value.
default: " This is the original style you had."

HSS_ARMOUR_PROV_YES = string, spoken by armourer when item has a provenance.
default: "This item does have a discernable provenance. Ownership from oldest
to most recent is as follows: "

HSS_ARMOUR_PROV_NO = string, spoken by armourer when item has no provenance.
default: "This item shows no sign of any inscriptions. Provenance unknown."

--------------------------Data held on the item.--------------------------------

HSS_ARMOUR_PROV -- string, single string holding previous owner's names. Only
if the provenance option is on.

-------------------------Data held on the module.-------------------------------

HSS_ARMOUR_PART_COUNT_CACHE = string, single string that holds the
total part count for each part type.

HSS_ARMOUR_AC_CHEST_CACHE = string, single string that holds the
available chest piece part numbers for each ac value.

---------------------Tag values for creatures/objects.--------------------------

                                IMPORTANT!
        If you change the value of the const string HSS_PREFX below,
        then you MUST update all npc's/object's tags to match the
        newly chosen prefix.

HSS_ARMOUR_DESIGNER -- the tag of the armour designer -- ALL armour designers
in a single module need to have this same tag.

HSS_ARMOUR_CONTAINER -- the tag of the armourer's work space (a placeable with inventory).

HSS_ARMOUR_DUMMY_F -- the tag of the female armour dummy.

HSS_ARMOUR_DUMMY_M -- the tag of the male armour dummy.

*/
//:://////////////////////////////////////////////
//:: Created By:  Heed
//:: Created On:  March 16, 2006.
//:://////////////////////////////////////////////
//:: Last Update By: Heed
//:: Last Update On: April 14, 2006.

#include "x2_inc_itemprop"

//void main () {}

             /*>>>>>>>>>>>>>>>>>>__CONSTANTS__<<<<<<<<<<<<<<<<<<*/
                   /*---Configure system behaviour here.---*/

                    /*        Pricing and Costs        */

//minimum cost for an armour alteration.
const int HSS_ARMOUR_MIN_COST = 5;

//multiply the part cost by this amount to get the cost to change the robe part
//it's a pretty major change, so allow for pricing it higher than other parts.
//a value of 1 here prices the same as any other part modification.
const int HSS_ROBE_X = 5;

                     /*          Policies          */

//true here will have the armourer speak the part numbers.  Enable to help
//configure exclusions or if you want the PC's to know the numbers.
const int HSS_VERBOSE = FALSE;

//the string that is prefixed to all varibale names used in the system.
//alter this value if you need to change variable naming convention for
//whatever reason (i.e. a conflict). Also realize that if you alter this
//value you will need to update in-game object's tags as well as the variable
//names in the npc armourer's variable panel to reflect your new prefix.
//unlikely anyone will need to alter this, but just in case it makes
//life easier.
const string HSS_PREFX = "HSS_";

//switch the provenance option on/off here.  TRUE = on, FALSE = off.
//If HSS_PROVENANCE is true, a local will be set on the item tracking the
//changes made to the item name over time.  This is a single string that
//gets the PC name added to it seperated by an underscore.
//(i.e a provenance tracked over 4 users might look like this:
//"Bob_J.R._Sammy Sunder_McWilliams") Left to right: oldest to newest.
const int HSS_PROVENANCE = TRUE;

//true to store abandoned items to the DB.  False to not store abandoned
//items but destroy them instead.
const int HSS_LOST_FOUND = TRUE;

//set this to 1 to allow PC's to change the robe style. Set it to 0 to
//disallow robe style changes. Colour changes are always enabled but actual
//model changes can be toggled off/on here.
const int HSS_ROBE_ENABLED = 1;

//set to 1 to only allow robe modifications for items that already have
//a robe part. i.e. attempting to add a robe to chainmail will be rejected.
//set to 0 for a robe free for all -- robes added or removed to any piece.
//ultimately, allowing robe modification depends on the maturity of your players
//in terms of coherent choices given the piece they want to alter, but this
//adds a little bit of a check in the system.
//requires HSS_ROBE_ENABLED to be = 1.
const int HSS_ROBE_POLICY = 0;

                 /*      Part/Colour/Item Exclusions      */

//add in colour codes in the letter/number format in order to EXCLUDE
//them from the choices a PC can make. Make sure the format is such that
//EACH excluded value has an underscore ("_") on EACH side of it.
//i.e. _A1_B5_  is correct A1_B5_ is NOT. Case doesn't matter.
//default is to exclude the previously "hidden colours" that give
//the "terminator appearance" (all reflective, no texture). Solid white,
//solid black and a greyish still remain available from the "hidden colours".
const string HSS_ARMOUR_COLOUR_EXCLUSION = "_D9_D10_D11_D12_D14_";

//add in chest piece numbers seperated by an underscore that you want to be
//EXCLUDED from the choices the PC can make while altering armour.  Make sure
//the format is such that EACH excluded value has an underscore ("_") on
//EACH side of it.  i.e. _1_2_ is correct, but 1_2_ is NOT.
//default is _1_ (i.e. not able to choose bare chested on AC0 pieces).
const string HSS_ARMOUR_CHEST_EXCLUSION = "_1_";

//add part numbers following the part number type that you want EXCLUDED from
//choices that the PC can make while altering armour.
//To exclude a torso piece use HSS_ARMOUR_CHEST_EXCLUSION, torso is included
//here simply for the sake of completeness. See above for format.
//Ranges are specified thusly: _|9-48|_ and must follow the above format
//with regard to seperators, etc. Ranges are very handy in allow for skipping
//a lot of code iterations and really quite necessary far large padded 2da
//files with lots of empty lines that need to be skipped over (i.e. CEP).
//Just for clarity, the 2da comment is not about READING the 2da, but about
//skipping those lines IN CODE.  Only two 2da reads are EVER done and both
//at the first customer encounter.  After that, everything is done by local
//or from defined strings.
//NOTE!: Armour part pieces start from 0, but helm pieces start from 1.
//
//
//exclude your pieces and ranges of pieces here:

//right foot
const string HSS_EX_P0 =  "Part0*_0_2_|13-79|_|84-149|_|159-199|_";
//left foot
const string HSS_EX_P1 =  "Part1*_0_2_|13-79|_|84-149|_|159-199|_";
//right shin
const string HSS_EX_P2 =  "Part2*_0_2_|18-79|_|94-149|_|163-199|_";
//left shin
const string HSS_EX_P3 =  "Part3*_0_2_|18-79|_|94-149|_|163-199|_";
//left thigh
const string HSS_EX_P4 =  "Part4*_0_2_|17-79|_|95-111|_|116-119|_|123-149|_|161-199|_";
//right thigh
const string HSS_EX_P5 =  "Part5*_0_2_|17-79|_|95-111|_|116-119|_|123-149|_|161-199|_";
//pelvis
const string HSS_EX_P6 =  "Part6*_|0-2|_|38-111|_119_|123-150|_152_157_|160-199|_";
//torso  -- LEAVE THIS UNTOUCHED!
//Torso exclusions go in HSS_ARMOUR_CHEST_EXCLUSION above.
const string HSS_EX_P7 =  "Part7*_";
//belt
const string HSS_EX_P8 =  "Part8*_1_2_|17-109|_|116-149|_|156-199|_";
//neck
const string HSS_EX_P9 =  "Part9*_0_2_|7-111|_|114-119|_|123-149|_|160-199|_";
//right forearm
const string HSS_EX_P10 = "Part10*_0_2_|24-109|_|113-119|_|123-149|_|166-199|_";
//left forearm
const string HSS_EX_P11 = "Part11*_0_2_|24-109|_|113-119|_|123-149|_|166-199|_";
//right bicep
const string HSS_EX_P12 = "Part12*_0_2_|16-109|_|113-119|_|125-149|_|162-199|_";
//left bicep
const string HSS_EX_P13 = "Part13*_0_2_|16-109|_|113-119|_|125-149|_|162-199|_";
//right shoulder
const string HSS_EX_P14 = "Part14*_1_2_|26-119|_|123-199|_";
//left shoulder
const string HSS_EX_P15 = "Part15*_1_2_|26-119|_|123-199|_";
//right hand
const string HSS_EX_P16 = "Part16*_0_2_|9-111|_|114-120|_|123-149|_|155-199|_";
//left hand
const string HSS_EX_P17 = "Part17*_0_2_|9-111|_|114-120|_|123-149|_|155-199|_";
//robe
//by default, no null robe values can be chosen -- that means robes can be
//changed, but never removed. UNLESS, there is no model existing for that model type.
//i.e. a model exists for females but not males -- for a male, in this case,
//choosing that model will visually be the same as removing the robe completely.
//Change _|0-2|_ to _1_2_ to enable robe removal.
const string HSS_EX_P18 = "Part18*_|0-2|_|7-109|_|117-120|_|122-149|_|172-199|_";
//helm
const string HSS_EX_P99 = "Part99*_|39-46|_|50-100|_";

//add in the item tags here, seperated by an underscore ("_"), that you DO NOT
//want the PC to be able to colour or change appearance.
const string HSS_ITEM_EXCLUDED = "";

                     /*      Miscellaneous Options      */

//number of available helm models.  There is no way to get this
//number dynamically (i.e. reading a 2da), so the builder must specify
//this number by checking the appearances available in the toolset.
//defaulted to the standard bioware or CEP resource count -- if custom content
//helms are present the builder needs to change this value accordingly.
//input the highest helm number you see in the toolset for helm appearances.
//you don't need to actually count them.
const int HSS_ARMOUR_HELM_COUNT = 104;

//string value used for the database name that we store unclaimed items
//in.  Customize here to change the database name.
const string HSS_ARMOUR_DB = "HSS_ARMOUR_DB";

//colour constant white
const string HSS_COLOUR_WHITE = "<cþþþ>";           // RGB 254, 254, 254

//colour constant light grey
const string HSS_COLOUR_LIGHT_GREY = "<cÀÀÀ>";      // RGB 192, 192, 192

//colour constant grey
const string HSS_COLOUR_GREY = "<c€€€>";            // RGB 128, 128, 128

//colour constant light yellow
const string HSS_COLOUR_LIGHT_YELLOW = "<cþþ€>";    // RGB 254, 254, 128

//colour constant yellow
const string HSS_COLOUR_YELLOW = "<cþþ >";          // RGB 254, 254, 0

//colour constant beige
const string HSS_COLOUR_BEIGE = "<cÆ¡m>";           // RGB 198, 161, 109

//colour used for debug messages
const string HSS_COLOUR_AQUA = "<c!»´>";            // RGB 33, 187, 180

//colour constant used for the inscription function. To change behaviour,
//set the value of this constant to one of the above colour constants.
//i.e. replace HSS_COLOUR_LIGHT_GREY with one of the other colour constants.
//you can change the colour code values above or add more.
const string HSS_INSCRIPTION_COLOUR = HSS_COLOUR_LIGHT_GREY;


              /* Non-Configurable constants -- do not alter */

//modification is for a suit of armour
const int HSS_TYPE_ARMOUR = 1;

//modification is for a helm
const int HSS_TYPE_HELM = 2;

//modification is for a weapon
const int HSS_TYPE_WEAPON = 3;

//modification is for a shield
const int HSS_TYPE_SHIELD = 4;

//constant used in various functions
const int HSS_NEXT = 1;

//constant used in various functions
const int HSS_PREV = 2;

//can't be a constant
string HSS_ARMOUR_PART_EXCLUSION =
HSS_EX_P0 + HSS_EX_P1 + HSS_EX_P2 + HSS_EX_P3 + HSS_EX_P4 + HSS_EX_P5 +
HSS_EX_P6 + HSS_EX_P7 + HSS_EX_P8 + HSS_EX_P9 + HSS_EX_P10 + HSS_EX_P11 +
HSS_EX_P12 + HSS_EX_P13 + HSS_EX_P14 + HSS_EX_P15 + HSS_EX_P16 + HSS_EX_P17 +
HSS_EX_P18 + HSS_EX_P99;

       /*>>>>>>>>>>>>>>>>>>__FUNCTION PROTOTYPES__<<<<<<<<<<<<<<<<<<*/

//converts the colour chart layout of lettered rows and numbered
//columns to a straight int to match the itemproperty values.
//valid values are in the form of "A1", "G14", etc.  Case does not
//matter.  A to K and 1 to 16 are the valid ranges.  All invalid
//inputs will result in a return value of -1 and excluded colours
//will return -2.
int HSS_ArmourColourChartToInt(string sString);

//converts a colour number (0-175) to the chart layout of numbered
//columns and lettered rows.
string HSS_ArmourColourIntToChart(int nColour);

//modify the item colour to the desired choice specified by nColour
//return a 1 if the change is back to the original value and 0 if not
int HSS_ArmourDoColourModification(int nColour, object oArmourer = OBJECT_SELF);

//get the type of colour modification (primary metal, secondary cloth, etc)
int HSS_ArmourGetColourType(object oArmourer = OBJECT_SELF);

//the armourer will tell the PC the colour values of each colour type
void HSS_ArmourReportColours(object oDummy, int nType = HSS_TYPE_ARMOUR);

//complete the routine by removing temp items, take the gold if a sale is made,
//clear locals set...basically, get ready for next customer.
//nSale would normally be TRUE or FALSE, but it will take another
//integer -- in which case all items are simply destroyed (still clears all
//locals etc, just doesn't hand back items).
void HSS_ArmourFinishRoutine(object oPC, int nSale);

//get 2da values and cache as locals -- used to build the two local strings
//that hold the part information in HSS_ArmourBuild2DAPartIndex(object oModule).
string HSS_ArmourGetAndCache2DAString(string s2DA, string sColumn, int nRow, object oModule);

//build the part indexes (stored as 2 local strings on the module)
//only runs once for the first customer, then we have the locals available
//for subsequent interactions.
void HSS_ArmourBuild2DAPartIndex(object oModule);

//modify nPartType to nPart number
//return a 1 if the change is back to the original value and 0 if not
int HSS_ArmourDoPartModification(int nPartType, int nPart, object oArmourer = OBJECT_SELF);

//armourers on conversation function to respond to the listen patterns for
//colour choices, part choices, etc.  nMatch is the listen pattern #
void HSS_ArmourOnConversationRoutine(int nMatch);

//finds the next (or previous) appearance for nPart number of npartType
//nNext can be HSS_NEXT or HSS_PREV
int HSS_ArmourFindNextAppearance(int nPart, int nPartType, int nNext);

//Finds the string following or preceding the seperator (default = "_") in sTarget
//depending on the value of nMode.  Returns the string that is bordered by
//the seperator on each side ("_5_" would return "5").  If no second bordering
//seperator is found, then the entire string from the seperator to either the
//beginning or end of sTarget will be returned ("ABC_DEF" would return "ABC"
//for nMode HSS_PREV and "DEF" for nMode HSS_NEXT). If sStart is an empty
//string, then the function will start its search at the beginning of sTarget.
//If sStart is specified, then the functions begins its search at sStart.
//Returns empty string if sStart is specified and not found or if the
//seperator can not be found.
string HSS_ArmourFindSeperatedString(string sStart, string sTarget, int nMode = HSS_NEXT, string sSeperator = "_");

//called from within HSS_ArmourFindNextAppearance() and finds the next or
//previous chest part for the AC value range of nCurrent.  starget is the
//chest part cache string local stored on the module.  HSS_NEXT or HSS_PREV for nNext.
int HSS_ArmourFindNextChestPiece(int nCurrent, string sTarget, int nNext);

//called from within HSS_ArmourFindNextAppearance() and finds the next or
//previous part piece for nPartType from nCurrent that is not excluded.
//nPartCount is the total available parts for nPartType. HSS_NEXT or HSS_PREV for nNext.
int HSS_FindNextPartPiece(int nCurrent, int nPartType, int nPartCount, int nNext);

//find the AC value of nPart from the string cache local on the module (sCache)
//we need this value to determine the range of chest piece choices that are
//appropriate for nPart.
int HSS_ArmourGetChestACFromCache(int nPart, string sCache);

//count and return the number of seperated string values in sString.
//sSeperator can be any string value.
int HSS_ArmourGetSeperatedStringsCount(string sString, string sSeperator = "_");

//Inscribes oPC's name on an item (adds the name to the item name
//using SetName()),  nNametype can be 1, 2, 3, or 4.  1 uses the full
//name of oPC, 2 the first, 3 the last and 4 the initials.  If nProveance
//is true, a local will be set on the item tracking the changes made to
//the item name over time.  This a single string that gets the PC name
//added to it seperated by an underscore. (i.e a provenance tracked over
//4 users might look like this: Bob_J.R._Sammy Sunder_McWilliams)
//Left to right: oldest to newest.
void HSS_ArmourDoInscription(int nNameType, object oPC, int nProvenance = HSS_PROVENANCE, string sColour = HSS_INSCRIPTION_COLOUR, object oArmourer = OBJECT_SELF);

//Either stores an abandoned item in the DB or retrieves an abandoned
//item for oPC.  If oPC is OBJECT_INVALID, then the function stores
//the item.  If oPC is valid, then it looks for an item in the DB
//that belongs to oPC and creates it on oPC.  Returns a 1 on success
//and a 0 on failure.
int HSS_ArmourLostAndFound(object oPC = OBJECT_INVALID);

//returns true if nPart of nPartType is specified as an excluded part in the
//specified constant string HSS_ARMOUR_CHEST_EXCLUSION or HSS_ARMOUR_PART_EXCLUSION
int HSS_ArmourIsExcludedPiece(int nPart, int nPartType, string sExclusion);

//returns true if nBase (base item type) is a weapon
int HSS_ArmourIsWeapon(int nBase);

//returns true if nBase (base item type) is a shield
int HSS_ArmourIsShield(int nBase);

//returns the max or min of a range value depending upon nNext being next (max)
//or prev (min) and if nPart actually falls within the range.  i.e |17-28|
//would return either 17 or 28 if nPart was within that range.  If not,
//then -1 is returned.
int HSS_ArmourGetRangeMinOrMax (int nPart, int nPartType, string sExclusion, int nNext);

//wrapper for actionequip which deals with equipping the item to be modified
//if it's a robe it runs a copy object on the entire dummy
void HSS_ArmourDummyEquipItem(object oDummy, object oItem, int nSlot, object oArmourer = OBJECT_SELF, float fDelay = 0.0);

//reads any provenance information on the item the armourer is working on
//and get him to speak the information. (used in the conversation action)
void HSS_ArmourReportItemProvenance(object oArmourer = OBJECT_SELF);

//sets appropriate locals on the armourer to disallow individual pieces
//specified in the constant string exclusions below.
void HSS_ArmourItemExclusionCheck(object oItem, object oArmourer);

     /*>>>>>>>>>>>>>>>>>>__FUNCTION IMPLEMENTATION__<<<<<<<<<<<<<<<<<<*/


int HSS_ArmourColourChartToInt(string sString)
{
   int nReturn = -1;
   int nLength = GetStringLength(sString);
   sString = GetStringLowerCase(sString);

   //excluded colour, exit and return -2
   if (TestStringAgainstPattern("**" + "_" + sString + "_" + "**",
      GetStringLowerCase(HSS_ARMOUR_COLOUR_EXCLUSION)))
      {
      nReturn = -2;
      return nReturn;
      }

   //exit right here as this can not be a valid value.
   if (nLength > 3)
      {
      return nReturn;
      }

   string sLetter = GetStringLeft(sString, 1);
   int nNumber = StringToInt(GetStringRight(sString, nLength - 1));
   int nAdd;

   //exit right here as this can not be a valid value.
   if (nNumber < 1 || nNumber > 16)
      {
      return nReturn;
      }

   //convert row letters to a numeric starting point.
   if (sLetter == "a")
      {
      nAdd = 0;
      }
      else if (sLetter == "b")
      {
      nAdd = 16;
      }
      else if (sLetter == "c")
      {
      nAdd = 32;
      }
      else if (sLetter == "d")
      {
      nAdd = 48;
      }
      else if (sLetter == "e")
      {
      nAdd = 64;
      }
      else if (sLetter == "f")
      {
      nAdd = 80;
      }
      else if (sLetter == "g")
      {
      nAdd = 96;
      }
      else if (sLetter == "h")
      {
      nAdd = 112;
      }
      else if (sLetter == "i")
      {
      nAdd = 128;
      }
      else if (sLetter == "j")
      {
      nAdd = 144;
      }
      else if (sLetter == "k")
      {
      nAdd = 160;
      }
      else
      {
      //invalid letter or non-letter, so exit.
      return nReturn;
      }

   nReturn = (nNumber + nAdd) - 1;

   return nReturn;
}

string HSS_ArmourColourIntToChart(int nColour)
{
   int nLetter = nColour/16;
   int nNumber;
   string sLetter;
   string sReturn;

   switch (nLetter)
   {
   case 0:
         sLetter = "A";
         nNumber = nColour + 1;
         sReturn = sLetter + IntToString(nNumber);
         break;
   case 1:
         sLetter = "B";
         nNumber = nColour - (nLetter * 16) + 1;
         sReturn = sLetter + IntToString(nNumber);
         break;
   case 2:
         sLetter = "C";
         nNumber = nColour - (nLetter * 16) + 1;
         sReturn = sLetter + IntToString(nNumber);
         break;
   case 3:
         sLetter = "D";
         nNumber = nColour - (nLetter * 16) + 1;
         sReturn = sLetter + IntToString(nNumber);
         break;
   case 4:
         sLetter = "E";
         nNumber = nColour - (nLetter * 16) + 1;
         sReturn = sLetter + IntToString(nNumber);
         break;
   case 5:
         sLetter = "F";
         nNumber = nColour - (nLetter * 16) + 1;
         sReturn = sLetter + IntToString(nNumber);
         break;
   case 6:
         sLetter = "G";
         nNumber = nColour - (nLetter * 16) + 1;
         sReturn = sLetter + IntToString(nNumber);
         break;
   case 7:
         sLetter = "H";
         nNumber = nColour - (nLetter * 16) + 1;
         sReturn = sLetter + IntToString(nNumber);
         break;
   case 8:
         sLetter = "I";
         nNumber = nColour - (nLetter * 16) + 1;
         sReturn = sLetter + IntToString(nNumber);
         break;
   case 9:
         sLetter = "J";
         nNumber = nColour - (nLetter * 16) + 1;
         sReturn = sLetter + IntToString(nNumber);
         break;
   case 10:
         sLetter = "K";
         nNumber = nColour - (nLetter * 16) + 1;
         sReturn = sLetter + IntToString(nNumber);
         break;
   }

   return sReturn;
}

int HSS_ArmourGetColourType(object oArmourer = OBJECT_SELF)
{
   int nType = GetLocalInt(oArmourer, HSS_PREFX + "ARMOUR_COLOUR_TYPE");
   int nReturn;

   switch (nType)
   {
   case 1:
        nReturn = ITEM_APPR_ARMOR_COLOR_METAL1;
        break;
   case 2:
        nReturn = ITEM_APPR_ARMOR_COLOR_METAL2;
        break;
   case 3:
        nReturn = ITEM_APPR_ARMOR_COLOR_CLOTH1;
        break;
   case 4:
        nReturn = ITEM_APPR_ARMOR_COLOR_CLOTH2;
        break;
   case 5:
        nReturn = ITEM_APPR_ARMOR_COLOR_LEATHER1;
        break;
   case 6:
        nReturn = ITEM_APPR_ARMOR_COLOR_LEATHER2;
        break;
   }

   return nReturn;
}

int HSS_ArmourDoColourModification(int nColour, object oArmourer = OBJECT_SELF)
{
   int nReturn;
   object oDummy;
   int nGender = GetLocalInt(oArmourer, HSS_PREFX + "CUSTOMER_GENDER");
   int nType = GetLocalInt(oArmourer, HSS_PREFX + "ARMOUR_ITEM_TYPE");
   float fCost = GetLocalFloat(oArmourer, HSS_PREFX + "ARMOUR_COLOUR_COST_X");
   int nValue = GetLocalInt(oArmourer, HSS_PREFX + "ARMOUR_VALUE");
   fCost = IntToFloat(nValue) * fCost;
   int nColType = HSS_ArmourGetColourType(oArmourer);
   string sOrig = GetLocalString(oArmourer, HSS_PREFX + "ARMOUR_ORIGINALS");
   string sTemp = "Lth1_Lth2_Cth1_Cth2_Mtl1_Mtl2_";
   string sAppear;
   int nSlot;
   int nCost;
   int nCount;
   int nAppear;
   int nPos;
   int nTally;

   if (nGender == 2)
      {
      oDummy = GetNearestObjectByTag(HSS_PREFX + "ARMOUR_DUMMY_F");
      }
      else
      {
      oDummy = GetNearestObjectByTag(HSS_PREFX + "ARMOUR_DUMMY_M");
      }

   switch (nType)
   {
   case HSS_TYPE_ARMOUR:
        nSlot = INVENTORY_SLOT_CHEST;
        break;
   case HSS_TYPE_HELM:
        nSlot = INVENTORY_SLOT_HEAD;
        break;
   }

   object oItem = GetItemInSlot(nSlot, oDummy);
   nCost = FloatToInt(fCost);

   //first colour mod, so store all the original colours
   if (sOrig == "")
      {
      //build original colours cache
      while (nCount < ITEM_APPR_ARMOR_NUM_COLORS)
          {
          nAppear = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_COLOR, nCount);

          switch (nCount)
          {
          case 0:
               sAppear = "Lth1_";
               break;
          case 1:
               sAppear = "Lth2_";
               break;
          case 2:
               sAppear = "Cth1_";
               break;
          case 3:
               sAppear = "Cth2_";
               break;
          case 4:
               sAppear = "Mtl1_";
               break;
          case 5:
               sAppear = "Mtl2_";
               break;
          }

          if (nCount == ITEM_APPR_ARMOR_NUM_COLORS - 1)
             {
             sAppear = IntToString(nAppear);
             sTemp = sTemp + sAppear + "_";
             }
             else
             {
             nPos = FindSubString(sTemp, sAppear);
             sAppear = IntToString(nAppear);
             sTemp = InsertString(sTemp,  sAppear + "_", nPos + 5);
             }

          nCount++;
          }

      //store the cache now as a single string
      SetLocalString(oArmourer, HSS_PREFX + "ARMOUR_ORIGINALS", sTemp);
      }

   //convert colour type to string
   switch (nColType)
   {
   case 0:
        sAppear = "Lth1";
        break;
   case 1:
        sAppear = "Lth2";
        break;
   case 2:
        sAppear = "Cth1";
        break;
   case 3:
        sAppear = "Cth2";
        break;
   case 4:
        sAppear = "Mtl1";
        break;
   case 5:
        sAppear = "Mtl2";
        break;
   }

   //get the cache again, we know it exists now
   sOrig = GetLocalString(oArmourer, HSS_PREFX + "ARMOUR_ORIGINALS");
   //find our original colour number -- with or without its flag
   sTemp = HSS_ArmourFindSeperatedString(sAppear, sOrig);

   //we are *NOT* flagged as being a changed colour
   if (GetStringLeft(sTemp, 1) != "*")
      {
      //the colour is now *NOT* the original, so flag the change
      if (IntToString(nColour) != sTemp)
         {
         nPos = FindSubString(sOrig, sAppear);
         sTemp = InsertString(sOrig,  "*", nPos + 5);
         SetLocalString(oArmourer, HSS_PREFX + "ARMOUR_ORIGINALS", sTemp);
         }

      }
      //we *ARE* flagged as being a changed colour
      else
      {
      nCount = GetStringLength(sTemp) - 1;
      sTemp = GetStringRight(sTemp, nCount);

      //the colour now *IS* back to original, so remove the flag
      if (IntToString(nColour) == sTemp)
         {
         //return 1 letting us know we are on an original
         nReturn = 1;
         nPos = FindSubString(sOrig, sAppear);

         sTemp = GetSubString(sOrig, 0, nPos + 5) +
                 GetSubString(sOrig, nPos + 6, GetStringLength(sOrig) - (nPos + 6));

         SetLocalString(oArmourer, HSS_PREFX + "ARMOUR_ORIGINALS", sTemp);
         }

      }

   //get the cache again, it may have changed again
   sOrig = GetLocalString(oArmourer, HSS_PREFX + "ARMOUR_ORIGINALS");

   nTally = HSS_ArmourGetSeperatedStringsCount(sOrig, "*");

   if (nTally > 0)
      {
      //we want the count of SEPERATORS; not the count of seperated strings
      //it will be one less than the number of seperated strings.
      nTally = nTally - 1;
      }

   //update the running cost
   if (nCost < HSS_ARMOUR_MIN_COST)
      {
      SetLocalInt(oArmourer, HSS_PREFX + "ARMOUR_COST", HSS_ARMOUR_MIN_COST * nTally);
      }
      else
      {
      SetLocalInt(oArmourer, HSS_PREFX + "ARMOUR_COST", nCost * nTally);
      }

   //make the change
   object oNew = IPDyeArmor(oItem, nColType, nColour);
   AssignCommand(oDummy, ActionEquipItem(oNew, nSlot));

   return nReturn;
}

void HSS_ArmourReportColours(object oDummy, int nType = HSS_TYPE_ARMOUR)
{
   object oItem;

   switch (nType)
   {
   case HSS_TYPE_ARMOUR:
        oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oDummy);
        break;
   case HSS_TYPE_HELM:
        oItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oDummy);
        break;
   }


   string sMet1 = HSS_ArmourColourIntToChart(GetItemAppearance(oItem,
                  ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_METAL1));

   string sMet2 = HSS_ArmourColourIntToChart(GetItemAppearance(oItem,
                  ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_METAL2));

   string sLeath1 = HSS_ArmourColourIntToChart(GetItemAppearance(oItem,
                    ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_LEATHER1));

   string sLeath2 = HSS_ArmourColourIntToChart(GetItemAppearance(oItem,
                    ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_LEATHER2));

   string sCloth1 = HSS_ArmourColourIntToChart(GetItemAppearance(oItem,
                    ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_CLOTH1));

   string sCloth2 = HSS_ArmourColourIntToChart(GetItemAppearance(oItem,
                    ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_CLOTH2));


   SpeakString("zakladni kovova barva je " + sMet1 + ", " + "sekundarni kovova je" +
              " barva je " + sMet2 + ", " + "zakladni kozena je " +
              sLeath1 + ", " + "sekundarni kozena je " + sLeath2 + ", " +
              "zakladni latkova je " + sCloth1 +
              " a sekundarni latkova je " + sCloth2 + ".");

}

void HSS_ArmourFinishRoutine(object oPC, int nSale)
{
   int nType = GetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_ITEM_TYPE");
   int nGender = GetLocalInt(OBJECT_SELF, HSS_PREFX + "CUSTOMER_GENDER");
   object oContainer = GetNearestObjectByTag(HSS_PREFX + "ARMOUR_CONTAINER");
   object oOriginal = GetFirstItemInInventory(oContainer);
   object oDummy;
   object oItem;
   object oNew;

   //stop listening for colour/armour commands
   SetListenPattern(OBJECT_SELF, "", 1387);
   SetListenPattern(OBJECT_SELF, "", 1388);
   SetListenPattern(OBJECT_SELF, "", 1389);
   SetListenPattern(OBJECT_SELF, "", 1391);

   if (nGender == 2)
      {
      oDummy = GetNearestObjectByTag(HSS_PREFX + "ARMOUR_DUMMY_F");
      }
      else
      {
      oDummy = GetNearestObjectByTag(HSS_PREFX + "ARMOUR_DUMMY_M");
      }

      switch (nType)
      {
      case HSS_TYPE_ARMOUR:
           oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oDummy);
           break;
      case HSS_TYPE_HELM:
           oItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oDummy);
           break;
      case HSS_TYPE_WEAPON:
           oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oDummy);
           break;
      case HSS_TYPE_SHIELD:
           oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oDummy);
           break;
      }

   if (nSale == TRUE)
      {
      oNew = CopyItem(oItem, oPC, TRUE);

      if (GetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PLOT_FLAG"))
         {
         SetPlotFlag(oNew, TRUE);
         }
      DestroyObject(oItem);
      DestroyObject(oOriginal);
      }
      else
      if (nSale == FALSE)
      {
      oNew = CopyItem(oOriginal, oPC, TRUE);

      if (GetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PLOT_FLAG"))
         {
         SetPlotFlag(oNew, TRUE);
         }
      DestroyObject(oOriginal);
      DestroyObject(oItem);
      }
      else
      {
      if (GetPlotFlag(oOriginal))
         {
         SetPlotFlag(oOriginal, FALSE);
         }
      DestroyObject(oOriginal);
      DestroyObject(oItem);
      }

   SetLocked(oContainer, FALSE);

   DeleteLocalObject(OBJECT_SELF, HSS_PREFX + "ARMOUR_CUSTOMER");
   DeleteLocalString(OBJECT_SELF, HSS_PREFX + "ARMOUR_CUSTOMER_ID");
   DeleteLocalString(OBJECT_SELF, HSS_PREFX + "ARMOUR_ORIGINALS");
   DeleteLocalInt(OBJECT_SELF, HSS_PREFX + "CUSTOMER_GENDER");
   DeleteLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_VALUE");
   DeleteLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_ITEM_TYPE");
   DeleteLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_COLOUR_TYPE");
   DeleteLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PLOT_FLAG");
   DeleteLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PART_TYPE");
   DeleteLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_COST");
   DeleteLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_TALLY");
   DeleteLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_IS_ROBED");
   DeleteLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_ITEM_IS_EXCLUDED");
   SetCustomToken(1387, "0");

}

string HSS_ArmourGetAndCache2DAString(string s2DA, string sColumn, int nRow, object oModule)
{
   string sCache = GetLocalString(oModule, s2DA + sColumn + IntToString(nRow));
   string sResult;

   if (sCache != "")
      {
      sResult = sCache;
      return sResult;
      }
      else
      {
      sResult = Get2DAString(s2DA, sColumn, nRow);

      if (sResult == "")
         {
         sResult = "/";
         }

      SetLocalString(oModule, s2DA + sColumn + IntToString(nRow), sResult);
      return sResult;
      }

}

void HSS_ArmourBuild2DAPartIndex(object oModule)
{
   int nCount = 0;
   int nChest;
   int nAC;
   int nPos;
   string sACIndex = "AC0*_AC1*_AC2*_AC3*_AC4*_AC5*_AC6*_AC7*_AC8*_";
   string sPartIndex;
   string sTotal;
   string sAC;

   //loop and cache the part totals
   //only runs once pulling from the 2da
   while (nCount < 19)
       {
       sTotal = HSS_ArmourGetAndCache2DAString("hss_armour_parts",
                "NumParts", nCount, oModule);

       //get the chest piece part total.
       if (nCount == 7)
          {
          nChest = StringToInt(sTotal);
          }

       sPartIndex = sPartIndex + "Part" + IntToString(nCount) + "_" + sTotal + "_";

       //clean up cached 2da results.
       DeleteLocalString(oModule, "hss_armour_parts" + "NumParts" + IntToString(nCount));
       nCount++;
       }

   //manually add in the helm count to the end
   SetLocalString(oModule, HSS_PREFX + "ARMOUR_PART_COUNT_CACHE", sPartIndex +
                 "Part99" + "_" + IntToString(HSS_ARMOUR_HELM_COUNT));

   nCount = 0;

   //loop and cache AC chest values
   //only runs once pulling from the 2da
   //The advantage here is easier
   //incorporation of extra parts (i.e. cep).
   while (nCount < nChest)
       {
       sAC = HSS_ArmourGetAndCache2DAString("parts_chest",
                "ACBONUS", nCount, oModule);

       //valid line, not a "****" or empty string
       if (sAC != "/")
          {
          //not specified as an excluded piece
          if (!HSS_ArmourIsExcludedPiece(nCount, 7, HSS_ARMOUR_CHEST_EXCLUSION))
             {
             nAC = StringToInt(sAC);

             if (nAC < 8)
                {
                nPos = FindSubString(sACIndex, "AC" + IntToString(nAC + 1));
                sACIndex = InsertString(sACIndex, IntToString(nCount) + "_", nPos);
                }
                else
                {
                sACIndex = sACIndex + IntToString(nCount) + "_";
                }
             }
          }

       //clean up cached 2da results.
       DeleteLocalString(oModule, "parts_chest" + "ACBONUS" + IntToString(nCount));
       nCount++;
       }

   SetLocalString(oModule, HSS_PREFX + "ARMOUR_AC_CHEST_CACHE", sACIndex + "ACx*");
}

int HSS_ArmourDoPartModification(int nPartType, int nNext, object oArmourer = OBJECT_SELF)
{
   int nReturn;
   object oDummy;
   object oItem;
   int nGender = GetLocalInt(OBJECT_SELF, HSS_PREFX + "CUSTOMER_GENDER");
   int nType = GetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_ITEM_TYPE");
   string sOrig = GetLocalString(OBJECT_SELF, HSS_PREFX + "ARMOUR_ORIGINALS");
   float fCost = GetLocalFloat(oArmourer, HSS_PREFX + "ARMOUR_PART_COST_X");
   int nValue = GetLocalInt(oArmourer, HSS_PREFX + "ARMOUR_VALUE");
   fCost = IntToFloat(nValue) * fCost;
   string sPartType;
   int nPartLength;
   int nSlot;
   int nCount;
   int nAppear;
   int nPart;
   int nPos;
   int nTally;
   int nCost;
   string sPartIndex;
   string sPart;

   if (nGender == 2)
      {
      oDummy = GetNearestObjectByTag(HSS_PREFX + "ARMOUR_DUMMY_F");
      }
      else
      {
      oDummy = GetNearestObjectByTag(HSS_PREFX + "ARMOUR_DUMMY_M");
      }

   switch (nType)
   {
   case HSS_TYPE_ARMOUR:
        nSlot = INVENTORY_SLOT_CHEST;
        nPartType = nPartType - 1;
        break;
   case HSS_TYPE_HELM:
        nSlot = INVENTORY_SLOT_HEAD;
        break;
   }

   nCost = FloatToInt(fCost);
   sPartType = "Part" + IntToString(nPartType);
   nPartLength = GetStringLength(sPartType);

   oItem = GetItemInSlot(nSlot, oDummy);
   nPart = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, nPartType);

   if (HSS_VERBOSE)
      {
      SpeakString("Posledni cast byla: " + IntToString(nPart) + ".");
      }

   nPart = HSS_ArmourFindNextAppearance(nPart, nPartType, nNext);

   if (HSS_VERBOSE)
      {
      SpeakString("Nova cast je: " + IntToString(nPart) + ".");
      }

   //first part mod, so build the cache of originals
   if (sOrig == "")
      {
      if (nType == HSS_TYPE_ARMOUR)
         {
         //build original parts cache
         while (nCount < 19)
             {
             nAppear = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, nCount);
             sPart = IntToString(nAppear);

             sPartIndex = sPartIndex + "Part" + IntToString(nCount) + "_" +
                       sPart + "_";

             nCount++;
             }

          }
          else
          if (nType == HSS_TYPE_HELM)
          {
          nAppear = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, nCount);
          sPart = IntToString(nAppear);
          sPartIndex = "Part99" + "_" + sPart + "_";
          }

      //store the cache now as a single string
      SetLocalString(oArmourer, HSS_PREFX + "ARMOUR_ORIGINALS", sPartIndex);
      }

   //get the cache again, we know it exists now
   sOrig = GetLocalString(oArmourer, HSS_PREFX + "ARMOUR_ORIGINALS");
   //find our original part number -- with or without its flag
   sPart = HSS_ArmourFindSeperatedString(sPartType, sOrig);

   //we are *NOT* flagged as being a changed part
   if (GetStringLeft(sPart, 1) != "*")
      {
      //the part is now *NOT* the original, so flag the change
      if (IntToString(nPart) != sPart)
         {
         nPos = FindSubString(sOrig, sPartType);
         sPart = InsertString(sOrig,  "*", nPos + nPartLength + 1);
         SetLocalString(oArmourer, HSS_PREFX + "ARMOUR_ORIGINALS", sPart);
         }

      }
      //we *ARE* flagged as being a changed part
      else
      {
      nCount = GetStringLength(sPart) - 1;
      sPart = GetStringRight(sPart, nCount);

      //the part now *IS* back to original, so remove the flag
      if (IntToString(nPart) == sPart)
         {
         //return 1 as we are back to original
         nReturn = 1;
         nPos = FindSubString(sOrig, sPartType) + 1;

         sPart = GetSubString(sOrig, 0, nPos + nPartLength) +
                 GetSubString(sOrig, nPos + nPartLength + 1, GetStringLength(sOrig) - (nPos + nPartLength + 1));

         SetLocalString(oArmourer, HSS_PREFX + "ARMOUR_ORIGINALS", sPart);
         }

      }

   //get the cache again, it may have changed again
   sOrig = GetLocalString(oArmourer, HSS_PREFX + "ARMOUR_ORIGINALS");

   nTally = HSS_ArmourGetSeperatedStringsCount(sOrig, "*");

   if (nTally > 0)
      {
      //we want the count of SEPERATORS; not the count of seperated strings
      //will be one less than the number of seperated strings.
      nTally = nTally - 1;
      }

   //update the running cost
   if (nCost < HSS_ARMOUR_MIN_COST)
      {
      //robe has been modified
      if (GetStringLeft(HSS_ArmourFindSeperatedString("Part18",
         sOrig), 1) == "*")
         {
         //robe has been modified as well as at least one other part
         if (nTally > 1)
            {
            nCount = HSS_ARMOUR_MIN_COST * HSS_ROBE_X;
            nCost = ((nTally - 1) * HSS_ARMOUR_MIN_COST) + nCount;
            }
            //just the robe
            else
            {
            nCost = HSS_ARMOUR_MIN_COST * HSS_ROBE_X;
            }
         }
         else
         {
         nCost = HSS_ARMOUR_MIN_COST * nTally;
         }
      }
      else
      {
      //robe has been modified
      if (GetStringLeft(HSS_ArmourFindSeperatedString("Part18",
         sOrig), 1) == "*")
         {
         //robe has been modified as well as at least one other part
         if (nTally > 1)
            {
            nCount = nCost * HSS_ROBE_X;
            nCost = ((nTally - 1) * nCost) + nCount;
            }
            //just the robe
            else
            {
            nCost = nCost * HSS_ROBE_X;
            }
         }
         else
         {
         nCost = nCost * nTally;
         }
      }
   //store the current cost total
   SetLocalInt(oArmourer, HSS_PREFX + "ARMOUR_COST", nCost);

   //make the change
   object oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL,
                 nPartType, nPart, TRUE);

   HSS_ArmourDummyEquipItem(oDummy, oNew, nSlot);
   DestroyObject(oItem);

   return nReturn;
}

void HSS_ArmourOnConversationRoutine(int nMatch)
{
   object oPC = GetLastSpeaker();

   if (oPC == GetLocalObject(OBJECT_SELF, HSS_PREFX + "ARMOUR_CUSTOMER"))
      {
      string sMatch;
      string sMatch0 = GetMatchedSubstring(0);
      string sMatch1 = GetMatchedSubstring(1);
      string sMatch2 = GetMatchedSubstring(2);
      string sMatch3 = GetMatchedSubstring(3);
      int nTotal;
      int nType;
      string sOriginal;

      switch (nMatch)
           {
           //we hear a colour code
           case 1387:
                if (TestStringAgainstPattern("*n**", sMatch3))
                   {
                   sMatch = sMatch1 + sMatch2 + GetStringLeft(sMatch3, 1);
                   }
                   else
                   {
                   sMatch = sMatch1 + sMatch2;
                   }

                if (GetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_COLOUR_TYPE"))
                   {
                   string sConfirm = GetLocalString(OBJECT_SELF, HSS_PREFX + "ARMOUR_CONFIRM");
                   string sInvalid = GetLocalString(OBJECT_SELF, HSS_PREFX + "ARMOUR_INVALID_COLOUR");
                   string sExcluded = GetLocalString(OBJECT_SELF, HSS_PREFX + "ARMOUR_COLOUR_EXCLUDED");
                   int nColour = HSS_ArmourColourChartToInt(sMatch);

                   if (nColour > -1)
                      {
                      if (HSS_ArmourDoColourModification(nColour))
                         {
                         sOriginal = GetLocalString(OBJECT_SELF, HSS_PREFX +
                                     "ARMOUR_PART_ORIGINAL");
                         }

                      nTotal = GetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_COST");
                      SpeakString(sConfirm + IntToString(nTotal) + "." + sOriginal);
                      }
                      else
                      if (nColour == -2)
                      {
                      SpeakString(sExcluded);
                      }
                      else
                      {
                      SpeakString(sInvalid);
                      }
                   }
                break;
           //we hear an armour part piece name
           case 1388:
                nType = GetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_ITEM_TYPE");
                sMatch = sMatch1;

             //take action only if we're working on an armour piece
             if (nType == HSS_TYPE_ARMOUR)
                {

                if (sMatch == "prava noha")
                   {
                   SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PART_TYPE", 1);
                   }
                   else
                   if (sMatch == "leva noha")
                   {
                   SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PART_TYPE", 2);
                   }
                   else
                   if (sMatch == "leva holen")
                   {
                   SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PART_TYPE", 3);
                   }
                   else
                   if (sMatch == "prava holen")
                   {
                   SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PART_TYPE", 4);
                   }
                   else
                   if (sMatch == "leve stehno")
                   {
                   SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PART_TYPE", 5);
                   }
                   else
                   if (sMatch == "prave stehno")
                   {
                   SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PART_TYPE", 6);
                   }
                   else
                   if (sMatch == "panev")
                   {
                   SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PART_TYPE", 7);
                   }
                   else
                   if (sMatch == "telo")
                   {
                   SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PART_TYPE", 8);
                   }
                   else
                   if (sMatch == "pas")
                   {
                   SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PART_TYPE", 9);
                   }
                   else
                   if (sMatch == "krk")
                   {
                   SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PART_TYPE", 10);
                   }
                   else
                   if (sMatch == "prave predlokti")
                   {
                   SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PART_TYPE", 11);
                   }
                   else
                   if (sMatch == "leve predlokti")
                   {
                   SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PART_TYPE", 12);
                   }
                   else
                   if (sMatch == "pravy loket")
                   {
                   SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PART_TYPE", 13);
                   }
                   else
                   if (sMatch == "levy loket")
                   {
                   SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PART_TYPE", 14);
                   }
                   else
                   if (sMatch == "prave rameno")
                   {
                   SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PART_TYPE", 15);
                   }
                   else
                   if (sMatch == "leve rameno")
                   {
                   SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PART_TYPE", 16);
                   }
                   else
                   if (sMatch == "prava ruka")
                   {
                   SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PART_TYPE", 17);
                   }
                   else
                   if (sMatch == "leva ruka")
                   {
                   SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PART_TYPE", 18);
                   }
                   else
                   if (sMatch == "roba")
                   {
                   SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PART_TYPE", 19);
                   }
                //don't acknowledge the choice if it's a robe and robe alteration
                //has been disabled.
                if ((sMatch == "roba" && HSS_ROBE_ENABLED == 0) ||
                   (!GetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_IS_ROBED") &&
                   HSS_ROBE_POLICY == 1 && sMatch == "roba"))
                   {
                   return;
                   }
                   else
                   {
                   //acknowledge the part type chosen.
                   SpeakString(GetLocalString(OBJECT_SELF,
                              HSS_PREFX + "ARMOUR_CONFIRM_PART_CHOICE") +
                              sMatch + ". ");
                   }
                }
                break;
           //we hear a command to change the armour piece
           case 1389:
                sMatch = sMatch1;
                nType = GetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PART_TYPE");

                if (nType)
                   {
                   //builder has disallowed robe model switching or...
                   //the item didn't begin with a robe and policy states we only
                   //change robes if they exist to begin with.
                   if ((nType == 19 && HSS_ROBE_ENABLED != 1) ||
                      (!GetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_IS_ROBED") &&
                      HSS_ROBE_POLICY == 1 && nType == 19))
                      {
                      SpeakString(GetLocalString(OBJECT_SELF, HSS_PREFX +
                                 "ARMOUR_IS_ROBED"));
                      //give the robe back
                      HSS_ArmourFinishRoutine(oPC, FALSE);
                      return;
                      }

                   if (sMatch == "dalsi")
                      {
                      //make the change, and if it's an original...say so
                      if (HSS_ArmourDoPartModification(GetLocalInt(OBJECT_SELF,
                         HSS_PREFX + "ARMOUR_PART_TYPE"), HSS_NEXT))
                         {
                         sOriginal = GetLocalString(OBJECT_SELF, HSS_PREFX +
                                     "ARMOUR_PART_ORIGINAL");
                         }

                      nTotal = GetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_COST");
                      //acknowledge the choice and report the current bill
                      SpeakString(GetLocalString(OBJECT_SELF, HSS_PREFX + "ARMOUR_CONFIRM") +
                                 IntToString(nTotal) + "." + sOriginal);
                      }
                      else
                      if (sMatch == "zpet")
                      {
                      //make the change
                      if (HSS_ArmourDoPartModification(GetLocalInt(OBJECT_SELF,
                         HSS_PREFX + "ARMOUR_PART_TYPE"), HSS_PREV))
                         {
                         sOriginal = GetLocalString(OBJECT_SELF, HSS_PREFX +
                                     "ARMOUR_PART_ORIGINAL");
                         }

                      nTotal = GetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_COST");
                      //acknowledge the choice and report the current bill
                      SpeakString(GetLocalString(OBJECT_SELF, HSS_PREFX + "ARMOUR_CONFIRM") +
                                 IntToString(nTotal) + "." + sOriginal);
                      }
                   }
                break;
           //we hear an armour colour type
           case 1391:
                sMatch = sMatch1;

                //Set a local to determine the colour type to be changed
                if (sMatch == "kov 1" || sMatch == "kov jedna" ||
                   sMatch == "zakladni kov" || sMatch == "prvni kov")
                   {
                   //SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_COLOUR_TYPE", 1);
                   nType = 1;
                   sMatch = "zakladni kov";
                   }
                   else
                   if (sMatch == "kov 2" || sMatch == "kov dva" ||
                   sMatch == "druhotny kov" || sMatch == "druhy kov")
                   {
                   //SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_COLOUR_TYPE", 2);
                   nType = 2;
                   sMatch = "druhotny kov";
                   }
                   else
                   if (sMatch == "latka 1" || sMatch == "latka jedna" ||
                   sMatch == "zakladni latka" || sMatch == "prvni latka")
                   {
                   //SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_COLOUR_TYPE", 3);
                   nType = 3;
                   sMatch = "zakladni latka";
                   }
                   else
                   if (sMatch == "latka 2" || sMatch == "latka dva" ||
                   sMatch == "druhotny latka" || sMatch == "druhy latka")
                   {
                   //SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_COLOUR_TYPE", 4);
                   nType = 4;
                   sMatch = "druhotny latka";
                   }
                   else
                   if (sMatch == "kuze 1" || sMatch == "kuze jedna" ||
                   sMatch == "zakladni kuze" || sMatch == "prvni kuze")
                   {
                   //SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_COLOUR_TYPE", 5);
                   nType = 5;
                   sMatch = "zakladni kuze";
                   }
                   else
                   if (sMatch == "kuze 2" || sMatch == "kuze dva" ||
                   sMatch == "druhotny kuze" || sMatch == "druhy kuze")
                   {
                   //SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_COLOUR_TYPE", 6);
                   nType = 6;
                   sMatch = "druhotny kuze";
                   }

                SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_COLOUR_TYPE", nType);//

                //acknowledge the choice
                SpeakString(GetLocalString(OBJECT_SELF,
                           HSS_PREFX + "ARMOUR_CONFIRM_PART_CHOICE") +
                           sMatch + " barvu.");
                break;
           }
      }
}

int HSS_ArmourFindNextAppearance(int nPart, int nPartType, int nNext)
{
   int nReturn;
   string sReturn;
   string sPartCache = GetLocalString(GetModule(), HSS_PREFX + "ARMOUR_PART_COUNT_CACHE");
   string sChestCache = GetLocalString(GetModule(), HSS_PREFX + "ARMOUR_AC_CHEST_CACHE");
   int nPartCount = StringToInt(HSS_ArmourFindSeperatedString("Part" +
                    IntToString(nPartType), sPartCache));

      if (nPartType == 7)
         {
         //sChestCache is built up already omitting exclusions
         nReturn = HSS_ArmourFindNextChestPiece(nPart, sChestCache, nNext);
         }
         //it's a helm or non-chest armour piece
         else
         {
         //this function filters exclusions on the fly since the cache is
         //a different style from the chest cache
         nReturn = HSS_FindNextPartPiece(nPart, nPartType, nPartCount, nNext);
         }

   return nReturn;
}

string HSS_ArmourFindSeperatedString(string sStart, string sTarget, int nMode = HSS_NEXT, string sSeperator = "_")
{
   int nSepLength = GetStringLength(sSeperator);
   int nLength = GetStringLength(sTarget);
   int nPartLength = GetStringLength(sStart);
   int nPos = FindSubString(sTarget, sStart);
   int nCount = 0;
   int nStart;
   string sResult;
   string sSub;

   //empty string for sStart, so we default to the beginning
   //of sTarget for our search.
   if (sStart == "")
      {
      //we're looking for the seperated string FOLLOWING sSeperator
      if (nMode == HSS_NEXT)
         {
         nPos = 0;
         //position indexed from 0, length indexed from 1
         while (nPos < nLength)
             {
             sSub = GetSubString(sTarget, nPos, nLength - nPos);

             //we have the first seperator of sTarget
             if (GetSubString(sSub, 0, nSepLength) == sSeperator)
                {
                nCount++;
                //1st seperator found so...
                if (nCount == 1)
                   {
                   //...store the start position of the seperated string
                   nStart = nPos;
                   }
                   //2nd seperator found...we have our seperated string.
                   else
                   if (nCount == 2)
                   {
                   sResult = GetSubString(sTarget, nStart + nSepLength, (nPos - nStart) - nSepLength);
                   return sResult;
                   }

                }
                //first seperator found and we are at the end of the string,
                //so return everything after the first seperator
                else           //position indexed from 0, length indexed from 1
                if (nCount == 1 && nPos == (nLength - 1))
                {
                sResult = GetSubString(sTarget, nStart + nSepLength, nLength - (nStart + nSepLength));
                return sResult;
                }

             nPos++;
             }
         }
         //we're looking for the seperated string PRECEDING sSeperator
         else
         if (nMode == HSS_PREV)
         {
         nPos = 0;
         //position indexed from 0, length indexed from 1
         while (nPos < nLength)
             {
             sSub = GetSubString(sTarget, nPos, nLength - nPos);
             //we have the first seperator of sTarget -- that's all we need here.
             //so, get the string from the beginning to here.
             if (GetSubString(sSub, 0, nSepLength) == sSeperator)
                {
                sResult = GetSubString(sTarget, 0, nPos);
                return sResult;
                }

             nPos++;
             }
         }

      return sResult;
      }

   //we have been given a string as sStart, so we begin there
   //we're looking for the seperated string FOLLOWING sSeperator at sStart
   if (nMode == HSS_NEXT)
      {
      nPos = nPos + nPartLength;
      //position indexed from 0, length indexed from 1
      while (nPos < nLength)
          {
          sSub = GetSubString(sTarget, nPos, nLength - nPos);

          if (GetSubString(sSub, 0, nSepLength) == sSeperator)
             {
             nCount++;
             //1st seperator found so...
             if (nCount == 1)
                {
                //...store the start position of the seperated string
                nStart = nPos;
                }
                //2nd seperator found...we have our seperated string.
                else
                if (nCount == 2)
                {
                sResult = GetSubString(sTarget, nStart + nSepLength, (nPos - nStart) - nSepLength);
                return sResult;
                }

             }
             //first seperator found and we are at the end of the stirng,
             //so return everything following the first seperator
             else           //position indexed from 0, length indexed from 1
             if (nCount == 1 && nPos == (nLength - 1))
             {
             sResult = GetSubString(sTarget, nStart + nSepLength, nLength - (nStart + nSepLength));
             return sResult;
             }

          nPos++;
          }
      }
      //we're looking for the seperated string PRECEDING sSeperator at sStart
      else
      if (nMode == HSS_PREV)
      {
         nPos = nPos - nSepLength;
         //position indexed from 0
         while (nPos >= 0)
             {
             sSub = GetSubString(sTarget, nPos, nLength - nPos);

             //we have the first seperator of sTarget
             if (GetSubString(sSub, 0, nSepLength) == sSeperator)
                {
                nCount++;
                //1st seperator found so...
                if (nCount == 1)
                   {
                   //...store the start position of the seperated string
                   nStart = nPos;
                   }
                   //2nd seperator found...we have our seperated string.
                   else
                   if (nCount == 2)
                   {
                   sResult = GetSubString(sTarget, nPos + nSepLength, (nStart - nPos) - nSepLength);
                   return sResult;
                   }

                }
                //first seperator found and we are at the beginning of the stirng,
                //so return everything before the first seperator
                else
                if (nCount == 1 && nPos == 0)
                {
                sResult = GetSubString(sTarget, 0, nStart);
                return sResult;
                }

             nPos--;
             }

      }

   return sResult;
}


int HSS_ArmourFindNextChestPiece(int nCurrent, string sTarget, int nNext)
{
   string sAC = IntToString(HSS_ArmourGetChestACFromCache(nCurrent, sTarget));
   string sCurrent = IntToString(nCurrent);
   int nCount = 1;
   string sResult;
   int nLength;
   string sTest;
   int nPartCount;
   int nReturn;

   //okay, we now have the block of ranges as sResult here.
   sResult = HSS_ArmourFindSeperatedString("AC" + sAC, sTarget, HSS_NEXT, "*");

   //trim the end 3 char's (AC+int)
   nLength = GetStringLength(sResult);
   sResult = GetStringLeft(sResult, nLength - 3);

   //we now know how many parts exist for this AC range
   nPartCount = HSS_ArmourGetSeperatedStringsCount(sResult);

   if (nNext == HSS_NEXT)
      {
      //find the next piece from the block
      sTest = HSS_ArmourFindSeperatedString(sCurrent, sResult);

      //empty string means we are at the end of the block, so we need to
      //wrap back to the beginning of the block.
      if (sTest == "")
         {
         sResult = HSS_ArmourFindSeperatedString("", sResult);
         }
         else
         {
         sResult = sTest;
         }
      }
      else
      if (nNext == HSS_PREV)
      {
      //find the previous piece from the block
      sTest = HSS_ArmourFindSeperatedString(sCurrent, sResult, HSS_PREV);

      //empty string means we are at the beginning of the block, so we need to
      //wrap back to the end the block.
      if (sTest == "")
         {
         //add a "cap" character to the end of sResult so we can have an unique
         //start point to start from to get the last block value.
         sResult = HSS_ArmourFindSeperatedString("!", sResult + "!", HSS_PREV);
         }
         else
         {
         sResult = sTest;
         }
      }
      nReturn = StringToInt(sResult);
      return nReturn;
}

int HSS_FindNextPartPiece(int nCurrent, int nPartType, int nPartCount, int nNext)
{
   int nReturn;
   int nCount;
   int nMinMax;
   int nStart;
   int nEnd;


   //adjust our variables to acount for index 0 or index 1, accordingly
   if (nPartType == 99)
      {
      nStart = 1;
      nEnd = nPartCount;
      }
      else
      {
      nStart = 0;
      nEnd = nPartCount - 1;
      }

   //looking for the NEXT part (forward)
   if (nNext == HSS_NEXT)
      {
      //current item is last item in the list or beyond
      if (nCurrent >= nEnd)
         {
         //so, we wrap back to the first in the list
         nCurrent = nStart;

         //changed position, check for ranged values
         nMinMax = HSS_ArmourGetRangeMinOrMax(nCurrent, nPartType,
                                             HSS_ARMOUR_PART_EXCLUSION, nNext);
         if (nMinMax != -1)
            {
            nCurrent = nMinMax + 1;
            }

         //check to see if the beginning part is excluded, if so...
         //iterate until we find the next part that is not excluded
         while (HSS_ArmourIsExcludedPiece(nCurrent, nPartType,
               HSS_ARMOUR_PART_EXCLUSION))
               {
               nCurrent++;
               }

         //we have the next non-excluded part
         nReturn = nCurrent;
         }
         //current item is less than the last item in the list
         else
         {
         //store our start position
         nCount = nCurrent;

         //nCurrent is not the last part, so increase by one
         nCurrent = nCurrent + 1;

         //changed position, check for ranged values
         nMinMax = HSS_ArmourGetRangeMinOrMax(nCurrent, nPartType,
                                             HSS_ARMOUR_PART_EXCLUSION, nNext);
         if (nMinMax != -1)
            {
            nCurrent = nMinMax + 1;
            }

         //did we just now go too far?
         if (nCurrent > nEnd)
            {
            nCurrent = nStart;
            //we did the wrap around, check for ranges
            nMinMax = HSS_ArmourGetRangeMinOrMax(nCurrent, nPartType,
                                                HSS_ARMOUR_PART_EXCLUSION, nNext);
            if (nMinMax != -1)
               {
               nCurrent = nMinMax + 1;
               }
            }

         //nCurrent is now our next choice, but is it excluded?
         //find the next non-excluded piece
         while (HSS_ArmourIsExcludedPiece(nCurrent, nPartType,
               HSS_ARMOUR_PART_EXCLUSION) && nCurrent < nEnd)
               {
               nCurrent++;
               }

         //hit the end of the line, so wrap back
         //our next excluded piece is from the beginning
         if (nCurrent >= nEnd && HSS_ArmourIsExcludedPiece(nCurrent, nPartType,
            HSS_ARMOUR_PART_EXCLUSION))
            {
            //so, we wrap back to the first in the list
            nCurrent = nStart;

            //changed position, check for ranged values
            nMinMax = HSS_ArmourGetRangeMinOrMax(nCurrent, nPartType,
                                             HSS_ARMOUR_PART_EXCLUSION, nNext);
            if (nMinMax != -1)
               {
               nCurrent = nMinMax + 1;
               }

               //check to see if the beginning part is excluded, if so...
               //iterate until we find the next part that is not excluded
               while (HSS_ArmourIsExcludedPiece(nCurrent, nPartType,
                     HSS_ARMOUR_PART_EXCLUSION))
                   {
                   nCurrent++;
                   }

            //we have the next non-excluded part
            nReturn = nCurrent;
            }
            else
            {
            //we have the next non-excluded part
            nReturn = nCurrent;
            }
         }
      }
      else
      if (nNext == HSS_PREV)
         {
         //current item is first item in the list
         if (nCurrent == nStart)
            {
            //so, we wrap back to the last in the list
            nCurrent = nEnd;

            //check for ranged values
            nMinMax = HSS_ArmourGetRangeMinOrMax(nCurrent, nPartType,
                                             HSS_ARMOUR_PART_EXCLUSION, nNext);
            if (nMinMax != -1)
               {
               nCurrent = nMinMax - 1;
               }

               //check to see if the end part is excluded, if so...
               //iterate until we find the next part that is not excluded
               while (HSS_ArmourIsExcludedPiece(nCurrent, nPartType,
                     HSS_ARMOUR_PART_EXCLUSION))
                   {
                   nCurrent--;
                   }

            //we have the next non-excluded part
            nReturn = nCurrent;
            }
            else
            {
            //store our start position
            nCount = nCurrent;

            //nCurrent is not the first part, so decrease by one
            nCurrent = nCurrent - 1;

            //check for ranged values
            nMinMax = HSS_ArmourGetRangeMinOrMax(nCurrent, nPartType,
                                             HSS_ARMOUR_PART_EXCLUSION, nNext);
            if (nMinMax != -1)
               {
               nCurrent = nMinMax - 1;
               }

            //did we just now go too far?
            if (nCurrent < 0)
               {
               nCurrent = nEnd - 1;
               //we did the wrap around, check for ranges
               nMinMax = HSS_ArmourGetRangeMinOrMax(nCurrent, nPartType,
                                                HSS_ARMOUR_PART_EXCLUSION, nNext);
               if (nMinMax != -1)
                  {
                  nCurrent = nMinMax - 1;
                  }
               }

               //nCurrent is now our next choice, but is it excluded?
               //find the next non-excluded piece
               while (HSS_ArmourIsExcludedPiece(nCurrent, nPartType,
                     HSS_ARMOUR_PART_EXCLUSION) && nCurrent > nStart)
                   {
                   nCurrent--;
                   }

               //hit the end of the line, so wrap back
               //our next excluded piece is from the end
               if (nCurrent <= nStart && HSS_ArmourIsExcludedPiece(nCurrent, nPartType,
                  HSS_ARMOUR_PART_EXCLUSION))
                  {
                  //so, we wrap back to the last in the list
                  nCurrent = nEnd;

                  //check for ranged values
                  nMinMax = HSS_ArmourGetRangeMinOrMax(nCurrent, nPartType,
                                             HSS_ARMOUR_PART_EXCLUSION, nNext);
                  if (nMinMax != -1)
                     {
                     nCurrent = nMinMax - 1;
                     }

                  //check to see if the beginning part is excluded, if so...
                  //iterate until we find the next part that is not excluded
                  while (HSS_ArmourIsExcludedPiece(nCurrent, nPartType,
                        HSS_ARMOUR_PART_EXCLUSION))
                      {
                      nCurrent--;
                      }

                  //we have the next non-excluded part
                  nReturn = nCurrent;
                  }
                  else
                  {
                  //we have the next non-excluded part
                  nReturn = nCurrent;
                  }
            }
         }


   return nReturn;
}

int HSS_ArmourGetChestACFromCache(int nPart, string sCache)
{
   int nResult;
   string sPart = IntToString(nPart);
   int nCount;
   string sResult;
   int nLength;

   //loop through the ac range blocks looking for our part
   //number.  This gives the base AC value of the part.
   while (nCount < 9)
       {
       sResult = HSS_ArmourFindSeperatedString("AC" + IntToString(nCount),
                       sCache, HSS_NEXT, "*");

       //trim the end 3 char's (AC+int)
       nLength = GetStringLength(sResult);
       sResult = GetStringLeft(sResult, nLength - 3);

       if (TestStringAgainstPattern("**" + "_" + sPart + "_" + "**", sResult))
          {
          nResult = nCount;
          return nResult;
          }

       nCount++;
       }

   return nResult;

}

int HSS_ArmourGetSeperatedStringsCount(string sString, string sSeperator = "_")
{
   string sResult;
   string sTemp;
   int nLength = GetStringLength(sString);
   int nSepLength = GetStringLength(sSeperator);
   int nChars;
   int nSubLength;
   int nReturn;

   //trim left end cap seperators if present
   if (GetStringLeft(sString, nSepLength) == sSeperator)
      {
      sString = GetStringRight(sString, nLength - nSepLength);
      nLength = GetStringLength(sString);
      }

   //trim right end cap seperators if present
   if (GetStringRight(sString, nSepLength) == sSeperator)
      {
      sString = GetStringLeft(sString, nLength - nSepLength);
      nLength = GetStringLength(sString);
      }

   //make sure there is at least one seperator -- if not exit and return 0
   if (HSS_ArmourFindSeperatedString("", sString, HSS_PREV, sSeperator) == "")
      {
      return nReturn;
      }

   //iterate our strings
   while (nLength > 0)
       {
       //find the first PREV seperated string
       sResult = HSS_ArmourFindSeperatedString("", sString, HSS_PREV, sSeperator);

       //there is a PREV seperated string
       if (sResult != "")
          {
          nSubLength = GetStringLength(sResult);
          nChars = (nLength - nSubLength) - nSepLength;

          //count the seperated string
          nReturn++;

          //subtract our seperated string from sString, it has now been counted
          sString = GetStringRight(sString, nChars);
          }
          //no more seperators left but we still have a string portion, so
          //it's our last seperated string -- count it and finish
          else
          if (sString != "")
          {
          nReturn++;
          break;
          }
          //safety net -- no more seperated strings -- make sure we stop now
          else
          {
          break;
          }
       //set our new iteration count for our newly chopped string
       nLength = GetStringLength(sString);
       }

   return nReturn;
}

void HSS_ArmourDoInscription(int nNameType, object oPC, int nProvenance = HSS_PROVENANCE, string sColour = HSS_INSCRIPTION_COLOUR, object oArmourer = OBJECT_SELF)
{
   string sName = GetName(oPC);
   string sFirst = HSS_ArmourFindSeperatedString("", sName, HSS_PREV, " ");
   string sLast = HSS_ArmourFindSeperatedString("", sName, HSS_NEXT, " ");
   float fCost = GetLocalFloat(OBJECT_SELF, HSS_PREFX + "ARMOUR_INSCRIBE_COST_X");
   int nValue = GetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_VALUE");
   fCost = IntToFloat(nValue) * fCost;
   int nGender = GetLocalInt(oArmourer, HSS_PREFX + "CUSTOMER_GENDER");
   int nType = GetLocalInt(oArmourer, HSS_PREFX + "ARMOUR_ITEM_TYPE");
   int nSlot;
   object oDummy;
   object oNew;
   string sProv;
   int nCost;

   if (nGender == 2)
      {
      oDummy = GetNearestObjectByTag(HSS_PREFX + "ARMOUR_DUMMY_F");
      }
      else
      {
      oDummy = GetNearestObjectByTag(HSS_PREFX + "ARMOUR_DUMMY_M");
      }

   switch (nType)
   {
   case HSS_TYPE_ARMOUR:
        nSlot = INVENTORY_SLOT_CHEST;
        break;
   case HSS_TYPE_HELM:
        nSlot = INVENTORY_SLOT_HEAD;
        break;
   case HSS_TYPE_WEAPON:
        nSlot = INVENTORY_SLOT_RIGHTHAND;
        break;
   case HSS_TYPE_SHIELD:
        nSlot = INVENTORY_SLOT_LEFTHAND;
        break;
   }

   object oItem = GetItemInSlot(nSlot, oDummy);

   string sItemName = GetName(oItem, TRUE);

   switch (nNameType)
   {
   case 1:
        sName = sName;
        break;
   case 2:
        sName = sFirst;
        break;
   case 3:
        sName = sLast;
        break;
   case 4:
        sName = GetStringUpperCase(GetStringLeft(sFirst, 1) +
                "." + GetStringLeft(sLast, 1) + ".");
        break;
   }

   SetName(oItem, sItemName + ", " + sColour + "~" + sName + "~" + "</c>");

   //we need to run the copy routine in order for the
   //ActionExamine() to show the new name...not sure why.
   oNew = CopyItem(oItem, oDummy, TRUE);
   AssignCommand(oDummy, ActionEquipItem(oNew, nSlot));
   DestroyObject(oItem);

   if (nProvenance)
      {
      sProv = GetLocalString(oNew, HSS_PREFX + "ARMOUR_PROV");

      if (sProv == "")
         {
         SetLocalString(oNew, HSS_PREFX + "ARMOUR_PROV", "_" + sName + "_");
         }
         else
         {
         SetLocalString(oNew, HSS_PREFX + "ARMOUR_PROV", sProv + sName + "_");
         }

      }

   nCost = FloatToInt(fCost);

   if (nCost < HSS_ARMOUR_MIN_COST)
      {
      SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_COST", HSS_ARMOUR_MIN_COST);
      }
      else
      {
      SetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_COST", nCost);
      }

   DelayCommand(2.0, SpeakString("*displays a sample inscription*"));
   DelayCommand(3.5, AssignCommand(oPC, ActionExamine(oNew)));

}

int HSS_ArmourLostAndFound(object oPC = OBJECT_INVALID)
{
   string sPCID = GetLocalString(OBJECT_SELF, HSS_PREFX + "ARMOUR_CUSTOMER_ID");
   object oContainer = GetNearestObjectByTag(HSS_PREFX + "ARMOUR_CONTAINER");
   object oItem = GetFirstItemInInventory(oContainer);
   int nReturn;

   //storing an abandoned object
   if (!GetIsObjectValid(oPC))
      {

      if (GetLocalInt(OBJECT_SELF, HSS_PREFX + "ARMOUR_PLOT_FLAG"))
         {
         SetPlotFlag(oItem, TRUE);
         }
      //do some record keeping so admins can double check there is no
      //item duplication happening.  Should be unlikely, but there is no
      //100% certainty when dealing with PC crashes, server crashes etc.
      WriteTimestampedLogEntry("HSS_ARMOUR_DESIGNER: Stored abandoned " +
      "object: " + GetName(oItem) + " for PC: " + sPCID + ".");

      //inform any DM's as well.
      SendMessageToAllDMs("HSS_ARMOUR_DESIGNER: Stored abandoned " +
      "object: " + GetName(oItem) + " for PC: " + sPCID + ".");

      nReturn = StoreCampaignObject(HSS_ARMOUR_DB, sPCID, oItem);
      return nReturn;
      }
      //looking for an abandoned object
      else
      {
      sPCID = GetPCPlayerName(oPC) + "_" + GetName(oPC);
      oItem = RetrieveCampaignObject(HSS_ARMOUR_DB, sPCID,
              GetLocation(oPC), oPC);

      if (GetIsObjectValid(oItem))
         {
         //do some record keeping so admins can double check there is no
         //item duplication happening.  Should be unlikely, but there is no
         //100% certainty when dealing with PC crashes, server crashes etc.
         WriteTimestampedLogEntry("HSS_ARMOUR_DESIGNER: Retrieved abandoned " +
         "object: " + GetName(oItem) + " for PC: " + sPCID + ".");

         //inform any DM's as well.
         SendMessageToAllDMs("HSS_ARMOUR_DESIGNER: Retrieved abandoned " +
         "object: " + GetName(oItem) + " for PC: " + sPCID + ".");

         //remove the DB entry
         DeleteCampaignVariable(HSS_ARMOUR_DB, sPCID);
         nReturn = 1;
         }
         else
         {
         nReturn = 0;
         }
      }

   return nReturn;
}

int HSS_ArmourIsExcludedPiece(int nPart, int nPartType, string sExclusion)
{
   int nReturn;
   string sPartType = IntToString(nPartType);
   string sPart = "_" + IntToString(nPart) + "_";
   string sBlock;

   if (nPartType == 7)
      {
      if (FindSubString(sExclusion, sPart) != -1)
         {
         nReturn = 1;
         }
      }
      else
      {
      sBlock = HSS_ArmourFindSeperatedString("Part" + sPartType, sExclusion,
               HSS_NEXT, "*");

      if (FindSubString(sBlock, sPart) != -1)
         {
         nReturn = 1;
         }
      }

   return nReturn;
}

int HSS_ArmourGetRangeMinOrMax(int nPart, int nPartType, string sExclusion, int nNext)
{
   int nReturn = -1;
   int nMax;
   int nMin;
   string sTemp;
   string sPartType = IntToString(nPartType);
   string sBlock = HSS_ArmourFindSeperatedString("Part" + sPartType, sExclusion,
                   HSS_NEXT, "*");

   while (HSS_ArmourFindSeperatedString(sTemp, sBlock, HSS_NEXT, "|") != "")
         {
         sTemp = HSS_ArmourFindSeperatedString(sTemp, sBlock, HSS_NEXT, "|");
         nMax = StringToInt(HSS_ArmourFindSeperatedString("", sTemp, HSS_NEXT, "-"));
         nMin = StringToInt(HSS_ArmourFindSeperatedString("", sTemp, HSS_PREV, "-"));

         if (nPart <= nMax && nPart >= nMin)
            {
            if (nNext == HSS_NEXT)
               {
               nReturn = nMax;
               return nReturn;
               }
               else
               if (nNext == HSS_PREV)
               {
               nReturn = nMin;
               return nReturn;
               }
            }

         sTemp = sTemp + "|";
         }

   return nReturn;

}

int HSS_ArmourIsWeapon(int nBase)
{
   int nReturn;

   switch (nBase)
   {
   case BASE_ITEM_BASTARDSWORD:
   case BASE_ITEM_BATTLEAXE:
   case BASE_ITEM_DAGGER:
   case BASE_ITEM_DIREMACE:
   case BASE_ITEM_DOUBLEAXE:
   case BASE_ITEM_DWARVENWARAXE:
   case BASE_ITEM_GREATAXE:
   case BASE_ITEM_GREATSWORD:
   case BASE_ITEM_HALBERD:
   case BASE_ITEM_HANDAXE:
   case BASE_ITEM_HEAVYCROSSBOW:
   case BASE_ITEM_HEAVYFLAIL:
   case BASE_ITEM_KAMA:
   case BASE_ITEM_KATANA:
   case BASE_ITEM_KUKRI:
   case BASE_ITEM_LIGHTCROSSBOW:
   case BASE_ITEM_LIGHTFLAIL:
   case BASE_ITEM_LIGHTHAMMER:
   case BASE_ITEM_LIGHTMACE:
   case BASE_ITEM_LONGBOW:
   case BASE_ITEM_LONGSWORD:
   case BASE_ITEM_MORNINGSTAR:
   case BASE_ITEM_QUARTERSTAFF:
   case BASE_ITEM_RAPIER:
   case BASE_ITEM_SCIMITAR:
   case BASE_ITEM_SCYTHE:
   case BASE_ITEM_SHORTBOW:
   case BASE_ITEM_SHORTSPEAR:
   case BASE_ITEM_SHORTSWORD:
   case BASE_ITEM_SICKLE:
   case BASE_ITEM_SLING:
   case BASE_ITEM_TRIDENT:
   case BASE_ITEM_TWOBLADEDSWORD:
   case BASE_ITEM_WARHAMMER:
   case BASE_ITEM_WHIP:
        nReturn = 1;
   }

   return nReturn;
}

int HSS_ArmourIsShield(int nBase)
{
   int nReturn;

   switch (nBase)
   {
   case BASE_ITEM_LARGESHIELD:
   case BASE_ITEM_SMALLSHIELD:
   case BASE_ITEM_TOWERSHIELD:
        nReturn = 1;
   }

   return nReturn;
}

void HSS_ArmourDummyEquipItem(object oDummy, object oItem, int nSlot, object oArmourer = OBJECT_SELF, float fDelay = 0.0)
{

   if (GetLocalInt(oArmourer, HSS_PREFX + "ARMOUR_PART_TYPE") == 19)
      {
      //disable changes -- prevents quick succesive changes
      //need time to run the copy routine on the dummy
      SetListenPattern(oArmourer, "", 1389);

      DelayCommand(fDelay, AssignCommand(oDummy, ActionEquipItem(oItem, nSlot)));
      DelayCommand(fDelay + 0.1, ExecuteScript("hss_astand_spwn", oDummy));
      //restore listening to enable changes again
      DelayCommand(fDelay + 3.0, SetListenPattern(oArmourer, "**(dalsi|zpet)**", 1389));
      }
      else
      {
      DelayCommand(fDelay, AssignCommand(oDummy, ActionEquipItem(oItem, nSlot)));
      }
}

void HSS_ArmourReportItemProvenance(object oArmourer = OBJECT_SELF)
{
   int nGender = GetLocalInt(oArmourer, HSS_PREFX + "CUSTOMER_GENDER");
   int nType = GetLocalInt(oArmourer, HSS_PREFX + "ARMOUR_ITEM_TYPE");
   string sPYes = GetLocalString(oArmourer, HSS_PREFX + "ARMOUR_PROV_YES");
   string sPNo = GetLocalString(oArmourer, HSS_PREFX + "ARMOUR_PROV_NO");
   string sProv;
   string sMsg;
   string sTemp;
   object oDummy;
   int nSlot;

   if (nGender == 2)
      {
      oDummy = GetNearestObjectByTag(HSS_PREFX + "ARMOUR_DUMMY_F");
      }
      else
      {
      oDummy = GetNearestObjectByTag(HSS_PREFX + "ARMOUR_DUMMY_M");
      }

   switch (nType)
   {
   case HSS_TYPE_ARMOUR:
        nSlot = INVENTORY_SLOT_CHEST;
        break;
   case HSS_TYPE_HELM:
        nSlot = INVENTORY_SLOT_HEAD;
        break;
   case HSS_TYPE_WEAPON:
        nSlot = INVENTORY_SLOT_RIGHTHAND;
        break;
   case HSS_TYPE_SHIELD:
        nSlot = INVENTORY_SLOT_LEFTHAND;
        break;
   }

   object oItem = GetItemInSlot(nSlot, oDummy);

   sProv = GetLocalString(oItem, HSS_PREFX + "ARMOUR_PROV");

   if (sProv == "")
      {
      AssignCommand(oArmourer, SpeakString(sPNo));
      return;
      }

   sTemp = HSS_ArmourFindSeperatedString(sTemp, sProv);

   while (sTemp != "")
   {

   if (sMsg == "")
      {
      sMsg = sTemp  + ".";
      }
      else
      {
      sMsg = sMsg + ".." + sTemp + ".";
      }

   sTemp = HSS_ArmourFindSeperatedString(sTemp, sProv);
   }

   AssignCommand(oArmourer,
                SpeakString(sPYes + sMsg));

}

void HSS_ArmourItemExclusionCheck(object oItem, object oArmourer)
{
   string sTag = GetStringLowerCase(GetTag(oItem));
   string sExcl = GetStringLowerCase(HSS_ITEM_EXCLUDED);

   if (FindSubString(sExcl, sTag) != -1)
      {
      SetLocalInt(oArmourer, HSS_PREFX + "ARMOUR_ITEM_IS_EXCLUDED", 1);
      }
}

