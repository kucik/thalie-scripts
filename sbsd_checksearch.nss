/**
 * Switch-Based Secret Doors, v1.0
 * Written by Samuel Ferguson, April 2007
 *
 * This script is modified from nw_02_dtwalldoor by Bioware.
 *
 * This is a heartbeat script that checks in-range players to see if they
 * find the hidden switch.  Place this script in the OnHeartbeat event of
 * the object containing the switch.  The object's Reflex save is the radius
 * of detection, and its Will save is the DC of detection.
 *
 **/

//::///////////////////////////////////////////////
//:: nw_o2_dtwalldoor.nss
//:: Copyright (c) 2001-2 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script runs on either the Hidden Trap Door
    or Hidden Wall Door Trigger invisible objects.
    This script will do a check and see
    if any PC comes within a radius of thisgTriger.

    If the PC has the search skill or is an Elf then
    a search check will be made.

    It will create a Trap or Wall door that will have
    its Destination set to a waypoint that has
    a tag of DST_<tag of this object>

    The radius is determined by the Reflex saving
    throw of the invisible object

    The DC of the search stored by the Willpower
    saving throw.

*/
//:://////////////////////////////////////////////
//:: Created By  : Robert Babiak
//:: Created On  : June 25, 2002
//::---------------------------------------------
//:: Modifyed By : Robert, Andrew, Derek
//:: Modifyed On : July - September
//:://////////////////////////////////////////////

#include "sbsd_include"
void main()
{
    // Tag of the object on which the switch will be found
//    string sTag2 = "";

    /* Do not make check if area is empty */
    object oArea = GetLocalObject(OBJECT_SELF,"ku_my_area");
    if(!GetIsObjectValid(oArea)) {
      oArea = GetArea(OBJECT_SELF);
      SetLocalObject(OBJECT_SELF, "ku_my_area",oArea);
    }
    if(!GetLocalInt(GetArea(oArea),"ku_notempty"))
      return;


    int needsTrigger = GetLocalInt(OBJECT_SELF, SBSD_TRIGGER_VAR);
    int isLocked = GetLocalInt(OBJECT_SELF, SBSD_LOCKED_VAR);
    int rehideTimer = GetLocalInt(OBJECT_SELF, SBSD_REHIDE_TIMER_VAR);
    int rehideCloseDoors = GetLocalInt(OBJECT_SELF, SBSD_REHIDE_CLOSE_DOORS_VAR);

    // String to display upon finding it
    string foundString = GetLocalString(OBJECT_SELF, SBSD_FOUNDSTRING_VAR);
    string sBestSearcherName = "";
    int isCurrentlyClickable = 0;


    // has it been found?
//    int nDone = GetLocalInt(OBJECT_SELF,"D_"+sTag);
    int nDone = GetLocalInt(OBJECT_SELF, SBSD_SWITCH_IS_VISIBLE_VAR);
//    int nReset = GetLocalInt(OBJECT_SELF, "Reset");

    if ((isLocked) && !(nDone))
      SetUseableFlag(OBJECT_SELF, 0);


    if (foundString == "")
      foundString = "You spot a hidden switch on the " + GetName(OBJECT_SELF) + "!";


    // get the radius and DC of the secret door.
    float fSearchDist = IntToFloat(GetReflexSavingThrow(OBJECT_SELF));
    float fSearchDistOriginal = fSearchDist;

    int nDiffaculty = GetWillSavingThrow(OBJECT_SELF);

    // what is the tag of this object used in setting the destination
    string sTag = GetTag(OBJECT_SELF);



    // ok reset the door is destroyed, and the done and reset flas are made 0 again
/*    if (nReset == 1)
    {
        nDone = 0;
        nReset = 0;

        SetLocalInt(OBJECT_SELF,"D_"+sTag,nDone);
        SetLocalInt(OBJECT_SELF,"Reset",nReset);

        object oidDoor= GetLocalObject(OBJECT_SELF,"Door");
        if (oidDoor != OBJECT_INVALID)
        {
            SetPlotFlag(oidDoor,0);
            DestroyObject(oidDoor,GetLocalFloat(OBJECT_SELF,"ResetDelay"));
        }

    }
  */

    int nBestSkill = -50;
    object oidBestSearcher = OBJECT_INVALID;
    object oidRealSearcher = OBJECT_INVALID;
    int nCount = 1;

    // Find the best searcher within the search radius.
    object oidNearestCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, nCount);
    int nDoneSearch = 0;
    int nFoundPCs = 0;
    int n = 1;

    // Reset the switch for persistent worlds if the setting is applied.
    // If no players are in the area, close all non-socketed hidden
    // switches and re-hide all hidden switches.
    if ((SBSD_REHIDE_SWITCHES) &&
        (!GetIsObjectValid(oidNearestCreature)) &&
        (nDone) &&
        (GetLocalInt(OBJECT_SELF, SBSD_PREVENT_RESET_VAR) == 0))
        // ||
