#include "x0_i0_anims"
#include "x2_inc_switches"
object oPCspeaker = GetPCSpeaker();
object oCheck2 = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck2,"DMSetNumber");
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");

void main()
{
int iAi;

switch (iDMSetNumber)
{

// Special tactics for ranged fighters.
// The caller will attempt to stay in ranged distance and
// will make use of active ranged combat feats (Rapid Shot
// and Called Shot).
// If the target is too close and is not currently attacking
// the caller, the caller will instead try to find a ranged
// enemy to attack. If that fails, the caller will try to run
// away from the target to a ranged distance.
// This will fall through and return FALSE after three
// consecutive attempts to get away from an opponent within
// melee distance, at which point the caller will use normal
// tactics until they are again at a ranged distance from
// their target.
// Returns TRUE on success, FALSE on failure.
case 1: iAi = X0_COMBAT_FLAG_RANGED;break;

// Special tactics for defensive fighters
// This will attempt to use the active defensive feats such as
// Knockdown and Expertise, and also use Parry mode, when these
// are appropriate. Falls through to standard combat on failure.
// Returns TRUE on success, FALSE on failure.
case 2: iAi = X0_COMBAT_FLAG_DEFENSIVE;break;

// Special tactics for cowardly creatures
// Cowards act as follows:
// - if you and your friends outnumber the enemy by 6:1 or
//   by more than 10, fall through to normal combat.
// - if you are currently being attacked by a melee attacker,
//   fight defensively (see SpecialTacticsDefensive).
// - if there is a "NW_SAFE" waypoint in your area that is
//   out of sight of the target, run to it.
// - otherwise, run away randomly from the target.
// Returns TRUE on success, FALSE on failure.
case 3: iAi = X0_COMBAT_FLAG_COWARDLY;break;

// Special tactics for ambushers.
// Ambushers will first attempt to get out of sight
// of their target if currently visible to that target.
// If not visible to the target, they will use any invisibility/
// hide powers they have.
// Once hidden, they will then attempt to attack the target using
// standard AI.
// Returns TRUE on success, FALSE on failure.
case 4: iAi = X0_COMBAT_FLAG_AMBUSHER;
SetCreatureFlag(oTarget,CREATURE_VAR_USE_SPAWN_STEALTH,TRUE);
ExecuteScript("nw_c2_default9",oTarget);break;
}

SetCombatCondition(iAi,TRUE,oTarget);

}
