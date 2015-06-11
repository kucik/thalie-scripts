#include "ku_libtime"
//#include "no_dr_inc"
#include "no_nastcraft_ini"
#include "tc_xpsystem_inc"
#include "tc_functions"

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


void no_osekane(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_osekane na objectu no_pec na hodnotu dreva
void no_moridlo(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_moridlo na objectu no_pec na hodnotu dreva
// no_nale_pocet  : pocet rudy
void no_drevo(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_drevo na objectu no_pec na hodnotu natezeneho dreva v peci
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

void no_xp_dr (object no_oPC, object no_pec);
//pomaha pridavat % polotovaru, kdyztak predava hotovvej vyrobek, pridava xpy..
void no_xp_drevo(object no_oPC, object no_pec, int no_kov);
// vytvori polotovar
void no_xp_deska(object no_oPC, object no_pec, int no_kov);
// vytvori polotovar
void no_xp_lat(object no_oPC, object no_pec, int no_druh_dreva);
// vytvori polotovar
void no_xp_nasa(object no_oPC, object no_pec, int no_druh_dreva);
// vytvori polotovar





/////////zacatek zavadeni funkci//////////////////////////////////////////////



/////////zacatek zavadeni funkci//////////////////////////////////////////////
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
switch (no_druh){
   case 1: { while (no_pocet>0)  {
                SetLocalInt(CreateItemOnObject("tc_osek_vrb",OBJECT_SELF,1,"tc_osek"),"tc_cena",FloatToInt(no_cena_nasa_vrb*no_dr_nasobitel));
                no_pocet=no_pocet-1;
                                }    break;
                                }///konec case
   case 2: {  while (no_pocet>0)
                   {
                SetLocalInt(CreateItemOnObject("tc_osek_ore",OBJECT_SELF,1,"tc_osek"),"tc_cena",FloatToInt(no_cena_nasa_ore*no_dr_nasobitel));
                  no_pocet=no_pocet-1;
                                }    break;
                                }///konec case
 case 3: {  while (no_pocet>0)
                   {
                SetLocalInt(CreateItemOnObject("tc_osek_dub",OBJECT_SELF,1,"tc_osek"),"tc_cena",FloatToInt(no_cena_nasa_dub*no_dr_nasobitel));
                  no_pocet=no_pocet-1;
                                }    break;
                                }///konec case
   case 4: {  while (no_pocet>0)
                   {
            SetLocalInt(CreateItemOnObject("tc_osek_mah",OBJECT_SELF,1,"tc_osek"),"tc_cena",FloatToInt(no_cena_nasa_mah*no_dr_nasobitel));
                      no_pocet=no_pocet-1;
                                }    break;
                                }///konec case
   case 5: {  while (no_pocet>0)
                   {
            SetLocalInt(CreateItemOnObject("tc_osek_tis",OBJECT_SELF,1,"tc_osek"),"tc_cena",FloatToInt(no_cena_nasa_tis*no_dr_nasobitel));
                      no_pocet=no_pocet-1;
                                }    break;
                                }///konec case
   case 6: {  while (no_pocet>0)
                   {
            SetLocalInt(CreateItemOnObject("tc_osek_jil",OBJECT_SELF,1,"tc_osek"),"tc_cena",FloatToInt(no_cena_nasa_jil*no_dr_nasobitel));
                      no_pocet=no_pocet-1;
                                }    break;
                                }///konec case
   case 7: {  while (no_pocet>0)
                   {
            SetLocalInt(CreateItemOnObject("tc_osek_zel",OBJECT_SELF,1,"tc_osek"),"tc_cena",FloatToInt(no_cena_nasa_zel*no_dr_nasobitel));
                      no_pocet=no_pocet-1;
                                }    break;
                                }///konec case
   case 8: {  while (no_pocet>0)
                   {
            SetLocalInt(CreateItemOnObject("tc_osek_pra",OBJECT_SELF,1,"tc_osek"),"tc_cena",FloatToInt(no_cena_nasa_pra*no_dr_nasobitel));
                      no_pocet=no_pocet-1;
                                }    break;
                                }///konec case




   }//konec switche

}  //konec vraceni veci////////////////////////////////////



/////////////kdyz bylo v peci malo veci, tak je pekne vrati dovnitr do pece !!!!
void no_vratslin(int no_slinovana)
{

switch (no_slinovana)  {
   case 1: {
                CreateItemOnObject("tc_moridlo_vrb",OBJECT_SELF,1,"no_moridlo");
                break; }
   case 2: {
                CreateItemOnObject("tc_moridlo_ore",OBJECT_SELF,1,"no_moridlo");
                break; }
   case 3: {
                CreateItemOnObject("tc_moridlo_dub",OBJECT_SELF,1,"no_moridlo");
                break; }
   case 4: {
                CreateItemOnObject("tc_moridlo_mah",OBJECT_SELF,1,"no_moridlo");
                break; }
   case 5: {
                CreateItemOnObject("tc_moridlo_tis",OBJECT_SELF,1,"no_moridlo");
                break; }
   case 6: {
                CreateItemOnObject("tc_moridlo_jil",OBJECT_SELF,1,"no_moridlo");
                break; }
   case 7: {
                CreateItemOnObject("tc_moridlo_zel",OBJECT_SELF,1,"no_moridlo");
                break; }
   case 8: {
                CreateItemOnObject("tc_moridlo_pra",OBJECT_SELF,1,"no_moridlo");
                break; }

   }//konec switche

}  //konec vraceni veci////////////////////////////////////



void no_osekane(object no_Item, object no_pec, int no_mazani)
{      // do no_osek ulozi cislo osekaneho dreva
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {


           if(GetResRef(no_Item) == "tc_osek_vrb")           //do promene no_osekane ulozime nazev prisady
    { SetLocalInt(no_pec,"no_osekane",1);
    no_snizstack(no_Item,no_mazani);                          //znicime prisadu
    break;      }
           if(GetResRef(no_Item) == "tc_osek_ore")
    { SetLocalInt(no_pec,"no_osekane",2);
    no_snizstack(no_Item,no_mazani);
    break;      }
           if(GetResRef(no_Item) == "tc_osek_dub")
    { SetLocalInt(no_pec,"no_osekane",3);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_osek_mah")
    { SetLocalInt(no_pec,"no_osekane",4);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_osek_tis")
    { SetLocalInt(no_pec,"no_osekane",5);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_osek_jil")
    { SetLocalInt(no_pec,"no_osekane",6);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_osek_zel")
    { SetLocalInt(no_pec,"no_osekane",7);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_osek_pra")
    { SetLocalInt(no_pec,"no_osekane",8);
    no_snizstack(no_Item,no_mazani);
    break;      }

  no_Item = GetNextItemInInventory(no_pec);
  }  //tak uz osekane drevo
}


//////////////urci ktere drevo je v inventari no_pece //////////////////////////////////
void no_drevo(object no_Item, object no_pec, int no_mazani)
{
SetLocalInt(no_pec,"no_drevo",0);
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {

    if(GetTag(no_Item) == "tc_Drev_Vrb")           // do promene no_drevo ulozime nazev dreva
    { SetLocalInt(no_pec,"no_drevo",1);
        no_snizstack(no_Item,no_mazani);                    // znicime drevo
    break;      }
    if(GetTag(no_Item) == "cnrBranchHic")
    { SetLocalInt(no_pec,"no_drevo",2);
        no_snizstack(no_Item,no_mazani);
    break;      }
      if(GetTag(no_Item) == "cnrBranchOak")
    { SetLocalInt(no_pec,"no_drevo",3);
        no_snizstack(no_Item,no_mazani);
    break;      }
      if(GetTag(no_Item) == "cnrBranchMah")
    {
        SetLocalInt(no_pec,"no_drevo",4);
        no_snizstack(no_Item,no_mazani);
    break;      }
      if(GetTag(no_Item) == "tc_Drev_Tis")
    { SetLocalInt(no_pec,"no_drevo",5);
        no_snizstack(no_Item,no_mazani);
    break;      }
      if(GetTag(no_Item) == "tc_Drev_Jil")
    { SetLocalInt(no_pec,"no_drevo",6);
        no_snizstack(no_Item,no_mazani);
    break;      }
      if(GetTag(no_Item) == "tc_Drev_Zel")
    { SetLocalInt(no_pec,"no_drevo",7);
        no_snizstack(no_Item,no_mazani);
    break;      }
      if(GetTag(no_Item) == "tc_Drev_Pra")
    { SetLocalInt(no_pec,"no_drevo",8);
        no_snizstack(no_Item,no_mazani);
    break;      }
  no_Item = GetNextItemInInventory(no_pec);
  }
}


void no_moridlo(object no_Item, object no_pec, int no_mazani)
///////////////////////////////////////////
//// vystup:  no_moridlo       cislo urci moridlo
//////
////////////////////////////////////////////


{      // do no_moridlo ulozi cislo moridla
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {

if (GetStringLeft(GetTag(no_Item),7) == "tc_mori" ) {

           if(GetTag(no_Item) == "tc_moridlo_vrb")           //do promene no_osekane ulozime nazev prisady
    { SetLocalInt(no_pec,"no_moridlo",1);
    no_snizstack(no_Item,no_mazani);                           //znicime prisadu
    break;      }
           if(GetTag(no_Item) == "tc_moridlo_ore")
    { SetLocalInt(no_pec,"no_moridlo",2);
    no_snizstack(no_Item,no_mazani);
    break;      }
           if(GetTag(no_Item) == "tc_moridlo_dub")
    { SetLocalInt(no_pec,"no_moridlo",3);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "tc_moridlo_mah")
    { SetLocalInt(no_pec,"no_moridlo",4);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "tc_moridlo_tis")
    { SetLocalInt(no_pec,"no_moridlo",5);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "tc_moridlo_jil")
    { SetLocalInt(no_pec,"no_moridlo",6);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "tc_moridlo_zel")
    { SetLocalInt(no_pec,"no_moridlo",7);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "tc_moridlo_pra")
    { SetLocalInt(no_pec,"no_moridlo",8);
    no_snizstack(no_Item,no_mazani);
    break;      }
    }// if moridlo

  no_Item = GetNextItemInInventory(no_pec);
  }  //tak uz osekane drevo
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
AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, no_dr_delay));
AssignCommand(no_oPC, SetCommandable(FALSE));
DelayCommand(no_dr_delay,ActionUnlockObject(OBJECT_SELF));
DelayCommand(no_dr_delay-1.0,AssignCommand(no_oPC, SetCommandable(TRUE)));
PlaySound("as_cv_sawing1");
}



///////////////////////////////Predelavam polotovar///////////////////////////////////////////////////////
/////////zjisti pravdepodobnost, prideli xpy, prida %hotovosti vyrobku a kdz bude nad 100% udela jej hotovym.
void no_xp_dr (object no_oPC, object no_pec)
{
int no_druh=0;
no_Item = GetFirstItemInInventory(no_pec);
while (GetIsObjectValid(no_Item)) {

if (GetResRef(no_Item) == "no_polot_dr") {
    if(GetTag(no_Item) == "no_dr_vrb")  {  no_druh=1; break;      }
    if(GetTag(no_Item) == "no_dr_ore")  {   no_druh=2; break;      }
    if(GetTag(no_Item) == "no_dr_dub")  {  no_druh=3; break;      }
    if(GetTag(no_Item) == "no_dr_mah")  {  no_druh=4; break;      }
    if(GetTag(no_Item) == "no_dr_tis")  {  no_druh=5; break;      }
    if(GetTag(no_Item) == "no_dr_jil")  {  no_druh=6; break;      }
    if(GetTag(no_Item) == "no_dr_zel")  {  no_druh=7; break;      }
    if(GetTag(no_Item) == "no_dr_pra")  {  no_druh=8; break;      }
    //nad 50= desky
    if(GetTag(no_Item) == "no_dr_d_vrb")  {  no_druh=51; break;      }
    if(GetTag(no_Item) == "no_dr_d_ore")  {  no_druh=52; break;      }
    if(GetTag(no_Item) == "no_dr_d_dub")  {  no_druh=53; break;      }
    if(GetTag(no_Item) == "no_dr_d_mah")  {  no_druh=54; break;      }
    if(GetTag(no_Item) == "no_dr_d_tis")  {  no_druh=55; break;      }
    if(GetTag(no_Item) == "no_dr_d_jil")  {  no_druh=56; break;      }
    if(GetTag(no_Item) == "no_dr_d_zel")  {  no_druh=57; break;      }
    if(GetTag(no_Item) == "no_dr_d_pra")  {  no_druh=58; break;      }
    //nad 100  late
    if(GetTag(no_Item) == "no_dr_l_vrb")  {  no_druh=101; break;      }
    if(GetTag(no_Item) == "no_dr_l_ore")  {  no_druh=102; break;      }
    if(GetTag(no_Item) == "no_dr_l_dub")  {  no_druh=103; break;      }
    if(GetTag(no_Item) == "no_dr_l_mah")  {  no_druh=104; break;      }
    if(GetTag(no_Item) == "no_dr_l_tis")  {  no_druh=105; break;      }
    if(GetTag(no_Item) == "no_dr_l_jil")  {  no_druh=106; break;      }
    if(GetTag(no_Item) == "no_dr_l_zel")  {  no_druh=107; break;      }
    if(GetTag(no_Item) == "no_dr_l_pra")  {  no_druh=108; break;      }
    //nad 150  nasady
    if(GetTag(no_Item) == "no_dr_n_vrb")  {  no_druh=151; break;      }
    if(GetTag(no_Item) == "no_dr_n_ore")  {  no_druh=152; break;      }
    if(GetTag(no_Item) == "no_dr_n_dub")  {  no_druh=153; break;      }
    if(GetTag(no_Item) == "no_dr_n_mah")  {  no_druh=154; break;      }
    if(GetTag(no_Item) == "no_dr_n_tis")  {  no_druh=155; break;      }
    if(GetTag(no_Item) == "no_dr_n_jil")  {  no_druh=156; break;      }
    if(GetTag(no_Item) == "no_dr_n_zel")  {  no_druh=157; break;      }
    if(GetTag(no_Item) == "no_dr_n_pra")  {  no_druh=158; break;      }
    }//pokud resref = no_polot_ko      - pro zrychleni ifu...
  no_Item = GetNextItemInInventory(no_pec);
  }    /// dokud valid

//////tak mame predmet, co sme chteli. ted pravdepodobnost, ze se neco povede:
if (no_druh>0 ) {

int no_level = TC_getLevel(no_oPC,TC_DREVO);
switch(no_druh) {
        case 1:   no_DC =  no_obt_drevo_vrb -(10*no_level );    break;
        case 2:   no_DC =  no_obt_drevo_orech -( 10*no_level );    break;
        case 3:   no_DC =  no_obt_drevo_dub -( 10*no_level );    break;
        case 4:   no_DC =  no_obt_drevo_mah -( 10*no_level );    break;
        case 5:   no_DC =  no_obt_drevo_tis -( 10*no_level );    break;
        case 6:   no_DC =  no_obt_drevo_jil -( 10*no_level );    break;
        case 7:   no_DC =  no_obt_drevo_zel -( 10*no_level );    break;
        case 8:   no_DC =  no_obt_drevo_pra -( 10*no_level );    break;
            //nad 50= desky
        case 51:   no_DC =  no_obt_deska_vrb -( 10*no_level );    break;
        case 52:   no_DC =  no_obt_deska_orech -( 10*no_level );    break;
        case 53:   no_DC =  no_obt_deska_dub -( 10*no_level );    break;
        case 54:   no_DC =  no_obt_deska_mah -( 10*no_level );    break;
        case 55:   no_DC =  no_obt_deska_tis -( 10*no_level );    break;
        case 56:   no_DC =  no_obt_deska_jil -( 10*no_level );    break;
        case 57:   no_DC =  no_obt_deska_zel -( 10*no_level );    break;
        case 58:   no_DC =  no_obt_deska_pra -( 10*no_level );    break;
        //nad 100  late
        case 101:   no_DC =  no_obt_lat_vrb -( 10*no_level );    break;
        case 102:   no_DC =  no_obt_lat_orech -( 10*no_level );    break;
        case 103:   no_DC =  no_obt_lat_dub -( 10*no_level );    break;
        case 104:   no_DC =  no_obt_lat_mah -( 10*no_level );    break;
        case 105:   no_DC =  no_obt_lat_tis -( 10*no_level );    break;
        case 106:   no_DC =  no_obt_lat_jil -( 10*no_level );    break;
        case 107:   no_DC =  no_obt_lat_zel -( 10*no_level );    break;
        case 108:   no_DC =  no_obt_lat_pra -( 10*no_level );    break;
         //nad 150 nasady
        case 151:   no_DC =  no_obt_nasa_vrb -( 10*no_level );    break;
        case 152:   no_DC =  no_obt_nasa_orech -( 10*no_level );    break;
        case 153:   no_DC =  no_obt_nasa_dub -( 10*no_level );    break;
        case 154:   no_DC =  no_obt_nasa_mah -( 10*no_level );    break;
        case 155:   no_DC =  no_obt_nasa_tis -( 10*no_level );    break;
        case 156:   no_DC =  no_obt_nasa_jil -( 10*no_level );    break;
        case 157:   no_DC =  no_obt_nasa_zel -( 10*no_level );    break;
        case 158:   no_DC =  no_obt_nasa_pra -( 10*no_level );    break;


                } //konec vnitrniho  switche
 //obtiznost kovu -5*lvlu

// pravdepodobnost uspechu =
int no_chance = 100 - (no_DC*2) ;
if (no_chance < 0) no_chance = 0;
//SendMessageToPC(no_oPC," Sance uspechu :" + IntToString(no_chance));
//samotny hod
int no_hod = 101-d100();
if (no_hod <= no_chance ) {
//SendMessageToPC(no_oPC," Hodils :" + IntToString(no_hod));
         float no_procenta = GetLocalFloat(no_Item,"no_suse_proc");
        SendMessageToPC(no_oPC,"===================================");
        if (no_chance >= 100) {FloatingTextStringOnCreature("Zpracovani je pro tebe trivialni",no_oPC,FALSE );

                         TC_setXPbyDifficulty(no_oPC,TC_DREVO,no_chance,TC_dej_vlastnost(TC_DREVO,no_oPC));
                         }

        if ((no_chance > 0)&(no_chance<100))  { TC_setXPbyDifficulty(no_oPC,TC_DREVO,no_chance,TC_dej_vlastnost(TC_DREVO,no_oPC));
                            }
        //////////povedlo se takze se zlepsi % zhotoveni na polotovaru////////////
        ///////////nacteme procenta z minula kdyz je polotovar novej, mel by mit int=0 /////////////////
                         int no_obtiznost_vyrobku = no_DC+( 10*no_level );
/*
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
*/
            no_procenta = no_procenta + (TC_getProgressByDifficulty(no_obtiznost_vyrobku) / 10.0);

                     if  (GetIsDM(no_oPC)== TRUE) no_procenta = no_procenta + 50.0;

        if (no_procenta >= 100.0) { //kdyz je vyrobek 100% tak samozrejmeje hotovej
                AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0, 5.0));

                DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru
        DestroyObject(no_Item); //znicim ho, protoze predam hotovej vyrobek



        switch(no_druh) {
        case 1:   {SetLocalInt(CreateItemOnObject("tc_osek_vrb",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_vrb*no_dr_nasobitel2));
                   FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 2:   {SetLocalInt(CreateItemOnObject("tc_osek_ore",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_ore*no_dr_nasobitel2));
                   FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 3:   {SetLocalInt(CreateItemOnObject("tc_osek_dub",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_dub*no_dr_nasobitel2));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 4:   {SetLocalInt(CreateItemOnObject("tc_osek_mah",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_mah*no_dr_nasobitel2));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 5:   {SetLocalInt(CreateItemOnObject("tc_osek_tis",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_tis*no_dr_nasobitel2));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 6:   {SetLocalInt(CreateItemOnObject("tc_osek_jil",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_jil*no_dr_nasobitel2));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 7:   {SetLocalInt(CreateItemOnObject("tc_osek_zel",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_zel*no_dr_nasobitel2));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 8:   {SetLocalInt(CreateItemOnObject("tc_osek_pra",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_pra*no_dr_nasobitel2));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
///////////////////nad 50= deska////////////////////////////////////////////////////////
        case 51:   {SetLocalInt(CreateItemOnObject("tc_desk_vrb",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_vrb*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 52:   {SetLocalInt(CreateItemOnObject("tc_desk_ore",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_ore*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 53:   {SetLocalInt(CreateItemOnObject("tc_desk_dub",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_dub*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 54:  {SetLocalInt(CreateItemOnObject("tc_desk_mah",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_mah*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 55:   {SetLocalInt(CreateItemOnObject("tc_desk_tis",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_tis*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 56:  { SetLocalInt(CreateItemOnObject("tc_desk_jil",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_jil*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 57:  { SetLocalInt(CreateItemOnObject("tc_desk_zel",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_zel*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 58:  { SetLocalInt(CreateItemOnObject("tc_desk_pra",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_pra*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
//////////////////////////nad 100 late//////////////////////////////////
        case 101:  { SetLocalInt(CreateItemOnObject("tc_lat_vrb",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_vrb*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 102:  { SetLocalInt(CreateItemOnObject("tc_lat_ore",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_ore*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 103:  { SetLocalInt(CreateItemOnObject("tc_lat_dub",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_dub*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 104:  { SetLocalInt(CreateItemOnObject("tc_lat_mah",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_mah*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 105:  { SetLocalInt(CreateItemOnObject("tc_lat_tis",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_tis*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 106:  { SetLocalInt(CreateItemOnObject("tc_lat_jil",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_jil*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 107:   {SetLocalInt(CreateItemOnObject("tc_lat_zel",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_zel*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 108:  {SetLocalInt(CreateItemOnObject("tc_lat_pra",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_pra*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        ////////////nad 150 nasady //////////////////////
        case 151:   {SetLocalInt(CreateItemOnObject("tc_nasa_vrb",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_vrb*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 152:   {SetLocalInt(CreateItemOnObject("tc_nasa_ore",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_ore*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 153:  {SetLocalInt(CreateItemOnObject("tc_nasa_dub",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_dub*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 154:   {SetLocalInt(CreateItemOnObject("tc_nasa_mah",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_mah*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 155:   {SetLocalInt(CreateItemOnObject("tc_nasa_tis",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_tis*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 156:   {SetLocalInt(CreateItemOnObject("tc_nasa_jil",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_jil*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 157:   {SetLocalInt(CreateItemOnObject("tc_nasa_zel",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_zel*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}
        case 158:  {SetLocalInt(CreateItemOnObject("tc_nasa_pra",no_oPC,1),"tc_cena",FloatToInt(no_cena_nasa_pra*no_dr_nasobitel));
                           FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                   break;}


                }  ///konec case
         }//konec kdzy uz mam nad 100%

        if (no_procenta < 100.0) {  //kdyz neni 100% tak samozrejmeje neni hotovej
                string no_nazev_procenta = FloatToString(no_procenta);

        if (no_procenta >= 10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                                  no_nazev_procenta = GetStringRight(no_nazev_procenta,4);}
        if (no_procenta <10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                               no_nazev_procenta = GetStringRight(no_nazev_procenta,3);}

        if ( GetLocalInt(no_Item,"no_pocet_cyklu") == 9 ) {TC_saveCraftXPpersistent(no_oPC,TC_DREVO);}

        switch(no_druh) {
        case 1:  {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Osekana vrba *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si osekavani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 2: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Osekany orech *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si osekavani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 3: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Osekany dub *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si osekavani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 4: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Osekany mahagon *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si osekavani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 5: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Osekany tis *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si osekavani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 6: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Osekany jilm *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si osekavani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 7: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Osekany zelezny dub *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si osekavani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 8: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Osekany prastary dub *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si osekavani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
////////////////nad50= desky////////////////////////////////
        case 51: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);



                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Vrbova deska *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 52:{string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Orechova deska*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 53: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Dubova deska*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 54: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Mahagonova deska*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 55: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Tisova deska*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 56: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Jilmova deska*" + no_nazev_procenta+ "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 57: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Deska ze zelezneho dubu*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 58: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Deska z prastareho dubu*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
             ///////////100 late    //////////////////////////////////
        case 101: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Vrbova lat*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 102:{string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Orechova lat*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 103: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Dubova lat*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 104: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Mahagonova lat*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 105: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Tisova lat*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 106: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Jilmova lat*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 107: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lat ze zelezneho dubu*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 108: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta+ "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Lat z prastareho dubu*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
//////////nad 150 nasady /////
        case 151:{string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Vrbova rukojet*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 152: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Orechova rukojet*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 153:{string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta+ "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Dubova rukojet*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 154: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Mahagonova rukojet*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 155: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Tisova rukojet*" +no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 156:{string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Jilmova rukojet*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 157: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Rukojet ze zelezneho dubu*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 158: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Rukojet z prastareho dubu*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
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

         FloatingTextStringOnCreature("Drevo se rozpadlo.",no_oPC,FALSE );
         ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE),OBJECT_SELF);
         DelayCommand(1.0,AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 2.0)));
                               }
        else  if ((no_chance > 0)&(no_procenta>0.0)) FloatingTextStringOnCreature("Na dreve se objevily praskliny ",no_oPC,FALSE );

        if (no_chance == 0){ FloatingTextStringOnCreature(" Se zpracovani by si mel radeji pockat ",no_oPC,FALSE );
                      DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(1,DAMAGE_TYPE_SONIC),no_oPC));
                          }     //konec ifu

if (no_procenta > 0.0 ) {


        string no_nazev_procenta = FloatToString(no_procenta);

        if (no_procenta >= 10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                                  no_nazev_procenta = GetStringRight(no_nazev_procenta,4);}
        if (no_procenta <10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                               no_nazev_procenta = GetStringRight(no_nazev_procenta,3);}


        switch(no_druh) {
        case 1:  {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Osekana vrba *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si osekavani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);

                         }
                 break; }
        case 2: {string no_tag_vyrobku = GetTag(no_Item);
                  int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Osekany orech *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si osekavani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 3: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Osekany dub *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si osekavani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 4: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Osekany mahagon *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si osekavani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 5: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Osekany tis *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si osekavani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 6: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Osekany jilm *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si osekavani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 7: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Osekany zelezny dub *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si osekavani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 8: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Osekany prastary dub *" +no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si osekavani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
////////////////nad50= desky////////////////////////////////
        case 51: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Vrbova deska *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 52:{string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Orechova deska*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 53: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta+ "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Dubova deska*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 54: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Mahagonova deska*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 55: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Tisova deska*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 56: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Jilmova deska*" +no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 57: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Deska ze zelezneho dubu*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 58: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Deska z prastareho dubu*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
             ///////////100 late    //////////////////////////////////
        case 101: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Vrbova lat*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 102:{string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Orechova lat*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 103: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Dubova lat*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 104: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Mahagonova lat*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 105: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta+ "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Tisova lat*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 106: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Jilmova lat*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 107: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"lat ze zelezneho dubu*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 108: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Lat z prastareho dubu*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
//////////nad 150 nasady /////
        case 151:{string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Vrbova rukojet*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 152: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Orechova rukojet*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 153:{string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Dubova rukojet*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 154: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Mahagonova rukojet*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 155: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Tisova rukojet*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 156:{string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Jilmova rukojet*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 157: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Rukojet ze zelezneho dubu*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 158: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_dr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Rukojet z prastareho dubu*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_dr_clos_spale",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si sekani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);

                         }
                 break; }
                 }//konec case zvetsovani %
          }// kdyz neni 100%



      }//konec else
 }// konec kdyz jsme davali polotovar..

}    ////knec no_xp_dr





void no_xp_drevo(object no_oPC, object no_pec, int no_druh_dreva)
// vyresi moznost uspechu a preda pripadny kus drea do no_pec
{
int no_level = TC_getLevel(no_oPC,TC_DREVO);
switch(no_druh_dreva) {
        case 1:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_vrb"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 2:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_ore"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 3:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_dub"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 4:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_mah"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 5:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_tis"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 6:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_jil"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 7:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_zel"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 8:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_pra"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        }
} // konec no_xp_drevo




void no_xp_deska(object no_oPC, object no_pec, int no_druh_dreva)
// vyresi moznost uspechu a preda pripadny povedenou desku do no_pec
{
int no_level = TC_getLevel(no_oPC,TC_DREVO);
switch(no_druh_dreva) {
        case 1:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_d_vrb"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 2:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_d_ore"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 3:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_d_dub"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 4:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_d_mah"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 5:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_d_tis"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 6:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_d_jil"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 7:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_d_zel"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 8:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_d_pra"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        }
} // konec no_xp_drevo


void no_xp_lat(object no_oPC, object no_pec, int no_druh_dreva)
// vyresi moznost uspechu a preda pripadnou lat do no_pec
{
int no_level = TC_getLevel(no_oPC,TC_DREVO);
switch(no_druh_dreva) {
case 1:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_l_vrb"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 2:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_l_ore"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 3:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_l_dub"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 4:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_l_mah"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 5:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_l_tis"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 6:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_l_jil"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 7:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_l_zel"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 8:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_l_pra"),"no_suse_proc",10.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
                   }
} // konec no_xp_lat


void no_xp_nasa(object no_oPC, object no_pec, int no_druh_dreva)
// vyresi moznost uspechu a preda pripadnou lat do no_pec
{
int no_level = TC_getLevel(no_oPC,TC_DREVO);
switch(no_druh_dreva) {
        case 1:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_n_vrb"),"no_suse_proc",15.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 2:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_n_ore"),"no_suse_proc",15.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 3:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_n_dub"),"no_suse_proc",15.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 4:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_n_mah"),"no_suse_proc",15.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 5:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_n_tis"),"no_suse_proc",15.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 6:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_n_jil"),"no_suse_proc",15.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 7:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_n_zel"),"no_suse_proc",15.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
        case 8:   {SetLocalFloat(CreateItemOnObject("no_polot_dr",no_pec,1,"no_dr_n_pra"),"no_suse_proc",15.0);
                   no_xp_dr(no_oPC,no_pec);
                   break; }
         }
} // konec no_xp_lat











