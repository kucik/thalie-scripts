void main()
{
  object oCont = OBJECT_SELF;
  /* First init */
  if(GetLocalInt(oCont,"KU_PERS_FIRST_OPEN") != 1 && GetIsOpen(oCont) == FALSE) {
    SetLocalInt(oCont,"LOCKED",GetLocked(oCont));
    SetLocalInt(oCont,"LOCK_KEY_REQUIED",GetLockKeyRequired(oCont));
    SetLocalString(oCont,"LOCK_KEY_TAG",GetLockKeyTag(oCont));
    SetLocalInt(oCont,"KU_PERS_FIRST_OPEN",1);
  }
//  SpeakString("LOCKED - "+IntToString(GetLocalInt(oCont,"LOCKED")));
//  SpeakString("KEY REQ - "+IntToString(GetLocalInt(oCont,"LOCK_KEY_REQUIED")));
//  SpeakString("KEY  - "+GetLocalString(oCont,"LOCK_KEY_TAG"));

}
