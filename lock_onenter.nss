//**///////////////////////////////////////////////////////////////////////////
//** LOCK(NESS) v1.0 - onEnter script
//**///////////////////////////////////////////////////////////////////////////
//**
//** This script must be installed on the onEnter event. Do NOT forget to
//** assign the "lock_onexit" script to the onExit event !!!
//**
//**///////////////////////////////////////////////////////////////////////////
//** Last modification: 08/01/2005
//** Created by Firya'nis & Ex Tempus.
//**///////////////////////////////////////////////////////////////////////////
/*
 * rev. 24.01.2008 Kucik - vzhled spectry v podsveti
 * Kucik 27.05.2008 Dyn. zamykani a zapastovani dveri
 */

//#include "x3_inc_horse"
#include "lock_inc"
#include "ja_inc_frakce"
#include "subraces"
#include "aps_include"
#include "mys_mount_lib"
#include "me_soul_inc"
#include "area_lib"

void ApplyDeadlandsEffects(object oPC, object oSoul);

void MakeAnimalFriends(object oPC){
    int classD = GetLevelByClass(CLASS_TYPE_DRUID, oPC);
    int classR = GetLevelByClass(CLASS_TYPE_RANGER, oPC);
    int class;

    if(classD > classR)
        class = classD;
    else class = classR;

    if( class > 0 ){
       int prob=100 - 200/class;

       object oCreatureFirst = GetFirstObjectInArea(OBJECT_SELF);
       object oCreature;
       int nNth = 1;

       if(GetObjectType(oCreatureFirst) == OBJECT_TYPE_CREATURE){
        oCreature = oCreatureFirst;
        nNth = 0;
       }
       else
        oCreature = GetNearestObject( OBJECT_TYPE_CREATURE, oCreatureFirst, nNth );

       while(GetIsObjectValid(oCreature)){
            if ( (GetRacialType(oCreature) == RACIAL_TYPE_ANIMAL) && (Random(100)<prob)){
                object oMember = GetFirstFactionMember(oPC, FALSE);
                while(GetIsObjectValid(oMember)){
                    int bDecays = TRUE;
                    if(oMember == oPC)
                        bDecays = FALSE;

                    SetIsTemporaryFriend(oMember, oCreature, bDecays);
                    oMember = GetNextFactionMember(oPC, FALSE);
                }
            }
            nNth++;
            oCreature = GetNearestObject( OBJECT_TYPE_CREATURE, oCreatureFirst, nNth );
       }
   }
}

