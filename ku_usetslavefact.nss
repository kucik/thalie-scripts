/*
 * release Kucik 08.01.2008
 */
#include "ja_inc_frakce"

void main()
{
 object oPC = GetPCSpeaker();
 object oTarget = GetLocalObject(oPC,"ku_soul_target");

  if(!GetIsPC(oTarget)) {
    SendMessageToPC(oPC,"Toto neni hracska postava.");
    return;
  }

  if(Subraces_GetIsCharacterFromUnderdark(oTarget ) == 1 ) {
    SendMessageToPC(oPC,"Tato postava je z podtemna.");
    return;
  }

  if(Subraces_GetIsCharacterFromUnderdark(oPC ) == 1 ) {

   setFactionsToPC(oTarget,0);
   SendMessageToPC(oPC,"Postave " + GetName(oTarget) + " byla zrusena frakce.");
 }
 else
   SendMessageToPC(oPC,"Nemuzes nastavovat tyto frakce.");

 DeleteLocalObject(oPC,"ku_soul_target");
}
