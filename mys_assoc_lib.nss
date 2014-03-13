string GetAssociateAppearanceList(string sTagSignature)
{
    if (sTagSignature == "test") return "8,11,21,1015";
    else if (sTagSignature == "vrk") return "185,1878";
    return "";
}

int GetAssociateAppearanceType(object oSoul, object oAssociate, int iAssociateType)
{
    return GetLocalInt(oSoul, "COMPANION_APPEARANCE_TYPE" + IntToString(iAssociateType));
}

void SetAssociateAppearanceType(object oSoul, object oAssociate, int iAssociateType, int iAppearanceType)
{
    if (GetIsObjectValid(oSoul) && GetIsObjectValid(oAssociate) && iAssociateType && iAppearanceType)
    {
        SetLocalInt(oSoul, "COMPANION_APPEARANCE_TYPE" + IntToString(iAssociateType), iAppearanceType);
        SetCreatureAppearanceType(oAssociate, iAppearanceType);
    }    
}

string GetAssociateName(object oSoul, object oAssociate, int iAssociateType)
{
    return GetLocalString(oSoul, "_APPEARANCE_TYPE" + IntToString(iAssociateType));
}

void SetAssociateName(object oSoul, object oAssociate, int iAssociateType, string sName)
{
    if (GetIsObjectValid(oAssociate) && iAssociateType && sName != "")
    {
        SetLocalString(oSoul, "COMPANION_NAME" + IntToString(iAssociateType), sName);
        SetName(oAssociate, sName);
    }
}

string GetAssociateTagSignature(string sTag)
{
    int iPosFrom = FindSubString(sTag, "_") + 1;
    int iPosTo = FindSubString(sTag, "_", iPosFrom);
    return GetSubString(sTag, iPosFrom, iPosTo - iPosFrom);    
}
