//::///////////////////////////////////////////////
//:: Drow - temnota
//:: sp_drow_darkness
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Shaman
//:: Created On: 21.7.2013
//:://////////////////////////////////////////////

//#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "sh_classes_inc_e"
void main()
{
    location lTarget = GetSpellTargetLocation();
    AssignCommand(OBJECT_SELF,ActionCastSpellAtLocation(SPELL_DARKNESS,lTarget,METAMAGIC_ANY,TRUE));
}
