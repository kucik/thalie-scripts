// ku_exp_inc.nss
///ku_GetLevelForXP


#include "me_soul_inc"

// Library for handling PC Experience Points (XP).


// Calculate character level from ammount of experiences
int ku_GetLevelForXP(int XP);

int ku_SaveXPPerKill(object oPC, int xp);

const int NT_PC_MAX_XP = 3900000; //40. level

/////////////////////////////////////////////////////////////////
// Function definitions
/////////////////////////////////////////////////////////////////

int ku_GetLevelForXP(int XP) {
  return FloatToInt(0.5 + sqrt(0.25 + ( IntToFloat(XP) / 2500.0 ))); //5000xp per level
}

void ku_GiveXP(object oPC, int XP) {

  int xp_limit = FALSE;
  // if(GetXP(oPC) > 525000) return; //15. level
  if(GetXP(oPC) > NT_PC_MAX_XP)
    xp_limit = TRUE;; //30 level

  if(XP <= 0)
    return;

  if(!xp_limit) {
    SetXP(oPC,GetXP(oPC) + XP);
  }
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

