//::///////////////////////////////////////////////
//:: Default: On Spawn In
//:: NW_C2_DEFAULT9
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the course of action to be taken
    after having just been spawned in
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 25, 2001
//:://////////////////////////////////////////////

void main()
{
    SetListenPattern(OBJECT_SELF, "**", 777); //listen to all text
    SetListening(OBJECT_SELF, TRUE);          //be sure NPC is listening

}