void spawn(object oPC){
     int iSpawn = GetLocalInt(OBJECT_SELF, "LOCK_SPAWN_ENTER");
     int iDisable_spawn = GetLocalInt(OBJECT_SELF,"KU_LOC_DISABLE_SPAWN");
     object oArea = OBJECT_SELF;

     if(!iSpawn && !iDisable_spawn){
        // Safety for double spawn
        if(GetLocalInt(oArea, "LOCK_SPAWN_IN_PROGRESS")) {
          WriteTimestampedLogEntry("Spawn already in progress in progress in '"+GetName(oArea)+"' '"+GetTag(oArea)+"'");
          return;
        }
        SetLocalInt(oArea, "LOCK_SPAWN_IN_PROGRESS",TRUE);
        DelayCommand(2.0, DeleteLocalInt(oArea,"LOCK_SPAWN_IN_PROGRESS"));
        WriteTimestampedLogEntry("Spawn start in '"+GetName(oArea)+"' '"+GetTag(oArea)+"'");

        //SpeakString(IntToString(pc_c), TALKVOLUME_SHOUT);
        float fSpawnDelay = 0.0;
        int nNth = 1;
        object oTarget = GetFirstObjectInArea(OBJECT_SELF);
        object oObject;
        object oOverrrideFaction = OBJECT_INVALID;
        string sOverrrideFaction = GetLocalString(oArea,"FACTION_OVERRIDE");
        if(GetStringLength(sOverrrideFaction) > 0) {
           oOverrrideFaction = GetFactionMember(sOverrrideFaction);
        }


        // Find out the first LOCK WP.
        if (GetStringLeft(GetTag(oTarget), 5) != "LOCK_")
             oObject = GetNearestObject(OBJECT_TYPE_WAYPOINT, oTarget, nNth);
        else
        {
            oObject = oTarget;
            nNth = 0;            // Corrected on 08/02/2005 by Firya'nis.
        }

        int iDayNight = GetIsNight() ? 2:1;        //0-always;1-day;2-night

        int TrapDC =GetLocalInt(GetArea(oTarget),"TREASURE_VALUE") / 5 +1;

        //Zamykani dveri, zapastovani
        int i=1,j=1;
        float distance;
        int locked,MaxDC,Trapped;
        object oDoors;
        oObject = GetNearestObject(OBJECT_TYPE_WAYPOINT, oTarget, i);
        while(GetIsObjectValid(oObject)) {

          //dvere
          if(GetTag(oObject)=="LOCK_DOORS") {
            distance = GetLocalFloat(oObject,"DISTANCE");
            locked = GetLocalInt(oObject,"LOCKED");
            MaxDC = GetLocalInt(oObject,"LOCK_DC");
            Trapped = GetLocalInt(oObject,"TRAPPED");

            GetFirstObjectInShape(SHAPE_SPELLCYLINDER,distance,GetLocation(oObject),FALSE,OBJECT_TYPE_DOOR);
            while(GetIsObjectValid(oDoors)) {

              if(locked > Random(100)) {
                SetLocked(oDoors,TRUE);
                SetLockKeyRequired(oDoors,FALSE);
                SetLockUnlockDC(oDoors,MaxDC - Random(Random(MaxDC)));
              }
              if(Trapped > Random(100)) {
                ku_SetRandomTrap(oDoors,TrapDC);
              }
              GetNextObjectInShape(SHAPE_SPELLCYLINDER,distance,GetLocation(oObject),FALSE,OBJECT_TYPE_DOOR);
            }
          }

          i++;
          oObject = GetNearestObject(OBJECT_TYPE_WAYPOINT, oTarget, i);
        }
        // ~ Zamykani dveri

        oTarget = GetFirstObjectInArea(OBJECT_SELF);
        nNth = 1;

        // Find out the first LOCK WP.
        if (GetStringLeft(GetTag(oTarget), 5) != "LOCK_")
             oObject = GetNearestObject(OBJECT_TYPE_WAYPOINT, oTarget, nNth);
        else
        {
            oObject = oTarget;
            nNth = 0;            // Corrected on 08/02/2005 by Firya'nis.
        }
        i=1;

        while (GetIsObjectValid(oObject))
        {
            //SpeakString("SPAWNING", TALKVOLUME_SHOUT);
            string sTag = GetTag(oObject);
            if (GetStringLeft(sTag, 5) == "LOCK_")
            {
                int iWhen = GetLocalInt(oObject, "JA_SPAWN_TIME");
                int prob = GetLocalInt(oObject, "JA_SPAWN_PROBABILITY");

                if((iWhen != iDayNight) && (iWhen != 0) || (Random(100) < prob)){
                    nNth++;
                    oObject = GetNearestObject(OBJECT_TYPE_WAYPOINT, oTarget, nNth);
                    continue;
                }

                // Old group spawn
                if (GetStringLeft(sTag, 7) == "LOCK_RA") {
                  SetLocalString(oObject,"SPAWN_TYPE","GROUP");
                }

                // New spawn prototype
                if(LOCK_ProcessSpawn(oObject, fSpawnDelay, oOverrrideFaction)) {
                    nNth++;
                    oObject = GetNearestObject(OBJECT_TYPE_WAYPOINT, oTarget, nNth);
                    fSpawnDelay += 0.02; // To define an interval between all spawns.
                    continue;
                }

                // Get information about this WP.
                location lLoc = GetLocation(oObject);
                string sWP    = GetTag(oObject);
                int length       = GetStringLength(sWP)-5;
                string sResref   = GetStringRight(sWP, length);

                // Get the variables on the WP.
                int PLC         = GetLocalInt(oObject, "PLC");
                int ITEM        = GetLocalInt(oObject, "ITEM");
                string NEWTAG   = GetLocalString(oObject, "NEWTAG");

                if (PLC == 1)       // Is it a placeable ?
                    DelayCommand(fSpawnDelay, LOCK_SpawnPlaceable(lLoc, sResref, NEWTAG));
                else if (ITEM == 1) // Is it an item ?
                    DelayCommand(fSpawnDelay, LOCK_SpawnObject(oPC, lLoc, sResref, NEWTAG));
                else                // So... it should be a creature !
                     DelayCommand(fSpawnDelay, LOCK_SpawnCreature(lLoc, sResref, NEWTAG,oOverrrideFaction));

                fSpawnDelay += 0.02; // To define an interval between all spawns.
            }
            nNth++;
            oObject = GetNearestObject(OBJECT_TYPE_WAYPOINT, oTarget, nNth);
        }
        SetLocalInt(OBJECT_SELF, "LOCK_SPAWN_ENTER", 1);
        WriteTimestampedLogEntry("Spawned "+IntToString(FloatToInt(fSpawnDelay / 0.02))+" from "+IntToString(nNth)+" waypoints '"+GetName(oArea)+"' '"+GetTag(oArea)+"'");
     }
     // We confirm the spawn has been done.
     DelayCommand(5.0f, MakeAnimalFriends(oPC));

}

