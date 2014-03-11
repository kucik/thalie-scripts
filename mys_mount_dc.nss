#include "nwnx_events"
#include "mys_hen_lib"

int StartingConditional()
{
    string sText = GetCurrentNodeText();
    object oPC = GetPCSpeaker();
    object oMaster = GetMaster(OBJECT_SELF);
    string sTag = GetTag(OBJECT_SELF);
    
    if (sText == "Informace o pronájmu.")
    {
        if (sTag == "henchman_leasable")
        {
            SetCustomToken(6891, IntToString(GetHenchmanHirePrice(OBJECT_SELF)));
            return TRUE;
        }
        return FALSE;
    }
    if (sTag == "mount")
    {
        if (sText == "<StartAction>[Do party]</Start>")
        {
            return oPC == oMaster ? FALSE : TRUE;
        }
        return oPC == oMaster ? TRUE : FALSE;
    }
    return FALSE;    
}