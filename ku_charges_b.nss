int iGetPrice(object oItem) {
 if(GetIsObjectValid(oItem)) {
    int bPlot = GetPlotFlag(oItem);
    SetPlotFlag(oItem,0);
    int iCost = GetGoldPieceValue(oItem);
    SetPlotFlag(oItem,bPlot);
    if(GetBaseItemType(oItem) == BASE_ITEM_TORCH)
      iCost = iCost * (50 - GetItemCharges(oItem)) / 20;
    else 
      iCost = iCost * (50 - GetItemCharges(oItem)) / 25;
    return iCost;
 }
 return 0;

}

void main()
{
  object oItem = GetFirstItemInInventory(OBJECT_SELF);
  object oChest = OBJECT_SELF;
  object oPC = GetLastClosedBy();


  if(GetIsObjectValid(oItem)) {
    object oChargeNPC = GetLocalObject(OBJECT_SELF,"MY_RECHARGER_NPC");
    if(!GetIsObjectValid(oChargeNPC)) {
      oChargeNPC = GetNearestObjectByTag("ku_charger_npc");
      SetLocalObject(oChargeNPC,"MY_RECHARGER_NPC",oChest);
      SetLocalObject(oChest,"MY_RECHARGER_CHEST",oChargeNPC);
    }
    SetCustomToken(6050,GetName(oItem));
    SetLocalObject(oChargeNPC,"MY_RECHARGER_ITEM",oItem);


    int iCost = iCost = iGetPrice(oItem);

    SetCustomToken(6051,IntToString(iCost));

    DelayCommand(0.5,AssignCommand(oPC,ActionStartConversation(oChargeNPC,"ku_recharger_dlg",FALSE,FALSE)));
  }

}
