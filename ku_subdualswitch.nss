// melvik upava na novy zpusob nacitani soulstone 16.5.2009
#include "me_soul_inc"
void main()
{
  object oPC = GetPCSpeaker();
  int isubdual;
  object oTarget = GetLocalObject(oPC,"KU_DM_WAND_USED_TO");
  object oSoul = GetSoulStone(oPC);

  if( !GetIsDM(oPC) ) {
    object oSoul = GetSoulStone(oPC);
    isubdual = GetLocalInt(oPC,"SUBDUAL_MODE");
    if(isubdual > 1) {
      SendMessageToPC(oPC,"Stinova zraneni vypnuta!!!");
      SetLocalInt(oPC,"SUBDUAL_MODE",1);
      SetLocalInt(oSoul,"SUBDUAL_MODE",1);
    }
    else {
      SendMessageToPC(oPC,"Stinova zraneni zapnuta.");
      SetLocalInt(oPC,"SUBDUAL_MODE",2);
      SetLocalInt(oSoul,"SUBDUAL_MODE",2);
    }


  }
  else {
    isubdual = GetLocalInt(oTarget,"SUBDUAL_MODE");
    if(isubdual > 1) {
      SendMessageToPC(oPC,"Stinova zraneni na "+GetName(oTarget)+" vypnuta.");
      SetLocalInt(oTarget,"SUBDUAL_MODE",1);
    }
    else {
      SendMessageToPC(oPC,"Stinova zraneni na "+GetName(oTarget)+" zapnuta.");
      SetLocalInt(oTarget,"SUBDUAL_MODE",2);
    }
  }


}
