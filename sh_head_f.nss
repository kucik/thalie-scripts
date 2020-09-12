void main()
{
    object oPC = GetPCSpeaker();
    int iGetHead =GetCreatureBodyPart(CREATURE_PART_HEAD,oPC);
    SetCreatureBodyPart(CREATURE_PART_HEAD,iGetHead+1,oPC);
}
