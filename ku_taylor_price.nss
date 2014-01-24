#include "ku_taylor_inc"

void main()
{
  object oDyer = OBJECT_SELF;
  object oCloth = GetLocalObject(oDyer,"ITEM");
  object oOldCloth = GetLocalObject(oDyer,"ITEM_BACKUP");
  SetCustomToken(6001,IntToString(ku_TaylorCalculatePrice(oCloth,oOldCloth)));
}
