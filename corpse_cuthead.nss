#include "ja_lib"

void main()
{
 string sPlayerName = GetLocalString(OBJECT_SELF, "PLAYER");
 string sPCName = GetLocalString(OBJECT_SELF, "PC");

 object oPC = GetPCSpeaker();

 object oHead = CreateObject(OBJECT_TYPE_ITEM, "hlavamrtvoly", GetLocation(OBJECT_SELF), TRUE);

 SetName( oHead, sPCName );
 SetLocalString(oHead, "PLAYER", sPlayerName);
 SetLocalString(oHead, "PC", sPCName);

 AssignCommand(oPC, ActionPickUpItem(oHead));

 DestroyObject(OBJECT_SELF, 1.0f);

 SendMessageToPC(FindPCByName(sPCName), "Citis ze tva mrtvola byla znesvecena! Ted uz ti nezbyva nic jineho, nez jit zadat o milost Pana podsveti.");
}
