#include "sh_classes_inc_e"
#include "sh_deity_inc"
void main()
{
    object oPC = GetPCSpeaker();
    object oDuse =GetSoulStone(oPC);
    SetLocalInt(oDuse,"DEITY",DEITY_DEI_ANANG);
      string sDestination = GetLocalString(OBJECT_SELF, "DESTINATION");
 effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2);

 object oDestination = GetObjectByTag(sDestination);

 if( !GetIsDM(oPC) ){
     ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(OBJECT_SELF));
     DelayCommand(0.5f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oDestination)));
 }

 DelayCommand(0.5f, AssignCommand(oPC, JumpToObject(oDestination)));
}
