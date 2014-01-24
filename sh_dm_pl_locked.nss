
object oPCspeaker =GetPCSpeaker();
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
void main()
{
  if (GetLocked(oTarget))
                    {
                    SetLocked(oTarget, FALSE);
                    SendMessageToPC(oPCspeaker,GetName(oTarget)+": is not locked now");
                    }
                    else
                    {
                    SetLocked(oTarget, TRUE);
                    SendMessageToPC(oPCspeaker,GetName(oTarget)+":is locked now");
                    }
                 }


