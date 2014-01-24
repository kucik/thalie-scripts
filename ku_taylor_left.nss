void main()
{
  int iPart = GetLocalInt(OBJECT_SELF,"KU_PART");

  // Prohozene prave a leve stehno;
//  if(iPart == 5)
//    iPart = 3;

  SetLocalInt(OBJECT_SELF,"KU_PART",iPart + 1);
}
