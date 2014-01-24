#include "ja_lib"
/*
 * melvik upava na novy zpusob nacitani soulstone 16.5.2009
 */
int StartingConditional()
{

    return FALSE;

    object oPC = GetPCSpeaker();
    if(GetLocalInt(GetSoulStone(oPC),"KU_ZLODEJ"))
      return TRUE;
    else
      return FALSE;
}
