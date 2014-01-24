
 object oPCspeaker =GetPCSpeaker();
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
void main()
{
  if (GetTrapOneShot(oTarget))
                    {
                    SetTrapOneShot(oTarget, FALSE);
                    SendMessageToPC(oPCspeaker,GetName(oTarget)+": Trap is repeatable");
                    }
                    else
                    {
                    SetTrapOneShot(oTarget, TRUE);
                    SendMessageToPC(oPCspeaker,GetName(oTarget)+": Trap is one shot");
                    }
                 }
