#include "subraces"
#include "sh_classes_inc"
void main()
{
 object oPC = GetLastRespawnButtonPresser();
 ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDamage(GetCurrentHitPoints(oPC)+10,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_PLUS_FIVE), oPC);
}

