object oPCspeaker =GetPCSpeaker();
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
void main()
{
  if (GetPlotFlag(oTarget))
                    {
                    SetPlotFlag(oTarget, FALSE);
                    SendMessageToPC(oPCspeaker,GetName(oTarget)+": is NOT plot related now");
                    }
                    else
                    {
                    SetPlotFlag(oTarget, TRUE);
                    SendMessageToPC(oPCspeaker,GetName(oTarget)+": is set to PLOT now");
                    }
                 }


