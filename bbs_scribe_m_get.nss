void main()
{
  string sTalk = GetLocalString(OBJECT_SELF, "Stack");
  if (sTalk != "") {
    if (GetStringLength(sTalk) > 1000) {sTalk = GetStringLeft(sTalk, 1000);}
    SetLocalString(OBJECT_SELF, "#M", sTalk);
    SetLocalString(OBJECT_SELF, "Stack", "");
  }
}
