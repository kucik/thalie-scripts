void main()
{
    location lTarget = GetSpellTargetLocation();
    AssignCommand(OBJECT_SELF,DelayCommand(2.0,ActionJumpToLocation(lTarget)));


}
