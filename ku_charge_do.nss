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
  object oChargeNPC = OBJECT_SELF;
  object oItem = GetLocalObject(oChargeNPC,"MY_RECHARGER_ITEM");
  object oChest = GetLocalObject(oChargeNPC,"MY_RECHARGER_NPC");
  object oPC = GetPCSpeaker();


  if(GetIsObjectValid(oItem)) {
/*    object oChargeNPC = GetLocalObject(OBJECT_SELF,"MY_RECHARGER_NPC");
    if(!GetIsObjectValid(oChargeNPC)) {
      oChargeNPC = GetNearestObjectByTag("ku_charger_npc");
      SetLocalObject(oChargeNPC,"MY_RECHARGER_NPC",oChest);
      SetLocalObject(oChest,"MY_RECHARGER_CHEST",oChargeNPC);
    }
    SetCustomToken(6050,GetName(oItem));
*/

    int iCost = iGetPrice(oItem);
//    SetCustomToken(6051,IntToString(iCost));


    if(GetGold(oPC) < iCost ) {
      SpeakString("Nemas dost penez.");
      return;
    }

    TakeGoldFromCreature(iCost,oPC,TRUE);
    SetItemCharges(oItem,50);
    DeleteLocalObject(oChargeNPC,"MY_RECHARGER_ITEM");
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION),GetLocation(oChest));
  }

}
