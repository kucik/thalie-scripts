#include "area_lib"
#include "pc_lib"
#include "me_soul_inc"
#include "mys_mount_lib"
#include "mys_hen_lib"

void DismountAfterActions(object oKey)
{
    // Restore mount object as var
    object oHenchman = GetLocalObject(OBJECT_SELF, "MOUNT_OBJECT");
    SetLocalObject(oKey, "HENCHMAN", oHenchman);
    DeleteLocalObject(OBJECT_SELF, "MOUNT_OBJECT");
    
    // for /h chat command
    SetLocalObject(OBJECT_SELF, "HENCHMAN", oHenchman);
    
    // Restore key uses
    SetLocalInt(oKey, "HENCHMAN_USES", 1);    
}

void main()
{
    object oTarget = GetSpellTargetObject();
    object oSoul = GetIsPlayer(OBJECT_SELF) ? GetSoulStone(OBJECT_SELF) : OBJECT_SELF;
    int iSpellId = GetSpellId();
    
    // Mount and jousting mount are not usable in interior areas.
    if (iSpellId == 813 || iSpellId == 815)
    {
        if (!GetIsAreaExterior(GetArea(OBJECT_SELF)))
        {
            SendMessageToPC(OBJECT_SELF, "Nelze použít uvnitø.");
            return;
        }
    }
    
    switch (iSpellId)
    {
        // Mount
        case 813:
            ActionMoveToLocation(GetLocation(oTarget));
            ActionDoCommand(Mount(OBJECT_SELF, oTarget, oSoul));
            break;
            
        // Mount jousting
        case 815:
            ActionMoveToLocation(GetLocation(GetSpellTargetObject()));
            ActionDoCommand(Mount(OBJECT_SELF, oTarget, oSoul, TRUE));
            break;
        
        // Dismount
        case 814:
            object oKey = GetKeyByName(OBJECT_SELF, GetLocalString(oSoul, "MOUNT_CREATURE_NAME"));
            ActionDoCommand(Dismount(OBJECT_SELF, oSoul));
            ActionDoCommand(DismountAfterActions(oKey));            
            break;
    }
}
