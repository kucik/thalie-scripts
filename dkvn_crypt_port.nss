void main()
{
  object oPC = GetLastUsedBy();
  string paka_tag = "dkvn_CryptPod1_NaPortaly";
  object paka = GetObjectByTag(paka_tag);
  string tag = GetTag(OBJECT_SELF);
  string tag_cil = GetLocalString(paka,tag);
  object target = GetObjectByTag(tag_cil);
  AssignCommand(oPC,ActionJumpToObject(target));

}
