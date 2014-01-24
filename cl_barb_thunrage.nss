

#include "X0_I0_SPELLS"

void main()
{


    //Declare major variables
    int nDamage = d6(3);
    effect eDam;

    object oTarget;
    float fDelay;



    //Set damage effect
    eDam = EffectDamage(nDamage, DAMAGE_TYPE_SONIC);
    //Get the first object in the persistant AOE
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetLocation(OBJECT_SELF), TRUE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            // Handle saving throws, damage, effects etc.
            fDelay = GetRandomDelay();
            DelayCommand(fDelay, AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget)));

        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_MEDIUM, GetLocation(OBJECT_SELF), TRUE);
    }


}
