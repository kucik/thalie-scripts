void main()
{
  object oPC = GetLastUsedBy();

  int bHasKnife = FALSE;

  object oTool = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
  if ( (GetIsObjectValid(oTool)) && (GetTag(oTool) == "cnrSkinningKnife") )
  {
      bHasKnife = TRUE;
  }

  if (bHasKnife == FALSE)
  {
     oTool = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
     if ( (GetIsObjectValid(oTool)) && (GetTag(oTool) == "cnrSkinningKnife") )
    {
      bHasKnife = TRUE;
    }
  }

//    SpeakString("*Toto je mrtvy "+GetLocalString(OBJECT_SELF, "PC")+"*");
  if(bHasKnife) {
    ActionStartConversation(oPC, "corpse_dialog", TRUE, FALSE);
    return;
  }


 string sPlayerName = GetLocalString(OBJECT_SELF, "PLAYER");
 string sPCName = GetLocalString(OBJECT_SELF, "PC");

 string sCorpseTag = GetTag(OBJECT_SELF);
 int iSubdual = GetLocalInt(OBJECT_SELF,"SUBDUAL");

 object oCorpse = CreateObject(OBJECT_TYPE_ITEM, "mrtvola", GetLocation(OBJECT_SELF), TRUE, sCorpseTag);

 SetName( oCorpse, sPCName );
 SetLocalString(oCorpse, "PLAYER", sPlayerName);
 SetLocalString(oCorpse, "PC", sPCName);
 SetLocalInt(oCorpse,"SUBDUAL",iSubdual);

 AssignCommand(oPC, ActionPickUpItem(oCorpse));

 DestroyObject(OBJECT_SELF, 1.0f);

}
