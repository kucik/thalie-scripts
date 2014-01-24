// OnExit script for precision search triggers.

void main()
{
  object oPC = GetExitingObject();
  string sTag = GetTag(OBJECT_SELF);

  if (GetIsPC(oPC))
    DeleteLocalInt(oPC, sTag);
}
