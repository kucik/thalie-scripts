int StartingConditional()
{
    if(GetLocalInt(OBJECT_SELF,"working"))
      return FALSE;
    if(GetIsObjectValid(GetLocalObject(OBJECT_SELF,"CUSTOMER")))
      return FALSE;
    else
      return TRUE;
}