void main()
{
    object oPC = GetEnteringObject();
    object oSoul = GetSoulStone(oPC);
    object oLoc = OBJECT_SELF;
    if(GetIsPC(oPC) || GetIsDM(oPC) ) {
      WriteTimestampedLogEntry("Player "+GetPCPlayerName(oPC)+", character "+GetName(oPC)+"["+IntToString(GetHitDice(oPC))+"] entering "+GetName(OBJECT_SELF)+"("+GetTag(OBJECT_SELF)+")TV:["+IntToString(GetLocalInt(OBJECT_SELF, "TREASURE_VALUE"))+"]");
    }

    /* Nastav, ze lokace neni prazdna */
    if(GetIsPC(oPC)) {
      lock_init_location();
      SetLocalInt(OBJECT_SELF,"ku_notempty",TRUE);
    }

    /* Set area, where I am */
    SetLocalObject(oPC,"KU_ACT_AREA",oLoc);

    // Only if the entering creature is a PC or DM.
    if (!(GetIsPC(oPC) || GetIsDMPossessed(oPC) || GetIsDM(oPC))) return;

    if(Subraces_GetIsCharacterFromUnderdark(oPC ))
      SendMessageToPC(oPC,GetLocalString(OBJECT_SELF,"ph_hloubka"));


    int arena = GetLocalInt(OBJECT_SELF, "ARENA");
    int mesto = GetLocalInt(OBJECT_SELF, "JA_MESTO");

    /* V meste odkryj mapu */
    if(mesto || GetLocalInt(OBJECT_SELF, "TH_EXPLORE") == 1)
      ExploreAreaForPlayer(OBJECT_SELF,oPC,TRUE);

    if(!mesto && !GetIsDM(oPC) && !GetIsObjectValid(GetMaster(oPC)) ){
        int found = GetPersistentInt(oPC, GetTag(OBJECT_SELF), "locations");

        if(!found){
            SetPersistentInt(oPC, GetTag(OBJECT_SELF), 1, 0, "locations");

            int value = GetLocalInt(OBJECT_SELF, "TREASURE_VALUE");
            if(value == 0) value = 5;

            int locType = GetLocalInt(OBJECT_SELF, "JA_LOC_TYPE");

            int fromUnderdark = Subraces_GetIsCharacterFromUnderdark(oPC) + 1;

            float multiplicator = 10.0;

            if(locType != fromUnderdark){
                multiplicator = 12.5; //
            }

            int XPBonus = FloatToInt(multiplicator * value);

            SendMessageToPC(oPC, "Nalezl jsi novou oblast!");
            SetXP(oPC, GetXP(oPC)+XPBonus);
        }
    }


    ExecuteScript(GetLocalString(OBJECT_SELF, "onenter"), OBJECT_SELF);  //specialni skripty

    if(arena){//jedna se o arenu
        ExecuteScript("ja_arena_enter", OBJECT_SELF);
    }

    if(!mesto && !arena){ //neni to mesto ani arena
        spawn(oPC);
        int iDisable_spawn = GetLocalInt(OBJECT_SELF,"KU_LOC_DISABLE_SPAWN");
        if(!iDisable_spawn){
          lock_SpawnBosses(oLoc);
        }
    }

    DelayCommand(3.0, setFactionsToPC(oPC, getFaction(oPC))); //update frakci pro vstupujici postavu

    if(GetIsPC(oPC) && !GetIsDM(oPC)) {
      KU_Subraces_OnEnterArea( oPC );
      ExecuteScript("ku_shop_trigger", oPC);

      ApplyIndoorHidePenalty(oPC,TRUE);
    }


   if( (GetTag(OBJECT_SELF)=="Sferamrtvych") )
   {
        if (GetLocalInt(oSoul, "MOUNTED"))
        {
            AssignCommand(oPC, DelayCommand(0.0f, Dismount(oPC, oSoul, FALSE)));
            if(!GetIsDM(oPC) && (GetAppearanceType(oPC) != APPEARANCE_TYPE_SPECTRE))
                DelayCommand(1.0f, ApplyDeadlandsEffects(oPC, oSoul));
        }
        else
        {
            if( !GetIsDM(oPC) && (GetAppearanceType(oPC)!=APPEARANCE_TYPE_SPECTRE) )
                DelayCommand(0.0f, ApplyDeadlandsEffects(oPC, oSoul));
        }
   }
   // Dismount in interior areas
   else if (!GetIsAreaExterior(OBJECT_SELF) && GetLocalInt(oSoul, "MOUNTED"))
   {
        AssignCommand(oPC, DelayCommand(0.0f, Dismount(oPC, oSoul)));
   }

}

void ApplyDeadlandsEffects(object oPC, object oSoul)
{
    SetLocalInt(oSoul,"KU_PC_ALIVE_APPEARANCE",GetAppearanceType(oPC));
    SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_SPECTRE);
}
