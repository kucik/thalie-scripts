
#include "x2_inc_itemprop"
 object oPCspeaker =GetPCSpeaker();
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
itemproperty IP_DMFeat =ItemPropertyBonusFeat(1096);
object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oTarget);
object oHide2=GetObjectByTag("dmfi_onering");
object oWand=GetObjectByTag("dmfi_dmw");
void main()
{
if(GetIsPC(oTarget))
{
SetPlotFlag(oTarget,FALSE);
effect eLoop=GetFirstEffect(oTarget);

while (GetIsEffectValid(eLoop))
   {
   if (GetEffectType(eLoop)==EFFECT_TYPE_ETHEREAL)
         RemoveEffect(oTarget, eLoop);

   eLoop=GetNextEffect(oTarget);
   }
}

if(!GetIsDM(oTarget) && oCheck != OBJECT_INVALID && oCheck ==oHide2)
{
DestroyObject(oCheck,0.1);

}
  else
  {
if(oCheck != OBJECT_INVALID && oCheck !=oHide2 && !GetIsDM(oTarget))
{
//DestroyObject(oWand,0.1);
IPRemoveMatchingItemProperties(oCheck,ITEM_PROPERTY_BONUS_FEAT,DURATION_TYPE_PERMANENT,41);
//RemoveItemProperty(oCheck,IP_DMFeat);
}
}
}

