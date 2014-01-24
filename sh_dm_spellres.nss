#include "x2_inc_itemprop"

object oPCspeaker = GetPCSpeaker();
object oCheck2 = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck2,"DMSetNumber");
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
int iGPC =GetIsPC(oTarget);

object oTargetChest = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oTarget);


void main()
{
IPRemoveMatchingItemProperties(oTargetChest,ITEM_PROPERTY_SPELL_RESISTANCE,DURATION_TYPE_PERMANENT,-1);


effect eLoop=GetFirstEffect(oTarget);

while (GetIsEffectValid(eLoop))
   {
   if (GetEffectType(eLoop)==EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||GetEffectType(eLoop)==EFFECT_TYPE_SPELL_RESISTANCE_INCREASE )
         RemoveEffect(oTarget, eLoop);

   eLoop=GetNextEffect(oTarget);
   }
if(iDMSetNumber == 0)
{
return;
}


effect eMResist;

if(iDMSetNumber >=1)
{
eMResist = EffectSpellResistanceIncrease(iDMSetNumber);
}


effect eSuper =SupernaturalEffect(eMResist);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSuper,oTarget);

}

