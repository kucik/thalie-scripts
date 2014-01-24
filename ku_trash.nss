/*
* kucik
* Simple script useable for trashes and other autocleaning containers
*/

void main()
{
  int bEmpty = TRUE;

  object oItem = GetFirstItemInInventory(OBJECT_SELF);
  while (oItem != OBJECT_INVALID)
  {
    DestroyObject(oItem);
    bEmpty = FALSE;
    oItem = GetNextItemInInventory(OBJECT_SELF);
  }

  if(!bEmpty) {
    effect eEffect=EffectVisualEffect(VFX_IMP_FLAME_M);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect,OBJECT_SELF,1.0);
  }

}
