#include "ku_libtime"
//#include "no_ko_inc"
#include "no_nastcraft_ini"
#include "tc_xpsystem_inc"

#include "ku_persist_inc"
#include "tc_functions"

int no_pocet;
string no_nazev;
int no_DC;

void no_vratveci(int druh, int pocet, int no_slinovana);
////vrati veci, kdyz je nekdo zapomnel v peci.
void no_vratslin(int no_slinovana);
////vrati veci, kdyz je nekdo zapomnel v peci.


void no_kuze(object no_pec, int no_mazani);
// nastavi promenou no_kuze na objectu no_pec na hodnotu kuze
void no_suseni(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_suseni na objectu no_pec na hodnotu vysusene kuze
void no_louh(object no_pec, int no_mazani);
// nastavi promenou no_louh na objectu no_pec na hodnotu louhovadla
void no_reopen(object no_oPC);
// preotevreni inventare prevzate z kovariny
void no_znicit(object no_oPC);
// znici tlacitka z inventare

void no_zamkni(object no_oPC);
// zamkne a pak odemkne + prehrava animacku

/////////////////////////////////////////////////////////////////////////////////////
/////////////   Funkce ne reseni xpu a lvlu craftu
/////////////
//////////////////////////////////////////////////////////////////////////////////////
void no_xp_kuze_ini(object no_oPC, object no_pec, int no_druh);
// vytvori polotovar s nastavenm promenma tak, aby z nej mohlo jit pouze pres disturbed udelat hotovej vyrobek.

void no_xp_kuze(object no_oPC, object no_pec);
// prozkouma pec, co za polotovar mame zkusi ho zpracovat dale.
// polotovar budto znici, nebo mu prilepsi procenta
void no_xp_louh_ini(object no_oPC, object no_pec, int no_kov);
// vyresi moznost uspechu a preda pripadny povedenou desku do no_pec
void no_xp_kozk_ini(object no_oPC, object no_pec, int no_kov);
// vyresi moznost uspechu a preda pripadny povedenou kozku do no_pec

/////////zacatek zavadeni funkci//////////////////////////////////////////////

string __getSuseByQuality(int no_druh) {
  switch(no_druh) {
    case 1: return "no_suse_obyc";
    case 2: return "no_suse_leps";
    case 3: return "no_suse_kval";
    case 4: return "no_suse_mist";
    case 5: return "no_suse_velm";
    case 6: return "no_suse_lege";
  }
  return "";
}

string __getKuzeByQuality(int no_druh) {
  switch(no_druh) {
    case 1: return "tc_kuze_obyc";
    case 2: return "tc_kuze_leps";
    case 3: return "tc_kuze_kval";
    case 4: return "tc_kuze_mist";
    case 5: return "tc_kuze_velm";
    case 6: return "tc_kuze_lege";
  }
  return "";
}

string __getKozkByQuality(int iQual) {
  switch(iQual) {
    case 1: return "tc_kozk_obyc";
    case 2: return "tc_kozk_leps";
    case 3: return "tc_kozk_kval";
    case 4: return "tc_kozk_mist";
    case 5: return "tc_kozk_velm";
    case 6: return "tc_kozk_lege";
  }
  return "";
}

int __getCenaKozk(int iQual) {
  switch(iQual) {
    case 1: return no_cena_kozk_obyc;
    case 2: return no_cena_kozk_leps;
    case 3: return no_cena_kozk_kval;
    case 4: return no_cena_kozk_mist;
    case 5: return no_cena_kozk_velm;
    case 6: return no_cena_kozk_lege;
  }
  return 0;
}

int __getCostByQuality(int no_druh, float nasobitel) {
  switch(no_druh) {
    case 1: return FloatToInt(10   * nasobitel);
    case 2: return FloatToInt(80   * nasobitel);
    case 3: return FloatToInt(250  * nasobitel);
    case 4: return FloatToInt(500  * nasobitel);
    case 5: return FloatToInt(1500 * nasobitel);
    case 6: return FloatToInt(2500 * nasobitel);
  }
  return 0;
}

string __getLouhResRef(int iQual) {
  switch(iQual) {
    case 1: return "no_louh_obyc";
    case 2: return "no_louh_leps";
    case 3: return "no_louh_kval";
    case 4: return "no_louh_mist";
    case 5: return "no_louh_velm";
    case 6: return "no_louh_lege";
  }
  return "";
}

int __getMakeDC(int no_suse) {

  switch(no_suse) {
        case 1:   return  no_obt_suse_obyc;
        case 2:   return  no_obt_suse_leps;
        case 3:   return  no_obt_suse_kval;
        case 4:   return  no_obt_suse_mist;
        case 5:   return  no_obt_suse_velm;
        case 6:   return  no_obt_suse_lege;
            //nad 50= namorene kuze
        case 51:   return  no_obt_louh_obyc;
        case 52:   return  no_obt_louh_leps;
        case 53:   return  no_obt_louh_kval;
        case 54:   return  no_obt_louh_mist;
        case 55:   return  no_obt_louh_velm;
        case 56:   return  no_obt_louh_lege;

            //nad 100= namorene kozky
        case 101:   return  no_obt_kozk_obyc;
        case 102:   return  no_obt_kozk_leps;
        case 103:   return  no_obt_kozk_kval;
        case 104:   return  no_obt_kozk_mist;
        case 105:   return  no_obt_kozk_velm;
        case 106:   return  no_obt_kozk_lege;
  }
  return 0;
}

string __getNameByQual(int iQual) {
  switch(iQual) {
    case 1: return "Obyčejná";
    case 2: return "Lepší";
    case 3: return "Kvalitní";
    case 4: return "Mistrovská";
    case 5: return "Velmistrovská";
    case 6: return "Legendární";
  }
  return "Neznámá";
}

string __getNameByType(int iType) {
  switch(iType) {
    case 0: return "sušená kůže";
    case 1: return "louhovaná kůže";
    case 2: return "louhovaná kožka";
  }
  return " neznámá věc";
}

int __getLouhQual(string sTag) {
  int i;

  for(i = 1; i <= 6; i++) {
    if(sTag == __getLouhResRef(i))
      return i;
  }
  return -1;
}

int __getSuseQual(string sTag) {
  int i;

  for(i = 1; i <= 6; i++) {
    if(sTag == __getSuseByQuality(i))
      return i;
  }
  return -1;
}

int __getProgressByDifficulty(int no_obtiznost_vyrobku) {

  // result is returned value / 10
  
  if(no_obtiznost_vyrobku > 190)
    no_obtiznost_vyrobku = 190;

  if (no_obtiznost_vyrobku >= 180 )
    return (200 - no_obtiznost_vyrobku) / 10;
  if (no_obtiznost_vyrobku >= 170)
    return Random(4);
  if (no_obtiznost_vyrobku >= 160)
    return Random(6);
  if (no_obtiznost_vyrobku >= 130)
    return Random(20)  + (160 - no_obtiznost_vyrobku) / 10;
  if (no_obtiznost_vyrobku >= 10)
    return Random(20)  + (130 - no_obtiznost_vyrobku) / 2;
  // < 10
  return Random(20) + 100;
}

int __getDestroyingByDifficulty(int no_obtiznost_vyrobku) {
  // result is returned value / 10

  if(no_obtiznost_vyrobku > 190)
    no_obtiznost_vyrobku = 190;

  if (no_obtiznost_vyrobku>=180)
    return (210 - no_obtiznost_vyrobku) / 10;
  if (no_obtiznost_vyrobku>=170)
    return Random(6);
  if (no_obtiznost_vyrobku>=160)
    return Random(8);
  if (no_obtiznost_vyrobku>=130)
    return Random(20) + (180 - no_obtiznost_vyrobku) / 10;
  if(no_obtiznost_vyrobku>=10)
    return Random(20) - FloatToInt(no_obtiznost_vyrobku * 0.7) + 93; // !!! To check
  // < 10
  return Random(20) + 150;
}


/////////////kdyz bylo v peci malo veci, tak je pekne vrati dovnitr do pece !!!!
void no_vratveci(int no_druh, int no_pocet, int no_slinovana)

{
   while (no_pocet>0) {
     object oNew = CreateItemOnObject(__getSuseByQuality(no_druh),OBJECT_SELF,1,"no_suse");
     // Set prize
     SetLocalInt(oNew,"tc_cena",__getCostByQuality(no_druh, no_ko_nasobitel2));
     // Set quality for easier handling.
     SetLocalInt(oNew, "tc_quality", no_druh);
   }

}  //konec vraceni veci////////////////////////////////////



/////////////kdyz bylo v peci malo veci, tak je pekne vrati dovnitr do pece !!!!
void no_vratslin(int no_slinovana)
{
   string sLouh = __getLouhResRef(no_slinovana);
   if(GetStringLength(sLouh) > 0)
     CreateItemOnObject("sLouh",OBJECT_SELF,1,"no_louh");

}  //konec vraceni veci////////////////////////////////////

int __getMaterialQuality(string sResref, string sType) {
  int iQual = 0;
  string sSql = "SELECT quality FROM craft_material WHERE resref = '"+sResref+"' AND type = '"+sType+"';";
  SQLExecDirect(sSql);
  if (SQLFetch() == SQL_SUCCESS) {
    iQual = StringToInt(SQLGetData(1));
  }

  return iQual;
}

void no_kuze(object no_pec, int no_mazani)
{      // do no_kuze ulozi cislo, kterym oznaci kvalitu budouci kuze.
  object oItem = GetFirstItemInInventory(no_pec);
  int iQual = 0;
  // Find known pelt
  while(GetIsObjectValid(oItem))  {
    iQual = __getMaterialQuality(GetResRef(oItem), "pelt");
    if(iQual > 0) {
      // Set pelt quality on device
      SetLocalInt(no_pec,"no_kuze",iQual);
      // Destroy pelt
      TC_SnizStack(oItem, no_mazani);
      return;
    }
    oItem = GetNextItemInInventory(no_pec);
  }
}


//////////////urci ktera susena kuze byla vlozena do no_pec //////////////////////////////////
void no_suseni(object no_Item, object no_pec, int no_mazani)
{
  SetLocalInt(no_pec,"no_suseni",56);// je to ruzne od 0 a taky tammusi zustat 56 kvuli vraceni veci..
  int iQual = 0;
  no_Item = GetFirstItemInInventory(no_pec);
  while(GetIsObjectValid(no_Item))  {
    if  (GetTag(no_Item) == "no_suse")   {
      iQual = __getSuseQual(GetResRef(no_Item));
      if(iQual > 0) {
        // do promene no_suseni ulozime nazev susene kuze
        SetLocalInt(no_pec,"no_suseni",iQual);
        TC_SnizStack(no_Item,no_mazani);                   // znicime susenou kuzi
        break;
      }
    }
    no_Item = GetNextItemInInventory(no_pec);
  }
}


void no_louh(object no_pec, int no_mazani) {
///////////////////////////////////////////
//// vystup:  no_louh       cislo urci louh pouzity v peci
//////
////////////////////////////////////////////
  string sTag = "";
  int iQual;
// do no_louh ulozi cislo louhu
  object oItem = GetFirstItemInInventory(no_pec);
  while(GetIsObjectValid(oItem))  {
    sTag = GetTag(oItem);
    if (GetStringLeft(sTag,7) == "no_louh" ) {  //// vsechny louhy maji tag no_louh
      // Get quality of louh
      iQual = __getLouhQual(sTag);
      if(iQual > 0) {
        //do promene no_louh ulozime hodnotu louhu
        SetLocalInt(no_pec,"no_louh",iQual);
        TC_SnizStack(oItem,no_mazani);                          //znicime prisadu
      }
    }
    oItem = GetNextItemInInventory(no_pec);
  }
}


////////z kovariny prevzate preotevreni pece s upravami  ////////////////////////////////////////
void no_reopen(object no_oPC)
{
AssignCommand(no_oPC,DoPlaceableObjectAction(OBJECT_SELF,PLACEABLE_ACTION_USE));
//   AssignCommand(oPC,DelayCommand(1.0,DoPlaceableObjectAction(GetNearestObjectByTag(GetTag(oSelf),oPC,1),PLACEABLE_ACTION_USE)));
}


////////Znici tlacitka z inventare ///////////////////////
void no_znicit(object no_oPC)
{
 no_Item = GetFirstItemInInventory(no_oPC);

 while (GetIsObjectValid(no_Item)) {

 if(GetResRef(no_Item) != "prepinac001") {
 no_Item = GetNextItemInInventory(no_oPC);
 continue;     //znicim vsechny prepinace 001
 }
 DestroyObject(no_Item);


 no_Item = GetNextItemInInventory(no_oPC);
}

no_Item = GetFirstItemInInventory(no_oPC);
 while (GetIsObjectValid(no_Item)) {

 if(GetResRef(no_Item) != "prepinac003") {
 no_Item = GetNextItemInInventory(no_oPC);
 continue;     //znicim vsechny prepinace 003
 }
 DestroyObject(no_Item);


 no_Item = GetNextItemInInventory(no_oPC);
}

}


void no_zamkni(object no_oPC)
// zamkne a pak odemkne + prehrava animacku
{
ActionLockObject(OBJECT_SELF);
AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, no_ko_delay));
    AssignCommand(no_oPC, SetCommandable(FALSE));
