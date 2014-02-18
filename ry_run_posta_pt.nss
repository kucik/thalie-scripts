void main()
{
  string posta_conv = GetLocalString(OBJECT_SELF,"no_posta_conv");
  if(GetStringLength(posta_conv) == 0) {
    posta_conv = "no_posta";
  }
  ClearAllActions();
  ActionStartConversation(GetPCSpeaker(), posta_conv);
}

