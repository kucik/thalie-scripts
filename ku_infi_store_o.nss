void main()
{
  object oStore = OBJECT_SELF;

  if(GetLocalInt(oStore,"INITIALIZED") > 0)
    return;

  object oItem = GetFirstItemInInventory(oStore);
  while(GetIsObjectValid(oItem)) {
    SetInfiniteFlag(oItem,TRUE);
    oItem = GetNextItemInInventory(oStore);
  }

  SetLocalInt(oStore,"INITIALIZED",1);
}
