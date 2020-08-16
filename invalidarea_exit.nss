void main()
{
    object oPC= GetExitingObject();
    object oTarget = GetObjectByTag("sh_invalidchar");
    DelayCommand(10.0,AssignCommand(oPC,JumpToObject(oTarget)));
}
