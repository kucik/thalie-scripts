int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(),"KU_HIRE_HIREDOK")) {
      return TRUE;

    }
    else {
      return FALSE;
    }
}
