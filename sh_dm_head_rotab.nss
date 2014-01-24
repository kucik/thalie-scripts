//Cep rotate heads
object oPCspeaker = GetPCSpeaker();
string sDMstring = GetLocalString(oPCspeaker,"DMstring");
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
int iGetHead =GetCreatureBodyPart(CREATURE_PART_HEAD,oTarget);
string sGetHead =IntToString(iGetHead);
int iGetRace=GetRacialType(oTarget);
int iGender =GetGender(oTarget);
int iRaceMaxhead;

void main()
{

if(iGetHead>1)
SetCreatureBodyPart(CREATURE_PART_HEAD,iGetHead-1,oTarget);
}
