#include "sh_classes_inc"
//zobrazi cislo konstanty
int StartingConditional()
{

    object oPCspeaker = GetPCSpeaker();
    object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
    string sDMid = "DM_"+GetName(oPCspeaker)+"_"+GetPCPlayerName(oPCspeaker);
    object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
    int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");
    string sDMstring = GetLocalString(oPCspeaker,"DMstring");
    int iTileC =GetLocalInt(oCheck,"TileC");
    int iTileR =GetLocalInt(oCheck,"TileR");
    float fDelay = GetCampaignFloat(sDMid,"dmfi_effectdelay",oPCspeaker);
    float fDuration =  GetCampaignFloat(sDMid,"dmfi_effectduration",oPCspeaker);
    float fBeamDuration = GetCampaignFloat(sDMid,"dmfi_beamduration",oPCspeaker);
    string sDesription = GetDescription(oTarget,FALSE,TRUE);
    string sDesript2 = GetDescription(oTarget,FALSE,FALSE);
    object oSoul = GetSoulStone(oTarget);
    int iNTBonus = GetLocalInt(oSoul,"NT_XP_BONUS_LEVEL");
    int iHead =GetCreatureBodyPart(CREATURE_PART_HEAD,oTarget);
    string sDeity = GetDeityName(oTarget);



    SetCustomToken(518,IntToString(iDMSetNumber));
    SetCustomToken(529,IntToString(iTileC));
    SetCustomToken(530,IntToString(iTileR));
    SetCustomToken(523,FloatToString(fDuration));
    SetCustomToken(524,FloatToString(fDelay));
    SetCustomToken(525,FloatToString(fBeamDuration));
    SetCustomToken(531,sDMstring);
    SetCustomToken(532,sDesription);
    SetCustomToken(533,sDesript2);
    SetCustomToken(534,IntToString(iNTBonus));
    SetCustomToken(535,IntToString(iHead));
    SetCustomToken(536,sDeity);
    SetCustomToken(537,"persist");
    return TRUE;
}
