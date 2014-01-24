
    int StartingConditional()
{
    object oCust = GetLocalObject(OBJECT_SELF,"CUSTOMER");
    object oPC = GetPCSpeaker();
    if(GetIsObjectValid(oCust) && oCust == oPC)
      return TRUE;
    else
      return FALSE;
}
