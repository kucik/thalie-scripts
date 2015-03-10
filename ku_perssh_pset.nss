//script ku_pers_sh_set
//Used in ku pers shop dialog
#include "ku_libchat"
#include "ku_persist_inc"

void main()
{
  object oPC = GetPCSpeaker();
  int iCnt = Persist_ShopGetNumberofMyItems(oPC);
  if(iCnt > 19) {
    SpeakString("Uz tady od tebe mam "+IntToString(iCnt)+" veci a vic uz nevezmu.");
    return;
  }

  int iIndex = GetLocalInt(oPC,"KU_CHAT_CACHE_INDEX");
  string sPrice = GetLocalString(oPC,KU_CHAT_CACHE+IntToString(iIndex));
  int iPrice = StringToInt(sPrice);
  object oItem = GetLocalObject(OBJECT_SELF,"actually_selling_item");
  int iStack = GetItemStackSize(oItem);
  if(iPrice < iStack) {
    iPrice = iStack;
  }
  sPrice = IntToString(iPrice);

  SetCustomToken(6021,sPrice);
  SetLocalInt(OBJECT_SELF,KU_PERS_SHOP_ITEMPRICE,iPrice);
}
