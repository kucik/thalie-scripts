//::///////////////////////////////////////////////
//:: cl_as_znacka
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

//:://////////////////////////////////////////////
void DeleteOZNACEN(object oTarget,string sName)
{
    if (GetLocalString(oTarget,"OZNACEN") == sName)
    {
         DeleteLocalString(oTarget,"OZNACEN");
    }
}


void main()
{
      object oAttacker = OBJECT_SELF;
      object oTarget = GetSpellTargetObject();
      string sName = GetName(oAttacker);
      SetLocalString(oTarget,"OZNACEN",sName);
      AssignCommand(oTarget,DelayCommand(TurnsToSeconds(5),DeleteOZNACEN(oTarget,sName)));


}
