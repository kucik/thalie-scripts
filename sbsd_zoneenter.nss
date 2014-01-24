// OnEnter script for precision search triggers.

void main()
{
  object oPC = GetEnteringObject();
  string sTag = GetTag(OBJECT_SELF);

  if (GetIsPC(oPC))
    SetLocalInt(oPC, sTag, 1);
}
