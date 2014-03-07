#include "pc_lib"
#include "me_soul_inc"
#include "mys_mount_lib"

void main()
{
    object oTarget = GetSpellTargetObject();
    //object oSoul = GetIsPlayer(OBJECT_SELF) ? GetSoulStone(OBJECT_SELF) : OBJECT_SELF;
    object oSoul = OBJECT_SELF;
    
    switch (GetSpellId())
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
            ActionDoCommand(Dismount(OBJECT_SELF, oSoul));
            break;
            
        default: break;
    }
}
