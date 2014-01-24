#include "ja_bank_inc"
#include "ja_tokens"

int StartingConditional()
{

    int iBallance = bank_GetBallance(GetPCSpeaker());

    if(iBallance <= 0) return FALSE;

    SetCustomToken( t_bank_ballance, IntToString(iBallance) );

    return TRUE;

}
