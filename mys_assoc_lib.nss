#include "nwnx_funcs"

string GetAssociateAppearanceList(string sTagSignature)
{
    if (sTagSignature == "test") return "8,11,21,1015";
    else if (sTagSignature == "vrk") return "185,1878";
    return "";
}

// 2da index
//---------------
int GetAssociateAppearanceIndex(object oSoul, object oAssociate, int iAssociateType)
{
    return GetLocalInt(oSoul, "ASSOCIATE_APPEARANCE_INDEX" + IntToString(iAssociateType));
}

void SetAssociateAppearanceIndex(object oSoul, object oAssociate, int iAssociateType, int iIndex)
{
    if (GetIsObjectValid(oSoul) && GetIsObjectValid(oAssociate) && iAssociateType)
    {
        SetLocalInt(oSoul, "ASSOCIATE_APPEARANCE_INDEX" + IntToString(iAssociateType), iIndex);
    }    
}

// AppearanceType
//---------------
int GetAssociateAppearanceType(object oSoul, object oAssociate, int iAssociateType)
{
    return GetLocalInt(oSoul, "ASSOCIATE_APPEARANCE_TYPE" + IntToString(iAssociateType));
}

void SetAssociateAppearanceType(object oSoul, object oAssociate, int iAssociateType, int iAppearanceType)
{
    if (GetIsObjectValid(oSoul) && GetIsObjectValid(oAssociate) && iAssociateType && iAppearanceType)
    {
        SetLocalInt(oSoul, "ASSOCIATE_APPEARANCE_TYPE" + IntToString(iAssociateType), iAppearanceType);
        SetCreatureAppearanceType(oAssociate, iAppearanceType);
    }    
}

// Portrait resref
//----------------
string GetAssociatePortraitResRef(object oSoul, object oAssociate, int iAssociateType)
{
    return GetLocalString(oSoul, "ASSOCIATE_PORTRAIT_RESREF" + IntToString(iAssociateType));
}

void SetAssociatePortraitResRef(object oSoul, object oAssociate, int iAssociateType, string sPoirtraitResRef)
{
    if (GetIsObjectValid(oSoul) && GetIsObjectValid(oAssociate) && iAssociateType && sPoirtraitResRef != "")
    {
        SetLocalString(oSoul, "ASSOCIATE_PORTRAIT_RESREF" + IntToString(iAssociateType), sPoirtraitResRef);
        SetPortraitResRef(oAssociate, sPoirtraitResRef);
    }    
}

// Soundset
//---------------
int GetAssociateSoundset(object oSoul, object oAssociate, int iAssociateType)
{
    return GetLocalInt(oSoul, "ASSOCIATE_SOUNDSET" + IntToString(iAssociateType));
}

void SetAssociateSoundset(object oSoul, object oAssociate, int iAssociateType, int iSoundset)
{
    if (GetIsObjectValid(oSoul) && GetIsObjectValid(oAssociate) && iAssociateType && iSoundset)
    {
        SetLocalInt(oSoul, "ASSOCIATE_SOUNDSET" + IntToString(iAssociateType), iSoundset);
        SetSoundset(oAssociate, iSoundset);
    }    
}

// Name
//---------------
string GetAssociateName(object oSoul, object oAssociate, int iAssociateType)
{
    return GetLocalString(oSoul, "ASSOCIATE_NAME" + IntToString(iAssociateType));
}

void SetAssociateName(object oSoul, object oAssociate, int iAssociateType, string sName)
{
    if (GetIsObjectValid(oAssociate) && iAssociateType && sName != "")
    {
        SetLocalString(oSoul, "ASSOCIATE_NAME" + IntToString(iAssociateType), sName);
        SetName(oAssociate, sName);
    }
}

string GetAssociateTagSignature(string sTag)
{
    int iPosFrom = FindSubString(sTag, "_") + 1;
    int iPosTo = FindSubString(sTag, "_", iPosFrom);
    return GetSubString(sTag, iPosFrom, iPosTo - iPosFrom);    
}
