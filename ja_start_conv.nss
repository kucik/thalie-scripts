void main()
{
    object oPC;
    if(GetObjectType(OBJECT_SELF) == OBJECT_TYPE_CREATURE){
      oPC = GetLastSpeaker();
    }
    else {
      oPC = GetLastUsedBy();
    }
    int bPrivite = FALSE;
    if(GetLocalInt(OBJECT_SELF,"PRIVATE_CONVERSATION")) {
      bPrivite = TRUE;
    }
    ActionStartConversation(oPC, "", bPrivite,FALSE);
}
