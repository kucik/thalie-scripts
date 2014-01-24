/////////////////////////////////////////////////////////
// Modul: Mintaka
// Autor: Labir
// Aktualizace: 18.7.2005
// Skript: la_damage_stop
// Popis: Pri opusteni postavy oblasti triggeru vymaze
//        zaznam o periodickem zranovani dae postavy
// Instalace: vlozit do OnExit Event triggeru
/////////////////////////////////////////////////////////

void main()
{
  object oTrigger=OBJECT_SELF;
  object oPC=GetExitingObject();
  int i=0;

  while (i<20 && GetLocalObject(oTrigger,"PC_"+IntToString(i))!=oPC)
    i++;

  if (GetLocalObject(oTrigger,"PC_"+IntToString(i))==oPC)
    {
      DeleteLocalObject(oTrigger,"PC_"+IntToString(i));
      SetLocalInt(oTrigger,"COUNTER",GetLocalInt(oTrigger,"COUNTER")-1);
    }
}
