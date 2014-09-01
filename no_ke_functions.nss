#include "ku_libtime"
//#include "no_ke_inc"
#include "no_nastcraft_ini"
#include "tc_xpsystem_inc"

#include "ku_persist_inc"


int no_pocet;
string no_nazev;
int no_DC;

void no_snizstack(object no_Item,int no_mazani);
////snizi pocet ve stacku. Kdyz je posledni, tak ho znici

void no_vratveci(int druh, int pocet, int no_slinovana);
////vrati veci, kdyz je nekdo zapomnel v peci.
void no_vratslin(int no_slinovana);
////vrati veci, kdyz je nekdo zapomnel v peci.


void no_cist(object no_Item, object no_pec, int no_mazani);
///////////////////////////////////////////
//// vystup:  no_cist        cislo urci 1-pisek ci 2-jil
//////        no_jil_pocet  ulozeno pocet jilu
////////////////////////////////////////////
void no_suro(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_suro na objectu no_pec na hodnotu 1-pisek, 2-jil
void no_slin(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_slin na objectu no_pec na hodnotu prisady
void no_pridatuhli(object no_Item, object no_pec);
//pridame uhli a zdelsime tak cas horeni pece
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

void no_xp_ke (object no_oPC, object no_pec);
//// udela z polotovaru konecnej vyrobek, nahaze xp, pridava % polotovaru

void no_xp_cisteni(object no_oPC, object no_pec, int no_kov);
//  udela polotovar
void no_xp_sklo(object no_oPC, object no_pec, int no_kov);
// udela polotovar
void no_xp_jil(object no_oPC, object no_pec, int no_kov);
// udela polotovar




/////////zacatek zavadeni funkci//////////////////////////////////////////////


/////////zacatek zavadeni funkci//////////////////////////////////////////////
void no_snizstack(object no_Item, int no_mazani)
{
int no_stacksize = GetItemStackSize(no_Item);      //zjisti kolik je toho ve stacku
  if (no_stacksize == 1)  {                     // kdyz je posledni znici objekt
                           if (no_mazani == TRUE)
                           DestroyObject(no_Item);


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
   case 1: { while (no_pocet>0)

                {
                SetLocalInt(CreateItemOnObject("no_cist_pise",OBJECT_SELF,1,"no_cist"),"tc_cena",FloatToInt(1*no_ke_nasobitel2));
                no_pocet=no_pocet-1;
                                }    break;
                                }///konec case
   case 2: {  while (no_pocet>0)
                   {
                  SetLocalInt(CreateItemOnObject("no_cist_jil",OBJECT_SELF,1,"no_cist"),"tc_cena",FloatToInt(2*no_ke_nasobitel2));
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
                CreateItemOnObject("no_slin_mala",OBJECT_SELF,1,"no_slin_mala");
                break; }
   case 2: {
                  CreateItemOnObject("no_slin_lahe",OBJECT_SELF,1,"no_slin_lahe");
                      break;                                }///konec case
   case 3: {
                  CreateItemOnObject("no_slin_tenk",OBJECT_SELF,1,"no_slin_tenk");
                       break;
                       }///konec case
   case 4: {        CreateItemOnObject("no_slin_ampu",OBJECT_SELF,1,"no_slin_ampu");
                    break;
                                }///konec case
   case 5: {
                  CreateItemOnObject("no_slin_stre",OBJECT_SELF,1,"no_slin_stre");
                      break;
                                }///konec case
   case 6: {
                  CreateItemOnObject("no_slin_velk",OBJECT_SELF,1,"no_slin_velk");
                   break;
                                }///konec case
   case 7: {
                  CreateItemOnObject("no_slin_zahn",OBJECT_SELF,1,"no_slin_zahn");
                    break;
                                }///konec case


   }//konec switche

}  //konec vraceni veci////////////////////////////////////



//////////////////////////////////////////////////////////////////////////


void no_suro(object no_Item, object no_pec, int no_mazani)
// nastavi promenou no_suro na objectu no_pec na hodnotu 1-pisek, 2-jil
{
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {

    if(GetTag(no_Item) == "cnrBagOfSand")
    { SetLocalInt(no_pec,"no_suro",1);
        no_snizstack(no_Item, no_mazani);
    break;      }
    if(GetTag(no_Item) == "cnrLumpOfClay")
    { SetLocalInt(no_pec,"no_suro",2);
        no_snizstack(no_Item, no_mazani);
    break;      }

  no_Item = GetNextItemInInventory(no_pec);
  }
}


void no_slin(object no_Item, object no_pec,int no_mazani)
// nastavi promenou no_slin na objectu no_pec na hodnotu prisady
{
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {

if (GetStringLeft(GetTag(no_Item),7) == "no_slin" ) {

    if(GetTag(no_Item) == "no_slin_mala")
    { SetLocalInt(no_pec,"no_slin",1);
        no_snizstack(no_Item, no_mazani);
    break;      }
    if(GetTag(no_Item) == "no_slin_lahe")
    { SetLocalInt(no_pec,"no_slin",2);
        no_snizstack(no_Item, no_mazani);
    break;      }
    if(GetTag(no_Item) == "no_slin_tenk")
    { SetLocalInt(no_pec,"no_slin",3);
        no_snizstack(no_Item, no_mazani);
    break;      }
    if(GetTag(no_Item) == "no_slin_ampu")
    { SetLocalInt(no_pec,"no_slin",4);
        no_snizstack(no_Item, no_mazani);
    break;      }
    if(GetTag(no_Item) == "no_slin_stre")
    { SetLocalInt(no_pec,"no_slin",5);
        no_snizstack(no_Item, no_mazani);
    break;      }
    if(GetTag(no_Item) == "no_slin_velk")
    { SetLocalInt(no_pec,"no_slin",6);
        no_snizstack(no_Item, no_mazani);
    break;      }
    if(GetTag(no_Item) == "no_slin_zahn")
    { SetLocalInt(no_pec,"no_slin",7);
        no_snizstack(no_Item, no_mazani);
    break;      }
    if(GetTag(no_Item) == "no_slin_kuli")
    { SetLocalInt(no_pec,"no_slin",8);
        no_snizstack(no_Item, no_mazani);
    break;      }
               }
  no_Item = GetNextItemInInventory(no_pec);
  }
}


void no_cist(object no_Item, object no_pec, int no_mazani)
///////////////////////////////////////////
//// vystup:  no_cist        cislo urci pisek ci jil
//////        no_jil_pocet  ulozeno pocet jilu
////////////////////////////////////////////
 {

SetLocalInt(OBJECT_SELF,"no_jil_pocet",0);
no_Item = GetFirstItemInInventory(no_pec);
int no_pocet = 0;
// SetLocalInt(no_pec,"no_jil_pocet",0);
while (GetIsObjectValid(no_Item)) {

 if(GetTag(no_Item) != "no_cist") {   //kdyz neni cisty pisek, ci jil, pokracujeme
 no_Item = GetNextItemInInventory(no_pec);
 continue;
         }

 if (GetResRef(no_Item) == "no_cist_jil" ) {
            if ( GetLocalInt(no_pec,"no_cist") == 2 ) {
                  if ( (GetLocalInt(no_pec,"no_slin") == 1) & (GetLocalInt(no_pec,"no_jil_pocet")<no_pocetskla_mala)  )
                  {SetLocalInt(no_pec,"no_jil_pocet",GetLocalInt(no_pec,"no_jil_pocet")+1); //kdyz sou stejne pricte 1
                  no_snizstack(no_Item, no_mazani);}
                  if ( (GetLocalInt(no_pec,"no_slin") == 3) & (GetLocalInt(no_pec,"no_jil_pocet")<no_pocetskla_tenk)  )
                  {SetLocalInt(no_pec,"no_jil_pocet",GetLocalInt(no_pec,"no_jil_pocet")+1); //kdyz sou stejne pricte 1
                  no_snizstack(no_Item, no_mazani);}
                  if ( (GetLocalInt(no_pec,"no_slin") == 5) & (GetLocalInt(no_pec,"no_jil_pocet")<no_pocetskla_stre)  )
                  {SetLocalInt(no_pec,"no_jil_pocet",GetLocalInt(no_pec,"no_jil_pocet")+1); //kdyz sou stejne pricte 1
                  no_snizstack(no_Item, no_mazani);}
                  if ( (GetLocalInt(no_pec,"no_slin") == 6) & (GetLocalInt(no_pec,"no_jil_pocet")<no_pocetskla_velk)  )
                  {SetLocalInt(no_pec,"no_jil_pocet",GetLocalInt(no_pec,"no_jil_pocet")+1); //kdyz sou stejne pricte 1
                  no_snizstack(no_Item, no_mazani);}
                  if ( (GetLocalInt(no_pec,"no_slin") == 7) & (GetLocalInt(no_pec,"no_jil_pocet")<no_pocetskla_zahn)  )
                  {SetLocalInt(no_pec,"no_jil_pocet",GetLocalInt(no_pec,"no_jil_pocet")+1); //kdyz sou stejne pricte 1
                  no_snizstack(no_Item, no_mazani);}
                  if ( (GetLocalInt(no_pec,"no_slin") == 8) & (GetLocalInt(no_pec,"no_jil_pocet")<no_pocetskla_kuli)  )
                  {SetLocalInt(no_pec,"no_jil_pocet",GetLocalInt(no_pec,"no_jil_pocet")+1); //kdyz sou stejne pricte 1
                  no_snizstack(no_Item, no_mazani);}
                  if ( NO_KE_DEBUG == TRUE)    {
                  SendMessageToPC(no_oPC,"Pridali sme jil : " + IntToString(GetLocalInt(no_pec,"no_jil_pocet")+1)); }

                  }
            else if ( GetLocalInt(no_pec,"no_cist") == 55 ){ //kdyz je no_pocet=0 zvysi se na jedna
                   SetLocalInt(no_pec,"no_cist",2);
                   SetLocalInt(no_pec,"no_jil_pocet",(GetLocalInt(no_pec,"no_jil_pocet")+1));
                   no_snizstack(no_Item, no_mazani);
                   if ( NO_KE_DEBUG == TRUE) {
                   SendMessageToPC(no_oPC,"nastavuju jil na: " + IntToString(GetLocalInt(no_pec,"no_jil_pocet")+1));  }
                 }
                 }//if jil
 if (GetResRef(no_Item) == "no_cist_pise" ) {
            if ( GetLocalInt(no_pec,"no_cist") == 1 ) {
                  if ( (GetLocalInt(no_pec,"no_slin") == 2) & (GetLocalInt(no_pec,"no_jil_pocet")<no_pocetskla_lahev)  )
                  {SetLocalInt(no_pec,"no_jil_pocet",GetLocalInt(no_pec,"no_jil_pocet")+1); //kdyz sou stejne pricte 1
                  no_snizstack(no_Item, no_mazani);}
                  if ( (GetLocalInt(no_pec,"no_slin") == 4) & (GetLocalInt(no_pec,"no_jil_pocet")<no_pocetskla_ampule)  )
                  {SetLocalInt(no_pec,"no_jil_pocet",GetLocalInt(no_pec,"no_jil_pocet")+1); //kdyz sou stejne pricte 1
                  no_snizstack(no_Item, no_mazani);}
                  if ( NO_KE_DEBUG == TRUE)   {
                  SendMessageToPC(no_oPC,"Pridali sme pisek: " + IntToString(GetLocalInt(no_pec,"no_jil_pocet")+1));   }

                  }
            else if ( GetLocalInt(no_pec,"no_cist") == 55 ){ //kdyz je no_pocet=0 zvysi se na jedna
                   SetLocalInt(no_pec,"no_cist",1);
                   SetLocalInt(no_pec,"no_jil_pocet",GetLocalInt(no_pec,"no_jil_pocet")+1);
                   no_snizstack(no_Item, no_mazani);
                 if ( NO_KE_DEBUG == TRUE)   {
                 SendMessageToPC(no_oPC,"nastavuju pisek na: " + IntToString(GetLocalInt(no_pec,"no_jil_pocet")+1)); }

                 }
                 }//if pisek

         no_Item = GetNextItemInInventory(no_pec);

        if ( NO_KE_DEBUG == TRUE) {
        SendMessageToPC(no_oPC,"Dalsi vec, mame pisku: " + IntToString(GetLocalInt(no_pec,"no_jil_pocet")+1));   }



    } //if je valid no_Item

//SetLocalInt(no_pec,"no_jil_pocet",no_pocet);
}

void BurnUpTheCoal(object oFire, object oPlume1, object oPlume2)
{
  int nCoalCount = GetLocalInt(OBJECT_SELF, "CnrCoalCount") - 1;
  SetLocalInt(OBJECT_SELF, "CnrCoalCount", nCoalCount);
  if (nCoalCount > 0)
  {
    DelayCommand(300.0, BurnUpTheCoal(oFire, oPlume1, oPlume2));
  }
  else
  {
    // the coal is gone, so put out the fire
    DestroyObject(oFire);
    DestroyObject(oPlume1);
    DestroyObject(oPlume2);

    object oSound = GetNearestObjectByTag("cnrForgeFire");
    if (oSound != OBJECT_INVALID)
    {
      SoundObjectStop(oSound);
    }

  }
}

void tc_armplayanimation(object oPC, int iCraftType);


float CnrNormalizeFacing(float fFacing)
{
  while (fFacing >= 360.0) fFacing -= 360.0;
  while (fFacing < 0.0) fFacing += 360.0;
  return fFacing;
}


////////////////pridavame uhli /////////////////////////////////////////////////////////////////
void no_pridatuhli(object no_Item, object no_pec)
   {
no_oPC=GetLastDisturbed();
no_Item = GetFirstItemInInventory(OBJECT_SELF);    //zjistime, zda je ve vyhni uhli
while(GetIsObjectValid(no_Item))  {
  if(GetTag(no_Item) == "cnrLumpOfCoal")
    break;
  no_Item = GetNextItemInInventory(OBJECT_SELF);
  }


if (GetIsObjectValid(no_Item)) {  //kdyz mame uhli

//////////////////////////////////////////////

if (GetLocalInt(OBJECT_SELF,"no_sl_horipec") > ku_GetTimeStamp() ) {//bylo tam pred driv nez minutou dane uhli
FloatingTextStringOnCreature("Pridavas dalsi uhli, presto pec nehori o moc hure, nez pred chvili.",no_oPC,FALSE);
DestroyObject(GetNearestObjectByTag("plc_flamesmall",OBJECT_SELF));

}
else  { FloatingTextStringOnCreature(" Uhli se krasne rozhorelo",no_oPC,FALSE );   }
// budto horime od zacatku, nebo to znovu nastavi cas horeni od ted na 1minutu
////////////pridano od melvika/////////////



      int nCoalCount = GetLocalInt(OBJECT_SELF, "CnrCoalCount") + 1;
      SetLocalInt(OBJECT_SELF, "CnrCoalCount", nCoalCount);
      if (nCoalCount == 1)
      {
        // Create and position the fire
        location locForge = GetLocation(OBJECT_SELF);
        float fForgeFacing = GetFacingFromLocation(locForge);
        fForgeFacing = CnrNormalizeFacing(fForgeFacing);

        // Note: the Forge's arrow points the opposite direction of fForgeFacing.
        float fFireFacing = fForgeFacing + 180.0;
        fFireFacing = CnrNormalizeFacing(fFireFacing);

        // find a position and facing fDistance meters towards the back of the object.
        float fDistance = 0.4f;
        float fDistanceY = sin(fFireFacing) * fDistance;
        float fDistanceX = cos(fFireFacing) * fDistance;
        vector vFire = GetPosition(OBJECT_SELF);
        vFire.x = vFire.x - fDistanceX;
        vFire.y = vFire.y - fDistanceY;
        vFire.z = vFire.z + 0.2f;

        location locFire = Location(GetArea(OBJECT_SELF), vFire, fFireFacing);
        object oFire = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_flamesmall", locFire, FALSE);
        object oPlume1 = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_dustplume", locFire, FALSE);
        object oLight1 = CreateObject(OBJECT_TYPE_PLACEABLE, "zep_lightshft006", locFire, FALSE);
        DelayCommand(900.0, DestroyObject(oLight1));

        // Note: the Forge's arrow points the opposite direction of fForgeFacing.
        float fPlumeFacing = fForgeFacing + 135.0;
        fPlumeFacing = CnrNormalizeFacing(fPlumeFacing);

        // find a position and facing fDistance meters towards the back of the object.
        fDistance = 0.75f;
        fDistanceY = sin(fPlumeFacing) * fDistance;
        fDistanceX = cos(fPlumeFacing) * fDistance;
        vector vPlume = GetPosition(OBJECT_SELF);
        vPlume.x = vPlume.x - fDistanceX;
        vPlume.y = vPlume.y - fDistanceY;
        vPlume.z = vPlume.z + 3.2f;

        location locPlume = Location(GetArea(OBJECT_SELF), vPlume, 0.0);
        object oPlume2 = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_dustplume", locPlume, FALSE);

        object oSound = GetNearestObjectByTag("cnrForgeFire");
        if (oSound != OBJECT_INVALID)
        {
          SoundObjectPlay(oSound);
        }

        // the PC just put the first coal nugget into the forge
        DelayCommand(900.0, BurnUpTheCoal(oFire, oPlume1, oPlume2));
      }


SetLocalInt(OBJECT_SELF,"no_sl_horipec",ku_GetTimeStamp(0,15));      // bude horet 5minut



DestroyObject(no_Item);   //znicime uhli

}    //konec  kdyz mame uhli
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

///dodelano 19_8_2014///////
//Persist_DeleteItemFromDB(no_Item);
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
AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, no_ke_delay));
    AssignCommand(no_oPC, SetCommandable(FALSE));
DelayCommand(no_ke_delay,ActionUnlockObject(OBJECT_SELF));
DelayCommand(no_ke_delay-1.0,AssignCommand(no_oPC, SetCommandable(TRUE)));
PlaySound("al_na_firelarge2");
}






///////////////////////////////Predelavam polotovar///////////////////////////////////////////////////////
/////////zjisti pravdepodobnost, prideli xpy, prida %hotovosti vyrobku a kdz bude nad 100% udela jej hotovym.
void no_xp_ke (object no_oPC, object no_pec)
{
int no_druh=0;
no_Item = GetFirstItemInInventory(no_pec);
while (GetIsObjectValid(no_Item)) {

if (GetResRef(no_Item) == "no_polot_ke") {
    if(GetTag(no_Item) == "no_ke_pise")  {  no_druh=1; break;      }
    if(GetTag(no_Item) == "no_ke_jil")   {  no_druh=2; break;      }
    if(GetTag(no_Item) == "no_ke_mala")  {  no_druh=3; break;      }
    if(GetTag(no_Item) == "no_ke_lahe")  {  no_druh=4; break;      }
    if(GetTag(no_Item) == "no_ke_tenk")  {  no_druh=5; break;      }
    if(GetTag(no_Item) == "no_ke_ampu")  {  no_druh=6; break;      }
    if(GetTag(no_Item) == "no_ke_stre")  {  no_druh=7; break;      }
    if(GetTag(no_Item) == "no_ke_velk")  {  no_druh=8; break;      }
    if(GetTag(no_Item) == "no_ke_zahn")  {  no_druh=9; break;      }
    if(GetTag(no_Item) == "no_ke_kuli")  {  no_druh=10; break;      }
    }//pokud resref = no_polot_ke      - pro zrychleni ifu...
  no_Item = GetNextItemInInventory(no_pec);
  }    /// dokud valid

//////tak mame predmet, co sme chteli. ted pravdepodobnost, ze se neco povede:
if (no_druh>0 ) {

int no_level = TC_getLevel(no_oPC,TC_KERAM);
switch(no_druh) {
        case 1:   {no_DC =  no_obt_cist_pise -( 10*no_level );    break; }
        case 2:   {no_DC =  no_obt_cist_jil -( 10*no_level );    break; }
        case 3:   {no_DC =  no_obt_mala -( 10*no_level );    break;     }
        case 4:   {no_DC =  no_obt_lahe -( 10*no_level );    break;    }
        case 5:   {no_DC =  no_obt_tenk -( 10*no_level );    break;    }
        case 6:   {no_DC =  no_obt_ampu -( 10*no_level );    break;    }
        case 7:   {no_DC =  no_obt_stre -( 10*no_level );    break;   }
        case 8:   {no_DC =  no_obt_velk -( 10*no_level );    break;   }
        case 9:   {no_DC =  no_obt_zahn -( 10*no_level );    break;}
        case 10:  {no_DC =  no_obt_kuli -( 10*no_level );    break;   }
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
                         TC_setXPbyDifficulty(no_oPC,TC_KERAM,no_chance,TC_dej_vlastnost(TC_KERAM,no_oPC));
                         }

        if ((no_chance > 0)&(no_chance<100)) { TC_setXPbyDifficulty(no_oPC,TC_KERAM,no_chance,TC_dej_vlastnost(TC_KERAM,no_oPC));
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
            no_procenta = no_procenta + Random(20)/10.0 +1.1;}
            else if ((no_obtiznost_vyrobku <150)&(no_obtiznost_vyrobku>=140)) {
            no_procenta = no_procenta + Random(20)/10.0 +1.2;}
            else if ((no_obtiznost_vyrobku<140)&(no_obtiznost_vyrobku>=130)) {
            no_procenta = no_procenta + Random(20)/10.0 +1.3;}
            else if ((no_obtiznost_vyrobku <130)&(no_obtiznost_vyrobku>=120)) {
            no_procenta = no_procenta + Random(20)/10.0 +1.5;}
            else if ((no_obtiznost_vyrobku <120)&(no_obtiznost_vyrobku>=110)) {
            no_procenta = no_procenta + Random(20)/10.0 +2.0;}
            else if ((no_obtiznost_vyrobku <110)&(no_obtiznost_vyrobku>=100)) {
            no_procenta = no_procenta + Random(20)/10.0 +2.5;}
            else if ((no_obtiznost_vyrobku <100)&(no_obtiznost_vyrobku>=90)) {
            no_procenta = no_procenta + Random(20)/10.0 +4.0;}
           else if ((no_obtiznost_vyrobku <90)&(no_obtiznost_vyrobku>=80)) {
            no_procenta = no_procenta + Random(20)/10.0 +5.5;}
            else if ((no_obtiznost_vyrobku <80)&(no_obtiznost_vyrobku>=70)) {
            no_procenta = no_procenta + Random(20)/10.0 +6.0;}
            else if ((no_obtiznost_vyrobku <70)&(no_obtiznost_vyrobku>=60)) {
            no_procenta = no_procenta + Random(20)/10.0 +7.5;}
            else if ((no_obtiznost_vyrobku <60)&(no_obtiznost_vyrobku>=50)) {
            no_procenta = no_procenta + Random(20)/10.0+ 8.0;}
            else if ((no_obtiznost_vyrobku <50)&(no_obtiznost_vyrobku>=40)) {
            no_procenta = no_procenta + Random(20)/10.0 +8.5;}
            else if ((no_obtiznost_vyrobku <40)&(no_obtiznost_vyrobku>=30)) {
            no_procenta = no_procenta + Random(20)/10.0 +10.0;}
            else if ((no_obtiznost_vyrobku <30)&(no_obtiznost_vyrobku>=20)) {
            no_procenta = no_procenta + Random(20)/10.0 + 15.5;}
            else if ((no_obtiznost_vyrobku <20)&(no_obtiznost_vyrobku>=10)) {
            no_procenta = no_procenta+ Random(20)/10.0 +16.0;}
            else if (no_obtiznost_vyrobku <10) {
            no_procenta = no_procenta + Random(20)/10.0 +20.0;}

                   if  (GetIsDM(no_oPC)== TRUE) no_procenta = no_procenta + 50.0;

        if (no_procenta >= 100.0) {  //kdyz je vyrobek 100% tak samozrejmeje hotovej

        AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0, 5.0));

///dodelano 1_9_2014///////
                DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru

        DestroyObject(no_Item); //znicim ho, protoze predam hotovej vyrobek


        switch(no_druh) {
        case 1:   {SetLocalInt(CreateItemOnObject("no_cist_pise",no_oPC,1,"no_cist"),"tc_cena",FloatToInt(1*no_ke_nasobitel2));
                  FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 2:   {SetLocalInt(CreateItemOnObject("no_cist_jil",no_oPC,1,"no_cist"),"tc_cena",FloatToInt(2*no_ke_nasobitel2));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 3:   {SetLocalInt(CreateItemOnObject("cnrmoldsmall",no_oPC,1),"tc_cena",FloatToInt(no_cena_mala*no_ke_nasobitel));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 4:   { object no_novavec = CreateItemOnObject("tc_flaska",no_oPC,10);
                    SetPlotFlag(no_novavec,1);
                    SetLocalInt(no_novavec,"tc_cena",FloatToInt(no_cena_lahe*no_ke_nasobitel));
                    SetName(no_novavec,"sklenena flaska");
                    FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }

        case 5:  { SetLocalInt(CreateItemOnObject("tc_form_tenk",no_oPC,1),"tc_cena",FloatToInt(no_cena_tenk*no_ke_nasobitel));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 6:   {object no_novavec = CreateItemOnObject("tc_flakon",no_oPC,10);
                    SetPlotFlag(no_novavec,1);
                    SetLocalInt(no_novavec,"tc_cena",FloatToInt(no_cena_ampu*no_ke_nasobitel));
                    SetName(no_novavec,"sklenena ampule");
                                     FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 7:   {SetLocalInt(CreateItemOnObject("cnrmoldmedium",no_oPC,1),"tc_cena",FloatToInt(no_cena_stre*no_ke_nasobitel));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 8:   {SetLocalInt(CreateItemOnObject("cnrmoldlarge",no_oPC,1),"tc_cena",FloatToInt(no_cena_velk*no_ke_nasobitel));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 9:   {SetLocalInt(CreateItemOnObject("tc_form_zahn",no_oPC,1),"tc_cena",FloatToInt(no_cena_zahn*no_ke_nasobitel));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 10:   {SetLocalInt(CreateItemOnObject("no_kuli",no_oPC,5),"tc_cena",FloatToInt(no_cena_kuli*no_ke_nasobitel));
                          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }

        }  ///konec case
                }//konec kdzy uz mam nad 100%

        if (no_procenta < 100.0) {  //kdyz neni 100% tak samozrejmeje neni hotovej

        if ( GetLocalInt(no_Item,"no_pocet_cyklu") == 9 ) {TC_saveCraftXPpersistent(no_oPC,TC_KERAM);}

        string no_nazev_procenta;
        if (no_procenta >= 10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                                  no_nazev_procenta = GetStringRight(no_nazev_procenta,4);}
        if (no_procenta <10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                               no_nazev_procenta = GetStringRight(no_nazev_procenta,3);}

        switch(no_druh) {
        case 1: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ke",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cisteny pisek *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ke_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 2: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ke",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cisteny jil *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ke_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 3: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ke",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Mala forma *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ke_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si slinovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 4:{string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ke",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Sklenene lahve *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ke_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si slinovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 5: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ke",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"tenka forma *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ke_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si slinovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 6: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ke",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Sklenena ampule *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ke_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si slinovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 7: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ke",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Stredni forma *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ke_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si slinovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 8: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ke",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Velka forma *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ke_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si slinovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 9: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ke",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Zahnuta forma *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ke_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si slinovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 10: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ke",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Kulicky *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ke_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si slinovani" ,no_oPC,FALSE );
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

         FloatingTextStringOnCreature("Vse se ti vylilo do pece.",no_oPC,FALSE );
         ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE),OBJECT_SELF);
         DelayCommand(1.0,AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 2.0)));
                               }
        else  if ((no_chance > 0)&(no_procenta>0.0)) FloatingTextStringOnCreature("Cast surovin se propalila ",no_oPC,FALSE );

        if (no_chance == 0){ FloatingTextStringOnCreature(" Se zpracovani by si mel radeji pockat ",no_oPC,FALSE );
                      DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(1,DAMAGE_TYPE_SONIC),no_oPC));
                          }     //konec ifu


 if (no_procenta > 0.0 ) {
                 string no_nazev_procenta;
        if (no_procenta >= 10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                                  no_nazev_procenta = GetStringRight(no_nazev_procenta,4);}
        if (no_procenta <10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                               no_nazev_procenta = GetStringRight(no_nazev_procenta,3);}

        switch(no_druh) {
        case 1: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ke",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cisteny pisek *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ke_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 2: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ke",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cisteny jil *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ke_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 3: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ke",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Mala forma *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ke_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si slinovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 4:{string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ke",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Sklenene lahve *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ke_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si slinovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 5: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ke",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"tenka forma *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ke_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si slinovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 6: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ke",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Sklenena ampule *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ke_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si slinovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 7: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ke",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Stredni forma *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ke_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si slinovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 8: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ke",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Velka forma *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ke_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si slinovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 9: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ke",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Zahnuta forma *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ke_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si slinovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 10: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_ke",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Kulicky *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_ke_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si slinovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }

                 }//konec case zvetsovani %
          }// kdyz neni 100%
         }//konec else

         }// konec kdyz jsme davali polotovar..

}    ////knec no_xp_ke




