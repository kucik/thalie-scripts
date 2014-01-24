//::///////////////////////////////////////////////
//:: FileName zz_dat_5xp
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 29.10.2007 18:13:02
//:://////////////////////////////////////////////
void main()
{

    // Dát mluvèímu nìjaké zkušenosti
    if(GetLocalInt(GetPCSpeaker(),"QUEST_FINISHED_#"+GetTag(GetArea(OBJECT_SELF))+"#"+GetTag(OBJECT_SELF))) {
      return;
    }
    SetLocalInt(GetPCSpeaker(),"QUEST_FINISHED_#"+GetTag(GetArea(OBJECT_SELF))+"#"+GetTag(OBJECT_SELF),TRUE);
    GiveXPToCreature(GetPCSpeaker(), 5);

}
