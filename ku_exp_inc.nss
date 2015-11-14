// ku_exp_inc.nss
///ku_GetLevelForXP

#include "aps_include"
#include "me_soul_inc"

// Library for handling PC Experience Points (XP).


// Calculate character level from ammount of experiences
int ku_GetLevelForXP(int XP);


// Reduce XP given to PC by experience debt after death.
int ku_ReduceXPGainForDeath(object oPC, int iXP, int bTimeXP = FALSE);

// Add to PC XP debt
void ku_GiveXPDebt(object oPC, int iXP);


int ku_SaveXPPerKill(object oPC, int xp);

// Get player XP debt
int ku_GetXpDebt(object oPC);

const int NT_PC_MAX_XP = 3900000; //40. level

/////////////////////////////////////////////////////////////////
// Function definitions
/////////////////////////////////////////////////////////////////

int ku_GetLevelForXP(int XP) {
  return FloatToInt(0.5 + sqrt(0.25 + ( IntToFloat(XP) / 2500.0 ))); //5000xp per level
}

int ku_GetXpDebt(object oPC) {
  if (!GetIsPC(oPC) || GetIsDM(oPC) || GetIsDMPossessed(oPC) || GetIsPossessedFamiliar(oPC))
        return 0;

  int iXPDebt = GetPersistentInt(oPC,"XP_DEBT");


  if(iXPDebt == 0) {
    object oSoul = GetSoulStone(oPC);
    iXPDebt = GetLocalInt(oSoul,"KU_XP_DEBT");
    SetPersistentInt(oPC, "XP_DEBT", iXPDebt);
    DeleteLocalInt(oSoul, "KU_XP_DEBT");
  }
  return iXPDebt;
}

int ku_ReduceXPGainForDeath(object oPC, int iXP, int bTimeXP = FALSE) {
  if (!GetIsPC(oPC) || GetIsDM(oPC) || GetIsDMPossessed(oPC) || GetIsPossessedFamiliar(oPC))
        return iXP;

  int iXPDebt = ku_GetXpDebt(oPC);

  if(iXPDebt <= 0)
    return iXP;

  // smaller half of xp
  int GiveXP;
  if( ( 100 * iXPDebt) / GetXP(oPC) >= 15)
    GiveXP = iXP / 10;
  else
    GiveXP = iXP / 2;

  // Update debt
  if(bTimeXP)
    //SetLocalInt(oSoul,"KU_XP_DEBT",iXPDebt - (2*(iXP - GiveXP)));
    SetPersistentInt(oPC, "XP_DEBT", iXPDebt - (2*(iXP - GiveXP)));
  else
    //SetLocalInt(oSoul,"XP_DEBT",iXPDebt - (iXP - GiveXP));
    SetPersistentInt(oPC, "XP_DEBT", iXPDebt - (iXP - GiveXP));

  return GiveXP;

}

void ku_GiveXP(object oPC, int XP) {

  int xp_limit = FALSE;
  // if(GetXP(oPC) > 525000) return; //15. level
  if(GetXP(oPC) > NT_PC_MAX_XP)
    xp_limit = TRUE;; //30 level

  if(XP <= 0)
    return;


  XP = ku_ReduceXPGainForDeath(oPC, XP, FALSE);

  if(XP <= 0)
    return;

  object oSoul = GetSoulStone(oPC);

  if(!xp_limit) {
    SetXP(oPC,GetXP(oPC) + XP);
//    SetLocalInt(oSoul,"ku_XPbyXPPT",XPbyXPPT + XP);
  }
}

void ku_GiveXPDebt(object oPC, int iXP) {
  if (!GetIsPC(oPC) || GetIsDM(oPC) || GetIsDMPossessed(oPC) || GetIsPossessedFamiliar(oPC))
        return;

  int iXPDebt = ku_GetXpDebt(oPC);
  int iPCXP = GetXP(oPC);

  // Reduce debt if current debt is more than 15% XP
  if( (iXP / 0.15) >  IntToFloat(GetXP(oPC)) )
    iXP = iXP /2;

  // in case of bug
  if(iXPDebt < 0)
    iXPDebt = 0;

  SetPersistentInt(oPC, "XP_DEBT", iXPDebt + iXP);

}

int ku_SaveXPPerKill(object oPC, int xp)
{
 if (!GetIsPC(oPC) || GetIsDM(oPC) || GetIsDMPossessed(oPC) || GetIsPossessedFamiliar(oPC))
        return xp;

 object oSoul = GetSoulStone(oPC);
 float xpk = IntToFloat(GetLocalInt(oSoul,"ku_XPbyKill"));

 if(xp == 0)
  return 0;

 if(xp<1)                                                 //1xp
   xp=1;

 SetLocalInt(oSoul,"ku_XPbyKill",FloatToInt(xpk) + xp);   //ukladani expu ze zabitych NPC
 return xp;

}

