#include "sh_chat_colors"
#include "sh_classes_inc_e"

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

void LanguageSpeech(object oSpeaker, object oSoul, string sSpoken, int iVolume)
{
    if (TALKVOLUME_TALK!=iVolume && TALKVOLUME_WHISPER!=iVolume)
    {
        return;
    }
    //it and emote or function so end it.
    int iLanguageSpeaker = GetLocalInt(oSoul,"Language");
    string sLanguageleft =GetStringLeft(sSpoken,1);
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
                SendMessageToPC(oTarget,GetName(oSpeaker)+sLangSpeak+sSpoken);
                SetPCChatMessage("");
            }
            if(oTarget == oSpeaker)
            {
                AssignCommand(oTarget,SpeakString(TranslateCommonToLanguage(iLanguageSpeaker,sSpoken), iVolume));
            }
            iHear=0;
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSpeakDistance, GetLocation(oSpeaker), FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_INVALID);
        }
    }
}

void TargetSpeak(object oSpeaker, object oSoul, string sSpoken, int iVolume)
{
    object oTargetspeak = GetLocalObject(oSpeaker, "dmfi_Lang_target");
    int iLanguageSpeaker = GetLocalInt(oSoul,"Language");
    if(iLanguageSpeaker==0)
    {
        AssignCommand(oTargetspeak,SpeakString(sSpoken, iVolume));
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
                SendMessageToPC(oTarget,ColorTextRGB(9,8,15)+GetName(oTargetspeak,FALSE)+ColorTextRGB(15,1,1)+sLangSpeak+ColorTextRGB()+sSpoken);
                SetPCChatMessage("");
            }
            if(oTarget == oSpeaker)
            {
                AssignCommand(oTargetspeak,SpeakString(TranslateCommonToLanguage(iLanguageSpeaker,sSpoken), iVolume));
            }
            iHear=0;
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSpeakDistance, GetLocation(oSpeaker), FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_INVALID);
        }
    }
}





void LanguageSet(object oSpeaker, object oSoul, string sSpoken)
{
    string sHenchFam =GetStringLeft(sSpoken,3);
    int iLength =GetStringLength(sSpoken);
    string sHenchFamR =GetStringRight(sSpoken,iLength-4);
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

    int iLanguage = TestStringAgainstPattern("**/l**",sSpoken);
    if(iLanguage==TRUE)
    {
    string sRright = GetStringRight(sSpoken,iLength-2);
    int iNumber =StringToInt(sRright);

    if(iNumber == 0 && iL_COMMON == 1)
    {
    SetLocalInt(oSoul,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking COMMON now.");
    SetPCChatMessage("");
    }
    if(iNumber == 1 && iL_ABYSSAL == 1)
    {
    SetLocalInt(oSoul,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Abyssal now.");
    SetPCChatMessage("");
    }
    if(iNumber == 2 && iL_AQUAN == 1)
    {
    SetLocalInt(oSoul,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Aquan now.");
    SetPCChatMessage("");
    }
    if(iNumber == 3 && iL_AURAN == 1)
    {
    SetLocalInt(oSoul,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Auran now.");
    SetPCChatMessage("");
    }
    if(iNumber == 4 && iL_CELESTIAL == 1)
    {
    SetLocalInt(oSoul,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Celestial now.");
    SetPCChatMessage("");
    }
    if(iNumber == 5 && iL_DRACONIC == 1)
    {
    SetLocalInt(oSoul,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Draconic now.");
    SetPCChatMessage("");
    }
    if(iNumber == 6 && iL_DRUIDIC == 1)
    {
    SetLocalInt(oSoul,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Druidic now.");
    SetPCChatMessage("");
    }
    if(iNumber == 7 && iL_DWARVEN == 1)
    {
    SetLocalInt(oSoul,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Dwarven now.");
    SetPCChatMessage("");
    }
    if(iNumber == 8 && iL_ELVEN == 1)
    {
    SetLocalInt(oSoul,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Elven now.");
    SetPCChatMessage("");
    }
    if(iNumber == 9 && iL_GIANT == 1)
    {
    SetLocalInt(oSoul,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Giant now.");
    SetPCChatMessage("");
    }
    if(iNumber == 10 && iL_GNOME == 1)
    {
    SetLocalInt(oSoul,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Gnome now.");
    SetPCChatMessage("");
    }
    if(iNumber == 11 && iL_GOBLIN == 1)
    {
    SetLocalInt(oSoul,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Goblin now.");
    SetPCChatMessage("");
    }
    if(iNumber == 12 && iL_GNOLL == 1)
    {
    SetLocalInt(oSoul,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Gnoll now.");
    SetPCChatMessage("");
    }
    if(iNumber == 13 && iL_HALFLING == 1)
    {
    SetLocalInt(oSoul,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Halfling now.");
    SetPCChatMessage("");
    }
    if(iNumber == 14 && iL_IGNAN == 1)
    {
    SetLocalInt(oSoul,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Ignan now.");
    SetPCChatMessage("");
    }
    if(iNumber == 15 && iL_INFERNAL == 1)
    {
    SetLocalInt(oSoul,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Infernal now.");
    SetPCChatMessage("");
    }
    if(iNumber == 16 && iL_ORC == 1)
    {
    SetLocalInt(oSoul,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Orc now.");
    SetPCChatMessage("");
    }
    if(iNumber == 17 && iL_SYLVAN == 1)
    {
    SetLocalInt(oSoul,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Sylvan now.");
    SetPCChatMessage("");
    }
    if(iNumber == 18 && iL_TERRAN == 1)
    {
    SetLocalInt(oSoul,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Terran now.");
    SetPCChatMessage("");
    }
    if(iNumber == 19 && iL_UNDERCOMMON == 1)
    {
    SetLocalInt(oSoul,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Undercommon now.");
    SetPCChatMessage("");
    }
    if(iNumber == 20 && iL_PLANT == 1)
    {
    SetLocalInt(oSoul,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Plant now.");
    SetPCChatMessage("");
    }
    if(iNumber == 21 && iL_ANIMAL == 1)
    {
    SetLocalInt(oSoul,"Language",iNumber);
    SendMessageToPC(oSpeaker,"You speaking Animal now.");
    SetPCChatMessage("");
    }
    SetPCChatMessage("");
    }

}