/*
 * Modified by S. Ferguson for Switch-Based Secret Doors.
 *
 * January 10, 2007: This script now controls both one-way and two-way doors
 *                   by examining the door's configuration variables.
 *
 * April 12, 2007: Door now transports multiple henchmen and their associates.
 *
 **/

//::///////////////////////////////////////////////
//:: Trap door that takes you to a waypoint that
//:: is stored into the Destination local string.
//:: FileName
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Robert Babiak
//:: Created On: June 25, 2002
//:://////////////////////////////////////////////
//:: Modified By: Andrew Nobbs
//:: Modified On: September 23, 2002
//:: Modification: Removed unnecessary spaces.
//:://////////////////////////////////////////////

#include "sbsd_include"

void SendCreature(object oCreature, object oDest)
{
    if(oCreature != OBJECT_INVALID)
    {
        AssignCommand(oCreature, ClearAllActions());
        AssignCommand(oCreature, ActionJumpToObject(oDest,FALSE));
    }
}

void SendCharacterAndTheirAssociates(object oCreature, object oidDest)
{
   object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oCreature);
   object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oCreature);
   object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oCreature);
   object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oCreature);

   SendCreature(oCreature, oidDest);
   SendCreature(oAnimal, oidDest);
   SendCreature(oDominated, oidDest);
   SendCreature(oFamiliar, oidDest);
   SendCreature(oSummoned, oidDest);
}

void main()
{
    object oidUser;
    object oidDest;
    object oidAssoc;
    string sDest;
    int n = 1;
    int oneWay = 0;

    object oHenchman;

//    if (!GetLocked(OBJECT_SELF))
//    {
//        if (GetIsOpen(OBJECT_SELF))
//        {
            sDest = GetLocalString(OBJECT_SELF,"Destination");

            oidUser = GetLastUsedBy();
            oidDest = GetObjectByTag(sDest);
            oHenchman = GetHenchman(oidUser, n);
/*            AssignCommand(oidUser,ActionJumpToObject(oidDest,FALSE));
            object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oidUser);
            object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oidUser);
            object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oidUser);
            object oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oidUser, n);
            object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oidUser);

            SendCreature(oAnimal, oidDest);
            SendCreature(oDominated, oidDest);
            SendCreature(oFamiliar, oidDest);
            SendCreature(oSummoned, oidDest);
  */
            SendCharacterAndTheirAssociates(oidUser, oidDest);

            while (GetIsObjectValid(oHenchman))
            {
              SendCharacterAndTheirAssociates(oHenchman, oidDest);
              n++;
              oHenchman = GetHenchman(oidUser, n);
            }


            object oSwitch = GetLocalObject(OBJECT_SELF, SBSD_SWITCHTRACKER_VAR);
            // If the door is one-way (only one-way doors use SWITCHTRACKER_VAR),
            // close it after the user walks through

            if (GetIsObjectValid(oSwitch))
            {
              string sSlam = GetLocalString(oSwitch, SBSD_SLAMSTRING_VAR);
              if (sSlam == "")
                sSlam = "The secret door seals itself behind you.";

              DelayCommand(1.0, FloatingTextStringOnCreature(sSlam, oidUser, FALSE));
              DelayCommand(1.0, CloseSecretDoor(oSwitch));
            }


        //PlayAnimation(ANIMATION_PLACEABLE_CLOSE);
//        } else
//        {
//            PlayAnimation(ANIMATION_PLACEABLE_OPEN);
//        }
//    } else
//    {
    //    ActionUseSkill
//    }

}
