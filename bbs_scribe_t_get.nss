void main()
{
  string sTalk = GetLocalString(OBJECT_SELF, "Stack");
  if (sTalk != "") {
    if (GetStringLength(sTalk) > 40) {sTalk = GetStringLeft(sTalk, 40);}
    SetLocalString(OBJECT_SELF, "#T", sTalk);
    SetLocalString(OBJECT_SELF, "Stack", "");
  }
}
