/*
 * Versions
 *
 * jaara 28.1.08
 */


int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oCorpse = GetLocalObject(oPC, "mrtvola");
    object oDeadPC = GetFirstPC();
    string sPlayerName = GetLocalString(oCorpse, "PLAYER");
    string sPCName = GetLocalString(oCorpse, "PC");
    int iPrice = 0;

    while( (oDeadPC != OBJECT_INVALID) ){
       if(GetPCPlayerName(oDeadPC) == sPlayerName && GetName(oDeadPC) == sPCName){
         int ilvl = GetHitDice(oDeadPC);
         iPrice = ilvl * ilvl * 50;
         break;
       }
       oDeadPC = GetNextPC();
    }

    SetLocalInt(oPC, "JA_RESSURECT_PRICE", iPrice);

    SetCustomToken(70001, IntToString(iPrice));


    return TRUE;
}
