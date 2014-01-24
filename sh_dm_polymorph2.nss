//polymorph that cannot be canceled by PC

object oPCspeaker = GetPCSpeaker();
object oCheck2 = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck2,"DMSetNumber");
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");


void Removepoly(object oTarget)
 {
 object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
  effect eEffect = GetFirstEffect(oTarget);
   while(GetIsEffectValid(eEffect))
   {
       if(GetEffectType(eEffect) == EFFECT_TYPE_POLYMORPH)
       {
       RemoveEffect(oTarget,eEffect);
       return;
          }
       else
          {

       effect eEffect = GetNextEffect(oTarget);
       }
       }
       }

void Poly()
{
effect ePoly =EffectPolymorph(iDMSetNumber,FALSE);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,ePoly,oTarget);
}

void main()
{

Removepoly(oTarget);

DelayCommand(0.4, Poly());

}