DelayCommand(no_ko_delay,ActionUnlockObject(OBJECT_SELF));
DelayCommand(no_ko_delay-1.0,AssignCommand(no_oPC, SetCommandable(TRUE)));
PlaySound("al_na_steamsm1");
}




/////////zjisti pravdepodobnost, prideli xpy, prida %hotovosti vyrobku a kdz bude nad 100% udela jej hotovym.
void no_xp_kuze(object no_oPC, object no_pec)
{
  int no_suse=0;
  no_Item = GetFirstItemInInventory(no_pec);
  while (GetIsObjectValid(no_Item)) {

    if (GetResRef(no_Item) == "no_polot_ko") {
      no_suse =  StringToInt(GetSubString(GetTag(no_Item),8,3));
      if(no_suse > 0)
        break;

    }//pokud resref = no_polot_ko      - pro zrychleni ifu...
    no_Item = GetNextItemInInventory(no_pec);
  }    /// dokud valid

//////tak mame predmet, co sme chteli. ted pravdepodobnost, ze se neco povede:
  if (no_suse>0 ) {

  int no_level = TC_getLevel(no_oPC,TC_KUZE);
  no_DC = __getMakeDC(no_suse) - ( 10*no_level );
 //obtiznost kovu -5*lvlu

  // pravdepodobnost uspechu =
  int no_chance = 100 - (no_DC*2) ;
  if (no_chance < 0)
    no_chance = 0;
  //SendMessageToPC(no_oPC," Sance uspechu :" + IntToString(no_chance));
  //samotny hod
  int no_hod = 101-d100();
  //SendMessageToPC(no_oPC," Hodils :" + IntToString(no_hod));
  if (no_hod <= no_chance ) {

    float no_procenta = GetLocalFloat(no_Item,"no_suse_proc");
    SendMessageToPC(no_oPC,"===================================");
    if (no_chance >= 100) {
      FloatingTextStringOnCreature("Zpracování je pro tebe triviální",no_oPC,FALSE );
      TC_setXPbyDifficulty(no_oPC,TC_KUZE,no_chance,TC_dej_vlastnost(TC_KUZE,no_oPC));
    }

    if ((no_chance > 0)&(no_chance<100)) {
      TC_setXPbyDifficulty(no_oPC,TC_KUZE,no_chance,TC_dej_vlastnost(TC_KUZE,no_oPC));
    }

        //////////povedlo se takze se zlepsi % zhotoveni na polotovaru////////////
        ///////////nacteme procenta z minula kdyz je polotovar novej, mel by mit int=0 /////////////////
    int no_obtiznost_vyrobku = no_DC+( 10*no_level );

           //SendMessageToPC(no_oPC," no_obtiznost_vyrobku:" + IntToString(no_obtiznost_vyrobku) );
    no_procenta = no_procenta + (TC_getProgressByDifficulty(no_obtiznost_vyrobku) / 10.0);


    if  (GetIsDM(no_oPC)== TRUE) no_procenta = no_procenta + 50.0;

    if (no_procenta >= 100.0) {  //kdyz je vyrobek 100% tak samozrejmeje hotovej
      AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0, 5.0));
      DestroyObject(no_Item); //znicim ho, protoze predam hotovej vyrobek
      DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru


      string sResref = "";
      string sTag = "";
      float fcena = 0.0;
      // Switch suse/kuze/kozk - 0/1/2
      switch(no_suse / 50) {
        //suse
        case 0:
          sResref = __getSuseByQuality(no_suse % 50);
          sTag = "no_suse";
          fcena = __getCenaKozk(no_suse % 50) * no_ko_nasobitel2;
          break;
        // 50+ kuze
        case 1:
          sResref = __getKuzeByQuality(no_suse % 50);
          fcena = __getCenaKozk(no_suse % 50) * no_ko_nasobitel;
          break;
        // 100+ kozky
        case 2:
          sResref = __getKozkByQuality(no_suse % 50);
          fcena = __getCenaKozk(no_suse % 50) * no_ko_nasobitel;
          break;
      }
      if(GetStringLength(sResref) > 0) {
        object oNew = CreateItemOnObject(sResref, no_oPC, 1, sTag);
        SetLocalInt(oNew,"tc_cena",FloatToInt(fcena));
        FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
      }

    }//konec kdzy uz mam nad 100%
    else {  //kdyz neni 100% tak samozrejmeje neni hotovej
      if ( GetLocalInt(no_Item,"no_pocet_cyklu") == 9 ) {
        TC_saveCraftXPpersistent(no_oPC,TC_KUZE);
      }

      string no_nazev_procenta;
      {
        int iPerc = FloatToInt(no_procenta * 10.0);
        no_nazev_procenta = IntToString(iPerc/10)+"."+IntToString(iPerc%10);
      }

      // Make progress on item
      string no_tag_vyrobku = GetTag(no_Item);
      int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
      DestroyObject(no_Item);
      no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);

      SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
      SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
      SetLocalString(no_Item,"no_crafter",GetName(no_oPC));

      FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
      SetName(no_Item,__getNameByQual(no_suse % 50)+" "+__getNameByType(no_suse / 50)+" *" + no_nazev_procenta + "%*" );

      if (GetCurrentAction(no_oPC) == 65535 ) {
        ExecuteScript("no_ko_clos_sus",OBJECT_SELF);
      }
      else {
        FloatingTextStringOnCreature("Přerušil jsi práci" ,no_oPC,FALSE );
        CopyItem(no_Item,no_oPC,TRUE);
        DestroyObject(no_Item);
      }

    }// kdyz neni 100%

    SendMessageToPC(no_oPC,"===================================");

  } /// konec, kdyz sme byli uspesni

  else {     ///////// bo se to nepovedlo, tak znicime polotovar////////////////
    float no_procenta = GetLocalFloat(no_Item,"no_suse_proc");
    int no_obtiznost_vyrobku = no_DC+( 10*no_level );

    no_procenta = no_procenta - TC_getDestroyingByDifficulty(no_obtiznost_vyrobku)/10.0;

    if (no_procenta <= 0.0 ){
      DestroyObject(no_Item);
      DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru

      FloatingTextStringOnCreature("Kůže se spálila - je na prach.",no_oPC,FALSE );
      ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE),OBJECT_SELF);
      DelayCommand(1.0,AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 2.0)));
    }
    else  if ((no_chance > 0)&(no_procenta>0.0))
      FloatingTextStringOnCreature("Kůže se ti trošku připálila ",no_oPC,FALSE );

    if (no_chance == 0) {
      FloatingTextStringOnCreature(" Se zpracováním by jsi měl raději počkat.",no_oPC,FALSE );
      DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(1,DAMAGE_TYPE_SONIC),no_oPC));
    }


    if (no_procenta > 0.0 ) {

      string no_nazev_procenta;
      {
        int iPerc = FloatToInt(no_procenta * 10.0);
        no_nazev_procenta = IntToString(iPerc/10)+"."+IntToString(iPerc%10);
      }

      // precess change
      string no_tag_vyrobku = GetTag(no_Item);
      int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
      DestroyObject(no_Item);

      no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
      SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
      SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
      SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
      FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
      SetName(no_Item,__getNameByQual(no_suse % 50)+" "+__getNameByType(no_suse / 50)+" *" + no_nazev_procenta + "%*" );

      if (GetCurrentAction(no_oPC) == 65535 ) {
        ExecuteScript("no_ko_clos_sus",OBJECT_SELF);
      }
      else  {
        FloatingTextStringOnCreature("Přerušil jsi práci" ,no_oPC,FALSE );
        CopyItem(no_Item,no_oPC,TRUE);
        DestroyObject(no_Item);
      }


    }

   } //konec nepovedeny

  }// konec kdyz jsme davali polotovar..

}    ////knec no_xp_kuze


