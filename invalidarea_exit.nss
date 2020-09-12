void main()
{
    object oPC= GetExitingObject();
    int iRogueClass = GetLevelByClass(CLASS_TYPE_ROGUE,oPC);
    int iHasRogueWeapons = GetHasFeat(FEAT_WEAPON_PROFICIENCY_ROGUE,oPC);
    object oTarget = GetObjectByTag("sh_invalidchar");
    if ((iRogueClass>0)&&(iHasRogueWeapons==FALSE))
    {
        DelayCommand(10.0,AssignCommand(oPC,JumpToObject(oTarget)));
    }
}
