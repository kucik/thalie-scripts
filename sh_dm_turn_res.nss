#include "x2_inc_itemprop"

object oPCspeaker = GetPCSpeaker();
object oCheck2 = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck2,"DMSetNumber");
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
object oTargetChest = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oTarget);

void main()
{
IPRemoveMatchingItemProperties(oTargetChest,ITEM_PROPERTY_TURN_RESISTANCE,DURATION_TYPE_PERMANENT,-1);

effect eLoop=GetFirstEffect(oTarget);

while (GetIsEffectValid(eLoop))
   {
   if (GetEffectType(eLoop)==EFFECT_TYPE_TURN_RESISTANCE_DECREASE ||GetEffectType(eLoop)==EFFECT_TYPE_TURN_RESISTANCE_INCREASE)
         RemoveEffect(oTarget, eLoop);

   eLoop=GetNextEffect(oTarget);
   }

int iGHD =GetHitDice(oTarget);
int iTurnHD =GetTurnResistanceHD(oTarget);
int iTurnTotal = iGHD+ iTurnHD;
effect eMResist;



if(iDMSetNumber == 0)
{
eMResist = EffectTurnResistanceDecrease(iGHD);
effect eSuper =SupernaturalEffect(eMResist);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSuper,oTarget);
return;
}

if(iDMSetNumber < iGHD)
{
eMResist = EffectTurnResistanceDecrease(iGHD-iDMSetNumber);
effect eSuper =SupernaturalEffect(eMResist);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSuper,oTarget);
return;
}


if(iDMSetNumber > iGHD)
{
eMResist = EffectTurnResistanceIncrease(iDMSetNumber-iGHD);
effect eSuper =SupernaturalEffect(eMResist);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSuper,oTarget);
return;
}



}

