int StartingConditional()
{
    if(GetLocalInt(OBJECT_SELF,"DYER_MACHINE_ACTIVATED"))
      return FALSE;
    else
      return TRUE;

}
