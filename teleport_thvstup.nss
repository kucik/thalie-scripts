#include "aps_include"
#include "persistence"
#include "zep_inc_phenos"
#include "ja_inc_stamina"
#include "me_pcneeds_inc"
#include "ja_inc_frakce"
#include "ku_libbase"
// kuly alchymii
#include "tc_constants"
#include "sh_classes_inc"
void main()
{
    object oPC = GetLastUsedBy();
    object oSoul = GetSoulStone(oPC);
    int iPlayed = GetLocalInt(oSoul, "PLAYED");
    location lLoc;
    if(iPlayed)
    {
        lLoc = GetPersistentLocation(oPC, "LOCATION");
        if (GetIsObjectValid(GetAreaFromLocation(lLoc)))
        {
            if (GetTag(GetAreaFromLocation(lLoc))=="th_vitejte")
            {
                if (Subraces_GetIsCharacterFromUnderdark(oPC))
                {
                    object oWP = GetObjectByTag("CHRAM_XIAN_CHARAS");
                    AssignCommand(oPC,ActionJumpToObject(oWP));

                }
                else
                {
                    object oWP = GetObjectByTag("CHRAM_JUANA_KARATHA");
                    AssignCommand(oPC,ActionJumpToObject(oWP));
                }
            }
            AssignCommand(oPC,ActionJumpToLocation(lLoc));
        }
        else
        {
            SendMessageToPC(oPC,"Vase postava neni schvalena, nepustim vas dale.");
        }
    }
    else
    {
        lLoc = GetLocation(GetObjectByTag("DST_thstart_isl1"));
    }
    AssignCommand(oPC,ActionJumpToLocation(lLoc));
}
