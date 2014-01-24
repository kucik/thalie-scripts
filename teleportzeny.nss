void main()
{
location locSpellTarget = GetLocation(OBJECT_SELF);
object oPC = GetPCSpeaker();
effect sp1 = EffectVisualEffect(VFX_DUR_GLYPH_OF_WARDING);
effect sp2 = EffectVisualEffect(VFX_DUR_GLOBE_INVULNERABILITY);
effect sp3= EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, sp1, oPC, 0.5);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, sp2, oPC, 1.0);
ApplyEffectToObject(DURATION_TYPE_INSTANT, sp3, oPC);
ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), locSpellTarget);
AssignCommand(GetPCSpeaker(),JumpToLocation(GetLocation(GetObjectByTag("nw_plc_portzeny"))));
}
