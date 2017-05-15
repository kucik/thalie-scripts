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
    //kontrola na validitu lokace
    object oArea = GetArea(oPC);
    string sAreaTag = GetTag(oArea);
    if (sAreaTag=="Sferamrtvych")
    {
        SendMessageToPC(oPC,"V teto lokaci je brana zakazana.");
        return;
    }

    //Kontrola na nepratele v okoli
    location lPC = GetLocation(oPC);
    object oTest = GetFirstObjectInShape(SHAPE_SPHERE,30.0,lPC);
    while (GetIsObjectValid(oTest))
    {
        if (GetIsEnemy(oTest,oPC))
        {
            SendMessageToPC(oPC,"Kouzlo nelze seslat, v okoli je nepratelska entita.");
            return;
        }
        oTest = GetNextObjectInShape(SHAPE_SPHERE,30.0,lPC);
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
