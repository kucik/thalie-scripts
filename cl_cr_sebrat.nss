#include "ku_persist_inc"
#include "me_soul_inc"

void ActionPickUp(object oTarget, string sCollectableItemResRef)
{
    if (GetIsObjectValid(oTarget))
    {
        // Debug
        SendMessageToPC(OBJECT_SELF, "Výsledek: sbíráš " + GetName(oTarget) + ".");

        CreateItemOnObject(sCollectableItemResRef, OBJECT_SELF);
        int iDeleted = Persist_DeleteObjectFromDB(oTarget);
        if (iDeleted < 0)
            SendMessageToPC(OBJECT_SELF, "Odstranìní ID "+ IntToString(GetLocalInt(oTarget,"KU_PERSIST_PLC_DB_ID"))+ " z persistence se nezdaøilo.");
        DestroyObject(oTarget);
    }
}

void main()
{
    object oTarget = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, GetSpellTargetLocation());
    string sTargetTag = GetTag(oTarget);
    object oSoulStone = GetSoulStone(OBJECT_SELF);
    string sCollectableItemResRef = GetLocalString(oTarget, "PLC_ITEMRESREF");

    // Debug
    SendMessageToPC(OBJECT_SELF, "Používáš feat Sebrat na: " + GetName(oTarget) + ".");
    //towngate_
    if (GetSubString(sTargetTag,0,9)=="towngate_")
    {
        if (GetHasFeat(1618))                                                    //mestska brana
        {
            SetLocalString(oSoulStone,"TOWNGATE_ACTIVE_TAG",sTargetTag);
            effect eVis = EffectVisualEffect(VFX_IMP_HOLY_AID);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
            SendMessageToPC(OBJECT_SELF,"Dimenzionalni kotva nastavena.");
        }
        else
        {
            SendMessageToPC(OBJECT_SELF,"Objekt nelze pouzit.");
        }
    }

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
