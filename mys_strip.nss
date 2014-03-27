#include "nwnx_funcs"
#include "nwnx_events"

const string STRIPPED = "STRIPPED";

void StripPart(object oItem, int iPart)
{
    int iVal = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, iPart);
    if (iVal)
    {
        SetLocalInt(oItem, STRIPPED + IntToString(iPart), iVal);
        SetItemAppearance(oItem, iPart, 0);
    }
}

void EquipPart(object oItem, int iPart, int iVal)
{
    DeleteLocalInt(oItem, STRIPPED + IntToString(iPart));
    SetItemAppearance(oItem, iPart, iVal);    
}

void TogglePart(object oItem, int iPart)
{
    int iVal = GetLocalInt(oItem, STRIPPED + IntToString(iPart));
    if (iVal)
        EquipPart(oItem, iPart, iVal);
    else
        StripPart(oItem, iPart);
}

void ToggleSetPart(object oItem, string sSetName, int iPart)
{
    int bSetStripped = GetLocalInt(oItem, STRIPPED + sSetName);    
    if (bSetStripped)
    {
        int iVal = GetLocalInt(oItem, STRIPPED + IntToString(iPart));
        if (iVal)
            EquipPart(oItem, iPart, iVal);
    }
    else
        StripPart(oItem, iPart);
}

void ToggleSet(object oItem, string sSetName)
{
    int iVal = GetLocalInt(oItem, STRIPPED + sSetName);
    if (iVal)
        DeleteLocalInt(oItem, STRIPPED + sSetName);
    else
        SetLocalInt(oItem, STRIPPED + sSetName, 1);
}

void main()
{
    string sText = GetSelectedNodeText();
    object oPC = GetPCSpeaker();
    object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    object oNewArmor;
    
    //--------------------------------------------------------------------------
    // ONE PART
    //--------------------------------------------------------------------------
    
    if (sText == "róba")
        TogglePart(oArmor, ITEM_APPR_ARMOR_MODEL_ROBE);
    
    // trup
    //----------------------
    else if (sText == "krk")
        TogglePart(oArmor, ITEM_APPR_ARMOR_MODEL_NECK);
    else if (sText == "torso")
        TogglePart(oArmor, ITEM_APPR_ARMOR_MODEL_TORSO);
    else if (sText == "pas")
        TogglePart(oArmor, ITEM_APPR_ARMOR_MODEL_BELT);
    else if (sText == "pánev")
        TogglePart(oArmor, ITEM_APPR_ARMOR_MODEL_PELVIS);
    
    // pravá horní konèetina
    //----------------------
    else if (sText == "rameno pravé")
        TogglePart(oArmor, ITEM_APPR_ARMOR_MODEL_RSHOULDER);
    else if (sText == "biceps pravý")
        TogglePart(oArmor, ITEM_APPR_ARMOR_MODEL_RBICEP);
    else if (sText == "pøedloktí pravé")
        TogglePart(oArmor, ITEM_APPR_ARMOR_MODEL_RFOREARM);
    else if (sText == "dlaò pravá")
        TogglePart(oArmor, ITEM_APPR_ARMOR_MODEL_RHAND);
    
    // levá horní konèetina
    //---------------------
    else if (sText == "rameno levé")
        TogglePart(oArmor, ITEM_APPR_ARMOR_MODEL_LSHOULDER);
    else if (sText == "biceps levý")
        TogglePart(oArmor, ITEM_APPR_ARMOR_MODEL_LBICEP);    
    else if (sText == "pøedloktí levé")
        TogglePart(oArmor, ITEM_APPR_ARMOR_MODEL_LFOREARM);
    else if (sText == "dlaò levá")
        TogglePart(oArmor, ITEM_APPR_ARMOR_MODEL_LHAND);
    
    // pravá dolní konèetina
    //----------------------
    else if (sText == "stehno pravé")
        TogglePart(oArmor, ITEM_APPR_ARMOR_MODEL_RTHIGH);
    else if (sText == "holeò pravá")
        TogglePart(oArmor, ITEM_APPR_ARMOR_MODEL_RSHIN);
    else if (sText == "chodidlo pravé")
        TogglePart(oArmor, ITEM_APPR_ARMOR_MODEL_RFOOT);
    
    // levá dolní konèetina
    //---------------------
    else if (sText == "stehno levé")
        TogglePart(oArmor, ITEM_APPR_ARMOR_MODEL_LTHIGH);
    else if (sText == "holeò levá")
        TogglePart(oArmor, ITEM_APPR_ARMOR_MODEL_LSHIN);
    else if (sText == "chodidlo levé")
        TogglePart(oArmor, ITEM_APPR_ARMOR_MODEL_LFOOT);
        
    // skupiny
    //----------------------    
    else if (sText == "rukavice")
    {
        ToggleSetPart(oArmor, sText, ITEM_APPR_ARMOR_MODEL_RHAND);
        ToggleSetPart(oArmor, sText, ITEM_APPR_ARMOR_MODEL_LHAND);
        ToggleSet(oArmor, sText);
    }
    else if (sText == "boty")
    {
        ToggleSetPart(oArmor, sText, ITEM_APPR_ARMOR_MODEL_RFOOT);
        ToggleSetPart(oArmor, sText, ITEM_APPR_ARMOR_MODEL_LFOOT);
        ToggleSet(oArmor, sText);
    }
    else if (sText == "svršek")
    {
        ToggleSetPart(oArmor, sText, ITEM_APPR_ARMOR_MODEL_TORSO);
        ToggleSetPart(oArmor, sText, ITEM_APPR_ARMOR_MODEL_BELT);
        ToggleSetPart(oArmor, sText, ITEM_APPR_ARMOR_MODEL_RSHOULDER);
        ToggleSetPart(oArmor, sText, ITEM_APPR_ARMOR_MODEL_LSHOULDER);
        ToggleSetPart(oArmor, sText, ITEM_APPR_ARMOR_MODEL_RBICEP);
        ToggleSetPart(oArmor, sText, ITEM_APPR_ARMOR_MODEL_LBICEP);
        ToggleSetPart(oArmor, sText, ITEM_APPR_ARMOR_MODEL_RFOREARM);
        ToggleSetPart(oArmor, sText, ITEM_APPR_ARMOR_MODEL_LFOREARM);
        ToggleSet(oArmor, sText);
    }
    else if (sText == "kalhoty")
    {
        ToggleSetPart(oArmor, sText, ITEM_APPR_ARMOR_MODEL_RTHIGH);
        ToggleSetPart(oArmor, sText, ITEM_APPR_ARMOR_MODEL_LTHIGH);
        ToggleSetPart(oArmor, sText, ITEM_APPR_ARMOR_MODEL_RSHIN);
        ToggleSetPart(oArmor, sText, ITEM_APPR_ARMOR_MODEL_LSHIN);
        ToggleSet(oArmor, sText);
    }
    
    else
        SendMessageToPC(oPC, "[Chyba] Neurèená akce.");
        
    oNewArmor = CopyItem(oArmor, oPC, TRUE);
    AssignCommand(oPC, ActionEquipItem(oNewArmor, INVENTORY_SLOT_CHEST));
    DestroyObject(oArmor);
}