#include    "x3_inc_string"
#include    "sh_classes_inc_e"
void FollowNearestPDM(object oSelf)
{
    location lTarget =GetLocation(oSelf);
    object oPDM;
    oPDM = GetFirstObjectInShape(SHAPE_SPHERE,50.0,lTarget,FALSE,OBJECT_TYPE_CREATURE);
    while(GetIsObjectValid(oPDM))
    {
        if(GetIsDMPossessed(oPDM))
        {
            string sFname =GetName(oPDM,FALSE);
            AssignCommand(oSelf, ActionForceFollowObject(oPDM, 3.5f));
            string sNSpoke =StringReplace(sSpoke,"/","");
            SetPCChatMessage("");
            AssignCommand(oSelf,SpeakString("I am following "+sFname+" now", GetPCChatVolume()));
            return;
        }
    oPDM =GetNextObjectInShape(SHAPE_SPHERE,50.0,lTarget,FALSE,OBJECT_TYPE_CREATURE);
    }
}

location GetLocationAboveAndInFrontOf(object oPC, float fDist, float fHeight)
{
    float fDistance = -fDist;
    object oTarget = (oPC);
    object oArea = GetArea(oTarget);
    vector vPosition = GetPosition(oTarget);
    vPosition.z += fHeight;
    float fOrientation = GetFacing(oTarget);
    vector vNewPos = AngleToVector(fOrientation);
    float vZ = vPosition.z;
    float vX = vPosition.x - fDistance * vNewPos.x;
    float vY = vPosition.y - fDistance * vNewPos.y;
    fOrientation = GetFacing(oTarget);
    vX = vPosition.x - fDistance * vNewPos.x;
    vY = vPosition.y - fDistance * vNewPos.y;
    vNewPos = AngleToVector(fOrientation);
    vZ = vPosition.z;
    vNewPos = Vector(vX, vY, vZ);
    return Location(oArea, vNewPos, fOrientation);
}

void SmokePipe(object oActivator)
{
    string sEmote1 = "*puffs on a pipe*";
    string sEmote2 = "*inhales from a pipe*";
    string sEmote3 = "*pulls a mouthful of smoke from a pipe*";
    float fHeight = 1.7;
    float fDistance = 0.1;
    // Set height based on race and gender
    if (GetGender(oActivator) == GENDER_MALE)
    {
        switch (GetRacialType(oActivator))
        {
            case RACIAL_TYPE_HUMAN:
            case RACIAL_TYPE_HALFELF: fHeight = 1.7; fDistance = 0.12; break;
            case RACIAL_TYPE_ELF: fHeight = 1.55; fDistance = 0.08; break;
            case RACIAL_TYPE_GNOME:
            case RACIAL_TYPE_HALFLING: fHeight = 1.15; fDistance = 0.12; break;
            case RACIAL_TYPE_DWARF: fHeight = 1.2; fDistance = 0.12; break;
            case RACIAL_TYPE_HALFORC: fHeight = 1.9; fDistance = 0.2; break;
        }
    }
    else
    {
        // FEMALES
        switch (GetRacialType(oActivator))
        {
            case RACIAL_TYPE_HUMAN:
            case RACIAL_TYPE_HALFELF: fHeight = 1.6; fDistance = 0.12; break;
            case RACIAL_TYPE_ELF: fHeight = 1.45; fDistance = 0.12; break;
            case RACIAL_TYPE_GNOME:
            case RACIAL_TYPE_HALFLING: fHeight = 1.1; fDistance = 0.075; break;
            case RACIAL_TYPE_DWARF: fHeight = 1.2; fDistance = 0.1; break;
            case RACIAL_TYPE_HALFORC: fHeight = 1.8; fDistance = 0.13; break;
        }
    }
    location lAboveHead = GetLocationAboveAndInFrontOf(oActivator, fDistance, fHeight);
    // emotes
    //switch (d3())
    //{
        //case 1: AssignCommand(oActivator, ActionSpeakString(sEmote1)); break;
        //case 2: AssignCommand(oActivator, ActionSpeakString(sEmote2)); break;
        //case 3: AssignCommand(oActivator, ActionSpeakString(sEmote3));break;
    //}
    // glow red
    AssignCommand(oActivator, ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_RED_5), oActivator, 0.15)));
    // wait a moment
    AssignCommand(oActivator, ActionWait(3.0));
    // puff of smoke above and in front of head
    AssignCommand(oActivator, ActionDoCommand(ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), lAboveHead)));
    // if female, turn head to left
    if ((GetGender(oActivator) == GENDER_FEMALE) && (GetRacialType(oActivator) != RACIAL_TYPE_DWARF))
        AssignCommand(oActivator, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 1.0, 5.0));
}

void EmoteDance(object oPC)
{
object oRightHand = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
object oLeftHand =  GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);

AssignCommand(oPC,ActionUnequipItem(oRightHand));
AssignCommand(oPC,ActionUnequipItem(oLeftHand));

AssignCommand(oPC,ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY2,1.0));
AssignCommand(oPC,ActionDoCommand(PlayVoiceChat(VOICE_CHAT_LAUGH,oPC)));
AssignCommand(oPC,ActionPlayAnimation( ANIMATION_LOOPING_TALK_LAUGHING, 2.0, 2.0));
AssignCommand(oPC,ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY1,1.0));
AssignCommand(oPC,ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY3,2.0));
AssignCommand(oPC,ActionPlayAnimation( ANIMATION_LOOPING_GET_MID, 3.0, 1.0));
AssignCommand(oPC,ActionPlayAnimation( ANIMATION_LOOPING_TALK_FORCEFUL,1.0));
AssignCommand(oPC,ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY2,1.0));
AssignCommand(oPC,ActionDoCommand(PlayVoiceChat(VOICE_CHAT_LAUGH,oPC)));
AssignCommand(oPC,ActionPlayAnimation( ANIMATION_LOOPING_TALK_LAUGHING, 2.0, 2.0));
AssignCommand(oPC,ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY1,1.0));
AssignCommand(oPC,ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY3,2.0));
AssignCommand(oPC,ActionDoCommand(PlayVoiceChat(VOICE_CHAT_LAUGH,oPC)));
AssignCommand(oPC,ActionPlayAnimation( ANIMATION_LOOPING_GET_MID, 3.0, 1.0));
AssignCommand(oPC,ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY2,1.0));

AssignCommand(oPC,ActionDoCommand(ActionEquipItem(oLeftHand,INVENTORY_SLOT_LEFTHAND)));
AssignCommand(oPC,ActionDoCommand(ActionEquipItem(oRightHand,INVENTORY_SLOT_RIGHTHAND)));
}

void SitInNearestChair(object oPC)
{
object oSit,oRightHand,oLeftHand,oChair,oCouch,oBenchPew,oStool;
float fDistSit;int nth;
// get the closest chair, couch bench or stool
   nth = 1;oChair = GetNearestObjectByTag("Chair", oPC,nth);
   while(oChair != OBJECT_INVALID &&  GetSittingCreature(oChair) != OBJECT_INVALID)
   {nth++;oChair = GetNearestObjectByTag("Chair", oPC,nth);}

   nth = 1;oCouch = GetNearestObjectByTag("Couch", oPC,nth);
   while(oCouch != OBJECT_INVALID && GetSittingCreature(oCouch) != OBJECT_INVALID)
      {nth++;oChair = GetNearestObjectByTag("Couch", oPC,nth);}

   nth = 1;oBenchPew = GetNearestObjectByTag("BenchPew", oPC,nth);
   while(oBenchPew != OBJECT_INVALID && GetSittingCreature(oBenchPew) != OBJECT_INVALID)
      {nth++;oChair = GetNearestObjectByTag("BenchPew", oPC,nth);}
/* 1.27 bug
   nth = 1;oStool = GetNearestObjectByTag("Stool", oPC,nth);
   while(oStool != OBJECT_INVALID && GetSittingCreature(oStool) != OBJECT_INVALID)
      {nth++;oStool = GetNearestObjectByTag("Stool", oPC,nth);}
*/
// get the distance between the user and each object (-1.0 is the result if no
// object is found
float fDistanceChair = GetDistanceToObject(oChair);
float fDistanceBench = GetDistanceToObject(oBenchPew);
float fDistanceCouch = GetDistanceToObject(oCouch);
float fDistanceStool = GetDistanceToObject(oStool);

// if any of the objects are invalid (not there), change the return value
// to a high number so the distance math can work
if (fDistanceChair == -1.0)
{fDistanceChair =1000.0;}

if (fDistanceBench == -1.0)
{fDistanceBench = 1000.0;}

if (fDistanceCouch == -1.0)
{fDistanceCouch = 1000.0;}

if (fDistanceStool == -1.0)
{fDistanceStool = 1000.0;}

// find out which object is closest to the PC
if (fDistanceChair<fDistanceBench && fDistanceChair<fDistanceCouch && fDistanceChair<fDistanceStool)
{oSit=oChair;fDistSit=fDistanceChair;}
else
if (fDistanceBench<fDistanceChair && fDistanceBench<fDistanceCouch && fDistanceBench<fDistanceStool)
{oSit=oBenchPew;fDistSit=fDistanceBench;}
else
if (fDistanceCouch<fDistanceChair && fDistanceCouch<fDistanceBench && fDistanceCouch<fDistanceStool)
{oSit=oCouch;fDistSit=fDistanceCouch;}
else
//if (fDistanceStool<fDistanceChair && fDistanceStool<fDistanceBench && fDistanceStool<fDistanceCouch)
{oSit=oStool;fDistSit=fDistanceStool;}

 if(oSit !=  OBJECT_INVALID && fDistSit < 12.0)
    {
     // if no one is sitting in the object the PC is closest to, have him sit in it
     if (GetSittingCreature(oSit) == OBJECT_INVALID)
         {
           oRightHand = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
           oLeftHand =  GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
           AssignCommand(oPC,ActionMoveToObject(oSit,FALSE,2.0)); //:: Presumably this will be fixed in a patch so that Plares will not run to chair
           ActionUnequipItem(oRightHand); //:: Added to resolve clipping issues when seated
           ActionUnequipItem(oLeftHand);  //:: Added to resolve clipping issues when seated
           ActionDoCommand(AssignCommand(oPC,ActionSit(oSit)));

        }
      else
        {SendMessageToPC(oPC,"The nearest chair is already taken ");}
    }
  else
    {SendMessageToPC(oPC,"There are no chairs nearby");}
}
// Set the text after this fuction to the color you specify.
// Numbers from (0-15)
//  (1,1,1)  =  Black
//  (15,15,1):= YELLOW
//  (15,5,1) := ORANGE
//  (15,1,1) := RED
//  (7,7,15) := BLUE
//  (1,15,1) := NEON GREEN
//  (1,11,1) := GREEN
//  (9,6,1)  := BROWN
//  (11,9,11):= LIGHT PURPLE
//  (12,10,7):= TAN
//  (8,1,8)  := PURPLE
//  (13,9,13):= PLUM
//  (1,7,7)  := TEAL
//  (1,15,15):= CYAN
//  (1,1,15) := BRIGHT BLUE
//  (0,0,0) or (15,15,15) = WHITE
string ColorTextRGB(int red = 15,int green = 15,int blue = 15);

