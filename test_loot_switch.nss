void main()
{
  object oBox = OBJECT_SELF;
  int i = GetLocalInt(oBox,"power");
  if(i >= 6 )
    i = 0;
  SetLocalInt(oBox,"power",i+1);

  string sName = GetTag(oBox)+IntToString(i+1);
  SetName(oBox,sName);

}
