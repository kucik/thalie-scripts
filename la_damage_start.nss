/////////////////////////////////////////////////////////
// Modul: Mintaka
// Autor: Labir
// Aktualizace: 18.7.2005
// Skript: la_damage_start
// Popis: Pri vstupu postavy do oblasti triggeru ji zpusobuje
//        zraneni nastavene sily a typu, lze nastavit aby zraneni
//        pusobilo periodicky az do opusteni oblasti triggeru
// Instalace: vlozit do OnEnter Event triggeru
/////////////////////////////////////////////////////////

// VYSVETLIVKY
//   int DAMAGE_AMOUNT - Velikost zraneni v HP
//   int DAMAGE_POWER - Pusobene zraneni, optimalne 1
//   string DAMAGE_TYPE - identifikuje typ zraneni
//                        acid - kyselina
//                        cold - mraz
//                        eletrical - elektrina
//                        fire - ohnive
//                        magical - magicke
//                        negative - negativni energii
//                        positive - pozitivni energii
//                        sonic - zvukem
//   int PERIODIC - pokud je nastaveno na 1 tak se
//                  zraneni opakuje az do opusteni triggeru
//                  Pro neperiodicka zraneni nemusi byt nastaveno

void main()
{
  // na damage se zvysoka sere
  return;

  object oTrigger=OBJECT_SELF;
  object oPC=GetEnteringObject();
  int i=0;

  int iAmount=GetLocalInt(oTrigger,"DAMAGE_AMOUNT");
  string sType=GetLocalString(oTrigger,"DAMAGE_TYPE");
  int iPower=GetLocalInt(oTrigger,"DAMAGE_POWER");;
  int iType=DAMAGE_TYPE_BASE_WEAPON;

  if (sType=="acid") iType=DAMAGE_TYPE_ACID;
  if (sType=="cold") iType=DAMAGE_TYPE_COLD;
  if (sType=="eletrical") iType=DAMAGE_TYPE_ELECTRICAL;
  if (sType=="fire") iType=DAMAGE_TYPE_FIRE;
  if (sType=="magical") iType=DAMAGE_TYPE_MAGICAL;
  if (sType=="negative") iType=DAMAGE_TYPE_NEGATIVE;
  if (sType=="positive") iType=DAMAGE_TYPE_POSITIVE;
  if (sType=="sonic") iType=DAMAGE_TYPE_SONIC;

  while (GetLocalObject(oTrigger,"PC_"+IntToString(i))!=OBJECT_INVALID)
    i++;

  ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(iAmount,iType,iPower),oPC,0.0);

  if (GetLocalInt(oTrigger,"PERIODIC")==1)
    {
      SetLocalObject(oTrigger,"PC_"+IntToString(i),oPC);
      SetLocalInt(oTrigger,"COUNTER",GetLocalInt(oTrigger,"COUNTER")+1);
    }
}