string ColorTextRGB(int red = 15,int green = 15,int blue = 15)
{
    string sColor = GetLocalString(GetModule(),"ColorSet");
    if(red > 15) red = 15; if(green > 15) green = 15; if(blue > 15) blue = 15;

    return "<c" +
    GetSubString(sColor, red - 1, 1) +
    GetSubString(sColor, green - 1, 1) +
    GetSubString(sColor, blue - 1, 1) +">";

}
string ConvertCustom(string sLetter, int iRotate)
{
    if (GetStringLength(sLetter) >= 1)
        sLetter = GetStringLeft(sLetter, 1);

    //Functional groups for custom languages
    //Vowel Sounds: a, e, i, o, u
    //Hard Sounds: b, d, k, p, t
    //Sibilant Sounds: c, f, s, q, w
    //Soft Sounds: g, h, l, r, y
    //Hummed Sounds: j, m, n, v, z
    //Oddball out: x, the rarest letter in the alphabet

    string sTranslate = "aeiouAEIOUbdkptBDKPTcfsqwCFSQWghlryGHLRYjmnvzJMNVZxX";
    int iTrans = FindSubString(sTranslate, sLetter);
    if (iTrans == -1) return sLetter; //return any character that isn't on the cipher

    //Now here's the tricky part... recalculating the offsets according functional
    //letter group, to produce an huge variety of "new" languages.

    int iOffset = iRotate % 5;
    int iGroup = iTrans / 5;
    int iBonus = iTrans / 10;
    int iMultiplier = iRotate / 5;
    iOffset = iTrans + iOffset + (iMultiplier * iBonus);

    return GetSubString(sTranslate, iGroup * 5 + iOffset % 5, 1);
}//end ConvertCustom
string ProcessCustom(string sPhrase, int iLanguage)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) >= 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertCustom(GetStringLeft(sPhrase, 1), iLanguage);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

//lang 1
string ConvertAbyssal(string sLetter)
{
    if (GetStringLength(sLetter) >= 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 27: return "N";
    case 28: return "M";
    case 29: return "G";
    case 30: return "A";
    case 31: return "K";
    case 32: return "S";
    case 33: return "D";
    case 35: return "H";
    case 36: return "B";
    case 37: return "L";
    case 38: return "P";
    case 39: return "T";
    case 40: return "E";
    case 41: return "B";
    case 43: return "N";
    case 44: return "M";
    case 45: return "G";
    case 48: return "B";
    case 51: return "T";
    case 0: return "oo";
    case 26: return "OO";
    case 1: return "n";
    case 2: return "m";
    case 3: return "g";
    case 4: return "a";
    case 5: return "k";
    case 6: return "s";
    case 7: return "d";
    case 8: return "oo";
    case 34: return "OO";
    case 9: return "h";
    case 10: return "b";
    case 11: return "l";
    case 12: return "p";
    case 13: return "t";
    case 14: return "e";
    case 15: return "b";
    case 16: return "ch";
    case 42: return "Ch";
    case 17: return "n";
    case 18: return "m";
    case 19: return "g";
    case 20: return  "ae";
    case 46: return  "Ae";
    case 21: return  "ts";
    case 47: return  "Ts";
    case 22: return "b";
    case 23: return  "bb";
    case 49: return  "Bb";
    case 24: return  "ee";
    case 50: return  "Ee";
    case 25: return "t";
    default: return sLetter;
    }
    return "";
}//end ConvertAbyssal

