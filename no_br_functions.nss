#include "ku_libtime"
//#include "no_br_inc"
#include "no_nastcraft_ini"
#include "tc_xpsystem_inc"
#include "tc_functions"

#include "ku_persist_inc"

int no_pocet;
string no_nazev;
int no_DC;



void no_zamkni(object no_oPC);
///// udelame animacky a zamkneme pekne sutricek proti zvidavym hracum :D


void no_snizstack(object no_Item, int no_mazani);
////snizi pocet ve stacku. Kdyz je posledni, tak ho znici


void no_vratveci(int druh, int pocet, int no_slinovana);
////vrati veci, kdyz je nekdo zapomnel v peci.
void no_vratslin(int no_slinovana);
////vrati veci, kdyz je nekdo zapomnel v peci.


void no_nuget(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_nuget na objectu no_pec na hodnotu mineralu
void no_lestidlo(object no_Item, object no_pec,int no_mazani );
// nastavi promenou no_lestidlo na objectu no_pec na hodnotu lestidla
void no_brousene(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_brousene na objectu no_pec na hodnotu brousenych sutru
void no_reopen(object no_oPC);
// preotevreni inventare prevzate z kovariny
void no_znicit(object no_oPC);
// znici tlacitka z inventare

/////////////////////////////////////////////////////////////////////////////////////
/////////////   Funkce ne reseni xpu a lvlu craftu
/////////////
//////////////////////////////////////////////////////////////////////////////////////
void no_xp_brous(object no_oPC, object no_pec, int no_kov);
// vyresi moznost uspechu a preda pripadny povedene brouseny kamen do no_pec
void no_xp_lest(object no_oPC, object no_pec, int no_kov);
// vyresi moznost uspechu a preda pripadny povedenou desku do no_pec









/////////zacatek zavadeni funkci//////////////////////////////////////////////


void no_zamkni(object no_oPC)
// zamkne a pak odemkne + prehrava animacku
{
ActionLockObject(OBJECT_SELF);
AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, no_br_delay));
    AssignCommand(no_oPC, SetCommandable(FALSE));
DelayCommand(no_br_delay,ActionUnlockObject(OBJECT_SELF));
DelayCommand(no_br_delay-0.5,AssignCommand(no_oPC, SetCommandable(TRUE)));
PlaySound("as_cv_chiseling1");
}


void no_snizstack(object no_Item, int no_mazani)
{
int no_stacksize = GetItemStackSize(no_Item);      //zjisti kolik je toho ve stacku
  if (no_stacksize == 1)  {                     // kdyz je posledni znici objekt
                           if (no_mazani == TRUE) DestroyObject(no_Item);


                    }
    else   {  if (no_mazani == TRUE) { //DestroyObject(no_Item);
              //FloatingTextStringOnCreature(" Tolikati prisad nebylo zapotrebi ",no_oPC,FALSE );
              SetItemStackSize(no_Item,no_stacksize-1);
              } }
}



/////////////kdyz bylo v peci malo veci, tak je pekne vrati dovnitr do pece !!!!
void no_vratveci(int no_druh, int no_pocet, int no_slinovana)
{


}  //konec vraceni veci////////////////////////////////////



/////////////kdyz bylo v peci malo veci, tak je pekne vrati dovnitr do pece !!!!
void no_vratslin(int no_slinovana)
{


}  //konec vraceni veci////////////////////////////////////




