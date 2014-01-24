void main()
{
    object oPC = OBJECT_SELF;
    location oPCLocation = GetLocation(oPC);
    object oClone = CopyObject(oPC,oPCLocation);
    int iRep = 0;
    object oCreature = GetFirstObjectInShape(SHAPE_SPHERE,50.0,oPCLocation);
    while (GetIsObjectValid(oCreature))
    {
        if (oCreature == oPC)
        {

            AdjustReputation(oClone,oCreature,100);
        }
        else
        {
            iRep = GetReputation(oPC,oCreature);
            AdjustReputation(oClone,oCreature,iRep);
        }
        object oCreature = GetNextObjectInShape(SHAPE_SPHERE,50.0,oPCLocation);
    }
}
