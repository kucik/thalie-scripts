const int PLAYER_TYPE_NONE         = 0x00;
const int PLAYER_TYPE_PC           = 0x01;
const int PLAYER_TYPE_DM           = 0x02;
const int PLAYER_TYPE_PC_POSSESSED = 0x05;
const int PLAYER_TYPE_DM_POSSESSED = 0x06;

// Get a type of the player controlled character.
// * Returns a type of the player controlled character (PLAYER_TYPE_*).
int GetPlayerType(object oPC = OBJECT_SELF);

// Get if oPC is player character and not DM
// - oPC: The player character.
// * Returns TRUE or FALSE.
int GetIsPlayer(object oPC);

// Get a topmost master of the creature.
// - oCreature: The creature.
// * Returns a topmost master of the creature or OBJECT_INVALID on failure if there is no master at all.
object GetTopMaster(object oCreature = OBJECT_SELF);

int GetIsPlayer(object oPC)
{
    return GetPlayerType(oPC) == PLAYER_TYPE_PC ? TRUE : FALSE;
}

int GetPlayerType(object oPC)
{
    int iDM = GetIsDM(oPC) || GetIsDMPossessed(oPC);
    int iPC = GetIsPC(oPC) && !iDM;
    int iPossessed = GetIsObjectValid(GetTopMaster(oPC)) && (iPC || iDM);
    return (iPC) | (iDM << 1) | (iPossessed << 2);
}

object GetTopMaster(object oCreature)
{
    // The first master may be an OBJECT_INVALID indicating there is no master at all.
    oCreature = GetMaster(oCreature);

    object oMaster;
    while (GetIsObjectValid(oMaster = GetMaster(oCreature)))
    {
        oCreature = oMaster;
    }
    return oCreature;
}