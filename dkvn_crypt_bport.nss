void main()
{
  object oPC = GetLastUsedBy();
  string tag_cil = "dkvn_CryptPod1_MagPort"+IntToString(Random(5)+1);
  object target = GetObjectByTag(tag_cil);
  AssignCommand(oPC,ActionJumpToObject(target));



}
