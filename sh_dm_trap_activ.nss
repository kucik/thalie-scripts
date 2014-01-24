


 object oPCspeaker =GetPCSpeaker();
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
void main()
{
  if (GetTrapActive(oTarget))
                    {
                    SetTrapActive(oTarget, FALSE);
                    SendMessageToPC(oPCspeaker,GetName(oTarget)+": Trap is not active now");
                    }
                    else
                    {
                    SetTrapActive(oTarget, TRUE);
                    SendMessageToPC(oPCspeaker,GetName(oTarget)+": Trap is active now");
                    }
                 }


