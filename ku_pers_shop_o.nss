#include "ku_persist_inc"

void DescribeInv(object oCont, object oPC) {
  object oItem = GetFirstItemInInventory(oCont);
  while(GetIsObjectValid(oItem)) {
    int iPrice = GetLocalInt(oItem,"GOLDPIECEVALUE");
    SendMessageToPC(oPC,GetName(oItem)+" price: "+IntToString(GetGoldPieceValue(oItem))+ "("+IntToString(iPrice)+")");
//    SetGoldPieceValue(oItem,iPrice);
    oItem = GetNextItemInInventory(oCont);
  }
}

void main()
{
  Persist_OnShopOpen(OBJECT_SELF,GetLastOpenedBy());
  object oShop = OBJECT_SELF;
  object oPC = GetLastOpenedBy();

//  DelayCommand(3.0,DescribeInv(oShop,oPC));
}