//         (GetDistanceBetween(OBJECT_SELF, oidNearestCreature) > fSearchDist)))
    {
       // Toggle the on/off animation (this is normally not used
       // for hidden switches, but it's included here to be safe).
       int onOff = GetLocalInt(OBJECT_SELF, SBSD_TOGGLE_VAR);
       ToggleAnimation(OBJECT_SELF, onOff);

       // If this is not a socketed switch, and if the rehide-close
       // variable is set, close the door.
       if (rehideCloseDoors && !isLocked)
       {
         CloseSecretDoor(OBJECT_SELF);
       }

       // Hide the switch.
       HideSwitch(OBJECT_SELF, GetLocalInt(OBJECT_SELF, SBSD_REUNUSE_VAR), fSearchDistOriginal);
    }

    else
    {

    while ((nDone == 0) &&
           (nDoneSearch == 0) &&
           (oidNearestCreature != OBJECT_INVALID)
          )
    {
        // what is the distance of the PC to the door location
        float fDist = GetDistanceBetween(OBJECT_SELF,oidNearestCreature);

        if (GetDetectMode(oidNearestCreature) != DETECT_MODE_ACTIVE)
          fSearchDist = fSearchDist * SBSD_PASSIVE_SEARCH_RANGE_MULTIPLE;

        else
          fSearchDist = fSearchDistOriginal;

        if (fDist <= fSearchDist)
        {
            // Only count this character if s/he has line of sight
            // For some reason, some objects always report no LOS, so
            // this is disabled for now.

//            if (LineOfSightObject(OBJECT_SELF, oidNearestCreature))
//            {
              int nSkill = GetSkillRank(SKILL_SEARCH,oidNearestCreature);

              if (GetDetectMode(oidNearestCreature) != DETECT_MODE_ACTIVE)
                 nSkill = FloatToInt(nSkill * SBSD_PASSIVE_SEARCH_SKILL_MULTIPLE);

              if ((nSkill > nBestSkill) &&
                (GetLocalInt(oidNearestCreature, ("SBPS_"+sTag)) == needsTrigger))
              {
                nBestSkill = nSkill;
                oidBestSearcher = oidNearestCreature;
              }

              /* SBSD modification to allow henchmen searching.  After the
               * player's skill rank is checked, all henchmen are given a chance
               * to beat the player's skill level.  The highest skill rank is
               * automatically used for the attempt.
               */

              if (SBSD_ALLOW_HENCHMAN_SEARCHING)
              {
                object oHench = GetHenchman(oidNearestCreature, n);

                while((GetIsObjectValid(oHench)) &&
                      (GetLocalInt(oidNearestCreature, ("SBPS_"+sTag)) == needsTrigger))
                {
                  int nSkill2 = GetSkillRank(SKILL_SEARCH, oHench);
                  if (GetDetectMode(oidNearestCreature) != DETECT_MODE_ACTIVE)
                    nSkill2 = FloatToInt(nSkill2 * SBSD_PASSIVE_SEARCH_SKILL_MULTIPLE);

                  if (nSkill2 > nBestSkill)
                  {
                    nBestSkill = nSkill2;
                    oidRealSearcher = oHench;
                  }
                  n++;
                  oHench = GetHenchman(oidNearestCreature, n);
                  //Best searcher is still considered the henchman's master
                }
              } // end henchman searching

              nFoundPCs = nFoundPCs +1;
//            } //los check

              // LOS debug
//            else
//              SendMessageToPC(oidNearestCreature, "no LOS");
          }
        else
        {
            // If there is no one in the search radius, don't continue to search
            // for the best skill.
            nDoneSearch = 1;
        }
        nCount = nCount +1;
        oidNearestCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF ,nCount);
    }


    if ((nDone == 0) &&
        (nFoundPCs != 0) &&
        (GetIsObjectValid(oidBestSearcher))
       )
    {
       int nMod = d20();

      //debug
//      SendMessageToPC(oidBestSearcher, IntToString(nBestSkill) + " + " + IntToString(nMod));

       // did we find it.
       if ((nBestSkill +nMod > nDiffaculty))
       {
            if (GetUseableFlag())
            {
              SetLocalInt(OBJECT_SELF, SBSD_REUNUSE_VAR, 1);
              isCurrentlyClickable = 1;
            }

            location locLoc = GetLocation (OBJECT_SELF);
            object oidDoor;
            // yes we found it, now create the appropriate door
//            oidDoor = CreateObject(OBJECT_TYPE_PLACEABLE,"NW_PL_HIDDENDR01",locLoc,TRUE);
//            oidDoor = GetNearestObjectByTag(sTag2, OBJECT_SELF);

            if (GetIsObjectValid(oidRealSearcher))
            {
              sBestSearcherName = GetName(oidRealSearcher);
              FloatingTextStringOnCreature(sBestSearcherName + " has found something!", oidBestSearcher, FALSE);
              PlayVoiceChat(VOICE_CHAT_LOOKHERE, oidRealSearcher);
            }

            else
            {
//              FloatingTextStringOnCreature("Hey!", oidBestSearcher, FALSE);
              PlayVoiceChat(VOICE_CHAT_LOOKHERE, oidBestSearcher);
            }

//            else
  //            FloatingTextStringOnCreature(sBestSearcherName + " has found something!", oidBestSearcher, FALSE);


            // If the switch has a rehide timer, start it now
            if (rehideTimer > 0)
            {
               // Toggle the on/off animation (this is normally not used
               // for hidden switches, but it's included here to be safe).
//               int onOff = GetLocalInt(OBJECT_SELF, SBSD_TOGGLE_VAR);
//               DelayCommand(0.0+rehideTimer, ToggleAnimation(OBJECT_SELF, onOff));

               // If this is not a socketed switch, and if the rehide-close
               // variable is set, close the door.
//               if (rehideCloseDoors && !isLocked)
//               {
//                 DelayCommand(0.0+rehideTimer, CloseSecretDoor(OBJECT_SELF));
//               }

               // Hide the switch.
               DelayCommand(0.0+rehideTimer, HideSwitch(OBJECT_SELF, isCurrentlyClickable, fSearchDistOriginal));
            }

            // end rehide routine

            SendMessageToPC(oidBestSearcher, foundString);

//            SetLocalString( oidDoor, "Destination" , "DST_"+sTag );
              SetLocalInt(OBJECT_SELF, SBSD_FOUNDYESNO_VAR, 1);
              SetLocalInt(OBJECT_SELF, SBSD_SWITCH_IS_VISIBLE_VAR, 2-(GetUseableFlag(OBJECT_SELF)));
            // make this door as found.
//            SetLocalInt(OBJECT_SELF,"D_"+sTag,1);
//            SetPlotFlag(oidDoor,1);
//            SetLocalObject(OBJECT_SELF,"Door",oidDoor);
            SetUseableFlag(OBJECT_SELF, 1);
            SetLocked(OBJECT_SELF, 0);


       } // if skill search found
    } // if Object is valid
    } //top else
}

