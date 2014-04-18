//////////////////////
// Get ILR from itemvalue.2da from item price and stack size
//
int GetILR(int iPrice, int iStack = 1);

//////////////////////
// Get ILR from itemvalue.2da from item.
//
int GetItemILR(object oItem);

int GetILR(int iPrice, int iStack = 1) {
  string sColumn;
  int i;

  if(iStack == 1)
    sColumn = "MAXSINGLEITEMVALUE";
  else 
    sColumn = "TOTALVALUEFILTER";

  for(i = 0; i <= 59; i++) {
    int iMaxPrice = Get2DAString("itemvalue", sColumn, i);
    if(iMaxPrice > iPrice)
      return i+1;
  }
 
  return 99;
}

int GetItemILR(object oItem) {
//  int iStolen = GetStolenFlag(oItem);
//  int iPlot = GetPlotFlag(oItem);
  int iPrice;
  int iStack;


//  if(iStolen)
//    SetStolenFlag(oItem, FALSE);
//  if(iPlot)
//    SetPlotFlag(oItem,FALSE);
  iPrice = GetGoldPieceValue(oItem);
//  if(iStolen)
//    SetStolenFlag(oItem, iStolen);
//  if(iPlot)
//      SetPlotFlag(oItem,TRUE);

  iStack = GetItemStackSize(oItem);
  return GetILR(iPrice, iStack);
}
