void main()
{
 object oUser = GetPCSpeaker();

 string sDestination = GetLocalString(OBJECT_SELF, "DESTINATION");
 effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2);

 object oDestination = GetObjectByTag(sDestination);

 if( !GetIsDM(oUser) ){
     ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(OBJECT_SELF));
     DelayCommand(0.5f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oDestination)));
 }

 DelayCommand(0.5f, AssignCommand(oUser, JumpToObject(oDestination)));
}
