void main()
{
 string sPlayerName = GetLocalString(OBJECT_SELF, "PLAYER");
 string sPCName = GetLocalString(OBJECT_SELF, "PC");
 int iSubdual = GetLocalInt(OBJECT_SELF,"SUBDUAL");

 object oPC = GetPCSpeaker();
 string sCorpseTag = GetTag(OBJECT_SELF);

 object oCorpse = CreateObject(OBJECT_TYPE_ITEM, "mrtvola", GetLocation(OBJECT_SELF), TRUE, sCorpseTag);

 SetName( oCorpse, sPCName );
 SetLocalString(oCorpse, "PLAYER", sPlayerName);
 SetLocalString(oCorpse, "PC", sPCName);
 SetLocalInt(oCorpse,"SUBDUAL",iSubdual);


 AssignCommand(oPC, ActionPickUpItem(oCorpse));

 DestroyObject(OBJECT_SELF, 1.0f);
}