////////////////////////////////////////////////////////////////////////
string ProcessAbyssal(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) >= 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertAbyssal(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

//lang 4
string ConvertCelestial(string sLetter)
{
    if (GetStringLength(sLetter) >= 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "a";
    case 1: return "p";
    case 2: return "v";
    case 3: return "t";
    case 4: return "el";
    case 5: return "b";
    case 6: return "w";
    case 7: return "r";
    case 8: return "i";
    case 9: return "m";
    case 10: return "x";
    case 11: return "h";
    case 12: return "s";
    case 13: return "c";
    case 14: return "u";
    case 15: return "q";
    case 16: return "d";
    case 17: return "n";
    case 18: return "l";
    case 19: return "y";
    case 20: return "o";
    case 21: return "j";
    case 22: return "f";
    case 23: return "g";
    case 24: return "z";
    case 25: return "k";
    case 26: return "A";
    case 27: return "P";
    case 28: return "V";
    case 29: return "T";
    case 30: return "El";
    case 31: return "B";
    case 32: return "W";
    case 33: return "R";
    case 34: return "I";
    case 35: return "M";
    case 36: return "X";
    case 37: return "H";
    case 38: return "S";
    case 39: return "C";
    case 40: return "U";
    case 41: return "Q";
    case 42: return "D";
    case 43: return "N";
    case 44: return "L";
    case 45: return "Y";
    case 46: return "O";
    case 47: return "J";
    case 48: return "F";
    case 49: return "G";
    case 50: return "Z";
    case 51: return "K";
    default: return sLetter;
    }
    return "";
}//end ConvertCelestial

////////////////////////////////////////////////////////////////////////
string ProcessCelestial(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) >= 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertCelestial(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

//lang 5
string ConvertDraconic(string sLetter)
{
    if (GetStringLength(sLetter) >= 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "e";
    case 26: return "E";
    case 1: return "po";
    case 27: return "Po";
    case 2: return "st";
    case 28: return "St";
    case 3: return "ty";
    case 29: return "Ty";
    case 4: return "i";
    case 5: return "w";
    case 6: return "k";
    case 7: return "ni";
    case 33: return "Ni";
    case 8: return "un";
    case 34: return "Un";
    case 9: return "vi";
    case 35: return "Vi";
    case 10: return "go";
    case 36: return "Go";
    case 11: return "ch";
    case 37: return "Ch";
    case 12: return "li";
    case 38: return "Li";
    case 13: return "ra";
    case 39: return "Ra";
    case 14: return "y";
    case 15: return "ba";
    case 41: return "Ba";
    case 16: return "x";
    case 17: return "hu";
    case 43: return "Hu";
    case 18: return "my";
    case 44: return "My";
    case 19: return "dr";
    case 45: return "Dr";
    case 20: return "on";
    case 46: return "On";
    case 21: return "fi";
    case 47: return "Fi";
    case 22: return "zi";
    case 48: return "Zi";
    case 23: return "qu";
    case 49: return "Qu";
    case 24: return "an";
    case 50: return "An";
    case 25: return "ji";
    case 51: return "Ji";
    case 30: return "I";
    case 31: return "W";
    case 32: return "K";
    case 40: return "Y";
    case 42: return "X";
    default: return sLetter;
    }
    return "";
}//end ConvertDraconic

////////////////////////////////////////////////////////////////////////
string ProcessDraconic(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) >= 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertDraconic(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

//7
string ConvertDwarf(string sLetter)
{
    if (GetStringLength(sLetter) >= 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "az";
    case 26: return "Az";
    case 1: return "po";
    case 27: return "Po";
    case 2: return "zi";
    case 28: return "Zi";
    case 3: return "t";
    case 4: return "a";
    case 5: return "wa";
    case 31: return "Wa";
    case 6: return "k";
    case 7: return "'";
    case 8: return "a";
    case 9: return "dr";
    case 35: return "Dr";
    case 10: return "g";
    case 11: return "n";
    case 12: return "l";
    case 13: return "r";
    case 14: return "ur";
    case 40: return "Ur";
    case 15: return "rh";
    case 41: return "Rh";
    case 16: return "k";
    case 17: return "h";
    case 18: return "th";
    case 44: return "Th";
    case 19: return "k";
    case 20: return "'";
    case 21: return "g";
    case 22: return "zh";
    case 48: return "Zh";
    case 23: return "q";
    case 24: return "o";
    case 25: return "j";
    case 29: return "T";
    case 30: return "A";
    case 32: return "K";
    case 33: return "'";
    case 34: return "A";
    case 36: return "G";
    case 37: return "N";
    case 38: return "L";
    case 39: return "R";
    case 42: return "K";
    case 43: return "H";
    case 45: return "K";
    case 46: return "'";
    case 47: return "G";
    case 49: return "Q";
    case 50: return "O";
    case 51: return "J";
    default: return sLetter;
    } return "";
}//end ConvertDwarf

////////////////////////////////////////////////////////////////////////
string ProcessDwarf(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) >= 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertDwarf(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

//8
string ConvertElven(string sLetter)
{
    if (GetStringLength(sLetter) >= 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "il";
    case 26: return "Il";
    case 1: return "f";
    case 2: return "ny";
    case 28: return "Ny";
    case 3: return "w";
    case 4: return "a";
    case 5: return "o";
    case 6: return "v";
    case 7: return "ir";
    case 33: return "Ir";
    case 8: return "e";
    case 9: return "qu";
    case 35: return "Qu";
    case 10: return "n";
    case 11: return "c";
    case 12: return "s";
    case 13: return "l";
    case 14: return "e";
    case 15: return "ty";
    case 41: return "Ty";
    case 16: return "h";
    case 17: return "m";
    case 18: return "la";
    case 44: return "La";
    case 19: return "an";
    case 45: return "An";
    case 20: return "y";
    case 21: return "el";
    case 47: return "El";
    case 22: return "am";
    case 48: return "Am";
    case 23: return "'";
    case 24: return "a";
    case 25: return "j";

    case 27: return "F";
    case 29: return "W";
    case 30: return "A";
    case 31: return "O";
    case 32: return "V";
    case 34: return "E";
    case 36: return "N";
    case 37: return "C";
    case 38: return "S";
    case 39: return "L";
    case 40: return "E";
    case 42: return "H";
    case 43: return "M";
    case 46: return "Y";
    case 49: return "'";
    case 50: return "A";
    case 51: return "J";

    default: return sLetter;
    } return "";
}

////////////////////////////////////////////////////////////////////////
string ProcessElven(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) >= 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertElven(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

// Lang 10
string ConvertGnome(string sLetter)
{
    if (GetStringLength(sLetter) >= 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
//cipher based on English -> Al Baed
    case 0: return "y";
    case 1: return "p";
    case 2: return "l";
    case 3: return "t";
    case 4: return "a";
    case 5: return "v";
    case 6: return "k";
    case 7: return "r";
    case 8: return "e";
    case 9: return "z";
    case 10: return "g";
    case 11: return "m";
    case 12: return "s";
    case 13: return "h";
    case 14: return "u";
    case 15: return "b";
    case 16: return "x";
    case 17: return "n";
    case 18: return "c";
    case 19: return "d";
    case 20: return "i";
    case 21: return "j";
    case 22: return "f";
    case 23: return "q";
    case 24: return "o";
    case 25: return "w";
    case 26: return "Y";
    case 27: return "P";
    case 28: return "L";
    case 29: return "T";
    case 30: return "A";
    case 31: return "V";
    case 32: return "K";
    case 33: return "R";
    case 34: return "E";
    case 35: return "Z";
    case 36: return "G";
    case 37: return "M";
    case 38: return "S";
    case 39: return "H";
    case 40: return "U";
    case 41: return "B";
    case 42: return "X";
    case 43: return "N";
    case 44: return "C";
    case 45: return "D";
    case 46: return "I";
    case 47: return "J";
    case 48: return "F";
    case 49: return "Q";
    case 50: return "O";
    case 51: return "W";
    default: return sLetter;
    } return "";
}

////////////////////////////////////////////////////////////////////////
string ProcessGnome(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) >= 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertGnome(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

//lang 11
string ConvertGoblin(string sLetter)
{
    if (GetStringLength(sLetter) >= 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "u";
    case 1: return "p";
    case 2: return "";
    case 3: return "t";
    case 4: return "'";
    case 5: return "v";
    case 6: return "k";
    case 7: return "r";
    case 8: return "o";
    case 9: return "z";
    case 10: return "g";
    case 11: return "m";
    case 12: return "s";
    case 13: return "";
    case 14: return "u";
    case 15: return "b";
    case 16: return "";
    case 17: return "n";
    case 18: return "k";
    case 19: return "d";
    case 20: return "u";
    case 21: return "";
    case 22: return "'";
    case 23: return "";
    case 24: return "o";
    case 25: return "w";
    case 26: return "U";
    case 27: return "P";
    case 28: return "";
    case 29: return "T";
    case 30: return "'";
    case 31: return "V";
    case 32: return "K";
    case 33: return "R";
    case 34: return "O";
    case 35: return "Z";
    case 36: return "G";
    case 37: return "M";
    case 38: return "S";
    case 39: return "";
    case 40: return "U";
    case 41: return "B";
    case 42: return "";
    case 43: return "N";
    case 44: return "K";
    case 45: return "D";
    case 46: return "U";
    case 47: return "";
    case 48: return "'";
    case 49: return "";
    case 50: return "O";
    case 51: return "W";
    default: return sLetter;
    }
    return "";
}//end ConvertGoblin

////////////////////////////////////////////////////////////////////////
string ProcessGoblin(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) >= 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertGoblin(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

//Lang 13
string ConvertHalfling(string sLetter)
{
    if (GetStringLength(sLetter) >= 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
//cipher based on Al Baed -> English
    case 0: return "e";
    case 1: return "p";
    case 2: return "s";
    case 3: return "t";
    case 4: return "i";
    case 5: return "w";
    case 6: return "k";
    case 7: return "n";
    case 8: return "u";
    case 9: return "v";
    case 10: return "g";
    case 11: return "c";
    case 12: return "l";
    case 13: return "r";
    case 14: return "y";
    case 15: return "b";
    case 16: return "x";
    case 17: return "h";
    case 18: return "m";
    case 19: return "d";
    case 20: return "o";
    case 21: return "f";
    case 22: return "z";
    case 23: return "q";
    case 24: return "a";
    case 25: return "j";
    case 26: return "E";
    case 27: return "P";
    case 28: return "S";
    case 29: return "T";
    case 30: return "I";
    case 31: return "W";
    case 32: return "K";
    case 33: return "N";
    case 34: return "U";
    case 35: return "V";
    case 36: return "G";
    case 37: return "C";
    case 38: return "L";
    case 39: return "R";
    case 40: return "Y";
    case 41: return "B";
    case 42: return "X";
    case 43: return "H";
    case 44: return "M";
    case 45: return "D";
    case 46: return "O";
    case 47: return "F";
    case 48: return "Z";
    case 49: return "Q";
    case 50: return "A";
    case 51: return "J";
    default: return sLetter;
    } return "";
}

////////////////////////////////////////////////////////////////////////
string ProcessHalfling(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) >= 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertHalfling(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

// Lang 15
string ConvertInfernal(string sLetter)
{
    if (GetStringLength(sLetter) >= 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "o";
    case 1: return "c";
    case 2: return "r";
    case 3: return "j";
    case 4: return "a";
    case 5: return "v";
    case 6: return "k";
    case 7: return "r";
    case 8: return "y";
    case 9: return "z";
    case 10: return "g";
    case 11: return "m";
    case 12: return "z";
    case 13: return "r";
    case 14: return "y";
    case 15: return "k";
    case 16: return "r";
    case 17: return "n";
    case 18: return "k";
    case 19: return "d";
    case 20: return "'";
    case 21: return "r";
    case 22: return "'";
    case 23: return "k";
    case 24: return "i";
    case 25: return "g";
    case 26: return "O";
    case 27: return "C";
    case 28: return "R";
    case 29: return "J";
    case 30: return "A";
    case 31: return "V";
    case 32: return "K";
    case 33: return "R";
    case 34: return "Y";
    case 35: return "Z";
    case 36: return "G";
    case 37: return "M";
    case 38: return "Z";
    case 39: return "R";
    case 40: return "Y";
    case 41: return "K";
    case 42: return "R";
    case 43: return "N";
    case 44: return "K";
    case 45: return "D";
    case 46: return "'";
    case 47: return "R";
    case 48: return "'";
    case 49: return "K";
    case 50: return "I";
    case 51: return "G";
    default: return sLetter;
    }
    return "";
}//end ConvertInfernal

////////////////////////////////////////////////////////////////////////
string ProcessInfernal(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) >= 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertInfernal(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}


// Lang 16
string ConvertOrc(string sLetter)
{
    if (GetStringLength(sLetter) >= 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "ha";
    case 26: return "Ha";
    case 1: return "p";
    case 2: return "z";
    case 3: return "t";
    case 4: return "o";
    case 5: return "";
    case 6: return "k";
    case 7: return "r";
    case 8: return "a";
    case 9: return "m";
    case 10: return "g";
    case 11: return "h";
    case 12: return "r";
    case 13: return "k";
    case 14: return "u";
    case 15: return "b";
    case 16: return "k";
    case 17: return "h";
    case 18: return "g";
    case 19: return "n";
    case 20: return "";
    case 21: return "g";
    case 22: return "r";
    case 23: return "r";
    case 24: return "'";
    case 25: return "m";
    case 27: return "P";
    case 28: return "Z";
    case 29: return "T";
    case 30: return "O";
    case 31: return "";
    case 32: return "K";
    case 33: return "R";
    case 34: return "A";
    case 35: return "M";
    case 36: return "G";
    case 37: return "H";
    case 38: return "R";
    case 39: return "K";
    case 40: return "U";
    case 41: return "B";
    case 42: return "K";
    case 43: return "H";
    case 44: return "G";
    case 45: return "N";
    case 46: return "";
    case 47: return "G";
    case 48: return "R";
    case 49: return "R";
    case 50: return "'";
    case 51: return "M";
    default: return sLetter;
    } return "";
}

////////////////////////////////////////////////////////////////////////
string ProcessOrc(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) >= 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertOrc(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

// Lang 17
string ConvertSylvan(string sLetter)
{
    if (GetStringLength(sLetter) >= 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "i";
    case 1: return "ri";
    case 2: return "ba";
    case 3: return "ma";
    case 4: return "i";
    case 5: return "mo";
    case 6: return "yo";
    case 7: return "f";
    case 8: return "ya";
    case 9: return "ta";
    case 10: return "m";
    case 11: return "t";
    case 12: return "r";
    case 13: return "j";
    case 14: return "nu";
    case 15: return "wi";
    case 16: return "bo";
    case 17: return "w";
    case 18: return "ne";
    case 19: return "na";
    case 20: return "li";
    case 21: return "v";
    case 22: return "ni";
    case 23: return "ya";
    case 24: return "mi";
    case 25: return "og";
    case 26: return "I";
    case 27: return "Ri";
    case 28: return "Ba";
    case 29: return "Ma";
    case 30: return "I";
    case 31: return "Mo";
    case 32: return "Yo";
    case 33: return "F";
    case 34: return "Ya";
    case 35: return "Ta";
    case 36: return "M";
    case 37: return "T";
    case 38: return "R";
    case 39: return "J";
    case 40: return "Nu";
    case 41: return "Wi";
    case 42: return "Bo";
    case 43: return "W";
    case 44: return "Ne";
    case 45: return "Na";
    case 46: return "Li";
    case 47: return "V";
    case 48: return "Ni";
    case 49: return "Ya";
    case 50: return "Mi";
    case 51: return "Og";
    default: return sLetter;
    } return "";
}

////////////////////////////////////////////////////////////////////////
string ProcessSylvan(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) >= 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertSylvan(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

////////////////////////////////////////////////////////////////////////
//Lang 19
string ConvertUnderdark(string sLetter)
{
    if (GetStringLength(sLetter) >= 1)
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "il";
    case 26: return "Il";
    case 1: return "f";
    case 27: return "F";
    case 2: return "st";
    case 28: return "St";
    case 3: return "w";
    case 4: return "a";
    case 5: return "o";
    case 6: return "v";
    case 7: return "ir";
    case 33: return "Ir";
    case 8: return "e";
    case 9: return "vi";
    case 35: return "Vi";
    case 10: return "go";
    case 11: return "c";
    case 12: return "li";
    case 13: return "l";
    case 14: return "e";
    case 15: return "ty";
    case 41: return "Ty";
    case 16: return "r";
    case 17: return "m";
    case 18: return "la";
    case 44: return "La";
    case 19: return "an";
    case 45: return "An";
    case 20: return "y";
    case 21: return "el";
    case 47: return "El";
    case 22: return "ky";
    case 48: return "Ky";
    case 23: return "'";
    case 24: return "a";
    case 25: return "p'";
    case 29: return "W";
    case 30: return "A";
    case 31: return "O";
    case 32: return "V";
    case 34: return "E";
    case 36: return "Go";
    case 37: return "C";
    case 38: return "Li";
    case 39: return "L";
    case 40: return "E";
    case 42: return "R";
    case 43: return "M";
    case 46: return "Y";
    case 49: return "'";
    case 50: return "A";
    case 51: return "P'";

    default: return sLetter;
    } return "";
}

////////////////////////////////////////////////////////////////////////
string ProcessUnderdark(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase) >= 1)
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertUnderdark(GetStringLeft(sPhrase, 1));

        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

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
string TranslateCommonToLanguage(int iLang, string sText)
{
    switch (iLang)
    {
    case 1:
        return ProcessAbyssal(sText); break;
    case 2:
        return ProcessCustom(sText,2); break;
    case 3:
        return ProcessCustom(sText,3); break;
    case 4:
        return ProcessCelestial(sText); break;
    case 5:
        return ProcessDraconic(sText); break;
    case 6:
        return ProcessCustom(sText,6); break;
    case 7:
        return ProcessDwarf(sText); break;
    case 8:
        return ProcessElven(sText); break;
    case 9:
        return ProcessCustom(sText,9); break;
    case 10:
        return ProcessGnome(sText); break;
    case 11:
        return ProcessGoblin(sText); break;
    case 12:
        return ProcessCustom(sText,12); break;
    case 13:
        return ProcessHalfling(sText); break;
    case 14:
        return ProcessCustom(sText,14); break;
    case 15:
        return ProcessInfernal(sText); break;
    case 16:
        return ProcessOrc(sText); break;
    case 17:
        return ProcessSylvan(sText); break;
    case 18:
        return ProcessCustom(sText,18); break;
    case 19:
        return ProcessUnderdark(sText); break;
    case 20:
        return "Rustling of plant matter"; break;
    case 21:
        return "Animal sounds"; break;
    default: if (iLang > 100) return ProcessCustom(sText, iLang - 100);break;
    }
    return "";
}

void Languagespeech()
{
    int iVolume = GetPCChatVolume();
    if (TALKVOLUME_TALK!=iVolume && TALKVOLUME_WHISPER!=iVolume)
    {
        return;
    }
    //it and emote or function so end it.
    string sLanguageleft =GetStringLeft(sSpoke,1);
    if(sLanguageleft=="/")return;
    if(iLanguageSpeaker!= 0)
    {

        string sLangSpeak;
        if(iLanguageSpeaker == 1) sLangSpeak =" ( Askandita ): ";
        if(iLanguageSpeaker == 2) sLangSpeak =" ( Inupiaq ): ";
        if(iLanguageSpeaker == 3) sLangSpeak =" ( Lugha ): ";
        if(iLanguageSpeaker == 4) sLangSpeak =" ( Saurika ): ";
        if(iLanguageSpeaker == 5) sLangSpeak =" ( Assurayítu ): ";
        if(iLanguageSpeaker == 6) sLangSpeak =" ( Rec druidù ): ";
        if(iLanguageSpeaker == 7) sLangSpeak =" ( Khazdul ): ";
        if(iLanguageSpeaker == 8) sLangSpeak =" ( Eldalambe ): ";
        if(iLanguageSpeaker == 9) sLangSpeak =" ( Sprog ): ";
        if(iLanguageSpeaker == 10) sLangSpeak =" ( Lashon ): ";
        if(iLanguageSpeaker == 11) sLangSpeak =" ( Khuzdul ): ";
        if(iLanguageSpeaker == 12) sLangSpeak =" ( Gnoll ): ";
        if(iLanguageSpeaker == 13) sLangSpeak =" ( Halfling ): ";
        if(iLanguageSpeaker == 14) sLangSpeak =" ( Lash'rorn ): ";
        if(iLanguageSpeaker == 15) sLangSpeak =" ( Jahkress ): ";
        if(iLanguageSpeaker == 16) sLangSpeak =" ( Orctina  ): ";
        if(iLanguageSpeaker == 17) sLangSpeak =" ( Tínaiweigo ): ";
        if(iLanguageSpeaker == 18) sLangSpeak =" ( Ráksasím ): ";
        if(iLanguageSpeaker == 19) sLangSpeak =" ( Xanalress ): ";
        if(iLanguageSpeaker == 20) sLangSpeak =" ( Rostliny ): ";
        if(iLanguageSpeaker == 21) sLangSpeak =" ( Zvirata ): ";



        int iChatVol =GetPCChatVolume();
        float fSpeakDistance;
        if(iChatVol == 2)
        {
            fSpeakDistance=40.0;
        }
        if(iChatVol == 1)
        {
            fSpeakDistance=10.0;
        }
        if(iChatVol == 0)
        {
            fSpeakDistance=20.0;
        }
        object oTarget;
        //OBJECT_TYPE_INVALID is needed because DM are not recognized as creatures. weird.
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSpeakDistance, GetLocation(oSpeaker), FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_INVALID);

        while(GetIsObjectValid(oTarget))
        {

            object oLangcheck = GetSoulStone(oTarget);

            int iHear;

            int iL_COMMON = GetLocalInt(oLangcheck,"L_COMMON");
            int iL_ABYSSAL = GetLocalInt(oLangcheck,"L_ABYSSAL");
            int iL_AQUAN = GetLocalInt(oLangcheck,"L_AQUAN");
            int iL_AURAN = GetLocalInt(oLangcheck,"L_AURAN");
            int iL_CELESTIAL = GetLocalInt(oLangcheck,"L_CELESTIAL");
            int iL_DRACONIC = GetLocalInt(oLangcheck,"L_DRACONIC");
            int iL_DRUIDIC = GetLocalInt(oLangcheck,"L_DRUIDIC");
            int iL_DWARVEN = GetLocalInt(oLangcheck,"L_DWARVEN");
            int iL_ELVEN = GetLocalInt(oLangcheck,"L_ELVEN");
            int iL_GIANT = GetLocalInt(oLangcheck,"L_GIANT");
            int iL_GNOME = GetLocalInt(oLangcheck,"L_GNOME");
            int iL_GOBLIN = GetLocalInt(oLangcheck,"L_GOBLIN");
            int iL_GNOLL = GetLocalInt(oLangcheck,"L_GNOLL");
            int iL_HALFLING = GetLocalInt(oLangcheck,"L_HALFLING");
            int iL_IGNAN = GetLocalInt(oLangcheck,"L_IGNAN");
            int iL_INFERNAL = GetLocalInt(oLangcheck,"L_INFERNAL");
            int iL_ORC = GetLocalInt(oLangcheck,"L_ORC");
            int iL_SYLVAN = GetLocalInt(oLangcheck,"L_SYLVAN");
            int iL_TERRAN = GetLocalInt(oLangcheck,"TERRAN");
            int iL_UNDERCOMMON = GetLocalInt(oLangcheck,"UNDERCOMMON");
            int iL_PLANT = GetLocalInt(oLangcheck,"PLANT");
            int iL_ANIMAL = GetLocalInt(oLangcheck,"ANIMAL");

            // Do you know the language of the speaker

            if(iLanguageSpeaker == 1 && iL_ABYSSAL ==1)iHear = 1;
            if(iLanguageSpeaker == 2 && iL_AQUAN ==1)iHear = 1;
            if(iLanguageSpeaker == 3 && iL_AURAN ==1)iHear = 1;
            if(iLanguageSpeaker == 4 && iL_CELESTIAL ==1)iHear = 1;
            if(iLanguageSpeaker == 5 && iL_DRACONIC ==1)iHear = 1;
            if(iLanguageSpeaker == 6 && iL_DRUIDIC ==1)iHear = 1;
            if(iLanguageSpeaker == 7 && iL_DWARVEN ==1)iHear = 1;
            if(iLanguageSpeaker == 8 && iL_ELVEN ==1)iHear = 1;
            if(iLanguageSpeaker == 9 && iL_GIANT ==1)iHear = 1;
            if(iLanguageSpeaker == 10 && iL_GNOME ==1)iHear = 1;
            if(iLanguageSpeaker == 11 && iL_GOBLIN ==1)iHear = 1;
            if(iLanguageSpeaker == 12 && iL_GNOLL ==1)iHear = 1;
            if(iLanguageSpeaker == 13 && iL_HALFLING ==1)iHear = 1;
            if(iLanguageSpeaker == 14 && iL_IGNAN ==1)iHear = 1;
            if(iLanguageSpeaker == 15 && iL_INFERNAL ==1)iHear = 1;
            if(iLanguageSpeaker == 16 && iL_ORC ==1)iHear = 1;
            if(iLanguageSpeaker == 17 && iL_SYLVAN ==1)iHear = 1;
            if(iLanguageSpeaker == 18 && iL_TERRAN==1)iHear = 1;
            if(iLanguageSpeaker == 19 && iL_UNDERCOMMON ==1)iHear = 1;
            if(iLanguageSpeaker == 20 && iL_PLANT ==1)iHear = 1;
            if(iLanguageSpeaker == 21 && iL_ANIMAL ==1)iHear = 1;

            object oItem = GetObjectByTag("dm_tool");
            object oDMtool = GetItemPossessor(oItem);

            if(GetIsPC(oTarget) && iHear==0)
            {
               //No translation for you, you do not speak the language.
               SetPCChatMessage("");
            }
            if(GetIsPC(oTarget) && iHear==1 || GetIsDM(oTarget)||GetIsDMPossessed(oTarget)||oTarget == oDMtool)
            {
                //Translation send to you in a send message
                // SendMessageToPC(oSpeaker,"DEBUG2");
                //SendMessageToPC(oTarget,ColorTextRGB(9,8,15)+sName+ColorTextRGB(15,1,1)+sLangSpeak+ColorTextRGB()+sSpoke);
                SendMessageToPC(oTarget,sName+sLangSpeak+sSpoke);
                SetPCChatMessage("");
            }
            if(oTarget == oSpeaker)
            {
                AssignCommand(oTarget,SpeakString(TranslateCommonToLanguage(iLanguageSpeaker,sSpoke), iGetVolume));
            }
            iHear=0;
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSpeakDistance, GetLocation(oSpeaker), FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_INVALID);
        }
    }
}

void TargetSpeak(object oTargetspeak)
{
    object oTargetspeak = GetLocalObject(oSpeaker, "dmfi_Lang_target");
    if(iLanguageSpeaker==0)
    {
        AssignCommand(oTargetspeak,SpeakString(sSpoke, GetPCChatVolume()));
        return;
    }
    //everyone knows common :)
    if(iLanguageSpeaker!= 0)
    {
        string sLangSpeak;

        if(iLanguageSpeaker == 0) sLangSpeak =" ( Obecna ): ";
        if(iLanguageSpeaker == 1) sLangSpeak =" ( Askandita ): ";
        if(iLanguageSpeaker == 2) sLangSpeak =" ( Inupiaq ): ";
        if(iLanguageSpeaker == 3) sLangSpeak =" ( Lugha ): ";
        if(iLanguageSpeaker == 4) sLangSpeak =" ( Saurika ): ";
        if(iLanguageSpeaker == 5) sLangSpeak =" ( Assurayítu ): ";
        if(iLanguageSpeaker == 6) sLangSpeak =" ( Rec druidù ): ";
        if(iLanguageSpeaker == 7) sLangSpeak =" ( Khazdul ): ";
        if(iLanguageSpeaker == 8) sLangSpeak =" ( Eldalambe ): ";
        if(iLanguageSpeaker == 9) sLangSpeak =" ( Sprog ): ";
        if(iLanguageSpeaker == 10) sLangSpeak =" ( Lashon ): ";
        if(iLanguageSpeaker == 11) sLangSpeak =" ( Khuzdul ): ";
        if(iLanguageSpeaker == 12) sLangSpeak =" ( Gnoll ): ";
        if(iLanguageSpeaker == 13) sLangSpeak =" ( Halfling ): ";
        if(iLanguageSpeaker == 14) sLangSpeak =" ( Lash'rorn ): ";
        if(iLanguageSpeaker == 15) sLangSpeak =" ( Jahkress ): ";
        if(iLanguageSpeaker == 16) sLangSpeak =" ( Orctina  ): ";
        if(iLanguageSpeaker == 17) sLangSpeak =" ( Tínaiweigo ): ";
        if(iLanguageSpeaker == 18) sLangSpeak =" ( Ráksasím ): ";
        if(iLanguageSpeaker == 19) sLangSpeak =" ( Xanalress ): ";
        if(iLanguageSpeaker == 20) sLangSpeak =" ( Rostliny ): ";
        if(iLanguageSpeaker == 21) sLangSpeak =" ( Zvirata ): ";

        /*
        int    TALKVOLUME_TALK          = 0;
        int    TALKVOLUME_WHISPER       = 1;
        int    TALKVOLUME_SHOUT         = 2;
        int    TALKVOLUME_SILENT_TALK   = 3;
        int    TALKVOLUME_SILENT_SHOUT  = 4;
        int    TALKVOLUME_PARTY         = 5;
        int    TALKVOLUME_TELL          = 6;
        */

        int iChatVol =GetPCChatVolume();
        float fSpeakDistance;
        if(iChatVol == 2)
        {
            fSpeakDistance=40.0;
        }
        if(iChatVol == 1)
        {
            fSpeakDistance=10.0;
        }
        if(iChatVol == 0)
        {
            fSpeakDistance=20.0;
        }
        object oTarget;
        //OBJECT_TYPE_INVALID is needed because DM are not recognized as creatures. weird.
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSpeakDistance, GetLocation(oTargetspeak), FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_INVALID);

        while(GetIsObjectValid(oTarget))
        {

            object oLangcheck = GetSoulStone(oTarget);

            int iHear;
            int iL_ABYSSAL = GetLocalInt(oLangcheck,"L_ABYSSAL");
            int iL_AQUAN = GetLocalInt(oLangcheck,"L_AQUAN");
            int iL_AURAN = GetLocalInt(oLangcheck,"L_AURAN");
            int iL_CELESTIAL = GetLocalInt(oLangcheck,"L_CELESTIAL");
            int iL_DRACONIC = GetLocalInt(oLangcheck,"L_DRACONIC");
            int iL_DRUIDIC = GetLocalInt(oLangcheck,"L_DRUIDIC");
            int iL_DWARVEN = GetLocalInt(oLangcheck,"L_DWARVEN");
            int iL_ELVEN = GetLocalInt(oLangcheck,"L_ELVEN");
            int iL_GIANT = GetLocalInt(oLangcheck,"L_GIANT");
            int iL_GNOME = GetLocalInt(oLangcheck,"L_GNOME");
            int iL_GOBLIN = GetLocalInt(oLangcheck,"L_GOBLIN");
            int iL_GNOLL = GetLocalInt(oLangcheck,"L_GNOLL");
            int iL_HALFLING = GetLocalInt(oLangcheck,"L_HALFLING");
            int iL_IGNAN = GetLocalInt(oLangcheck,"L_IGNAN");
            int iL_INFERNAL = GetLocalInt(oLangcheck,"L_INFERNAL");
            int iL_ORC = GetLocalInt(oLangcheck,"L_ORC");
            int iL_SYLVAN = GetLocalInt(oLangcheck,"L_SYLVAN");
            int iL_TERRAN = GetLocalInt(oLangcheck,"TERRAN");
            int iL_UNDERCOMMON = GetLocalInt(oLangcheck,"UNDERCOMMON");
            int iL_PLANT = GetLocalInt(oLangcheck,"PLANT");
            int iL_ANIMAL = GetLocalInt(oLangcheck,"ANIMAL");

            // Do you know the language of the speaker

            if(iLanguageSpeaker == 1 && iL_ABYSSAL ==1)iHear = 1;
            if(iLanguageSpeaker == 2 && iL_AQUAN ==1)iHear = 1;
            if(iLanguageSpeaker == 3 && iL_AURAN ==1)iHear = 1;
            if(iLanguageSpeaker == 4 && iL_CELESTIAL ==1)iHear = 1;
            if(iLanguageSpeaker == 5 && iL_DRACONIC ==1)iHear = 1;
            if(iLanguageSpeaker == 6 && iL_DRUIDIC ==1)iHear = 1;
            if(iLanguageSpeaker == 7 && iL_DWARVEN ==1)iHear = 1;
            if(iLanguageSpeaker == 8 && iL_ELVEN ==1)iHear = 1;
            if(iLanguageSpeaker == 9 && iL_GIANT ==1)iHear = 1;
            if(iLanguageSpeaker == 10 && iL_GNOME ==1)iHear = 1;
            if(iLanguageSpeaker == 11 && iL_GOBLIN ==1)iHear = 1;
            if(iLanguageSpeaker == 12 && iL_GNOLL ==1)iHear = 1;
            if(iLanguageSpeaker == 13 && iL_HALFLING ==1)iHear = 1;
            if(iLanguageSpeaker == 14 && iL_IGNAN ==1)iHear = 1;
            if(iLanguageSpeaker == 15 && iL_INFERNAL ==1)iHear = 1;
            if(iLanguageSpeaker == 16 && iL_ORC ==1)iHear = 1;
            if(iLanguageSpeaker == 17 && iL_SYLVAN ==1)iHear = 1;
            if(iLanguageSpeaker == 18 && iL_TERRAN==1)iHear = 1;
            if(iLanguageSpeaker == 19 && iL_UNDERCOMMON ==1)iHear = 1;
            if(iLanguageSpeaker == 20 && iL_PLANT ==1)iHear = 1;
            if(iLanguageSpeaker == 21 && iL_ANIMAL ==1)iHear = 1;
            object oItem = GetObjectByTag("dm_tool");
            object oDMtool = GetItemPossessor(oItem);




            if(GetIsPC(oTarget) && iHear==0)
            {
                //No translation for you, you do not speak the language.
                SetPCChatMessage("");
            }
            if(GetIsPC(oTarget) && iHear==1 || GetIsDM(oTarget)||GetIsDMPossessed(oTarget)||oTarget == oDMtool)
            {
                //Translation send to you in a send message
                // SendMessageToPC(oSpeaker,"DEBUG2");
                SendMessageToPC(oTarget,ColorTextRGB(9,8,15)+sNameTarget+ColorTextRGB(15,1,1)+sLangSpeak+ColorTextRGB()+sSpoke);
                SetPCChatMessage("");
            }
            if(oTarget == oSpeaker)
            {
                AssignCommand(oTargetspeak,SpeakString(TranslateCommonToLanguage(iLanguageSpeaker,sSpoke), GetPCChatVolume()));
            }
            iHear=0;
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSpeakDistance, GetLocation(oSpeaker), FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_INVALID);
        }
    }
}



void DmSpeakFunction()
{
    object oItem = GetObjectByTag("dm_tool");
    object oDMtool = GetItemPossessor(oItem);
    if(oSpeaker == oDMtool)iDM =TRUE;

    if(iDMp==TRUE) iDM =TRUE;
    // give the DM the skin piece if he/she missing it
    object oCheck2 = GetSoulStone(oSpeaker);
    //if(oCheck2==OBJECT_INVALID && iDM ==TRUE) HorseAddHorseMenu(oSpeaker);

    // give the DM the skin piece if he/she missing it

    //DM String
    int iDmString = TestStringAgainstPattern("**/dms**",sSpoke);
    if(iDmString==TRUE && iDM ==TRUE)
    {
        string sDMright = GetStringRight(sSpoke,iLength-5);
        SetLocalString(oSpeaker,"DMstring",sDMright);
        SendMessageToPC(oSpeaker,"DM string set");
        SetPCChatMessage("");
    }

    //DM Interger
    int iDminteger = TestStringAgainstPattern("**/dmi**",sSpoke);
    if(iDminteger==TRUE && iDM ==TRUE)
    {
        string sDMright = GetStringRight(sSpoke,iLength-5);
        int iDmConstant =StringToInt(sDMright);
        SetLocalInt(oCarmour,"DMSetNumber",iDmConstant);
        SendMessageToPC(oSpeaker,"DM constant set");
        SetPCChatMessage("");
    }

    // DM Craft
    string sCraftcheck = GetSubString(sSpoke,5,1);
    int iDmCraftInt = TestStringAgainstPattern("**/dmci**",sSpoke);
    if(iDmCraftInt==TRUE && iDM ==TRUE && sCraftcheck != "2")
    {
        string sDMright = GetStringRight(sSpoke,iLength-6);
        int iDmCraftconstent =StringToInt(sDMright);
        SetLocalInt(oCheck,"DMCNumber",iDmCraftconstent);
        SendMessageToPC(oSpeaker,"DM Craft int set");
        //SendMessageToPC(oSpeaker,sCraftcheck);
        SetPCChatMessage("");
    }

    //DM Craft 2
    int iDmCraftInt2 = TestStringAgainstPattern("**/dmci2**",sSpoke);
    if(iDmCraftInt2==TRUE && iDM ==TRUE && sCraftcheck == "2")
    {
        string sDMright = GetStringRight(sSpoke,iLength-7);
        int iDmCraftconstent2 =StringToInt(sDMright);
        SetLocalInt(oCheck,"DMCNumber2",iDmCraftconstent2);
        SendMessageToPC(oSpeaker,"DM Craft int 2 set");
        //SendMessageToPC(oSpeaker,sCraftcheck);
        SetPCChatMessage("");
    }
}

void PCEmoteFunction()
{
//give pc PC tool if they do not already have it.
int iPCtool = TestStringAgainstPattern("**/pctool**",sSpoke);
object oPCtool = GetItemPossessedBy(oSpeaker,"cf_em_info");

//emotes
int iPCdodge = TestStringAgainstPattern("**/dodge**",sSpoke);
int iPCdrink = TestStringAgainstPattern("**/drink**",sSpoke);
int iPCduck = TestStringAgainstPattern("**/duck**",sSpoke);
int iPCFback = TestStringAgainstPattern("**/Fback**",sSpoke);
int iPCFprone = TestStringAgainstPattern("**/Fprone**",sSpoke);
int iPCread = TestStringAgainstPattern("**/read**",sSpoke);
int iPCsit = TestStringAgainstPattern("**/sit**",sSpoke);
//continuous emots
int iPCbeg = TestStringAgainstPattern("**/beg**",sSpoke);
int iPCconjure1 = TestStringAgainstPattern("**/conjure1**",sSpoke);
int iPCconjure2 = TestStringAgainstPattern("**/conjure2**",sSpoke);
int iPCgetlow = TestStringAgainstPattern("**/getlow**",sSpoke);
int iPCgetmid = TestStringAgainstPattern("**/getmid**",sSpoke);
int iPCmeditate = TestStringAgainstPattern("**/meditate**",sSpoke);
int iPCthreaten = TestStringAgainstPattern("**/threaten**",sSpoke);
int iPCworship = TestStringAgainstPattern("**/worship**",sSpoke);

int iPCdance = TestStringAgainstPattern("**/dance**",sSpoke);
int iPCdrunk = TestStringAgainstPattern("**/drunk**",sSpoke);
int iPCfollowPC = TestStringAgainstPattern("**/followpc**",sSpoke);
int iPCfollowDM = TestStringAgainstPattern("**/followdm**",sSpoke);
int iPCsitchair = TestStringAgainstPattern("**/sitchair**",sSpoke);
int iPCsitdrink = TestStringAgainstPattern("**/sitdrink**",sSpoke);
int iPCsitread = TestStringAgainstPattern("**/sitread**",sSpoke);
int iPCspasm = TestStringAgainstPattern("**/spasm**",sSpoke);
int iPCsmoke = TestStringAgainstPattern("**/smoke**",sSpoke);

//standards missed
int iPCbow = TestStringAgainstPattern("**/bow**",sSpoke);
int iPCgreet = TestStringAgainstPattern("**/greet**",sSpoke);
int iPCwaves = TestStringAgainstPattern("**/wave**",sSpoke);
int iPCbored = TestStringAgainstPattern("**/bored**",sSpoke);
int iPCscratch = TestStringAgainstPattern("**/scratch**",sSpoke);
int iPCsalute = TestStringAgainstPattern("**/salute**",sSpoke);
int iPCsteal = TestStringAgainstPattern("**/steal**",sSpoke);
int iPCtaunt = TestStringAgainstPattern("**/taunt**",sSpoke);
int iPCvic1 = TestStringAgainstPattern("**/vic1**",sSpoke);
int iPCvic2 = TestStringAgainstPattern("**/vic2**",sSpoke);
int iPCvic3 = TestStringAgainstPattern("**/vic3**",sSpoke);
int iPCnod = TestStringAgainstPattern("**/nod**",sSpoke);
int iPClookf = TestStringAgainstPattern("**/looks**",sSpoke);
int iPCtired = TestStringAgainstPattern("**/tired**",sSpoke);
int iPClaugh = TestStringAgainstPattern("**/laugh**",sSpoke);
int ibattleCry = TestStringAgainstPattern("**/battle1**",sSpoke);
int ibattleCry2 = TestStringAgainstPattern("**/battle2**",sSpoke);
int ibattleCry3 = TestStringAgainstPattern("**/battle3**",sSpoke);


float fDur = 9999.0f;

if(iPCtool==TRUE && oPCtool == OBJECT_INVALID)
{
CreateItemOnObject("cf_em_info",oSpeaker,1);
SetPCChatMessage("");
}

if(iPCtool==TRUE && oPCtool != OBJECT_INVALID)
{
DestroyObject(oPCtool,0.0);
SetPCChatMessage("");
}

if(iPCdodge==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_DODGE_SIDE, 1.0));
string sNSpoke =StringReplace(sSpoke,"/","");
SetPCChatMessage("");
}
if(iPCdrink==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_DRINK, 1.0));
string sNSpoke =StringReplace(sSpoke,"/","");
SetPCChatMessage("");
}
if(iPCduck==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_DODGE_DUCK, 1.0));
string sNSpoke =StringReplace(sSpoke,"/","");
SetPCChatMessage("");
}
if(iPCFback==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0,fDur));
string sNSpoke =StringReplace(sSpoke,"/","falls backwards");
SetPCChatMessage("");
}
if(iPCFprone==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0,fDur));
string sNSpoke =StringReplace(sSpoke,"/","falls forwards");
SetPCChatMessage("");
}
if(iPCread==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation( ANIMATION_FIREFORGET_READ,1.0));
DelayCommand(3.0f, AssignCommand(oSpeaker, PlayAnimation( ANIMATION_FIREFORGET_READ, 1.0)));
string sNSpoke =StringReplace(sSpoke,"/","");
SetPCChatMessage("");
}
if(iPCsit==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0,fDur));
string sNSpoke =StringReplace(sSpoke,"/","");
SetPCChatMessage("");
}
if(iPCbeg==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0,fDur));
string sNSpoke =StringReplace(sSpoke,"/","");
SetPCChatMessage("");
}
if(iPCconjure1==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0,fDur));
string sNSpoke =StringReplace(sSpoke,"/conjure1","Conjures");
SetPCChatMessage("");
}
if(iPCconjure2==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_CONJURE2, 1.0,fDur));
string sNSpoke =StringReplace(sSpoke,"/conjure2","Conjures");
SetPCChatMessage("");
}
if(iPCgetlow==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0,fDur));
string sNSpoke =StringReplace(sSpoke,"/getlow","Bends down");
SetPCChatMessage("");
}
if(iPCgetmid==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0,fDur));
string sNSpoke =StringReplace(sSpoke,"/getmid","manipulates");
SetPCChatMessage("");
}
if(iPCmeditate==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0,fDur));
string sNSpoke =StringReplace(sSpoke,"/","");
SetPCChatMessage("");
}
if(iPCthreaten==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0,fDur));
string sNSpoke =StringReplace(sSpoke,"/","");
SetPCChatMessage("");
}
if(iPCworship==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0,fDur));
string sNSpoke =StringReplace(sSpoke,"/","");
SetPCChatMessage("");
}
if(iPCdance==TRUE)
{
EmoteDance(oSpeaker);
string sNSpoke =StringReplace(sSpoke,"/","");
SetPCChatMessage("");
}
if(iPCdrunk==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0,fDur));
string sNSpoke =StringReplace(sSpoke,"/","");
SetPCChatMessage("");
}
if(iPCfollowPC==TRUE && GetIsPC(oSpeaker)||iPCfollowPC==TRUE && GetIsDM(oSpeaker) || iPCfollowPC==TRUE && GetIsDMPossessed(oSpeaker))
{
object oFollowing = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oSpeaker);
string sFname =GetName(oFollowing,FALSE);
AssignCommand(oSpeaker, ActionForceFollowObject(oFollowing, 3.5f));
string sNSpoke =StringReplace(sSpoke,"/","");
SetPCChatMessage("");
SendMessageToPC(oSpeaker,"You start following "+sFname+" now");
}
if(iPCsitchair==TRUE)
{
SitInNearestChair(oSpeaker);
SetPCChatMessage("");
}
if(iPCsitdrink==TRUE)
{
AssignCommand(oSpeaker, ActionPlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur)); DelayCommand(1.0f, AssignCommand(oSpeaker, PlayAnimation( ANIMATION_FIREFORGET_DRINK, 1.0))); DelayCommand(3.0f, AssignCommand(oSpeaker, PlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur)));
SetPCChatMessage("");
}
if(iPCsitread==TRUE)
{
AssignCommand(oSpeaker, ActionPlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur)); DelayCommand(1.0f, AssignCommand(oSpeaker, PlayAnimation( ANIMATION_FIREFORGET_READ, 1.0))); DelayCommand(3.0f, AssignCommand(oSpeaker, PlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur)));
SetPCChatMessage("");
}
if(iPCspasm==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation( ANIMATION_LOOPING_SPASM, 1.0, fDur));
string sNSpoke =StringReplace(sSpoke,"/","");
SetPCChatMessage("");
}
if(iPCsmoke==TRUE)
{
SmokePipe(oSpeaker);
string sNSpoke =StringReplace(sSpoke,"/","");
SetPCChatMessage("");
}

