const string sMagicComponentTag = "sys_magcomp";

//Returns spell level for oCaster class (or Wizard by default)
int getSpellComponentCount( int nSpellID, int iClass ){

    string sClass;
    switch(iClass){
        case CLASS_TYPE_WIZARD:
        case CLASS_TYPE_SORCERER:
            sClass = "Wiz_Sorc";
            break;
        case CLASS_TYPE_BARD:
            sClass = "Bard";
            break;
    }

    int nSpellLevel = 0;
    int CacheD = GetLocalInt(GetModule(), "Cached_"+sClass + IntToString(nSpellID));
    string sSpellLevel;
    if (CacheD!=1)
    {
        sSpellLevel = Get2DAString("spells", sClass, nSpellID);
        SetLocalString(GetModule(), "2DA_"+sClass+IntToString(nSpellID), sSpellLevel);
        SetLocalInt(GetModule(), "Cached_"+sClass + IntToString(nSpellID),1);
    }
    else
    {
        sSpellLevel = GetLocalString(GetModule(), "2DA_"+ sClass + IntToString(nSpellID));
    }

    if (sSpellLevel != "")
    {
        nSpellLevel=StringToInt(sSpellLevel);
    }

    if ((nSpellLevel==7) || (nSpellLevel==6))
    {
        return 1;
    }
    if ((nSpellLevel==8) || (nSpellLevel==9))
    {
        return 2;
    }

    return 0;
}
#include "x2_inc_switches"


void CheckComponent(object oCaster, int iComponentCount)
{
    if (iComponentCount == 0)
    {
        return;
    }
    //najdu predmet -
    object oItem = GetItemPossessedBy(oCaster,sMagicComponentTag);
    if (GetIsObjectValid(oItem)==FALSE)
    {
        SetModuleOverrideSpellScriptFinished();
        return;
    }
    int iStackSize = GetItemStackSize(oItem);
    if (iStackSize > iComponentCount)
    {
        SetItemStackSize(oItem,iStackSize-iComponentCount);
    }
    else if (iStackSize == iComponentCount)
    {
        DestroyObject(oItem,0.2);
    }
    else
    {
        DestroyObject(oItem,0.2);
        CheckComponent(oCaster,iComponentCount-iStackSize);
    }

}


void main()
{
    object oCaster = OBJECT_SELF;
    int iSpellId = GetSpellId();
    int iClass = GetLastSpellCastClass();
    //Neplati pro magicke predmety
    object oItem = GetSpellCastItem();
    if (GetIsObjectValid(oItem)) return;
    int iComponentCount = getSpellComponentCount(iSpellId,iClass);
    CheckComponent(oCaster,iComponentCount);
}
