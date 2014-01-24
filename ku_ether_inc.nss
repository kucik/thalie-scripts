/**
 * Thalie Etherealnes library
 */

#include "nwnx_visibility"

int ku_GetIsEthereal(object oPC);

void ku_RemoveFromEthereals(object oPC);

void ku_CheckEtherealPC(object oPC) {
  if(!GetIsPC(oPC)) {
    return;
  }

  if(ku_GetIsEthereal(oPC)) {
    return;
  }

  if(GetLocalInt(oPC,"KU_ETHEREALNES")) {
    ku_RemoveFromEthereals(oPC);

  }

}


int ku_GetIsEthereal(object oPC) {

  return GetHasSpellEffect(SPELL_ETHEREALNESS,oPC);
}


void ku_RemoveFromEthereals(object oPC) {

  if(!GetIsObjectValid(oPC)) {
    return;
  }

  SetVisibilityOverride(oPC,VISIBILITY_TYPE_DEFAULT);
  DeleteLocalInt(oPC,"KU_ETHEREALNES");

  object oMod = GetModule();
  object oEth;
  int iCount = GetLocalInt(oMod,"KU_ETHEREALS_CNT");
  int i;

  for(i=1;i<=iCount;i++) {
    oEth = GetLocalObject(oMod,"KU_ETHEREAL"+IntToString(i));
    if(oEth == oPC) {
      SetLocalObject(oMod,"KU_ETHEREAL"+IntToString(i),GetLocalObject(oMod,"KU_ETHEREAL"+IntToString(iCount)));
      iCount--;
      SetLocalInt(oMod,"KU_ETHEREALS_CNT",iCount);
    }
    else if(GetIsObjectValid(oEth)) {
//      SetVisibility(oPC,oEth,VISIBILITY_TYPE_DEFAULT);
//      SetVisibility(oEth,oPC,VISIBILITY_TYPE_INVISIBLE);
    }

  }

}


void ku_AddToEthereals(object oPC) {

  if(!GetIsObjectValid(oPC)) {
    return;
  }

  object oMod = GetModule();
  object oEth;
  int iCount = GetLocalInt(oMod,"KU_ETHEREALS_CNT");
  int iPresent = 0;
  int i;

  SetVisibilityOverride(oPC,VISIBILITY_TYPE_DEFAULT);
  SetLocalInt(oPC,"KU_ETHEREALNES",TRUE);

  for(i=1;i<=iCount;i++) {
    oEth = GetLocalObject(oMod,"KU_ETHEREAL"+IntToString(i));
    if(oEth == oPC) {
      iPresent = 1;
    }
    else if(GetIsObjectValid(oEth)) {
//      SetVisibility(oPC,oEth,VISIBILITY_TYPE_VISIBLE);
//      SetVisibility(oEth,oPC,VISIBILITY_TYPE_VISIBLE);
    }

  }

  if(!iPresent) {
    iCount++;
    SetLocalInt(oMod,"KU_ETHEREALS_CNT",iCount);
    SetLocalObject(oMod,"KU_ETHEREAL"+IntToString(iCount),oPC);
  }
}

void ku_EtherealClientEnter(object oPC) {

  if(GetIsDM(oPC)) {
    return;
  }

  if(ku_GetIsEthereal(oPC)) {
    ku_AddToEthereals(oPC);
  }
  else {
    ku_RemoveFromEthereals(oPC);
  }
}

void ku_EtherealClientLeave(object oPC) {

  if(GetIsDM(oPC)) {
    return;
  }

  if(ku_GetIsEthereal(oPC)) {
    ku_RemoveFromEthereals(oPC);
  }

}

void ku_EtherealsCheck() {

  object oMod = GetModule();
  object oEth;
  int iCount = GetLocalInt(oMod,"KU_ETHEREALS_CNT");
  int i;

  for(i=1;i<=iCount;i++) {
    oEth = GetLocalObject(oMod,"KU_ETHEREAL"+IntToString(i));
    if(GetIsObjectValid(oEth) &&
        !ku_GetIsEthereal(oEth)) {
      ku_RemoveFromEthereals(oEth);
      iCount = GetLocalInt(oMod,"KU_ETHEREALS_CNT");
    }
  }

}

void ku_DumpEthers() {

  object oMod = GetModule();
  object oEth;
  int iCount = GetLocalInt(oMod,"KU_ETHEREALS_CNT");
  int i;

  for(i=1;i<=iCount;i++) {
    oEth = GetLocalObject(oMod,"KU_ETHEREAL"+IntToString(i));
    SendMessageToPC(GetFirstPC(),"Ethers "+IntToString(i)+": "+GetName(oEth));
  }

}

void ku_EtherRemoveEtherealnes(object oPC) {

  effect eff = GetFirstEffect(oPC);
  while(GetIsEffectValid(eff)) {
    if(GetEffectType(eff) == EFFECT_TYPE_ETHEREAL) {
      RemoveEffect(oPC,eff);
//      ku_RemoveFromEthereals(oPC);
    }
    eff = GetNextEffect(oPC);
  }
  ku_RemoveFromEthereals(oPC);
}

int ku_EtherSpellCheck(object oCaster, int iSpell, object oTarget) {

  if(!ku_GetIsEthereal(oCaster)) {
    return 0;
  }

  if(GetIsObjectValid(oTarget) && ku_GetIsEthereal(oTarget)) {
    return 0;
  }
  else {
    return 1;
  }


}

