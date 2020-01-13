void main()
{
    object oPC = GetLastUsedBy();
    string sTargetTag = GetLocalString(OBJECT_SELF,"PORTAL_TARGET");
    if (sTargetTag!="")
    {
        object oTownGate = GetObjectByTag(sTargetTag);
        if (GetIsObjectValid(oTownGate))
        {
            DelayCommand(1.0f, AssignCommand(oPC, JumpToObject(oTownGate)));
        }
    }
}
