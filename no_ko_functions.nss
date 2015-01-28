#include "ku_libtime"
//#include "no_ko_inc"
#include "no_nastcraft_ini"
#include "tc_xpsystem_inc"

#include "ku_persist_inc"

int no_pocet;
string no_nazev;
int no_DC;

void no_snizstack(object no_Item, int no_mazani);
////snizi pocet ve stacku. Kdyz je posledni, tak ho znici

void no_vratveci(int druh, int pocet, int no_slinovana);
////vrati veci, kdyz je nekdo zapomnel v peci.
void no_vratslin(int no_slinovana);
////vrati veci, kdyz je nekdo zapomnel v peci.


void no_kuze(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_kuze na objectu no_pec na hodnotu kuze
void no_suseni(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_suseni na objectu no_pec na hodnotu vysusene kuze
void no_louh(object no_Item, object no_pec, int no_mazani);
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
void no_snizstack(object no_Item, int no_mazani)
{
  int no_stacksize = GetItemStackSize(no_Item);      //zjisti kolik je toho ve stacku
  if (no_stacksize == 1)  {                     // kdyz je posledni znici objekt
    if (no_mazani == TRUE) 
      DestroyObject(no_Item);
  }
  else {
    if (no_mazani == TRUE) { //DestroyObject(no_Item);
              //FloatingTextStringOnCreature(" Tolikati prisad nebylo zapotrebi ",no_oPC,FALSE );
      SetItemStackSize(no_Item,no_stacksize-1);
    } 
  }
}

string __getSkinByQuality(int no_druh) {
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

/////////////kdyz bylo v peci malo veci, tak je pekne vrati dovnitr do pece !!!!
void no_vratveci(int no_druh, int no_pocet, int no_slinovana)

{
   while (no_pocet>0) {
     SetLocalInt(CreateItemOnObject(__getSkinByQuality(no_druh),OBJECT_SELF,1,"no_suse"),"tc_cena",__getCostByQuality(no_druh, no_ko_nasobitel2));
   }

}  //konec vraceni veci////////////////////////////////////



/////////////kdyz bylo v peci malo veci, tak je pekne vrati dovnitr do pece !!!!
void no_vratslin(int no_slinovana)
{

switch (no_slinovana)  {
   case 1: {
                CreateItemOnObject("no_louh_obyc",OBJECT_SELF,1,"no_louh");
                break; }
   case 2: {
                  CreateItemOnObject("no_louh_leps",OBJECT_SELF,1,"no_louh");
                      break;                                }///konec case
   case 3: {
                  CreateItemOnObject("no_louh_kval",OBJECT_SELF,1,"no_louh");
                       break;
                       }///konec case
   case 4: {        CreateItemOnObject("no_louh_mist",OBJECT_SELF,1,"no_louh");
                    break;
                                }///konec case
   case 5: {
                  CreateItemOnObject("no_louh_velm",OBJECT_SELF,1,"no_louh");
                      break;
                                }///konec case
   case 6: {
                  CreateItemOnObject("no_louh_lege",OBJECT_SELF,1,"no_louh");
                   break;
                                }///konec case
   }//konec switche

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

void no_kuze(object no_Item, object no_pec, int no_mazani)
{      // do no_kuze ulozi cislo, kterym oznaci kvalitu budouci kuze.
  object oItem = GetFirstItemInInventory(no_pec);
  int iQual = 0;
  while(GetIsObjectValid(oItem))  {
    iQual = __getMaterialQuality(GetResRef(oItem), "pelt");
    if(iQual > 0) {
      SetLocalInt(no_pec,"no_kuze",iQual);
      no_snizstack(oItem, no_mazani);
      return;
    }
    oItem = GetNextItemInInventory(no_pec);
  }  //tak uz mame nugety
}


//////////////urci ktera susena kuze byla vlozena do no_pec //////////////////////////////////
void no_suseni(object no_Item, object no_pec, int no_mazani)
{
SetLocalInt(no_pec,"no_suseni",56);// je to ruzne od 0 a taky tammusi zustat 56 kvuli vraceni veci..
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {

if  (GetTag(no_Item) == "no_suse")   {

    if(GetResRef(no_Item) == "no_suse_obyc")           // do promene no_suseni ulozime nazev susene kuze
    { SetLocalInt(no_pec,"no_suseni",1);
        no_snizstack(no_Item,no_mazani);                   // znicime susenou kuzi
    break;      }
    if(GetResRef(no_Item) == "no_suse_leps")
    { SetLocalInt(no_pec,"no_suseni",2);
        no_snizstack(no_Item,no_mazani);
    break;      }
      if(GetResRef(no_Item) == "no_suse_kval")
    { SetLocalInt(no_pec,"no_suseni",3);
        no_snizstack(no_Item,no_mazani);
    break;      }
      if(GetResRef(no_Item) == "no_suse_mist")
    {  SetLocalInt(no_pec,"no_suseni",4);
        no_snizstack(no_Item,no_mazani);
    break;      }
      if(GetResRef(no_Item) == "no_suse_velm")
    { SetLocalInt(no_pec,"no_suseni",5);
        no_snizstack(no_Item,no_mazani);
    break;      }
      if(GetResRef(no_Item) == "no_suse_lege")
    { SetLocalInt(no_pec,"no_suseni",6);
        no_snizstack(no_Item,no_mazani);
    break;      }
            }//pokud tag = no_suse      - pro zrychleni ifu...
  no_Item = GetNextItemInInventory(no_pec);
  }
}


void no_louh(object no_Item, object no_pec, int no_mazani)
///////////////////////////////////////////
//// vystup:  no_louh       cislo urci louh pouzity v peci
//////
////////////////////////////////////////////


{

// do no_louh ulozi cislo louhu
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {

if (GetStringLeft(GetTag(no_Item),7) == "no_louh" ) {  //// vsechny louhy maji tag no_louh
           if(GetTag(no_Item) == "no_louh_obyc")           //do promene no_louh ulozime hodnotu louhu
    { SetLocalInt(no_pec,"no_louh",1);
    no_snizstack(no_Item,no_mazani);                          //znicime prisadu
    break;      }
               if(GetTag(no_Item) == "no_louh_leps")           //do promene no_louh ulozime hodnotu louhu
    { SetLocalInt(no_pec,"no_louh",2);
    no_snizstack(no_Item,no_mazani);                         //znicime louh
    break;      }
               if(GetTag(no_Item) == "no_louh_kval")           //do promene no_louh ulozime hodnotu louhu
    { SetLocalInt(no_pec,"no_louh",3);
    no_snizstack(no_Item,no_mazani);                          //znicime louh
    break;      }
                   if(GetTag(no_Item) == "no_louh_mist")           //do promene no_louh ulozime hodnotu louhu
    { SetLocalInt(no_pec,"no_louh",4);
    no_snizstack(no_Item,no_mazani);    break;      }                        //znicime louh
                   if(GetTag(no_Item) == "no_louh_velm")           //do promene no_louh ulozime hodnotu louhu
    { SetLocalInt(no_pec,"no_louh",5);
    no_snizstack(no_Item,no_mazani);      break;      }                      //znicime louh
                   if(GetTag(no_Item) == "no_louh_lege")           //do promene no_louh ulozime hodnotu louhu
    { SetLocalInt(no_pec,"no_louh",6);
    no_snizstack(no_Item,no_mazani);    break;      }                       //znicime louh

               }// kdyz maj tag no_louh
  no_Item = GetNextItemInInventory(no_pec);
  }  //tak uz mame nactene brousene kameny
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
    if(GetTag(no_Item) == "no_suse_1")  {  no_suse=1; break;      }
    if(GetTag(no_Item) == "no_suse_2")  {  no_suse=2; break;      }
    if(GetTag(no_Item) == "no_suse_3")  {  no_suse=3; break;      }
    if(GetTag(no_Item) == "no_suse_4")  {  no_suse=4; break;      }
    if(GetTag(no_Item) == "no_suse_5")  {  no_suse=5; break;      }
    if(GetTag(no_Item) == "no_suse_6")  {  no_suse=6; break;      }
    //nad 50= namorene kuze
    if(GetTag(no_Item) == "no_suse_51")  {  no_suse=51; break;      }
    if(GetTag(no_Item) == "no_suse_52")  {  no_suse=52; break;      }
    if(GetTag(no_Item) == "no_suse_53")  {  no_suse=53; break;      }
    if(GetTag(no_Item) == "no_suse_54")  {  no_suse=54; break;      }
    if(GetTag(no_Item) == "no_suse_55")  {  no_suse=55; break;      }
    if(GetTag(no_Item) == "no_suse_56")  {  no_suse=56; break;      }
// nad 100 - kozky
    if(GetTag(no_Item) == "no_suse_101")  {  no_suse=101; break;      }
    if(GetTag(no_Item) == "no_suse_102")  {  no_suse=102; break;      }
    if(GetTag(no_Item) == "no_suse_103")  {  no_suse=103; break;      }
    if(GetTag(no_Item) == "no_suse_104")  {  no_suse=104; break;      }
    if(GetTag(no_Item) == "no_suse_105")  {  no_suse=105; break;      }
    if(GetTag(no_Item) == "no_suse_106")  {  no_suse=106; break;      }

    }//pokud resref = no_polot_ko      - pro zrychleni ifu...
  no_Item = GetNextItemInInventory(no_pec);
  }    /// dokud valid

//////tak mame predmet, co sme chteli. ted pravdepodobnost, ze se neco povede:
if (no_suse>0 ) {

int no_level = TC_getLevel(no_oPC,TC_KUZE);
switch(no_suse) {
        case 1:   no_DC =  no_obt_suse_obyc -( 10*no_level );    break;
        case 2:   no_DC =  no_obt_suse_leps -( 10*no_level );    break;
        case 3:   no_DC =  no_obt_suse_kval -( 10*no_level );    break;
        case 4:   no_DC =  no_obt_suse_mist -( 10*no_level );    break;
        case 5:   no_DC =  no_obt_suse_velm -( 10*no_level );    break;
        case 6:   no_DC =  no_obt_suse_lege -( 10*no_level );    break;
            //nad 50= namorene kuze
        case 51:   no_DC =  no_obt_louh_obyc -( 10*no_level );    break;
        case 52:   no_DC =  no_obt_louh_leps -( 10*no_level );    break;
        case 53:   no_DC =  no_obt_louh_kval -( 10*no_level );    break;
        case 54:   no_DC =  no_obt_louh_mist -( 10*no_level );    break;
        case 55:   no_DC =  no_obt_louh_velm -( 10*no_level );    break;
        case 56:   no_DC =  no_obt_louh_lege -( 10*no_level );    break;

            //nad 100= namorene kozky
        case 101:   no_DC =  no_obt_kozk_obyc -( 10*no_level );    break;
        case 102:   no_DC =  no_obt_kozk_leps -( 10*no_level );    break;
        case 103:   no_DC =  no_obt_kozk_kval -( 10*no_level );    break;
        case 104:   no_DC =  no_obt_kozk_mist -( 10*no_level );    break;
        case 105:   no_DC =  no_obt_kozk_velm -( 10*no_level );    break;
        case 106:   no_DC =  no_obt_kozk_lege -( 10*no_level );    break;
                } //konec vnitrniho  switche
 //obtiznost kovu -5*lvlu

// pravdepodobnost uspechu =
int no_chance = 100 - (no_DC*2) ;
if (no_chance < 0) no_chance = 0;
//SendMessageToPC(no_oPC," Sance uspechu :" + IntToString(no_chance));
//samotny hod
int no_hod = 101-d100();
//SendMessageToPC(no_oPC," Hodils :" + IntToString(no_hod));
if (no_hod <= no_chance ) {

         float no_procenta = GetLocalFloat(no_Item,"no_suse_proc");
        SendMessageToPC(no_oPC,"===================================");
        if (no_chance >= 100) {FloatingTextStringOnCreature("Zpracovani je pro tebe trivialni",no_oPC,FALSE );
                         TC_setXPbyDifficulty(no_oPC,TC_KUZE,no_chance,TC_dej_vlastnost(TC_KUZE,no_oPC));
                         }

        if ((no_chance > 0)&(no_chance<100)) { TC_setXPbyDifficulty(no_oPC,TC_KUZE,no_chance,TC_dej_vlastnost(TC_KUZE,no_oPC));
                            }
        //////////povedlo se takze se zlepsi % zhotoveni na polotovaru////////////
        ///////////nacteme procenta z minula kdyz je polotovar novej, mel by mit int=0 /////////////////
             int no_obtiznost_vyrobku = no_DC+( 10*no_level );

           //SendMessageToPC(no_oPC," no_obtiznost_vyrobku:" + IntToString(no_obtiznost_vyrobku) );


            if (no_obtiznost_vyrobku >=190) {
            no_procenta = no_procenta + 0.1 ;}
            else if ((no_obtiznost_vyrobku <190)&(no_obtiznost_vyrobku>=180)) {
            no_procenta = no_procenta + 0.2 ;}
            else if ((no_obtiznost_vyrobku <180)&(no_obtiznost_vyrobku>=170)) {
            no_procenta = no_procenta + Random(4)/10.0 ;}
           else if ((no_obtiznost_vyrobku <170)&(no_obtiznost_vyrobku>=160)) {
            no_procenta = no_procenta + Random(6)/10.0 ;} //0.1-0.6%
            else if ((no_obtiznost_vyrobku <160)&(no_obtiznost_vyrobku>=150)) {
            no_procenta = no_procenta + Random(20)/10.0 +0.1;}
            else if ((no_obtiznost_vyrobku <150)&(no_obtiznost_vyrobku>=140)) {
            no_procenta = no_procenta + Random(20)/10.0 +0.2;}
            else if ((no_obtiznost_vyrobku<140)&(no_obtiznost_vyrobku>=130)) {
            no_procenta = no_procenta + Random(20)/10.0 +0.3;}
            else if ((no_obtiznost_vyrobku <130)&(no_obtiznost_vyrobku>=120)) {
            no_procenta = no_procenta + Random(20)/10.0 +0.5;}
            else if ((no_obtiznost_vyrobku <120)&(no_obtiznost_vyrobku>=110)) {
            no_procenta = no_procenta + Random(20)/10.0 +1.0;}
            else if ((no_obtiznost_vyrobku <110)&(no_obtiznost_vyrobku>=100)) {
            no_procenta = no_procenta + Random(20)/10.0 +1.5;}
            else if ((no_obtiznost_vyrobku <100)&(no_obtiznost_vyrobku>=90)) {
            no_procenta = no_procenta + Random(20)/10.0 +2.0;}
           else if ((no_obtiznost_vyrobku <90)&(no_obtiznost_vyrobku>=80)) {
            no_procenta = no_procenta + Random(20)/10.0 +2.5;}
            else if ((no_obtiznost_vyrobku <80)&(no_obtiznost_vyrobku>=70)) {
            no_procenta = no_procenta + Random(20)/10.0 +3.0;}
            else if ((no_obtiznost_vyrobku <70)&(no_obtiznost_vyrobku>=60)) {
            no_procenta = no_procenta + Random(20)/10.0 +3.5;}
            else if ((no_obtiznost_vyrobku <60)&(no_obtiznost_vyrobku>=50)) {
            no_procenta = no_procenta + Random(20)/10.0+ 4.0;}
            else if ((no_obtiznost_vyrobku <50)&(no_obtiznost_vyrobku>=40)) {
            no_procenta = no_procenta + Random(20)/10.0 +4.5;}
            else if ((no_obtiznost_vyrobku <40)&(no_obtiznost_vyrobku>=30)) {
            no_procenta = no_procenta + Random(20)/10.0 +5.0;}
            else if ((no_obtiznost_vyrobku <30)&(no_obtiznost_vyrobku>=20)) {
            no_procenta = no_procenta + Random(20)/10.0 + 5.5;}
            else if ((no_obtiznost_vyrobku <20)&(no_obtiznost_vyrobku>=10)) {
            no_procenta = no_procenta+ Random(20)/10.0 +6.0;}
            else if (no_obtiznost_vyrobku <10) {
            no_procenta = no_procenta + Random(20)/10.0 +10.0;}

                        if  (GetIsDM(no_oPC)== TRUE) no_procenta = no_procenta + 50.0;

        if (no_procenta >= 100.0) {  //kdyz je vyrobek 100% tak samozrejmeje hotovej
        AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0, 5.0));
        DestroyObject(no_Item); //znicim ho, protoze predam hotovej vyrobek
 DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru

        switch(no_suse) {
        case 1:    {SetLocalInt(CreateItemOnObject("no_suse_obyc",no_oPC,1,"no_suse"),"tc_cena",FloatToInt(no_cena_kozk_obyc*no_ko_nasobitel2));
                    FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 2:    {SetLocalInt(CreateItemOnObject("no_suse_leps",no_oPC,1,"no_suse"),"tc_cena",FloatToInt(no_cena_kozk_leps*no_ko_nasobitel2));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 3:    {SetLocalInt(CreateItemOnObject("no_suse_kval",no_oPC,1,"no_suse"),"tc_cena",FloatToInt(no_cena_kozk_kval*no_ko_nasobitel2));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 4:    {SetLocalInt(CreateItemOnObject("no_suse_mist",no_oPC,1,"no_suse"),"tc_cena",FloatToInt(no_cena_kozk_mist*no_ko_nasobitel2));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 5:   { SetLocalInt(CreateItemOnObject("no_suse_velm",no_oPC,1,"no_suse"),"tc_cena",FloatToInt(no_cena_kozk_velm*no_ko_nasobitel2));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 6:    {SetLocalInt(CreateItemOnObject("no_suse_lege",no_oPC,1,"no_suse"),"tc_cena",FloatToInt(no_cena_kozk_lege*no_ko_nasobitel2));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
///////////////////nad 50= kuze////////////////////////////////////////////////////////
        case 51:    {SetLocalInt(CreateItemOnObject("tc_kuze_obyc",no_oPC,1),"tc_cena",FloatToInt(no_cena_kozk_obyc*no_ko_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 52:    {SetLocalInt(CreateItemOnObject("tc_kuze_leps",no_oPC,1),"tc_cena",FloatToInt(no_cena_kozk_leps*no_ko_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 53:    {SetLocalInt(CreateItemOnObject("tc_kuze_kval",no_oPC,1),"tc_cena",FloatToInt(no_cena_kozk_kval*no_ko_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 54:   { SetLocalInt(CreateItemOnObject("tc_kuze_mist",no_oPC,1),"tc_cena",FloatToInt(no_cena_kozk_mist*no_ko_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 55:    {SetLocalInt(CreateItemOnObject("tc_kuze_velm",no_oPC,1),"tc_cena",FloatToInt(no_cena_kozk_velm*no_ko_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 56:    {SetLocalInt(CreateItemOnObject("tc_kuze_lege",no_oPC,1),"tc_cena",FloatToInt(no_cena_kozk_lege*no_ko_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
///////////////////nad 100= kozky////////////////////////////////////////////////////////
        case 101:    {SetLocalInt(CreateItemOnObject("tc_kozk_obyc",no_oPC,1),"tc_cena",FloatToInt(no_cena_kozk_obyc*no_ko_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 102:    {SetLocalInt(CreateItemOnObject("tc_kozk_leps",no_oPC,1),"tc_cena",FloatToInt(no_cena_kozk_leps*no_ko_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 103:    {SetLocalInt(CreateItemOnObject("tc_kozk_kval",no_oPC,1),"tc_cena",FloatToInt(no_cena_kozk_kval*no_ko_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 104:   { SetLocalInt(CreateItemOnObject("tc_kozk_mist",no_oPC,1),"tc_cena",FloatToInt(no_cena_kozk_mist*no_ko_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 105:   {SetLocalInt(CreateItemOnObject("tc_kozk_velm",no_oPC,1),"tc_cena",FloatToInt(no_cena_kozk_velm*no_ko_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 106:    {SetLocalInt(CreateItemOnObject("tc_kozk_lege",no_oPC,1),"tc_cena",FloatToInt(no_cena_kozk_lege*no_ko_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }



        }  ///konec case
                }//konec kdzy uz mam nad 100%

        if (no_procenta < 100.0) {  //kdyz neni 100% tak samozrejmeje neni hotovej

        if ( GetLocalInt(no_Item,"no_pocet_cyklu") == 9 ) {TC_saveCraftXPpersistent(no_oPC,TC_KUZE);}

        string no_nazev_procenta = FloatToString(no_procenta);

        if (no_procenta >= 10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                                  no_nazev_procenta = GetStringRight(no_nazev_procenta,4);}
        if (no_procenta <10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                               no_nazev_procenta = GetStringRight(no_nazev_procenta,3);}


        switch(no_suse) {
        case 1: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Obycejna susena kuze *" + no_nazev_procenta + "%*" );
                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si suseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 2: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lepsi susena kuze *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si suseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 3: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Kvalitni susena kuze *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si suseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 4: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Mistrovska susena kuze *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si suseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 5: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Velmistrovska susena kuze *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si suseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 6: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Legendarni susena kuze *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si suseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
////////////////nad50= louhovane kuze////////////////////////////////
        case 51: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Obycejna louhovana kuze *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 52: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lepsi louhovana kuze *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 53: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"kvalitni louhovana kuze *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 54: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Mistrovska louhovana kuze *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 55: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Velmistrovska louhovana kuze *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 56: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta+ "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"legendarni louhovana kuze *" +no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }

////////////////nad100= louhovane kozky////////////////////////////////
        case 101: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Obycejna louhovana kozka *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 102:{string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lepsi louhovana kozka *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 103:{string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Kvalitni louhovana kozka *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 104: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Mistrovska louhovana kozka *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 105:{string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"velmistrovska louhovana kozka *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 106: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Legendrani louhovana kozka *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
                 }//konec case zvetsovani %

          }// kdyz neni 100%

        SendMessageToPC(no_oPC,"===================================");

       } /// konec, kdyz sme byli uspesni

else if (no_hod > no_chance )  {     ///////// bo se to nepovedlo, tak znicime polotovar////////////////
    float no_procenta = GetLocalFloat(no_Item,"no_suse_proc");
    int no_obtiznost_vyrobku = no_DC+( 10*no_level );

            if (no_obtiznost_vyrobku >=190) {
            no_procenta = no_procenta - 0.2 ;}
            else if ((no_obtiznost_vyrobku <190)&(no_obtiznost_vyrobku>=180)) {
            no_procenta = no_procenta - 0.3 ;}
            else if ((no_obtiznost_vyrobku <180)&(no_obtiznost_vyrobku>=170)) {
            no_procenta = no_procenta - Random(6)/10.0 ;}
            else if ((no_obtiznost_vyrobku <170)&(no_obtiznost_vyrobku>=160)) {
            no_procenta = no_procenta - Random(8)/10.0 ;} //0.1-0.6%
            else if ((no_obtiznost_vyrobku <160)&(no_obtiznost_vyrobku>=150)) {
            no_procenta = no_procenta - Random(20)/10.0 -0.3;}
            else if ((no_obtiznost_vyrobku <150)&(no_obtiznost_vyrobku>=140)) {
            no_procenta = no_procenta - Random(20)/10.0 -0.4;}
            else if ((no_obtiznost_vyrobku<140)&(no_obtiznost_vyrobku>=130)) {
            no_procenta = no_procenta - Random(20)/10.0 -0.5;}
            else if ((no_obtiznost_vyrobku <130)&(no_obtiznost_vyrobku>=120)) {
            no_procenta = no_procenta - Random(20)/10.0 -0.9;}
            else if ((no_obtiznost_vyrobku <120)&(no_obtiznost_vyrobku>=110)) {
            no_procenta = no_procenta - Random(20)/10.0 -1.5;}
            else if ((no_obtiznost_vyrobku <110)&(no_obtiznost_vyrobku>=100)) {
            no_procenta = no_procenta - Random(20)/10.0 -2.0;}
            else if ((no_obtiznost_vyrobku <100)&(no_obtiznost_vyrobku>=90)) {
            no_procenta = no_procenta - Random(20)/10.0 -3.1;}
           else if ((no_obtiznost_vyrobku <90)&(no_obtiznost_vyrobku>=80)) {
            no_procenta = no_procenta - Random(20)/10.0 -3.5;}
           else if ((no_obtiznost_vyrobku <80)&(no_obtiznost_vyrobku>=70)) {
            no_procenta = no_procenta - Random(20)/10.0 -4.5;}
            else if ((no_obtiznost_vyrobku <70)&(no_obtiznost_vyrobku>=60)) {
            no_procenta = no_procenta - Random(20)/10.0 -4.8;}
            else if ((no_obtiznost_vyrobku <60)&(no_obtiznost_vyrobku>=50)) {
            no_procenta = no_procenta - Random(20)/10.0- 6.0;}
            else if ((no_obtiznost_vyrobku <50)&(no_obtiznost_vyrobku>=40)) {
            no_procenta = no_procenta - Random(20)/10.0 -6.6;}
            else if ((no_obtiznost_vyrobku <40)&(no_obtiznost_vyrobku>=30)) {
            no_procenta = no_procenta- Random(20)/10.0 -7.5;}
            else if ((no_obtiznost_vyrobku <30)&(no_obtiznost_vyrobku>=20)) {
            no_procenta = no_procenta - Random(20)/10.0 - 7.8;}
            else if ((no_obtiznost_vyrobku <20)&(no_obtiznost_vyrobku>=10)) {
            no_procenta = no_procenta- Random(20)/10.0 -9.0;}
            else if (no_obtiznost_vyrobku <10) {
            no_procenta = no_procenta - Random(20)/10.0 -15.0;}


         if (no_procenta <= 0.0 ){
         DestroyObject(no_Item);
         DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru

         FloatingTextStringOnCreature("Kuze se spalila je na prach.",no_oPC,FALSE );
         ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE),OBJECT_SELF);
         DelayCommand(1.0,AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 2.0)));
                               }
        else  if ((no_chance > 0)&(no_procenta>0.0)) FloatingTextStringOnCreature("Kuze se ti trosku pripalila ",no_oPC,FALSE );

        if (no_chance == 0){ FloatingTextStringOnCreature(" Se zpracovani by si mel radeji pockat ",no_oPC,FALSE );
                      DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(1,DAMAGE_TYPE_SONIC),no_oPC));
                          }     //konec ifu


if (no_procenta > 0.0 ) {

        string no_nazev_procenta = FloatToString(no_procenta);
        if (no_procenta >= 10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                                  no_nazev_procenta = GetStringRight(no_nazev_procenta,4);}
        if (no_procenta <10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                               no_nazev_procenta = GetStringRight(no_nazev_procenta,3);}


        switch(no_suse) {
               case 1: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Obycejna susena kuze *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si suseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 2: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lepsi susena kuze *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si suseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 3: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Kvalitni susena kuze *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si suseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 4: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta+ "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Mistrovska susena kuze *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si suseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 5: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Velmistrovska susena kuze *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si suseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 6: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Legendarni susena kuze *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si suseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
////////////////nad50= louhovane kuze////////////////////////////////
        case 51: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Obycejna louhovana kuze *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 52: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lepsi louhovana kuze *" + no_nazev_procenta+ "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 53: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"kvalitni louhovana kuze *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 54: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Mistrovska louhovana kuze *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 55: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Velmistrovska louhovana kuze *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 56: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"legendarni louhovana kuze *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }

////////////////nad100= louhovane kozky////////////////////////////////
        case 101: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Obycejna louhovana kozka *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 102:{string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lepsi louhovana kozka *" +no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 103:{string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Kvalitni louhovana kozka *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 104: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Mistrovska louhovana kozka *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 105:{string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"velmistrovska louhovana kozka *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 106: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_ko",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Legendrani louhovana kozka *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ko_clos_sus",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si louhovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }

                 }//konec case zvetsovani %
          }// kdyz neni 100%

         }//konec else

         }// konec kdyz jsme davali polotovar..

}    ////knec no_xp_kuze


void no_xp_kuze_ini(object no_oPC, object no_pec, int no_druh)
// vtvori polotovar s nastavenm promenma tak, aby z nej mohlo jit pouze pres slose udelat hotovej vyrobek.
{
        ///////////////udelame polotovar////////////////////
        switch(no_druh) {
        case 1:   {SetLocalFloat(CreateItemOnObject("no_polot_ko",no_pec,1,"no_suse_1"),"no_suse_proc",15.0);
                   no_xp_kuze(no_oPC,no_pec);
                   break; }
        case 2:  {SetLocalFloat(CreateItemOnObject("no_polot_ko",no_pec,1,"no_suse_2"),"no_suse_proc",15.0);
                   no_xp_kuze(no_oPC,no_pec);
                   break; }
        case 3:   {SetLocalFloat(CreateItemOnObject("no_polot_ko",no_pec,1,"no_suse_3"),"no_suse_proc",15.0);
                   no_xp_kuze(no_oPC,no_pec);
                   break; }
        case 4:   {SetLocalFloat(CreateItemOnObject("no_polot_ko",no_pec,1,"no_suse_4"),"no_suse_proc",15.0);
                   no_xp_kuze(no_oPC,no_pec);
                   break; }
        case 5:   {SetLocalFloat(CreateItemOnObject("no_polot_ko",no_pec,1,"no_suse_5"),"no_suse_proc",15.0);
                   no_xp_kuze(no_oPC,no_pec);
                   break; }
        case 6:   {SetLocalFloat(CreateItemOnObject("no_polot_ko",no_pec,1,"no_suse_6"),"no_suse_proc",15.0);
                   no_xp_kuze(no_oPC,no_pec);       //no_pec je tam , at se objevi v peci a muze se rovnou zvetsit %
                   break; }
                } //konec vnitrniho  switche

} // konec no_xp_brous




void no_xp_louh_ini(object no_oPC, object no_pec, int no_druh)
// vtvori polotovar s nastavenm promenma tak, aby z nej mohlo jit pouze pres close udelat hotovej vyrobek.
{
        ///////////////udelame polotovar////////////////////
        switch(no_druh) {
        case 1:   {SetLocalFloat(CreateItemOnObject("no_polot_ko",no_pec,1,"no_suse_51"),"no_suse_proc",15.0);
                   no_xp_kuze(no_oPC,no_pec);
                   break; }
        case 2:  {SetLocalFloat(CreateItemOnObject("no_polot_ko",no_pec,1,"no_suse_52"),"no_suse_proc",15.0);
                   no_xp_kuze(no_oPC,no_pec);
                   break; }
        case 3:   {SetLocalFloat(CreateItemOnObject("no_polot_ko",no_pec,1,"no_suse_53"),"no_suse_proc",15.0);
                   no_xp_kuze(no_oPC,no_pec);
                   break; }
        case 4:   {SetLocalFloat(CreateItemOnObject("no_polot_ko",no_pec,1,"no_suse_54"),"no_suse_proc",15.0);
                   no_xp_kuze(no_oPC,no_pec);
                   break; }
        case 5:   {SetLocalFloat(CreateItemOnObject("no_polot_ko",no_pec,1,"no_suse_55"),"no_suse_proc",15.0);
                   no_xp_kuze(no_oPC,no_pec);
                   break; }
        case 6:   {SetLocalFloat(CreateItemOnObject("no_polot_ko",no_pec,1,"no_suse_56"),"no_suse_proc",15.0);
                   no_xp_kuze(no_oPC,no_pec);       //no_pec je tam , at se objevi v peci a muze se rovnou zvetsit %
                   break; }
                } //konec vnitrniho  switche

} // konec no_xp_brous

void no_xp_kozk_ini(object no_oPC, object no_pec, int no_druh)
// vtvori polotovar s nastavenm promenma tak, aby z nej mohlo jit pouze pres close udelat hotovej vyrobek.
{
        ///////////////udelame polotovar////////////////////
        switch(no_druh) {
        case 1:   {SetLocalFloat(CreateItemOnObject("no_polot_ko",no_pec,1,"no_suse_101"),"no_suse_proc",15.0);
                   no_xp_kuze(no_oPC,no_pec);
                   break; }
        case 2:  {SetLocalFloat(CreateItemOnObject("no_polot_ko",no_pec,1,"no_suse_102"),"no_suse_proc",15.0);
                   no_xp_kuze(no_oPC,no_pec);
                   break; }
        case 3:   {SetLocalFloat(CreateItemOnObject("no_polot_ko",no_pec,1,"no_suse_103"),"no_suse_proc",15.0);
                   no_xp_kuze(no_oPC,no_pec);
                   break; }
        case 4:   {SetLocalFloat(CreateItemOnObject("no_polot_ko",no_pec,1,"no_suse_104"),"no_suse_proc",15.0);
                   no_xp_kuze(no_oPC,no_pec);
                   break; }
        case 5:   {SetLocalFloat(CreateItemOnObject("no_polot_ko",no_pec,1,"no_suse_105"),"no_suse_proc",15.0);
                   no_xp_kuze(no_oPC,no_pec);
                   break; }
        case 6:   {SetLocalFloat(CreateItemOnObject("no_polot_ko",no_pec,1,"no_suse_106"),"no_suse_proc",15.0);
                   no_xp_kuze(no_oPC,no_pec);       //no_pec je tam , at se objevi v peci a muze se rovnou zvetsit %
                   break; }
                } //konec vnitrniho  switche

} // konec no_xp_brous












