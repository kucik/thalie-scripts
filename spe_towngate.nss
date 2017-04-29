#include "me_soul_inc"
void main()
{
    object oPC=OBJECT_SELF;
    object oSoulStone= GetSoulStone(oPC);
    string sTownGateTag = GetLocalString(oSoulStone,"TOWNGATE_ACTIVE_TAG");
    if (sTownGateTag=="")
    {
        SendMessageToPC(oPC,"Dimenzionalni neni kotva nastavena.");
        return;
    }

    object oTownGate = GetObjectByTag(sTownGateTag);
    if (GetIsObjectValid(oTownGate)==FALSE)
    {
        SendMessageToPC(oPC,"Kotva jiz neexistuje.");
        return;
    }
    //Kontrola na nepratele v okoli
    object oArea = GetArea(oPC);
    object oTest = GetFirstObjectInArea(oArea);
    while (GetIsObjectValid(oTest))
    {
        if (GetIsReactionTypeHostile(oTest,oPC))
        {
            SendMessageToPC(oPC,"Kouzlo nelze seslat, v lokaci je nepratelska entita.");
            return;
        }
        oTest = GetNextObjectInArea(oArea);
    }
    //Area effect
    location lBase = GetLocation(oPC);
    effect eVis = EffectVisualEffect(VFX_FNF_TIME_STOP);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lBase);
    //portujeme
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lBase);
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsPC(oTarget))
        {
            DelayCommand(1.0f, AssignCommand(oTarget, JumpToObject(oTownGate)));
        }
        //Get the next target in the specified area around the caster
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lBase);
    }
}
