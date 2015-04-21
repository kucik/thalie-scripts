#include "subraces"

void UnequipItemsAfterDelevel(object oPC);


void Raise(object oPlayer)
{
 effect eEff = GetFirstEffect(oPlayer);
 ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPlayer);
 ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPlayer)), oPlayer);

 //Search for effects
 while(GetIsEffectValid(eEff))
 {

   RemoveEffect(oPlayer, eEff);
   eEff = GetNextEffect(oPlayer);
 }
 Subraces_RespawnSubrace( oPlayer );

/* DelayCommand( 1.0,UnequipItemsAfterDelevel(oPlayer));
 DelayCommand(10.0,UnequipItemsAfterDelevel(oPlayer));
 DelayCommand(30.0,UnequipItemsAfterDelevel(oPlayer));
 DelayCommand(60.0,UnequipItemsAfterDelevel(oPlayer));
 DelayCommand(90.0,UnequipItemsAfterDelevel(oPlayer));*/
}

int GetItemRequiedLevel(object oItem) {

  int iPlot,iStolen;
  iStolen = GetStolenFlag(oItem);
  iPlot = GetPlotFlag(oItem);
  SetStolenFlag(oItem,0);
  SetPlotFlag(oItem,0);

  int iPrice= GetGoldPieceValue(oItem);
  int iLevel;
  int iRow = 0;
  while( StringToInt(Get2DAString("itemvalue","MAXSINGLEITEMVALUE",iRow)) < iPrice) {
    iRow++;
  }

  // Level je vzdy radek + 1;
  iRow++;
  return iRow;
}

void UnequipItemsAfterDelevel(object oPC) {
  if(!GetIsPC(oPC)) {
    return;
  }

  int i;
  object oItem;
  int iHD = GetHitDice(oPC);
  int ILR;

  for(i=0;i<NUM_INVENTORY_SLOTS;i++) {
    oItem = GetItemInSlot(i,oPC);
    if(GetIsObjectValid(oItem)) {
      ILR = GetItemRequiedLevel(oItem);
      if(ILR > iHD) {
        AssignCommand(oPC,ActionUnequipItem(oItem));
      }
    }
  }

}

