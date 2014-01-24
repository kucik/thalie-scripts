#include "nw_o2_coninclude"


void main()
{
  object oBox = OBJECT_SELF;

  /* Clear inventory */
  object oItem = GetFirstItemInInventory(oBox);
  while(GetIsObjectValid(oItem)) {
    DestroyObject(oItem,0.2);
    oItem = GetNextItemInInventory(oBox);
  }

  int i = GetLocalInt(oBox,"power");
  if(i <= 0)
   i = 1;
  string sLoot = GetTag(oBox)+IntToString(i);
  SetLocalString(oBox,"LOOT",sLoot);

  SpeakString("Test: Generating boss loot "+sLoot);
  ku_LootCreateBossUniqueLootItems(oBox);

}
