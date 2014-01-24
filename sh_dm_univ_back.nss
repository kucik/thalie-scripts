object oTarget = GetPCSpeaker();
void main()
{
SetLocalInt(oTarget,"dmfi_univ_offset",7);
SetLocalString(oTarget,"dmfi_univ_conv", "onering");
ActionStartConversation(oTarget,"dmfi_universal", TRUE,FALSE);
}