void no_xp_cisteni(object no_oPC, object no_pec, int no_kov)
// vyresi moznost uspechu a preda pripadny povedeny pisek ci jil do pece
{
switch(no_kov) {
        case 1:   {SetLocalFloat(CreateItemOnObject("no_polot_ke",no_pec,1,"no_ke_pise"),"no_suse_proc",15.0);
                   no_xp_ke(no_oPC,no_pec);
                   break; }
        case 2:   {SetLocalFloat(CreateItemOnObject("no_polot_ke",no_pec,1,"no_ke_jil"),"no_suse_proc",15.0);
                   no_xp_ke(no_oPC,no_pec);
                   break; }
                   }
} // konec no_xp_cisteni



void no_xp_sklo(object no_oPC, object no_pec, int no_kov)
// vyresi moznost uspechu a preda pripadny povedeny kov do pece
{

switch(no_kov) {
        case 2:   {SetLocalFloat(CreateItemOnObject("no_polot_ke",no_pec,1,"no_ke_lahe"),"no_suse_proc",15.0);
                   no_xp_ke(no_oPC,no_pec);
                   break; }
        case 4:   {SetLocalFloat(CreateItemOnObject("no_polot_ke",no_pec,1,"no_ke_ampu"),"no_suse_proc",15.0);
                   no_xp_ke(no_oPC,no_pec);
                   break; }
                   }
} // konec no_xp_sklo

