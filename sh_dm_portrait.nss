 object oPCspeaker =GetPCSpeaker();
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
string sDMstring = GetLocalString(oPCspeaker,"DMstring");
void main()
{

SetPortraitResRef(oTarget, sDMstring);
}

