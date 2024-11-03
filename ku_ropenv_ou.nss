/* ku_ropenv_ou
 * Vytovreno pro premistovani postavy pouzitim lana
 ***** POUZITI *******
 * Umistit na placeable jako onUsed script.
 * Nastavit useable
 * Promenna
 */

void main()
{
  object oRope = OBJECT_SELF;
  object oPC = GetLastUsedBy();
//  string sDest = GetLocalString("WAY_UP")
  if(GetLocalInt(OBJECT_SELF,"ROPE_PLACED") ||
     GetIsObjectValid(GetItemPossessedBy(oPC,"ku_rope"))) {
    AssignCommand(oPC,ClearAllActions());
    AssignCommand(oPC,ActionStartConversation(oRope,"ku_ropenv_dlg",TRUE,FALSE));
  }
  else {

    SendMessageToPC(oPC,"Solidne pevny zachytny bod.");
  }
}
