void main()
{
    object oUser = GetPCSpeaker();
    AssignCommand(OBJECT_SELF,ActionSpeakString("Tak takove hrace tady nechceme. Dozivotni ban!")) ;
    DelayCommand(6.0,BootPC(oUser));
}
