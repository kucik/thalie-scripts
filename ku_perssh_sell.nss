//Stript ku_perssh_sell
#include "ku_persist_inc"

void main()
{
  object oPC = GetPCSpeaker();
  object oSpeaker = OBJECT_SELF;
  int iCnt = Persist_ShopGetNumberofMyItems(oPC);
  if(iCnt > 19) {
    SpeakString("Uz tady od tebe mam "+IntToString(iCnt)+" veci a vic uz nevezmu.");
    return;
  }
  object oItem = GetLocalObject(oSpeaker,"actually_selling_item");
  int iPrice =   GetLocalInt(oSpeaker,KU_PERS_SHOP_ITEMPRICE);
                 SetLocalInt(oItem,KU_PERS_SHOP_ITEMPRICE,iPrice);
  int iStack = GetItemStackSize(oItem);
  iPrice = iPrice / iStack;

  SetGoldPieceValue(oItem,iPrice);
  Persist_ShopPutItemToShop(oItem,oPC);

}