void no_nuget(object no_Item, object no_pec, int no_mazani)
{      // do no_nuget ulozi cislo osekaneho nugetu
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {


           if(GetResRef(no_Item) == "cnrgemmineral001")           //do promene no_nuget ulozime nazev prisady
    { SetLocalInt(no_pec,"no_nuget",1);
    no_snizstack(no_Item,no_mazani);                           //znicime prisadu
    break;      }
           if(GetResRef(no_Item) == "cnrgemmineral002")
    { SetLocalInt(no_pec,"no_nuget",2);
    no_snizstack(no_Item,no_mazani);
    break;      }
           if(GetResRef(no_Item) == "cnrgemmineral003")
    { SetLocalInt(no_pec,"no_nuget",3);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "cnrgemmineral004")
    { SetLocalInt(no_pec,"no_nuget",4);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "cnrgemmineral005")
    { SetLocalInt(no_pec,"no_nuget",5);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "cnrgemmineral006")
    { SetLocalInt(no_pec,"no_nuget",6);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "cnrgemmineral007")
    { SetLocalInt(no_pec,"no_nuget",7);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "cnrgemmineral008")
    { SetLocalInt(no_pec,"no_nuget",8);
    no_snizstack(no_Item,no_mazani);
    break;      }
                   if(GetResRef(no_Item) == "cnrgemmineral009")
    { SetLocalInt(no_pec,"no_nuget",9);
    no_snizstack(no_Item,no_mazani);
    break;      }
                   if(GetResRef(no_Item) == "cnrgemmineral010")
    { SetLocalInt(no_pec,"no_nuget",10);
    no_snizstack(no_Item,no_mazani);
    break;      }
                   if(GetResRef(no_Item) == "cnrgemmineral011")
    { SetLocalInt(no_pec,"no_nuget",11);
    no_snizstack(no_Item,no_mazani);
    break;      }
                   if(GetResRef(no_Item) == "cnrgemmineral012")
    { SetLocalInt(no_pec,"no_nuget",12);
    no_snizstack(no_Item,no_mazani);
    break;      }
                   if(GetResRef(no_Item) == "cnrgemmineral013")
    { SetLocalInt(no_pec,"no_nuget",13);
    no_snizstack(no_Item,no_mazani);
    break;      }
                   if(GetResRef(no_Item) == "cnrgemmineral014")
    { SetLocalInt(no_pec,"no_nuget",14);
    no_snizstack(no_Item,no_mazani);
    break;      }
                   if(GetResRef(no_Item) == "cnrgemmineral015")
    { SetLocalInt(no_pec,"no_nuget",15);
    no_snizstack(no_Item,no_mazani);
    break;      }

  no_Item = GetNextItemInInventory(no_pec);
  }  //tak uz mame nugety
}


//////////////urci ktere lestidlo je v inventari no_pece //////////////////////////////////
void no_lestidlo(object no_Item, object no_pec, int no_mazani)
{
SetLocalInt(no_pec,"no_lestidlo",57);//musi byt 57 stejne jak no_close_kame protoze by se to pak nevatilo..
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {

if (GetStringLeft(GetTag(no_Item),7) == "no_lest" ) {

    if(GetTag(no_Item) == "no_lest_nefr")           // do promene no_drevo ulozime nazev dreva
    { SetLocalInt(no_pec,"no_lestidlo",1);
        no_snizstack(no_Item,no_mazani);                    // znicime lestidlo
    break;      }
    if(GetTag(no_Item) == "no_lest_ohni")
    { SetLocalInt(no_pec,"no_lestidlo",2);
        no_snizstack(no_Item,no_mazani);
    break;      }
      if(GetTag(no_Item) == "no_lest_amet")
    { SetLocalInt(no_pec,"no_lestidlo",3);
        no_snizstack(no_Item,no_mazani);
    break;      }
      if(GetTag(no_Item) == "no_lest_fene")
    {  SetLocalInt(no_pec,"no_lestidlo",4);
        no_snizstack(no_Item,no_mazani);
    break;      }
      if(GetTag(no_Item) == "no_lest_diam")
    { SetLocalInt(no_pec,"no_lestidlo",5);
        no_snizstack(no_Item,no_mazani);
    break;      }
      if(GetTag(no_Item) == "no_lest_rubi")
    { SetLocalInt(no_pec,"no_lestidlo",6);
        no_snizstack(no_Item,no_mazani);
    break;      }
      if(GetTag(no_Item) == "no_lest_mala")
    { SetLocalInt(no_pec,"no_lestidlo",7);
        no_snizstack(no_Item,no_mazani);
    break;      }
      if(GetTag(no_Item) == "no_lest_safi")
    { SetLocalInt(no_pec,"no_lestidlo",8);
        no_snizstack(no_Item,no_mazani);
    break;      }
          if(GetTag(no_Item) == "no_lest_opal")
    { SetLocalInt(no_pec,"no_lestidlo",9);
        no_snizstack(no_Item,no_mazani);
    break;      }
          if(GetTag(no_Item) == "no_lest_topa")
    { SetLocalInt(no_pec,"no_lestidlo",10);
        no_snizstack(no_Item,no_mazani);
    break;      }
          if(GetTag(no_Item) == "no_lest_gran")
    { SetLocalInt(no_pec,"no_lestidlo",11);
       no_snizstack(no_Item,no_mazani);
    break;      }
          if(GetTag(no_Item) == "no_lest_smar")
    { SetLocalInt(no_pec,"no_lestidlo",12);
        no_snizstack(no_Item,no_mazani);
    break;      }
          if(GetTag(no_Item) == "no_lest_alex")
    { SetLocalInt(no_pec,"no_lestidlo",13);
        no_snizstack(no_Item,no_mazani);
    break;      }
          if(GetTag(no_Item) == "no_lest_aven")
    { SetLocalInt(no_pec,"no_lestidlo",14);
        no_snizstack(no_Item,no_mazani);
    break;      }
          if(GetTag(no_Item) == "no_lest_zive")
    { SetLocalInt(no_pec,"no_lestidlo",15);
        no_snizstack(no_Item,no_mazani);
    break;      }

            }//pokud tag = no_lestidlo      - pro zrychleni ifu...
  no_Item = GetNextItemInInventory(no_pec);
  }
}


