//#include "ja_lib"

int CheckItemForCopy(object oItem) {
  string sTag = GetTag(oItem);
  if(sTag == "sy_soulstone")
    return FALSE;

  if(GetPlotFlag(oItem))
    return FALSE;

  if(GetBaseItemType(oItem) == BASE_ITEM_TRAPKIT)
    return FALSE;

  if(GetStolenFlag(oItem))
    return TRUE;

  return FALSE;
}

void main()
{
  object oPC = GetPCSpeaker();
  object oCorpse = OBJECT_SELF;
  string sPlayerName = GetLocalString(OBJECT_SELF, "PLAYER");
  string sPCName = GetLocalString(OBJECT_SELF, "PC");

//  object oDead = FindPCByName(sPCName);
  object oDead = GetFirstPC();
  while(oDead != OBJECT_INVALID) {
    if(GetPCPlayerName(oDead) == sPlayerName && GetName(oDead) == sPCName)
      break;

    oDead = GetNextPC();
    if(oDead == OBJECT_INVALID) {
      SpeakString("//Hrac "+sPCName+" s postavou "+sPlayerName+" neni ve hre!");
      return;
    }
  }

  SetLocalInt(OBJECT_SELF,"OPEN_INVENTORY",1);
  DelayCommand(2.0f,SetLocalInt(OBJECT_SELF,"OPEN_INVENTORY",0));
  AssignCommand(oPC,DoPlaceableObjectAction(oCorpse,PLACEABLE_ACTION_USE));

  /* Copy items */
  object oItem = GetFirstItemInInventory(oDead);
  while(GetIsObjectValid(oItem)) {
    if(CheckItemForCopy(oItem)) {
      CopyItem(oItem,oCorpse,TRUE);
      DestroyObject(oItem,0.5f);
    }
    oItem = GetNextItemInInventory(oDead);
  }

  /* Copy Gold */
  int iGold = GetGold(oDead);
  if(iGold > 50000) {
    iGold = 50000;
  }
  TakeGoldFromCreature(iGold,oDead,TRUE);
  CreateItemOnObject("NW_IT_GOLD001",oCorpse,iGold);
}
