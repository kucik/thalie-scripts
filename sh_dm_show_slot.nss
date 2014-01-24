object oPC = GetPCSpeaker();
object oCheck2 = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
int iDMSetNumber =GetLocalInt(oCheck2,"DMSetNumber");
object oCreature = GetLocalObject(oPC, "dmfi_univ_target");
object oSlotitem =GetItemInSlot((iDMSetNumber-1),oCreature);
void main()
{
if(oSlotitem == OBJECT_INVALID)
{
SendMessageToPC(oPC,"No item in slot");
return;
}
AssignCommand(oPC,OpenInventory(oCreature,oPC));
AssignCommand(oPC,ActionExamine(GetItemInSlot((iDMSetNumber-1),oCreature)));
AssignCommand(oPC,DelayCommand(0.2,OpenInventory(oCreature,oPC)));

}

