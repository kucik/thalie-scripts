/*
 * On disturbed pro persristentni obchody
 *
 *
 */

#include "ku_libtime"
#include "ku_persist_inc"

int GetMaxStack(int iBaseItem) {
  return StringToInt(Get2DAString("BASEITEMS","STACKING",iBaseItem));
}

int ShopSetBuyTimeStamp(object oItem, object oFrom) {

 if( GetObjectType(oFrom) != OBJECT_TYPE_STORE) {
   return FALSE;
 }

 if(GetMaxStack(GetBaseItemType(oItem)) > 1) {
   return FALSE;
 }
 SetLocalInt(oItem,"KU_ITEM_BOUGHT_STAMP",ku_GetTimeStamp());
 return TRUE;
}

void main()
{
   object oFrom = GetModuleItemAcquiredFrom();
   object oItem = GetModuleItemAcquired();
   object oPC   = GetModuleItemAcquiredBy();
   if(Persist_ShopDisturbedItem(oItem,oPC,oFrom) == 0) {
     ShopSetBuyTimeStamp(oItem, oFrom);
   }


}
