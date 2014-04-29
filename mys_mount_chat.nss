#include "area_lib"
#include "pc_lib"
#include "me_soul_inc"
#include "mys_mount_lib"
#include "mys_hen_lib"

void DismountAfterActions(object oPC, object oKey)
{
    // Restore mount object as var
    object oHenchman = GetLocalObject(oPC, "MOUNT_OBJECT");
    SetLocalObject(oKey, "HENCHMAN", oHenchman);
    DeleteLocalObject(oPC, "MOUNT_OBJECT");
    
    // for /h chat command
    SetLocalObject(oPC, "HENCHMAN", oHenchman);
    
    // Restore key uses
    SetLocalInt(oKey, "HENCHMAN_USES", 1);    
}

void main()
{
    object oPC = GetPCChatSpeaker();
    string sSpoken = GetPCChatMessage();
    object oTarget = GetNearestObjectByTag("mount", oPC);
    object oSoul = GetIsPlayer(oPC) ? GetSoulStone(oPC) : oPC;
    int iSpellId;
    
    if (sSpoken == "/mount") iSpellId = 813;
    else if (sSpoken == "/mount2") iSpellId = 815;
    else if (sSpoken == "/dismount") iSpellId = 814;
    else return;
    
    // Mount and jousting mount are not usable in interior areas.
    if (iSpellId == 813 || iSpellId == 815)
    {
        if (!GetIsAreaExterior(GetArea(oPC)))
        {
            SendMessageToPC(oPC, "Nelze použít uvnitø.");
            return;
        }
    }
    
    switch (iSpellId)
    {
        // Mount
        case 813:
            ActionMoveToLocation(GetLocation(oTarget));
            ActionDoCommand(Mount(oPC, oTarget, oSoul));
            break;
            
        // Mount jousting
        case 815:
            ActionMoveToLocation(GetLocation(GetSpellTargetObject()));
            ActionDoCommand(Mount(oPC, oTarget, oSoul, TRUE));
            break;
        
        // Dismount
        case 814:
            object oKey = GetKeyByName(oPC, GetLocalString(oSoul, "MOUNT_CREATURE_NAME"));
            ActionDoCommand(Dismount(oPC, oSoul));
            ActionDoCommand(DismountAfterActions(oPC, oKey));            
            break;
    }
}
