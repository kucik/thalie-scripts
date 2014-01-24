/////////////////////////////////////////////////////////
// Modul: Mintaka
// Autor: Labir
// Aktualizace: 18.7.2005
// Skript: la_damage_make
// Popis: Provadi zraneni postav jejich jmena jsou
//        ulozena v lokalnich promennych nastavenou silou a typem
//
// Instalace: vlozit do OnHeartbeat Event triggeru
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

void main()
{
  // na damage se zvysoka sere
  return;

  object oTrigger=OBJECT_SELF;
  int iCounter=GetLocalInt(oTrigger,"COUNTER");

  if (iCounter>0)
    {
      object oPC;
      int i;
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

      for (i=0;i<20;i++)
        {
          oPC=GetLocalObject(oTrigger,"PC_"+IntToString(i));
          if (oPC!=OBJECT_INVALID)
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(iAmount,iType,iPower),oPC,0.0);
        }
    }
}
