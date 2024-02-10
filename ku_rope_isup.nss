int StartingConditional()
{
  if(GetStringLength(GetLocalString(OBJECT_SELF,"DEST_UP")) > 0 &&
     GetStringLength(GetLocalString(OBJECT_SELF,"DEST_DOWN")) <= 0) {
    return TRUE;
  }
  return FALSE;
}
