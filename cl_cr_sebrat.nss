#include "ku_persist_inc"

void ActionPickUp(object oTarget, string sCollectableItemResRef)
{
    if (GetIsObjectValid(oTarget))
    {
        // Debug
        SendMessageToPC(OBJECT_SELF, "Výsledek: sbíráš " + GetName(oTarget) + ".");
        
        CreateItemOnObject(sCollectableItemResRef, OBJECT_SELF);
        SendMessageToPC(OBJECT_SELF, "DEBUG: " + IntToString(GetLocalInt(oTarget,"KU_PERSIST_PLC_DB_ID")));
        int iDeleted = Persist_DeleteObjectFromDB(oTarget);
        SendMessageToPC(OBJECT_SELF, "DEBUG: " + IntToString(iDeleted));
        if (iDeleted < 0)
            SendMessageToPC(OBJECT_SELF, "Odstranìní ID "+ IntToString(GetLocalInt(oTarget,"KU_PERSIST_PLC_DB_ID"))+ " z persistence se nezdaøilo.");
        DestroyObject(oTarget);
    }
}

void main()
{
    object oTarget = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, GetSpellTargetLocation());
    string sCollectableItemResRef = GetLocalString(oTarget, "PLC_ITEMRESREF");
    
    // Debug
    SendMessageToPC(OBJECT_SELF, "Používáš feat Sebrat na: " + GetName(oTarget) + ".");

    if (sCollectableItemResRef != "")
    {
        ActionMoveToLocation(GetLocation(oTarget), FALSE);
        ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 3.0f);
        ActionDoCommand(ActionPickUp(oTarget, sCollectableItemResRef));
    }
    else
    {
        // Debug
        SendMessageToPC(OBJECT_SELF, "Výsledek: žádný.");
    }
}