void no_xp_jil(object no_oPC, object no_pec, int no_kov)
// vyresi moznost uspechu a preda pripadny povedeny kov do pece
{
int no_level = TC_getLevel(no_oPC,TC_KERAM);
switch(no_kov) {
        case 1:   {SetLocalFloat(CreateItemOnObject("no_polot_ke",no_pec,1,"no_ke_mala"),"no_suse_proc",15.0);
                   no_xp_ke(no_oPC,no_pec);
                   break; }
        case 3:   {SetLocalFloat(CreateItemOnObject("no_polot_ke",no_pec,1,"no_ke_tenk"),"no_suse_proc",15.0);
                   no_xp_ke(no_oPC,no_pec);
                   break; }
        case 5:   {SetLocalFloat(CreateItemOnObject("no_polot_ke",no_pec,1,"no_ke_stre"),"no_suse_proc",15.0);
                   no_xp_ke(no_oPC,no_pec);
                   break; }
        case 6:   {SetLocalFloat(CreateItemOnObject("no_polot_ke",no_pec,1,"no_ke_velk"),"no_suse_proc",15.0);
                   no_xp_ke(no_oPC,no_pec);
                   break; }
        case 7:   {SetLocalFloat(CreateItemOnObject("no_polot_ke",no_pec,1,"no_ke_zahn"),"no_suse_proc",15.0);
                   no_xp_ke(no_oPC,no_pec);
                   break; }
        case 8:   {SetLocalFloat(CreateItemOnObject("no_polot_ke",no_pec,1,"no_ke_kuli"),"no_suse_proc",15.0);
                   no_xp_ke(no_oPC,no_pec);
                   break; }
                } //konec vnitrniho  switche

} // konec no_xp_jil
