void no_brousene(object no_Item, object no_pec, int no_mazani)
///////////////////////////////////////////
//// vystup:  no_brousene       cislo urci brouseny kamen
//////
////////////////////////////////////////////


{      // do no_brousene ulozi cislo brouseneho kamenu
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {

           if(GetResRef(no_Item) == "cnrgemcut001")           //do promene no_osekane ulozime nazev prisady
    { SetLocalInt(no_pec,"no_brousene",1);
    no_snizstack(no_Item,no_mazani);                          //znicime prisadu
    break;      }
           if(GetResRef(no_Item) == "cnrgemcut002")
    { SetLocalInt(no_pec,"no_brousene",2);
    no_snizstack(no_Item,no_mazani);
    break;      }
           if(GetResRef(no_Item) == "cnrgemcut003")
    { SetLocalInt(no_pec,"no_brousene",3);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "cnrgemcut004")
    { SetLocalInt(no_pec,"no_brousene",4);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "cnrgemcut005")
    { SetLocalInt(no_pec,"no_brousene",5);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "cnrgemcut006")
    { SetLocalInt(no_pec,"no_brousene",6);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "cnrgemcut007")
    { SetLocalInt(no_pec,"no_brousene",7);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "cnrgemcut008")
    { SetLocalInt(no_pec,"no_brousene",8);
    no_snizstack(no_Item,no_mazani);
    break;      }
                   if(GetResRef(no_Item) == "cnrgemcut009")
    { SetLocalInt(no_pec,"no_brousene",9);
    no_snizstack(no_Item,no_mazani);
    break;      }
                   if(GetResRef(no_Item) == "cnrgemcut010")
    { SetLocalInt(no_pec,"no_brousene",10);
    no_snizstack(no_Item,no_mazani);
    break;      }
                   if(GetResRef(no_Item) == "cnrgemcut011")
    { SetLocalInt(no_pec,"no_brousene",11);
    no_snizstack(no_Item,no_mazani);
    break;      }
                   if(GetResRef(no_Item) == "cnrgemcut012")
    { SetLocalInt(no_pec,"no_brousene",12);
    no_snizstack(no_Item,no_mazani);
    break;      }
                   if(GetResRef(no_Item) == "cnrgemcut013")
    { SetLocalInt(no_pec,"no_brousene",13);
    no_snizstack(no_Item,no_mazani);
    break;      }
                   if(GetResRef(no_Item) == "cnrgemcut014")
    { SetLocalInt(no_pec,"no_brousene",14);
    no_snizstack(no_Item,no_mazani);
    break;      }
                   if(GetResRef(no_Item) == "cnrgemcut015")
    { SetLocalInt(no_pec,"no_brousene",15);
    no_snizstack(no_Item,no_mazani);
    break;      }

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



/////////zjisti pravdepodobnost, prideli xpy, prida %hotovosti vyrobku a kdz bude nad 100% udela jej hotovym.
void no_xp_kamen(object no_oPC, object no_pec)
{
int no_suse=0;
no_Item = GetFirstItemInInventory(no_pec);
while (GetIsObjectValid(no_Item)) {

if (GetResRef(no_Item) == "no_polot_br") {
    if(GetTag(no_Item) == "no_nuget_1")  {  no_suse=1; break;      }
    if(GetTag(no_Item) == "no_nuget_2")  {  no_suse=2; break;      }
    if(GetTag(no_Item) == "no_nuget_3")  {  no_suse=3; break;      }
    if(GetTag(no_Item) == "no_nuget_4")  {  no_suse=4; break;      }
    if(GetTag(no_Item) == "no_nuget_5")  {  no_suse=5; break;      }
    if(GetTag(no_Item) == "no_nuget_6")  {  no_suse=6; break;      }
    if(GetTag(no_Item) == "no_nuget_7")  {  no_suse=7; break;      }
    if(GetTag(no_Item) == "no_nuget_8")  {  no_suse=8; break;      }
    if(GetTag(no_Item) == "no_nuget_9")  {  no_suse=9; break;      }
    if(GetTag(no_Item) == "no_nuget_10")  {  no_suse=10; break;      }
    if(GetTag(no_Item) == "no_nuget_11")  {  no_suse=11; break;      }
    if(GetTag(no_Item) == "no_nuget_12")  {  no_suse=12; break;      }
    if(GetTag(no_Item) == "no_nuget_13")  {  no_suse=13; break;      }
    if(GetTag(no_Item) == "no_nuget_14")  {  no_suse=14; break;      }
    if(GetTag(no_Item) == "no_nuget_15")  {  no_suse=15; break;      }
    //nad 50= lestene
    if(GetTag(no_Item) == "no_brou_1")  {  no_suse=51; break;      }
    if(GetTag(no_Item) == "no_brou_2")  {  no_suse=52; break;      }
    if(GetTag(no_Item) == "no_brou_3")  {  no_suse=53; break;      }
    if(GetTag(no_Item) == "no_brou_4")  {  no_suse=54; break;      }
    if(GetTag(no_Item) == "no_brou_5")  {  no_suse=55; break;      }
    if(GetTag(no_Item) == "no_brou_6")  {  no_suse=56; break;      }
    if(GetTag(no_Item) == "no_brou_7")  {  no_suse=57; break;      }
    if(GetTag(no_Item) == "no_brou_8")  {  no_suse=58; break;      }
    if(GetTag(no_Item) == "no_brou_9")  {  no_suse=59; break;      }
    if(GetTag(no_Item) == "no_brou_10")  {  no_suse=60; break;      }
    if(GetTag(no_Item) == "no_brou_11")  {  no_suse=61; break;      }
    if(GetTag(no_Item) == "no_brou_12")  {  no_suse=62; break;      }
    if(GetTag(no_Item) == "no_brou_13")  {  no_suse=63; break;      }
    if(GetTag(no_Item) == "no_brou_14")  {  no_suse=64; break;      }
    if(GetTag(no_Item) == "no_brou_15")  {  no_suse=65; break;      }

    }//pokud resref = no_polot_ko      - pro zrychleni ifu...
  no_Item = GetNextItemInInventory(no_pec);
  }    /// dokud valid

//////tak mame predmet, co sme chteli. ted pravdepodobnost, ze se neco povede:
if (no_suse>0 ) {

int no_level = TC_getLevel(no_oPC,TC_SUTRY);
switch(no_suse) {
        case 1:   no_DC =  no_obt_kame_nefr -( 10*no_level );    break;
        case 2:   no_DC =  no_obt_kame_ohni -( 10*no_level );    break;
        case 3:   no_DC =  no_obt_kame_amet -( 10*no_level );    break;
        case 4:   no_DC =  no_obt_kame_fene -( 10*no_level );    break;
        case 5:   no_DC =  no_obt_kame_diam -( 10*no_level );    break;
        case 6:   no_DC =  no_obt_kame_rubi -( 10*no_level );    break;
        case 7:   no_DC =  no_obt_kame_mala -( 10*no_level );    break;
        case 8:   no_DC =  no_obt_kame_safi -( 10*no_level );    break;
        case 9:   no_DC =  no_obt_kame_opal -( 10*no_level );    break;
        case 10:   no_DC =  no_obt_kame_topa -( 10*no_level );    break;
        case 11:   no_DC =  no_obt_kame_gran -( 10*no_level );    break;
        case 12:   no_DC =  no_obt_kame_smar -( 10*no_level );    break;
        case 13:   no_DC =  no_obt_kame_alex -( 10*no_level );    break;
        case 14:   no_DC =  no_obt_kame_aven -( 10*no_level );    break;
        case 15:   no_DC =  no_obt_kame_zive -( 10*no_level );    break;
            //nad 50= lestene
        case 51:   no_DC =  no_obt_brou_nefr -( 10*no_level );    break;
        case 52:   no_DC =  no_obt_brou_ohni -( 10*no_level );    break;
        case 53:   no_DC =  no_obt_brou_amet -( 10*no_level );    break;
        case 54:   no_DC =  no_obt_brou_fene -( 10*no_level );    break;
        case 55:   no_DC =  no_obt_brou_diam -( 10*no_level );    break;
        case 56:   no_DC =  no_obt_brou_rubi -( 10*no_level );    break;
        case 57:   no_DC =  no_obt_brou_mala -( 10*no_level );    break;
        case 58:   no_DC =  no_obt_brou_safi -( 10*no_level );    break;
        case 59:   no_DC =  no_obt_brou_opal -( 10*no_level );    break;
        case 60:   no_DC =  no_obt_brou_topa -( 10*no_level );    break;
        case 61:   no_DC =  no_obt_brou_gran -( 10*no_level );    break;
        case 62:   no_DC =  no_obt_brou_smar -( 10*no_level );    break;
        case 63:   no_DC =  no_obt_brou_alex -( 10*no_level );    break;
        case 64:   no_DC =  no_obt_brou_aven -( 10*no_level );    break;
        case 65:   no_DC =  no_obt_brou_zive -( 10*no_level );    break;
                } //konec vnitrniho  switche
 //obtiznost kovu -5*lvlu

// pravdepodobnost uspechu =
int no_chance = 100 - (no_DC*2) ;
if (no_chance < 0) no_chance = 0;
//if (no_chance > 100) no_chance = 100;

//SendMessageToPC(no_oPC," no_DC:" + IntToString(no_DC) );
//SendMessageToPC(no_oPC," Sance uspechu :" + IntToString(no_chance) + "%");
//samotny hod
int no_hod = 101-d100();
//SendMessageToPC(no_oPC," Hodils :" + IntToString(no_hod));
if (no_hod <= no_chance ) {

         float no_procenta = GetLocalFloat(no_Item,"no_suse_proc");
        SendMessageToPC(no_oPC,"===================================");
        if (no_chance >= 100) {FloatingTextStringOnCreature("Zpracovani je pro tebe trivialni",no_oPC,FALSE );
                         TC_setXPbyDifficulty(no_oPC,TC_SUTRY,no_chance,TC_dej_vlastnost(TC_SUTRY,no_oPC));
                         }

        if ((no_chance > 0)&(no_chance<100)) { TC_setXPbyDifficulty(no_oPC,TC_SUTRY,no_chance,TC_dej_vlastnost(TC_SUTRY,no_oPC));
                            }
        //////////povedlo se takze se zlepsi % zhotoveni na polotovaru////////////
        ///////////nacteme procenta z minula kdyz je polotovar novej, mel by mit int=0 /////////////////
        //no_procenta = no_procenta + 10+ d20() + no_level ;  // = 12-45

        //  nove zavedene pomale crafteni  2.3.2009//////////////
             int no_obtiznost_vyrobku = no_DC+( 10*no_level );

           //SendMessageToPC(no_oPC," no_obtiznost_vyrobku:" + IntToString(no_obtiznost_vyrobku) );


/*            if (no_obtiznost_vyrobku >=190) {
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
            no_procenta = no_procenta + Random(20)/10.0 +10.0;}*/

            no_procenta = no_procenta + (TC_getProgressByDifficulty(no_obtiznost_vyrobku) / 10.0);

            if  (GetIsDM(no_oPC)== TRUE) no_procenta = no_procenta + 50.0;

        if (no_procenta >= 100.0) { //kdyz je vyrobek 100% tak samozrejmeje hotovej

        AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0, 5.0));

        DestroyObject(no_Item); //znicim ho, protoze predam hotovej vyrobek
        DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru


        switch(no_suse) {
        case 1:   {SetLocalInt(CreateItemOnObject("cnrgemcut001",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_1*no_br_nasobitel2));
                  FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 2:    {SetLocalInt(CreateItemOnObject("cnrgemcut002",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_2*no_br_nasobitel2));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 3:    {SetLocalInt(CreateItemOnObject("cnrgemcut003",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_3*no_br_nasobitel2));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 4:    {SetLocalInt(CreateItemOnObject("cnrgemcut004",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_4*no_br_nasobitel2));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 5:   { SetLocalInt(CreateItemOnObject("cnrgemcut005",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_5*no_br_nasobitel2));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 6:    {SetLocalInt(CreateItemOnObject("cnrgemcut006",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_6*no_br_nasobitel2));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 7:    {SetLocalInt(CreateItemOnObject("cnrgemcut007",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_7*no_br_nasobitel2));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 8:   { SetLocalInt(CreateItemOnObject("cnrgemcut008",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_8*no_br_nasobitel2));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 9:   { SetLocalInt(CreateItemOnObject("cnrgemcut009",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_9*no_br_nasobitel2));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 10:   { SetLocalInt(CreateItemOnObject("cnrgemcut010",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_10*no_br_nasobitel2));
                        FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 11:   { SetLocalInt(CreateItemOnObject("cnrgemcut011",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_11*no_br_nasobitel2));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 12:    {SetLocalInt(CreateItemOnObject("cnrgemcut012",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_12*no_br_nasobitel2));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 13:   { SetLocalInt(CreateItemOnObject("cnrgemcut013",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_13*no_br_nasobitel2));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 14:   { SetLocalInt(CreateItemOnObject("cnrgemcut014",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_14*no_br_nasobitel2));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 15:    {SetLocalInt(CreateItemOnObject("cnrgemcut015",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_15*no_br_nasobitel2));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
///////////////////nad 50= namorene////////////////////////////////////////////////////////
        case 51:   { SetLocalInt(CreateItemOnObject("cnrgemfine001",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_1*no_br_nasobitel));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 52:   { SetLocalInt(CreateItemOnObject("cnrgemfine002",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_2*no_br_nasobitel));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 53:   { SetLocalInt(CreateItemOnObject("cnrgemfine003",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_3*no_br_nasobitel));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 54:    {SetLocalInt(CreateItemOnObject("cnrgemfine004",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_4*no_br_nasobitel));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 55:   { SetLocalInt(CreateItemOnObject("cnrgemfine005",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_5*no_br_nasobitel));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 56:  { SetLocalInt(CreateItemOnObject("cnrgemfine006",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_6*no_br_nasobitel));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 57:    {SetLocalInt(CreateItemOnObject("cnrgemfine007",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_7*no_br_nasobitel));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 58:   { SetLocalInt(CreateItemOnObject("cnrgemfine008",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_8*no_br_nasobitel));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 59:   { SetLocalInt(CreateItemOnObject("cnrgemfine009",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_9*no_br_nasobitel));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 60:   { SetLocalInt(CreateItemOnObject("cnrgemfine010",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_10*no_br_nasobitel));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 61:    {SetLocalInt(CreateItemOnObject("cnrgemfine011",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_11*no_br_nasobitel));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 62:    {SetLocalInt(CreateItemOnObject("cnrgemfine012",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_12*no_br_nasobitel));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 63:    {SetLocalInt(CreateItemOnObject("cnrgemfine013",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_13*no_br_nasobitel));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 64:   { SetLocalInt(CreateItemOnObject("cnrgemfine014",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_14*no_br_nasobitel));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 65:   { SetLocalInt(CreateItemOnObject("cnrgemfine015",no_oPC,1),"tc_cena",FloatToInt(no_cena_kame_15*no_br_nasobitel));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        }  ///konec case
                }//konec kdzy uz mam nad 100%
        if (no_procenta < 100.0) {  //kdyz neni 100% tak samozrejmeje neni hotovej

        if ( GetLocalInt(no_Item,"no_pocet_cyklu") == 9 ) {TC_saveCraftXPpersistent(no_oPC,TC_SUTRY);}

        string no_nazev_procenta = FloatToString(no_procenta);

        if (no_procenta >= 10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                                  no_nazev_procenta = GetStringRight(no_nazev_procenta,4);}
        if (no_procenta <10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                               no_nazev_procenta = GetStringRight(no_nazev_procenta,3);}

        switch(no_suse) {
        case 1:  {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);



                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny nefrit *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);


                         }
                 break; }
        case 2: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny ohnivy achat *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);


                         }
                 break; }
        case 3: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny ametyst *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 4: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny fenelop *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 5: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny diamant *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 6: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny rubin *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 7: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny malachit *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 8: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny safir *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 9: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny opal *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 10: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny topaz *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 11: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny granat *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 12: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny smaragd *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 13: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny alexandrit *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 14: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny aventurin *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 15: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny zivec *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }

////////////////nad50= louhovane kuze////////////////////////////////
        case 51: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny nefrit *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 52: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny ohnivy achat *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 53: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny ametyst *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 54: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny fenelop *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 55: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny diamant *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 56: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny rubin *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 57: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny malachit *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 58: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny safir *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 59: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny opal *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 60: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny topaz *" +no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 61: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny granat *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 62: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny smaragd *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 63: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny alexandrit *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 64: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny aventurin *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 65: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny zivec *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
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
         FloatingTextStringOnCreature("Kamen je na prach.",no_oPC,FALSE );
         ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE),OBJECT_SELF);
         DelayCommand(1.0,AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 2.0)));
                               }
        else  if ((no_chance > 0)&(no_procenta>0.0)) FloatingTextStringOnCreature("Na kameni se objevily praskliny ",no_oPC,FALSE );

        if (no_chance == 0){ FloatingTextStringOnCreature(" Se zpracovani by si mel radeji pockat ",no_oPC,FALSE );
                      DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(1,DAMAGE_TYPE_SONIC),no_oPC));
                          }     //konec ifu

if (no_procenta > 0.0 ) {
        string no_nazev_procenta;
        if (no_procenta >= 10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                                  no_nazev_procenta = GetStringRight(no_nazev_procenta,4);}
        if (no_procenta <10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                               no_nazev_procenta = GetStringRight(no_nazev_procenta,3);}

    /////////nastavime procenta ////////////////
        switch(no_suse) {
        case 1:  {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny nefrit *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 2: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny ohnivy achat *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 3: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny ametyst *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 4: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny fenelop *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 5: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny diamant *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 6: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny rubin *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 7: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny malachit *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 8: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny safir *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 9: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny opal *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 10: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta+ "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny topaz *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 11: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny granat *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 12: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny smaragd *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 13: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny alexandrit *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 14: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny aventurin *" +no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 15: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Brouseny zivec *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si brouseni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }

////////////////nad50= louhovane kuze////////////////////////////////
        case 51: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny nefrit *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 52: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny ohnivy achat *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 53: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny ametyst *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 54: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny fenelop *" +no_nazev_procenta+ "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 55: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny diamant *" + no_nazev_procenta+ "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 56: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny rubin *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 57: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta+ "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny malachit *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 58: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny safir *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 59: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta+ "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny opal *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 60: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny topaz *" +no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 61: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny granat *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 62: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny smaragd *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 63: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny alexandrit *" + no_nazev_procenta+ "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 64: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny aventurin *" + no_nazev_procenta+ "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 65: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);
                 no_Item = CreateItemOnObject("no_polot_br",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lesteny zivec *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_br_clos_kame",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si lesteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
                }/// kdyz mame nad 0% vyrobku.
               }//konec nastaveni % u vyrobku

         }//konec elsetzn kdyz se nepovedlo.

         }// konec kdyz jsme davali polotovar..

}    ////knec no_xp_kamen




void no_xp_brous(object no_oPC, object no_pec, int no_druh_sutru)
// vyresi moznost uspechu a preda pripadny kus drea do no_pec
{
        ///////////////udelame polotovar////////////////////
        switch(no_druh_sutru) {
        case 1:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_nuget_1"),"no_suse_proc",15.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 2:  {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_nuget_2"),"no_suse_proc",15.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 3:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_nuget_3"),"no_suse_proc",15.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 4:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_nuget_4"),"no_suse_proc",15.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 5:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_nuget_5"),"no_suse_proc",15.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 6:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_nuget_6"),"no_suse_proc",15.0);
                   no_xp_kamen(no_oPC,no_pec);       //no_pec je tam , at se objevi v peci a muze se rovnou zvetsit %
                   break; }
        case 7:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_nuget_7"),"no_suse_proc",15.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 8:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_nuget_8"),"no_suse_proc",15.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 9:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_nuget_9"),"no_suse_proc",15.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 10:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_nuget_10"),"no_suse_proc",15.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 11:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_nuget_11"),"no_suse_proc",15.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 12:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_nuget_12"),"no_suse_proc",15.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 13:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_nuget_13"),"no_suse_proc",15.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 14:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_nuget_14"),"no_suse_proc",15.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 15:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_nuget_15"),"no_suse_proc",15.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }

                } //konec vnitrniho  switche

} // konec no_xp_brous






void no_xp_lest(object no_oPC, object no_pec, int no_druh_sutru)
// vyresi moznost uspechu a preda pripadny povedenou desku do no_pec
{
int no_level = TC_getLevel(no_oPC,TC_SUTRY);        ///////////////udelame polotovar////////////////////
        switch(no_druh_sutru) {
        case 1:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_brou_1"),"no_suse_proc",10.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 2:  {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_brou_2"),"no_suse_proc",10.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 3:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_brou_3"),"no_suse_proc",10.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 4:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_brou_4"),"no_suse_proc",10.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 5:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_brou_5"),"no_suse_proc",10.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 6:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_brou_6"),"no_suse_proc",10.0);
                   no_xp_kamen(no_oPC,no_pec);       //no_pec je tam , at se objevi v peci a muze se rovnou zvetsit %
                   break; }
        case 7:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_brou_7"),"no_suse_proc",10.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 8:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_brou_8"),"no_suse_proc",10.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 9:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_brou_9"),"no_suse_proc",10.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 10:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_brou_10"),"no_suse_proc",10.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 11:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_brou_11"),"no_suse_proc",10.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 12:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_brou_12"),"no_suse_proc",10.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 13:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_brou_13"),"no_suse_proc",10.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 14:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_brou_14"),"no_suse_proc",10.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }
        case 15:   {SetLocalFloat(CreateItemOnObject("no_polot_br",no_pec,1,"no_brou_15"),"no_suse_proc",10.0);
                   no_xp_kamen(no_oPC,no_pec);
                   break; }

                } //konec vnitrniho  switche
} // konec no_xp_lest











