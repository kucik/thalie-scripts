
object oPC = GetPCSpeaker();
object oCheck2 = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
int iDMSetNumber =GetLocalInt(oCheck2,"DMSetNumber");
object oCreature = GetLocalObject(oPC, "dmfi_univ_target");
object oSlotitem =GetItemInSlot((iDMSetNumber-1),oCreature);
void main()
{
if(oSlotitem == OBJECT_INVALID ||GetIsDM(oCreature) || GetIsDMPossessed(oCreature))
{
SendMessageToPC(oPC,"No item in slot or is DM");
return;
}
AssignCommand(oCreature,ActionUnequipItem(GetItemInSlot((iDMSetNumber-1),oCreature)));
}

