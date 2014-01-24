//Stript ku_perssh_sell
#include "ku_persist_inc"

void main()
{
  object oPC = GetPCSpeaker();
  object oSpeaker = OBJECT_SELF;
  object oItem = GetLocalObject(oSpeaker,"actually_selling_item");
  int iPrice =   GetLocalInt(oSpeaker,KU_PERS_SHOP_ITEMPRICE);
                 SetLocalInt(oItem,KU_PERS_SHOP_ITEMPRICE,iPrice);
  int iStack = GetItemStackSize(oItem);
  iPrice = iPrice / iStack;

  SetGoldPieceValue(oItem,iPrice);
  Persist_ShopPutItemToShop(oItem,oPC);

}
