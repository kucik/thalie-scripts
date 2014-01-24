// condicional jestli muzem nastavit jako otroka.
/*
 * release Kucik 25.04.2008
 */

#include "subraces"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oTarget = GetLocalObject(oPC,"ku_soul_target");
  if(!GetIsPC(oTarget)) {
//    SendMessageToPC(oPC,"Toto neni hracska postava.");
    return FALSE;
  }

  if(Subraces_GetIsCharacterFromUnderdark(oTarget ) == 1 ) {
//    SendMessageToPC(oPC,"Tato postava je z podtemna.");
    return FALSE;
  }

  if(Subraces_GetIsCharacterFromUnderdark(oPC ) == 1 )
    return TRUE;


  return FALSE;
}
