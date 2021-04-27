int StartingConditional()
{
    object oNPC = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    int iSkillReq = GetLocalInt(oNPC,"SPECIAL_SHOP_REQ");
    if (iSkillReq==0) return FALSE;
    int iIntimidate = GetSkillRank(SKILL_INTIMIDATE,oPC);
    int iPersuade   = GetSkillRank(SKILL_PERSUADE,oPC);
    if ((iIntimidate>=iSkillReq) || (iIntimidate>=iSkillReq))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