if(iPCbow==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_BOW, 1.0));
string sNSpoke =StringReplace(sSpoke,"/","");
SetPCChatMessage("");
}
if(iPCgreet==TRUE ||iPCwaves==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_GREETING, 1.0));
string sNSpoke =StringReplace(sSpoke,"/","");
SetPCChatMessage("");
}

if(iPCbored==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED, 1.0));
string sNSpoke =StringReplace(sSpoke,"/","");
SetPCChatMessage("");
}

if(iPCscratch==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 1.0));
string sNSpoke =StringReplace(sSpoke,"/","");
SetPCChatMessage("");
}
if(iPCsalute==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_SALUTE, 1.0));
string sNSpoke =StringReplace(sSpoke,"/","");
SetPCChatMessage("");
}
if(iPCsteal==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_STEAL, 1.0));
SetPCChatMessage("");
}
if(iPCtaunt==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0));
PlayVoiceChat(VOICE_CHAT_TAUNT, oSpeaker);
SetPCChatMessage("");
}

if(iPCvic1==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0));
PlayVoiceChat(VOICE_CHAT_CHEER, oSpeaker);
SetPCChatMessage("");
}
if(iPCvic2==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_VICTORY2, 1.0));
PlayVoiceChat(VOICE_CHAT_CHEER, oSpeaker);
SetPCChatMessage("");
}
if(iPCvic3==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_VICTORY3, 1.0));
PlayVoiceChat(VOICE_CHAT_CHEER, oSpeaker);
SetPCChatMessage("");
}
if(iPCnod==TRUE)
{
//it really nod animation, weird
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_LISTEN, 1.0,fDur));
string sNSpoke =StringReplace(sSpoke,"/","");
SetPCChatMessage("");
}
if(iPClookf==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0,fDur));
string sNSpoke =StringReplace(sSpoke,"/","");
SetPCChatMessage("");
}

