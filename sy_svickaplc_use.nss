/*
  by Sylmael - 16.8.2006
  -script posluzi na predmety ktore sa daju rozlozit ako sviecky,
  stany,deky...
*/

void main()
{
    object   oPlayer = GetLastUsedBy();
    string   sVyzor  = GetLocalString(OBJECT_SELF,"Vyzor");
    CreateItemOnObject(sVyzor,oPlayer,1,"");
    DestroyObject(OBJECT_SELF);
}
