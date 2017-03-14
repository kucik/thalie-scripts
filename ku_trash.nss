/*
* kucik
* Simple script useable for trashes and other autocleaning containers
*/

void main()
{
  int bEmpty = TRUE;
  int ieffect = GetLocalInt(OBJECT_SELF, "DESTROY_EFFECT");

  object oItem = GetFirstItemInInventory(OBJECT_SELF);
  while (oItem != OBJECT_INVALID)
  {
    DestroyObject(oItem);
    bEmpty = FALSE;
    oItem = GetNextItemInInventory(OBJECT_SELF);
  }

  if(!bEmpty) {
    if(ieffect == 0)
      ieffect = VFX_IMP_FLAME_M;

    if(ieffect != -1) {
      effect eEffect=EffectVisualEffect(ieffect);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect,OBJECT_SELF,1.0);
    }
  }
}