if(iPCtired==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0,fDur));
string sNSpoke =StringReplace(sSpoke,"/","");
SetPCChatMessage("");
}
if(iPClaugh==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation( ANIMATION_LOOPING_TALK_LAUGHING, 1.0, fDur));
PlayVoiceChat(VOICE_CHAT_LAUGH, oSpeaker);
SetPCChatMessage("");
}
if(ibattleCry==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0));
PlayVoiceChat(VOICE_CHAT_BATTLECRY1, oSpeaker);
SetPCChatMessage("");
}
if(ibattleCry2==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0));
PlayVoiceChat(VOICE_CHAT_BATTLECRY2, oSpeaker);
SetPCChatMessage("");
}
if(ibattleCry3==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_VICTORY3, 1.0));
PlayVoiceChat(VOICE_CHAT_BATTLECRY3, oSpeaker);
SetPCChatMessage("");
}
int iAnimate = TestStringAgainstPattern("**/Animate**",sSpoke);
if(iAnimate==TRUE)
{
 if (GetLocalInt(oSpeaker, "dmfi_dice_no_animate")==1)
{
SetLocalInt(oSpeaker, "dmfi_dice_no_animate", 0);
 FloatingTextStringOnCreature("Rolls will show animation", oSpeaker);
 SetPCChatMessage("");
 }
else
{
SetLocalInt(oSpeaker, "dmfi_dice_no_animate", 1);
FloatingTextStringOnCreature("Rolls will NOT show animation", oSpeaker);
SetPCChatMessage("");
}
}
if(iPCfollowDM==TRUE && GetIsPC(oSpeaker))
{
FollowNearestPDM(oSpeaker);
SetPCChatMessage("");
}

