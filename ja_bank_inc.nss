/*

    BANKING SYSTEM BY JAARA ON 31.5.2006

*/

#include "aps_include"

//CONSTANTS

const int bank_CommandPut = 1;
const int bank_CommandGet = 2;

const int bank_Success   = 0;
const int bank_Failture = -1;

/*string GetID(object oPC){
  return GetPCPlayerName(oPC)+"_"+GetName(oPC)+"_GOLD";
} */

//DECLARATIONS

//Puts a specified amount of gold to character's account from pouch
int bank_PutInAccount(object oPC, int iAmount);

//Gets a specified amount of gold from character's account to pouch
int bank_GetFromAccount(object oPC, int iAmount);

//Gets amount of gold remaining in account
int bank_GetBallance(object oPC);


//DEFINITIONS

//Puts a specified amount of gold to character's account from pouch
int bank_PutInAccount(object oPC, int iAmount){
    if(!GetIsObjectValid(oPC)) return bank_Failture;

    int iLocalGold = GetGold(oPC);
    if(iAmount > iLocalGold) return bank_Failture;

   // string sID = GetID(oPC);

    int iBallance = bank_GetBallance(oPC);

    TakeGoldFromCreature(iAmount, oPC, TRUE);

    iAmount = FloatToInt(iAmount - iAmount*0.01);

    iBallance += iAmount;

    SetPersistentInt(oPC, "GOLD", iBallance);

    return bank_Success;
}

//Gets a specified amount of gold from character's account to pouch
int bank_GetFromAccount(object oPC, int iAmount){
    if(!GetIsObjectValid(oPC)) return bank_Failture;

  // string sID = GetID(oPC);

    int iBallance = bank_GetBallance(oPC);

    if(iAmount > iBallance) return bank_Failture;

    GiveGoldToCreature(oPC, iAmount);

    iBallance -= iAmount;

    SetPersistentInt(oPC, "GOLD", iBallance);

    return bank_Success;
}

//Gets amount of gold remaining in account
int bank_GetBallance(object oPC){
    if(!GetIsObjectValid(oPC)) return bank_Failture;

  //  string sID = GetID(oPC);

    int iBallance = GetPersistentInt(oPC, "GOLD");

    return iBallance;
}