void no_xp_kuze_ini(object no_oPC, object no_pec, int no_druh)
// vtvori polotovar s nastavenm promenma tak, aby z nej mohlo jit pouze pres slose udelat hotovej vyrobek.
{
        ///////////////udelame polotovar////////////////////
        object oNew = CreateItemOnObject("no_polot_ko",no_pec,1,"no_suse_"+IntToString(no_druh));
        SetLocalFloat(oNew, "no_suse_proc",15.0);

} // konec no_xp_brous




void no_xp_louh_ini(object no_oPC, object no_pec, int no_druh)
// vtvori polotovar s nastavenm promenma tak, aby z nej mohlo jit pouze pres close udelat hotovej vyrobek.
{
        ///////////////udelame polotovar////////////////////
        object oNew = CreateItemOnObject("no_polot_ko",no_pec,1,"no_suse_"+IntToString(50 + no_druh));
        SetLocalFloat(oNew, "no_suse_proc",15.0);

} // konec no_xp_brous

void no_xp_kozk_ini(object no_oPC, object no_pec, int no_druh)
// vtvori polotovar s nastavenm promenma tak, aby z nej mohlo jit pouze pres close udelat hotovej vyrobek.
{
        ///////////////udelame polotovar////////////////////
        object oNew = CreateItemOnObject("no_polot_ko",no_pec,1,"no_suse_"+IntToString(100 + no_druh));
        SetLocalFloat(oNew, "no_suse_proc",15.0);

} // konec no_xp_brous



