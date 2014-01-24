#include "x2_inc_itemprop"
 object oPCspeaker =GetPCSpeaker();
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
itemproperty ip_dmfeat = ItemPropertyBonusFeat(1096);
itemproperty ip_DmSpeak = ItemPropertyBonusFeat(1097);
object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oTarget);


void main()
{
if(GetIsPC(oTarget))
{
SetPlotFlag(oTarget,TRUE);
effect eEthereal = EffectEthereal();
effect supereEthereal =SupernaturalEffect(eEthereal);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, supereEthereal, oTarget);
}
if(oCheck!=OBJECT_INVALID)
{
   AddItemProperty(DURATION_TYPE_PERMANENT,ip_dmfeat,oCheck);
   AddItemProperty(DURATION_TYPE_PERMANENT,ip_DmSpeak,oCheck);
}
  else
  {
if(oCheck==OBJECT_INVALID)
{
  CreateItemOnObject("dmfi_onering", oTarget);
  object oHide2=GetObjectByTag("dmfi_onering");
  AssignCommand(oTarget, ActionEquipItem(oHide2, INVENTORY_SLOT_CARMOUR));
}
}
}
