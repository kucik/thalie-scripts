#include "ja_lib"
#include "nw_i0_generic"
void main()
{

    // This CAN return a blocking creature.
    object oBlocker = GetBlockingDoor();
    int nBlockerType = GetObjectType(oBlocker);

    if(!GetIsObjectValid(oBlocker)) return;

    // Anyone blocked by an enemy will re-target them (and attack them), blocked
    // by someone they cannot get they will cast seeing spells and react, and if
    // blocked by a friend, they may run back and use a ranged weapon if they
    // have one.
    if(nBlockerType == OBJECT_TYPE_CREATURE)
    {
        // Is it an enemy?
        if(GetIsEnemy(oBlocker))
        {
            // Check if seen or heard
            if(GetObjectSeen(oBlocker) || GetObjectHeard(oBlocker))
            {
                    ClearAllActions();
                    DetermineCombatRound();
                    return;
            }
            else
            {
                ClearAllActions();
                ActionMoveAwayFromObject(oBlocker, TRUE);
            }
        }
        // Else is non-enemy, a friend or neutral
        else
        {


                // Reinitate combat
                ClearAllActions();
                DetermineCombatRound();
                return;

        }
    }
    // Placeable - Not sure it can be returned, however, we can add it to the
    // type if/else check.
    else if(nBlockerType == OBJECT_TYPE_PLACEABLE)
    {
        // Check for plot, and therefore attack it to bring it down.
        // - Remember, ActionAttack will re-initiate when combat round fires
        //   again in 3 or 6 seconds (or less, if we just were moving)
        if(!GetPlotFlag(oBlocker) &&
            GetIsPlaceableObjectActionPossible(oBlocker, PLACEABLE_ACTION_BASH))
        {
            // Do placeable action
            DoPlaceableObjectAction(oBlocker, PLACEABLE_ACTION_BASH);
        }
    }
    // Door behaviour
    else if(nBlockerType == OBJECT_TYPE_DOOR)
    {
        int iIntelligence = GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE);
        // Right, first, we may...shock...open it!!!
        // Checks Key, lock, trap and if the action is possible.
        if(iIntelligence >= 7 &&
        GetIsDoorActionPossible(oBlocker, DOOR_ACTION_OPEN) &&
        !GetLocked(oBlocker) &&
        !GetIsTrapped(oBlocker) &&
        (!GetLockKeyRequired(oBlocker) ||
        (GetLockKeyRequired(oBlocker) && GetItemPossessor(GetObjectByTag(GetLockKeyTag(oBlocker))) == OBJECT_SELF)))
        {
            DoDoorAction(oBlocker, DOOR_ACTION_OPEN);

            return;
        }
        // Unlock it with the skill, if it is not trapped and we can :-P
        // We take 20 off the door DC, thats our minimum roll, after all.
        if(GetLocked(oBlocker) &&
        !GetLockKeyRequired(oBlocker) && GetHasSkill(SKILL_OPEN_LOCK) &&
        GetIsDoorActionPossible(oBlocker, DOOR_ACTION_UNLOCK) && !GetIsTrapped(oBlocker) &&
        (GetSkillRank(SKILL_OPEN_LOCK) >= (GetLockLockDC(oBlocker) - 20)))
        {
            DoDoorAction(oBlocker, DOOR_ACTION_UNLOCK);

            return;
        }
        // Specilist thing - knock
        if(iIntelligence >= 10 &&
        (GetIsDoorActionPossible(oBlocker, DOOR_ACTION_KNOCK)) &&
        GetLockUnlockDC(oBlocker) <= 25 &&
        !GetLockKeyRequired(oBlocker) && GetHasSpell(SPELL_KNOCK))
        {
            DoDoorAction(oBlocker, DOOR_ACTION_KNOCK);

            return;
        }

        // If Our Int is over 5, we will bash after everything else.
        if(iIntelligence >= 5 &&GetIsDoorActionPossible(oBlocker, DOOR_ACTION_BASH) && !GetPlotFlag(oBlocker) && GetAttackTarget() != oBlocker)
        {
            DoDoorAction(oBlocker, DOOR_ACTION_BASH);

            return;

        }
    }

}

