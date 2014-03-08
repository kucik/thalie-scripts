#include "nwnx_events"
#include "mys_hen_lib"

int StartingConditional()
{
    string sText = GetCurrentNodeText();
    object oPC = GetPCSpeaker();
    object oMaster = GetMaster(OBJECT_SELF);
    string sTag = GetTag(OBJECT_SELF);
    
    if (sTag == "mount")
    {
        if (sText == "<StartAction>[Do party]</Start>")
        {
            return oPC == oMaster ? FALSE : TRUE;
        }
        return oPC == oMaster ? TRUE : FALSE;
    }
    else if (sTag == "henchman_leasable")
    {
        if (sText == "Pronajmout zvíøe.")
        {
            SetCustomToken(6891, IntToString(GetHenchmanHirePrice(OBJECT_SELF)));
            return TRUE;
        }
        return FALSE;
    }
    return FALSE;    
}