if(!GetIsPC(oSpeaker) && iPCfollowDM != TRUE)
{
string sNSpoke =StringReplace(sSpoke,"/","");
AssignCommand(oSpeaker,SpeakString("* "+sNSpoke+" *", GetPCChatVolume()));
SetPCChatMessage("");
}
if(iPCfollowDM==TRUE && !GetIsPC(oSpeaker))
{
FollowNearestPDM(oSpeaker);
SetPCChatMessage("");
}
}


//setting the color of speech by volume
void ColorSet(string sChat)
{
    string sChat =GetPCChatMessage();
    if(iGetVolume==TALKVOLUME_PARTY)
    {
        SetPCChatMessage(ColorTextRGB(15,1,1)+sChat);
        SetPCChatVolume(GetPCChatVolume());
    }
    if(iGetVolume==TALKVOLUME_WHISPER)
    {
        SetPCChatMessage(ColorTextRGB(15,15,15)+sChat);
    }
}


void PCDiceFuntion()
{
    int iRandom = TestStringAgainstPattern("**/Random**",sSpoke);
    int iSTR = TestStringAgainstPattern("**/STR.**",sSpoke);
    int iDEX = TestStringAgainstPattern("**/DEX.**",sSpoke);
    int iCON = TestStringAgainstPattern("**/CON.**",sSpoke);
    int iINT = TestStringAgainstPattern("**/INT.**",sSpoke);
    int iWIS = TestStringAgainstPattern("**/WIS.**",sSpoke);
    int iCHA = TestStringAgainstPattern("**/CHA.**",sSpoke);

    int iFORTITUDE = TestStringAgainstPattern("**/FOR.**",sSpoke);
    int iREFLEX = TestStringAgainstPattern("**/REF.**",sSpoke);
    int iWILL = TestStringAgainstPattern("**/WILL.**",sSpoke);

    int iAnimalEmp = TestStringAgainstPattern("**/A.E.**",sSpoke);
    int iAppraise = TestStringAgainstPattern("**/Appraise**",sSpoke);
    int iBluff = TestStringAgainstPattern("**/Bluff**",sSpoke);
    int iConcentration = TestStringAgainstPattern("**/Concentration**",sSpoke);
    int iCArmor = TestStringAgainstPattern("**/CArmor**",sSpoke);
    int iCTrap = TestStringAgainstPattern("**/CTrap**",sSpoke);
    int iCWeapon = TestStringAgainstPattern("**/CWeapon**",sSpoke);
    int iDTrap = TestStringAgainstPattern("**/DTrap**",sSpoke);
    int iDis = TestStringAgainstPattern("**/Dis.**",sSpoke);
    int iHeal = TestStringAgainstPattern("**/Heal**",sSpoke);
    int iHide = TestStringAgainstPattern("**/Hide**",sSpoke);
    int iIntimidate = TestStringAgainstPattern("**/Intimidate**",sSpoke);
    int iListen = TestStringAgainstPattern("**/Listen**",sSpoke);
    int iLore = TestStringAgainstPattern("**/Lore**",sSpoke);
    int iMS = TestStringAgainstPattern("**/M.S.**",sSpoke);
    int iOL = TestStringAgainstPattern("**/O.L.**",sSpoke);
    int iParry = TestStringAgainstPattern("**/Parry**",sSpoke);
    int iPerform= TestStringAgainstPattern("**/Perform**",sSpoke);
    int iRide= TestStringAgainstPattern("**/Ride**",sSpoke);
    int iPersuade= TestStringAgainstPattern("**/Persuade**",sSpoke);
    int iPP= TestStringAgainstPattern("**/P.P.**",sSpoke);
    int iSearch= TestStringAgainstPattern("**/Search**",sSpoke);
    int iST= TestStringAgainstPattern("**/S.T.**",sSpoke);
    int iSpellcraft= TestStringAgainstPattern("**/Spellcraft**",sSpoke);
    int iSpot= TestStringAgainstPattern("**/Spot**",sSpoke);
    int iTaunt= TestStringAgainstPattern("**/sTaunt**",sSpoke);
    int iTumble= TestStringAgainstPattern("**/Tumble**",sSpoke);
    int iUMD= TestStringAgainstPattern("**/U.M.D.**",sSpoke);


    if(iSTR==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 61);
    string sNSpoke = StringReplace(sSpoke,"/str.","");
    string sNSpoke2 = StringReplace(sNSpoke,"/STR.","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iDEX==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 62);
    string sNSpoke = StringReplace(sSpoke,"/dex.","");
    string sNSpoke2 = StringReplace(sNSpoke,"/DEX.","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iCON==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 63);
    string sNSpoke = StringReplace(sSpoke,"/con.","");
    string sNSpoke2 = StringReplace(sNSpoke,"/CON.","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iINT==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 64);
    string sNSpoke = StringReplace(sSpoke,"/int.","");
    string sNSpoke2 = StringReplace(sNSpoke,"/INT.","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iWIS==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 65);
    string sNSpoke = StringReplace(sSpoke,"/wis.","");
    string sNSpoke2 = StringReplace(sNSpoke,"/WIS.","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iCHA==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 66);
    string sNSpoke = StringReplace(sSpoke,"/cha.","");
    string sNSpoke2 = StringReplace(sNSpoke,"/CHA.","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iFORTITUDE==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 67);
    string sNSpoke = StringReplace(sSpoke,"/for.","");
    string sNSpoke2 = StringReplace(sNSpoke,"/FOR.","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iREFLEX==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 68);
    string sNSpoke = StringReplace(sSpoke,"/ref.","");
    string sNSpoke2 = StringReplace(sNSpoke,"/REF.","");
    //SetPCChatMessage("* "+sNSpoke2+" *");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iWILL==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 69);
    string sNSpoke = StringReplace(sSpoke,"/will.","");
    string sNSpoke2 = StringReplace(sNSpoke,"/WILL.","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iAnimalEmp==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 71);
    string sNSpoke = StringReplace(sSpoke,"/a.e.","");
    string sNSpoke2 = StringReplace(sNSpoke,"/A.E.","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iAppraise==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 72);
    string sNSpoke = StringReplace(sSpoke,"/appraise","");
    string sNSpoke2 = StringReplace(sNSpoke,"/APPRAISE","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iBluff==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 73);
    string sNSpoke = StringReplace(sSpoke,"/bluff","");
    string sNSpoke2 = StringReplace(sNSpoke,"/BLUFF","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iConcentration==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 74);
    string sNSpoke = StringReplace(sSpoke,"/concentration","");
    string sNSpoke2 = StringReplace(sNSpoke,"/CONCENTRATION","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iCArmor==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 75);
    string sNSpoke = StringReplace(sSpoke,"/carmor","");
    string sNSpoke2 = StringReplace(sNSpoke,"/CARMOR","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iCTrap==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 76);
    string sNSpoke = StringReplace(sSpoke,"/ctrap","");
    string sNSpoke2 = StringReplace(sNSpoke,"/CTRAP","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iCWeapon==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 77);
    string sNSpoke = StringReplace(sSpoke,"/cweapon","");
    string sNSpoke2 = StringReplace(sNSpoke,"/CWEAPON","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iDTrap==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 78);
    string sNSpoke = StringReplace(sSpoke,"/dtrap","");
    string sNSpoke2 = StringReplace(sNSpoke,"/DTRAP","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iDis==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 79);
    string sNSpoke = StringReplace(sSpoke,"/dis.","");
    string sNSpoke2 = StringReplace(sNSpoke,"/DIS.","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iHeal==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 81);
    string sNSpoke = StringReplace(sSpoke,"/heal","");
    string sNSpoke2 = StringReplace(sNSpoke,"/HEAL","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iHide==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 82);
    string sNSpoke = StringReplace(sSpoke,"/hide","");
    string sNSpoke2 = StringReplace(sNSpoke,"/HIDE","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iIntimidate==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 83);
    string sNSpoke = StringReplace(sSpoke,"/intimidate","");
    string sNSpoke2 = StringReplace(sNSpoke,"/INTIMIDATE","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iListen==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 84);
    string sNSpoke = StringReplace(sSpoke,"/listen","");
    string sNSpoke2 = StringReplace(sNSpoke,"/LISTEN","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iLore==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 85);
    string sNSpoke = StringReplace(sSpoke,"/lore","");
    string sNSpoke2 = StringReplace(sNSpoke,"/LORE","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iMS==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 86);
    string sNSpoke = StringReplace(sSpoke,"/m.s.","");
    string sNSpoke2 = StringReplace(sNSpoke,"/M.S.","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iOL==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 87);
    string sNSpoke = StringReplace(sSpoke,"/o.l.","");
    string sNSpoke2 = StringReplace(sNSpoke,"/O.L.","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iParry==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 88);
    string sNSpoke = StringReplace(sSpoke,"/parry","");
    string sNSpoke2 = StringReplace(sNSpoke,"/PARRY","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iPerform==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 89);
    string sNSpoke = StringReplace(sSpoke,"/perform","");
    string sNSpoke2 = StringReplace(sNSpoke,"/PERFORM","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iRide==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 90);
    string sNSpoke = StringReplace(sSpoke,"/ride","");
    string sNSpoke2 = StringReplace(sNSpoke,"/RIDE","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iPersuade==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 91);
    string sNSpoke = StringReplace(sSpoke,"/persuade","");
    string sNSpoke2 = StringReplace(sNSpoke,"/PERSUADE","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iPP==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 92);
    string sNSpoke = StringReplace(sSpoke,"/p.p.","");
    string sNSpoke2 = StringReplace(sNSpoke,"/P.P.","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iSearch==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 93);
    string sNSpoke = StringReplace(sSpoke,"/search","");
    string sNSpoke2 = StringReplace(sNSpoke,"/SEARCH","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iST==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 94);
    string sNSpoke = StringReplace(sSpoke,"/s.t.","");
    string sNSpoke2 = StringReplace(sNSpoke,"/S.T.","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iSpellcraft==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 95);
    string sNSpoke = StringReplace(sSpoke,"/spellcraft","");
    string sNSpoke2 = StringReplace(sNSpoke,"/SPELLCRAFT","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iSpot==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 96);
    string sNSpoke = StringReplace(sSpoke,"/spot","");
    string sNSpoke2 = StringReplace(sNSpoke,"/SPOT","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iTaunt==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 97);
    string sNSpoke = StringReplace(sSpoke,"/staunt","");
    string sNSpoke2 = StringReplace(sNSpoke,"/STAUNT","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iTumble==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 98);
    string sNSpoke = StringReplace(sSpoke,"/tumble","");
    string sNSpoke2 = StringReplace(sNSpoke,"/TUMBLE","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iUMD==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 99);
    string sNSpoke = StringReplace(sSpoke,"/u.m.d.","");
    string sNSpoke2 = StringReplace(sNSpoke,"/U.M.D.","");
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }

/*
BCMP Broadcast Mode set to Private
BCMG Broadcast Mode set to Global
BCML Broadcast Mode set to Local
*/


int iBroadP= TestStringAgainstPattern("**/BCMP**",sSpoke);
int iBroadG= TestStringAgainstPattern("**/BCMG**",sSpoke);
int iBroadL= TestStringAgainstPattern("**/BCML**",sSpoke);

if(iBroadL==TRUE)
{
SetLocalInt(oSpeaker, "dmfi_univ_int", 101);
SetPCChatMessage("");
SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
ExecuteScript("sh_dm_execute", oSpeaker);
        return;
}
if(iBroadG==TRUE)
{
SetLocalInt(oSpeaker, "dmfi_univ_int", 102);
SetPCChatMessage("");
SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
ExecuteScript("sh_dm_execute", oSpeaker);
        return;
}
if(iBroadP==TRUE)
{
SetLocalInt(oSpeaker, "dmfi_univ_int", 103);
SetPCChatMessage("");
SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
ExecuteScript("sh_dm_execute", oSpeaker);
        return;
}




if(iRandom==TRUE)
{
string sRright = GetStringRight(sSpoke,iLength-8);
int iRandom =StringToInt(sRright);
int iTotal =Random(iRandom)+1;
string sTotal =IntToString(iTotal);
string sNew ="Random Roll from 1 - "+sRright+" = "+sTotal;
SetPCChatMessage(sNew);
ColorSet(sNew);
}

string sFirst =GetStringLeft(sSpoke,1);
int iDnumber = TestStringAgainstPattern("**d**",sSpoke);
string sSecond =GetSubString(sSpoke,1,1);
int iSecond =StringToInt(sSecond);

if(iDnumber == TRUE && sFirst == "/" && iSecond != 0)
{
//SendMessageToPC(oSpeaker,"DEBUG");

int iFind_d =FindSubString(sSpoke,"d",1);
int iFind_big_D =FindSubString(sSpoke,"D",1);
int iCount;
if(iFind_d >=1 && iFind_big_D == -1)
{
int iCount = iFind_d;
int iNCount = iCount+1;
int iLength =GetStringLength(sSpoke);
string sRightNumber = GetStringRight(sSpoke,iLength-iNCount);
string sLeftNumber =GetSubString(sSpoke,1,iCount-1);
int iLeftNumber =StringToInt(sLeftNumber);
int iRightNumber =StringToInt(sRightNumber);
int iDice;
int iValidnumber=0;
if(iRightNumber==2)iDice = d2(iLeftNumber);
if(iRightNumber==3)iDice = d3(iLeftNumber);
if(iRightNumber==4)iDice = d4(iLeftNumber);
if(iRightNumber==6)iDice = d6(iLeftNumber);
if(iRightNumber==8)iDice = d8(iLeftNumber);
if(iRightNumber==10)iDice = d10(iLeftNumber);
if(iRightNumber==12)iDice = d12(iLeftNumber);
if(iRightNumber==20)iDice = d20(iLeftNumber);
if(iRightNumber==100)iDice = d100(iLeftNumber);
if(iRightNumber != 100 && iRightNumber != 20 && iRightNumber != 12
&& iRightNumber != 10 && iRightNumber != 8 && iRightNumber != 6
&& iRightNumber != 4 && iRightNumber != 3 && iRightNumber != 2)iValidnumber=1;
string sDice =IntToString(iDice);
string sRoll ="Roll "+sLeftNumber+"d"+sRightNumber+" = "+sDice;
if(iValidnumber==1)sRoll = "Not a valid die, 2, 3, 4, 6, 8, 10, 12, 20, 100 are valid";
SetPCChatMessage(sRoll);
ColorSet(sRoll);
}
if(iFind_d ==-1 && iFind_big_D >= 1)
{
int iCount = iFind_big_D;
int iNCount = iCount+1;
int iLength =GetStringLength(sSpoke);
string sRightNumber = GetStringRight(sSpoke,iLength-iNCount);
string sLeftNumber =GetSubString(sSpoke,1,iCount-1);
int iLeftNumber =StringToInt(sLeftNumber);
int iRightNumber =StringToInt(sRightNumber);
int iDice;
int iValidnumber=0;
if(iRightNumber==2)iDice = d2(iLeftNumber);
if(iRightNumber==3)iDice = d3(iLeftNumber);
if(iRightNumber==4)iDice = d4(iLeftNumber);
if(iRightNumber==6)iDice = d6(iLeftNumber);
if(iRightNumber==8)iDice = d8(iLeftNumber);
if(iRightNumber==10)iDice = d10(iLeftNumber);
if(iRightNumber==12)iDice = d12(iLeftNumber);
if(iRightNumber==20)iDice = d20(iLeftNumber);
if(iRightNumber==100)iDice = d100(iLeftNumber);
if(iRightNumber != 100 && iRightNumber != 20 && iRightNumber != 12
&& iRightNumber != 10 && iRightNumber != 8 && iRightNumber != 6
&& iRightNumber != 4 && iRightNumber != 3 && iRightNumber != 2)iValidnumber=1;
string sDice =IntToString(iDice);
string sRoll ="Roll "+sLeftNumber+"d"+sRightNumber+" = "+sDice;
if(iValidnumber==1)sRoll = "Not a valid die, 2, 3, 4, 6, 8, 10, 12, 20, 100 are valid(Number on the right)";
SetPCChatMessage(sRoll);
ColorSet(sRoll);
}
}
}


void LanguageSet()
{
    string sHenchFam =GetStringLeft(sSpoke,3);
    int iLength =GetStringLength(sSpoke);
    string sHenchFamR =GetStringRight(sSpoke,iLength-4);
    object oHench =GetHenchman(oSpeaker,1);
    object oHench2 =GetHenchman(oSpeaker,2);
    object oAsAnimal =GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oSpeaker);
    object oAsFamilar =GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oSpeaker);



    if(sHenchFam == "/h1" ||  sHenchFam == "/H1")
    {
        AssignCommand(oHench,SpeakString(sHenchFamR));
        SetPCChatMessage("");
    }
    if(sHenchFam == "/h2" ||  sHenchFam == "/H2")
    {
        AssignCommand(oHench2,SpeakString(sHenchFamR));
        SetPCChatMessage("");
    }
    if(sHenchFam == "/f." ||  sHenchFam == "/F.")
    {
        AssignCommand(oAsFamilar,SpeakString(sHenchFamR));
        SetPCChatMessage("");
    }
    if(sHenchFam == "/a." ||  sHenchFam == "/A.")
    {
        AssignCommand(oAsAnimal,SpeakString(sHenchFamR));
        SetPCChatMessage("");
    }

    object oLangcheck = GetSoulStone(oSpeaker);
    int iL_COMMON = GetLocalInt(oLangcheck,"L_COMMON");
    int iL_ABYSSAL = GetLocalInt(oLangcheck,"L_ABYSSAL");
    int iL_AQUAN = GetLocalInt(oLangcheck,"L_AQUAN");
    int iL_AURAN = GetLocalInt(oLangcheck,"L_AURAN");
    int iL_CELESTIAL = GetLocalInt(oLangcheck,"L_CELESTIAL");
    int iL_DRACONIC = GetLocalInt(oLangcheck,"L_DRACONIC");
    int iL_DRUIDIC = GetLocalInt(oLangcheck,"L_DRUIDIC");
    int iL_DWARVEN = GetLocalInt(oLangcheck,"L_DWARVEN");
    int iL_ELVEN = GetLocalInt(oLangcheck,"L_ELVEN");
    int iL_GIANT = GetLocalInt(oLangcheck,"L_GIANT");
    int iL_GNOME = GetLocalInt(oLangcheck,"L_GNOME");
    int iL_GOBLIN = GetLocalInt(oLangcheck,"L_GOBLIN");
    int iL_GNOLL = GetLocalInt(oLangcheck,"L_GNOLL");
    int iL_HALFLING = GetLocalInt(oLangcheck,"L_HALFLING");
    int iL_IGNAN = GetLocalInt(oLangcheck,"L_IGNAN");
    int iL_INFERNAL = GetLocalInt(oLangcheck,"L_INFERNAL");
    int iL_ORC = GetLocalInt(oLangcheck,"L_ORC");
    int iL_SYLVAN = GetLocalInt(oLangcheck,"L_SYLVAN");
    int iL_TERRAN = GetLocalInt(oLangcheck,"TERRAN");
    int iL_UNDERCOMMON = GetLocalInt(oLangcheck,"UNDERCOMMON");
    int iL_PLANT = GetLocalInt(oLangcheck,"PLANT");
    int iL_ANIMAL = GetLocalInt(oLangcheck,"ANIMAL");

    int iLanguage = TestStringAgainstPattern("**/l**",sSpoke);
    if(iLanguage==TRUE)
    {
    string sRright = GetStringRight(sSpoke,iLength-2);
    int iNumber =StringToInt(sRright);

    if(iNumber == 0 && iL_COMMON == 1)
    {
    SetLocalInt(oCheck,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking COMMON now.");
    SetPCChatMessage("");
    }
    if(iNumber == 1 && iL_ABYSSAL == 1)
    {
    SetLocalInt(oCheck,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Abyssal now.");
    SetPCChatMessage("");
    }
    if(iNumber == 2 && iL_AQUAN == 1)
    {
    SetLocalInt(oCheck,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Aquan now.");
    SetPCChatMessage("");
    }
    if(iNumber == 3 && iL_AURAN == 1)
    {
    SetLocalInt(oCheck,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Auran now.");
    SetPCChatMessage("");
    }
    if(iNumber == 4 && iL_CELESTIAL == 1)
    {
    SetLocalInt(oCheck,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Celestial now.");
    SetPCChatMessage("");
    }
    if(iNumber == 5 && iL_DRACONIC == 1)
    {
    SetLocalInt(oCheck,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Draconic now.");
    SetPCChatMessage("");
    }
    if(iNumber == 6 && iL_DRUIDIC == 1)
    {
    SetLocalInt(oCheck,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Druidic now.");
    SetPCChatMessage("");
    }
    if(iNumber == 7 && iL_DWARVEN == 1)
    {
    SetLocalInt(oCheck,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Dwarven now.");
    SetPCChatMessage("");
    }
    if(iNumber == 8 && iL_ELVEN == 1)
    {
    SetLocalInt(oCheck,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Elven now.");
    SetPCChatMessage("");
    }
    if(iNumber == 9 && iL_GIANT == 1)
    {
    SetLocalInt(oCheck,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Giant now.");
    SetPCChatMessage("");
    }
    if(iNumber == 10 && iL_GNOME == 1)
    {
    SetLocalInt(oCheck,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Gnome now.");
    SetPCChatMessage("");
    }
    if(iNumber == 11 && iL_GOBLIN == 1)
    {
    SetLocalInt(oCheck,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Goblin now.");
    SetPCChatMessage("");
    }
    if(iNumber == 12 && iL_GNOLL == 1)
    {
    SetLocalInt(oCheck,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Gnoll now.");
    SetPCChatMessage("");
    }
    if(iNumber == 13 && iL_HALFLING == 1)
    {
    SetLocalInt(oCheck,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Halfling now.");
    SetPCChatMessage("");
    }
    if(iNumber == 14 && iL_IGNAN == 1)
    {
    SetLocalInt(oCheck,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Ignan now.");
    SetPCChatMessage("");
    }
    if(iNumber == 15 && iL_INFERNAL == 1)
    {
    SetLocalInt(oCheck,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Infernal now.");
    SetPCChatMessage("");
    }
    if(iNumber == 16 && iL_ORC == 1)
    {
    SetLocalInt(oCheck,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Orc now.");
    SetPCChatMessage("");
    }
    if(iNumber == 17 && iL_SYLVAN == 1)
    {
    SetLocalInt(oCheck,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Sylvan now.");
    SetPCChatMessage("");
    }
    if(iNumber == 18 && iL_TERRAN == 1)
    {
    SetLocalInt(oCheck,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Terran now.");
    SetPCChatMessage("");
    }
    if(iNumber == 19 && iL_UNDERCOMMON == 1)
    {
    SetLocalInt(oCheck,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Undercommon now.");
    SetPCChatMessage("");
    }
    if(iNumber == 20 && iL_PLANT == 1)
    {
    SetLocalInt(oCheck,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Plant now.");
    SetPCChatMessage("");
    }
    if(iNumber == 21 && iL_ANIMAL == 1)
    {
    SetLocalInt(oCheck,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Animal now.");
    SetPCChatMessage("");
    }
    SetPCChatMessage("");
    }

}
